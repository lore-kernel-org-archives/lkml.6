Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B998C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C6B20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 18:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C6B20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeJXDIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 23:08:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:55078 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbeJXDH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 23:07:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 11:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,417,1534834800"; 
   d="scan'208";a="243726561"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Oct 2018 11:43:23 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [v3 00/12] x86: Enable FSGSBASE instructions
Date:   Tue, 23 Oct 2018 11:42:22 -0700
Message-Id: <20181023184234.14025-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSGSBASE is a 64-bit instruction set to allow read/write FS/GSBASE from
any privileges. Since introduced in Ivybridge, enabling efforts has been
revolving in a quite long period of time, for various reasons [2,3,4].
After the extended discussions [1], the new ABIs are finally introduced to
customize FS/GSBASE separately from the selector.

Benefits:
Some performance benefit in context switch is expected by skipping MSR
write for GSBASE. User-level programs (such as JAVA-based) may benefit
from avoiding system calls to edit FS/GSBASE.

Major changes in the kernel:
* In a context switch, a thread's FS/GSBASE will be secured regardless of
its selector, base on the discussion [1].
* (Subsequently) ptracer should expect a divergence of FS/GS index and
base values. There was a controversial debate on the concerns for a
backward compatibility (mostly for GDB. [7,8]). We finally concluded it is
insignificant in real usages.
* On the paranoid_entry, GSBASE is updated to point the per_CPU base and
the original GSBASE is restored at the exit.

Virtualization:
A FSGSBASE-enabled VM can be located on a host either with HW
virtualization or with SW emulation. KVM advertises FSGSBASE when
physical CPU has. The emulation is supported in QEMU/TCG [5]. In a pool of
the mixed systems, VMM may disable FSGSBASE for seamless VM migrations [6].

Update from v2 [10]:
* Separate out the preparatory patches [11] (now merged to the tip)
* Bisect the paranoid_entry update patch
* Edit minor nits

Updates from v1 [9]:
* Update the GSBASE update mechanism on the paranoid entry/exit.
* Exclude ptracer backward compatibility patches.
* Include FSGSBASE documentation and enumerating capability
for user space
* Add the TAINT_INSECURE flag.

[1] Recent discussion on LKML:
https://marc.info/?t=150147053700001&r=1&w=2
[2] Andy Lutomirski’s patchwork work :
https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/fsgsbase
[3] Patchset shown in 2016:
https://lore.kernel.org/patchwork/patch/660520
[4] Patchset shown in 2014:
https://lore.kernel.org/patchwork/patch/460288
[5] QEMU with FSGSBASE emulation:
https://github.com/qemu/qemu/blob/026aaf47c02b79036feb830206cfebb2a726510d/target/i386/translate.c#L8186
[6] 5-level EPT:
http://lkml.kernel.org/r/9ddf602b-6c8b-8c1e-ab46-07ed12366593@redhat.com
[7] RR/FSGSBASE:
https://mail.mozilla.org/pipermail/rr-dev/2018-March/000616.html
[8] CRIU/FSGSBASE:
https://lists.openvz.org/pipermail/criu/2018-March/040654.html
[9] Version 1:
https://lore.kernel.org/patchwork/cover/934843
[10] Version 2:
https://lore.kernel.org/patchwork/cover/912063
[11] x86: infra to enable FSGSBASE
https://lore.kernel.org/patchwork/cover/988180

Andi Kleen (3):
  x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions
  x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2
  x86/fsgsbase/64: Add documentation for FSGSBASE

Andy Lutomirski (4):
  x86/fsgsbase/64: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
  x86/fsgsbase/64: Preserve FS/GS state in __switch_to() if FSGSBASE is
    on
  selftests/x86/fsgsbase: Test WRGSBASE
  x86/fsgsbase/64: Enable FSGSBASE by default and add a chicken bit

Chang S. Bae (5):
  taint: Introduce a new taint flag (insecure)
  x86/fsgsbase/64: Enable FSGSBASE instructions in the helper functions
  x86/fsgsbase/64: When copying a thread, use the FSGSBASE instructions
    if available
  x86/fsgsbase/64: Introduce the new FIND_PERCPU_BASE macro
  x86/fsgsbase/64: Use the per-CPU base as GSBASE at the paranoid_entry

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/sysctl/kernel.txt               |   1 +
 Documentation/x86/fsgs.txt                    | 104 +++++++++++++
 arch/x86/entry/entry_64.S                     |  73 +++++++--
 arch/x86/include/asm/fsgsbase.h               | 140 +++++++++++++++++-
 arch/x86/include/asm/inst.h                   |  15 ++
 arch/x86/include/uapi/asm/hwcap2.h            |   3 +
 arch/x86/kernel/cpu/common.c                  |  22 +++
 arch/x86/kernel/process_64.c                  | 128 +++++++++++++---
 include/linux/kernel.h                        |   3 +-
 kernel/panic.c                                |   1 +
 tools/testing/selftests/x86/fsgsbase.c        | 110 +++++++++++++-
 12 files changed, 556 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/x86/fsgs.txt

--
2.19.1

