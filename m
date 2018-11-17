Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D49CC43610
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CEA208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14CEA208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbeKQMmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:42:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:31776 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeKQMmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:42:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 18:26:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="281852474"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2018 18:26:46 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [Patch v5 00/16] Provide task property based options to enable Spectre v2 userspace-userspace protection 
Date:   Fri, 16 Nov 2018 17:53:43 -0800
Message-Id: <cover.1542418936.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous version of this series had a patch to apply TIF_STIBP updates
to all threads affected by a dumpability change, and keeping all the CPUs'
SPEC CTRL MSRs in sync with running task's TIF_STIBP.

However, this feature adds much overhead and complexities
for little gain.  Normally a task making uid/gid or prctl dumpability change
will do so before it starts spawning threads.

So in this version, the TIF_STIBP associated with dumpability change
is only applied to the task that makes the change, and not extended
to its associated threads.

Thomas also pointed out that new cpu_smt_enabled staic key is
created under CONFIG_HOTPLUG_SMT and currently applies only to x86.
So cpu_smt_enabled cannot replace sched_smt_present key which needs to
be used by all architectures, unless the cpu_smt_control setting logic
is moved out of CONFIG_HOTPLUG_SMT.  So I dropped the patch replacing
sched_smt_present with cpu_smt_enabled.

I've also moved the TIF flags re-organization patch to the end
of the series to make it easier for backporting to stable kernels
without needing to reorganize the TIF flags.

Thomas, can you consider this series to be merged to 4.20-rc along
with Jiri's changes on STIBP?

Thanks.

Tim

Patch 1 to 3 are clean up patches.
Patch 4 and 5 disable STIBP for enhacned IBRS.
Patch 6 to 9 reorganize and clean up the code without affecting
 functionality for easier modification later.
Patch 10 introduces the STIBP flag on a task to dynamically
 enable STIBP for that task.
Patch 11 introduces different modes to protect a
 task against Spectre v2 user space attack.
Patch 12 adds prctl interface to turn on Spectre v2 user mode defenses on a task. 
Patch 13-14 add Spectre v2 defenses for non-dumpable tasks.
Patch 15-16 reorganizes the TIF flags, and can be dropped without affecting this series 

Changes:
v5:
1. Drop patch to extend TIF_STIBP changes to all related threads on 
a task's dumpabibility change.
2. Drop patch to replace sched_smt_present with cpu_smt_enabled.
3. Drop export of cpu_smt_control in kernel/cpu.c and replace external
usages of cpu_smt_control with cpu_smt_enabled.
4. Rebase patch series on 4.20-rc2.

v4:
1. Extend STIBP update to all threads of a process changing
it dumpability.
2. Add logic to update SPEC_CTRL MSR on a remote CPU when TIF flags
affecting speculation changes for task running on the remote CPU.
3. Regroup x86 TIF_* flags according to their functions.
4. Various code clean up.

v3:
1. Add logic to skip STIBP when Enhanced IBRS is used.
2. Break up v2 patches into smaller logical patches. 
3. Fix bug in arch_set_dumpable that did not update SPEC_CTRL
MSR right away when according to task's STIBP flag clearing which
caused SITBP to be left on.
4. Various code clean up. 

v2:
1. Extend per process STIBP to AMD cpus
2. Add prctl option to control per process indirect branch speculation
3. Bug fixes and cleanups 

Jiri's patchset to harden Spectre v2 user space mitigation makes IBPB
and STIBP in use for Spectre v2 mitigation on all processes.  IBPB will
be issued for switching to an application that's not ptraceable by the
previous application and STIBP will be always turned on.

However, leaving STIBP on all the time is expensive for certain
applications that have frequent indirect branches. One such application
is perlbench in the SpecInt Rate 2006 test suite which shows a
21% reduction in throughput.
There're also reports of drop in performance on Python and PHP benchmarks:
https://www.phoronix.com/scan.php?page=article&item=linux-420-bisect&num=2

Other applications like bzip2 with minimal indirct branches have
only a 0.7% reduction in throughput. IBPB will also impose
overhead during context switches.

Users may not wish to incur performance overhead from IBPB and STIBP for
general non security sensitive processes and use these mitigations only
for security sensitive processes.

This patchset provides a process property based lite protection mode.
In this mode, IBPB and STIBP mitigation are applied only to security
sensitive non-dumpable processes and processes that users want to protect
by having indirect branch speculation disabled via PRCTL.  So the overhead
from IBPB and STIBP are avoided for low security processes that don't
require extra protection.
Tim Chen (16):
  x86/speculation: Clean up spectre_v2_parse_cmdline()
  x86/speculation: Remove unnecessary ret variable in cpu_show_common()
  x86/speculation: Reorganize cpu_show_common()
  x86/speculation: Add X86_FEATURE_USE_IBRS_ENHANCED
  x86/speculation: Disable STIBP when enhanced IBRS is in use
  x86/speculation: Rename SSBD update functions
  x86/speculation: Reorganize speculation control MSRs update
  smt: Create cpu_smt_enabled static key for SMT specific code
  x86/smt: Convert cpu_smt_control check to cpu_smt_enabled static key
  x86/speculation: Turn on or off STIBP according to a task's TIF_STIBP
  x86/speculation: Add Spectre v2 app to app protection modes
  x86/speculation: Create PRCTL interface to restrict indirect branch
    speculation
  security: Update speculation restriction of a process when modifying
    its dumpability
  x86/speculation: Use STIBP to restrict speculation on non-dumpable
    task
  x86/speculation: Update comment on TIF_SSBD
  x86: Group thread info flags by functionality

 Documentation/admin-guide/kernel-parameters.txt |  21 ++
 Documentation/userspace-api/spec_ctrl.rst       |   9 +
 arch/x86/include/asm/cpufeatures.h              |   1 +
 arch/x86/include/asm/msr-index.h                |   6 +-
 arch/x86/include/asm/nospec-branch.h            |   9 +
 arch/x86/include/asm/spec-ctrl.h                |  18 +-
 arch/x86/include/asm/thread_info.h              |  98 ++++---
 arch/x86/kernel/cpu/bugs.c                      | 323 +++++++++++++++++++++---
 arch/x86/kernel/process.c                       |  58 ++++-
 arch/x86/kvm/vmx.c                              |   2 +-
 arch/x86/mm/tlb.c                               |  23 +-
 fs/exec.c                                       |   3 +
 include/linux/cpu.h                             |  12 +-
 include/linux/sched.h                           |   9 +
 include/uapi/linux/prctl.h                      |   1 +
 kernel/cpu.c                                    |  25 +-
 kernel/cred.c                                   |   5 +-
 kernel/sys.c                                    |   7 +
 tools/include/uapi/linux/prctl.h                |   1 +
 19 files changed, 520 insertions(+), 111 deletions(-)

-- 
2.9.4

