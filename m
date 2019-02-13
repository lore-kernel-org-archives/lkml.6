Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D3CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1312086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389633AbfBMVgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:36:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:41474 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729767AbfBMVgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:36:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 13:36:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,366,1544515200"; 
   d="scan'208";a="274859798"
Received: from chang-linux-2.sc.intel.com ([10.3.52.165])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2019 13:36:53 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>
Cc:     Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 00/12] x86: Enable FSGSBASE instructions
Date:   Wed, 13 Feb 2019 13:36:12 -0800
Message-Id: <20190213213624.14354-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates from v5 [5]:
* Drop the new tain flag (TAINT_INSECURE)
* Cleanup copy_thread_tls(), some changelog, and unnecessary comments on
  assembly macros
* Rearrange some helper updates appropriately (from patch 4 to 6)

Updates from v4 [4]:
* Remove the FSGSBASE assembly macros

Updates from v3 [3]:
* Raise minimum binutils requirement to use the new instructions directly
* Optimize FIND_PERCPU_BASE macro
* Rename some helper functions, __{rd,wr}gsbase_inactive()
* Use NOKPROBE_SYMBOL instead of __kprobes
* Rebase on top of the helper function fix [7]

Update from v2 [2]:
* Separate out the preparatory patches [6] (merged as of now)
* Bisect the paranoid_entry update patch
* Edit minor nits

Updates from v1 [1]:
* Update the GSBASE update mechanism on the paranoid entry/exit.
* Exclude ptracer backward compatibility patches.
* Include FSGSBASE documentation and enumerating capability
  for user space
* Add the TAINT_INSECURE flag.

[1] Version 1: https://lore.kernel.org/patchwork/cover/934843
[2] Version 2: https://lore.kernel.org/patchwork/cover/912063
[3] Version 3: https://lore.kernel.org/patchwork/cover/1002725
[4] Version 4: https://lore.kernel.org/patchwork/cover/1032799
[5] Version 5: https://lore.kernel.org/patchwork/cover/1038035
[5] https://lore.kernel.org/patchwork/cover/988180
[6] https://lore.kernel.org/patchwork/patch/1017513

Andi Kleen (3):
  x86/fsgsbase/64: Add intrinsics for FSGSBASE instructions
  x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2
  x86/fsgsbase/64: Add documentation for FSGSBASE

Andy Lutomirski (4):
  x86/fsgsbase/64: Add 'unsafe_fsgsbase' to enable CR4.FSGSBASE
  x86/fsgsbase/64: Preserve FS/GS state in __switch_to() if FSGSBASE is
    on
  selftests/x86/fsgsbase: Test WRGSBASE
  x86/fsgsbase/64: Enable FSGSBASE by default and add a chicken bit

Chang S. Bae (5):
  kbuild: Raise the minimum required binutils version to 2.21
  x86/fsgsbase/64: Enable FSGSBASE instructions in the helper functions
  x86/fsgsbase/64: When copying a thread, use the FSGSBASE instructions
    if available
  x86/fsgsbase/64: Introduce the FIND_PERCPU_BASE macro
  x86/fsgsbase/64: Use the per-CPU base as GSBASE at the paranoid_entry

 .../admin-guide/kernel-parameters.txt         |   2 +
 Documentation/process/changes.rst             |   6 +-
 Documentation/x86/fsgs.txt                    | 104 +++++++++++++++++
 arch/x86/entry/entry_64.S                     |  71 +++++++++---
 arch/x86/include/asm/fsgsbase.h               |  95 ++++++++++++++--
 arch/x86/include/asm/inst.h                   |  15 +++
 arch/x86/include/uapi/asm/hwcap2.h            |   3 +
 arch/x86/kernel/cpu/common.c                  |  22 ++++
 arch/x86/kernel/process_64.c                  | 105 ++++++++++++++++--
 tools/testing/selftests/x86/fsgsbase.c        | 102 ++++++++++++++++-
 10 files changed, 484 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/x86/fsgs.txt

--
2.19.1

