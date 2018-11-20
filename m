Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE23C04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD1E214C1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD1E214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbeKULFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:05:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:30238 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbeKULFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:05:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:33:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="93650164"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2018 16:33:17 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: [Patch v6 00/16] Provide task property based options to enable Spectre v2 userspace-userspace protection
Date:   Tue, 20 Nov 2018 15:59:52 -0800
Message-Id: <cover.1542757030.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix in this version bugs causing build problems for UP configuration.

Also merged in Jiri's change to extend STIBP for SECCOMP processes and
renaming TIF_STIBP to TIF_SPEC_INDIR_BRANCH.

I've updated the boot options spectre_v2_app2app to 
on, off, auto, prctl and seccomp.  This aligns with
the options for other speculation related mitigations.

I tried to incorporate sched_smt_present to detect when we have all SMT
going offline and we can disable the SMT path, which Peter suggested.
This optimization that can be easily left out of the patch series and
not backported.  I've put these two patches at the end and they can be
considered separately.

I've dropped the TIF flags re-organization patches
as they are not needed in this patch series.

To do: Create a dedicated document on the mitigation options for Spectre V2.

Since Jiri's patchset to always turn on STIBP
has big performance impact, I think that it should
be reverted from 4.20 and stable kernels for now, till this
patchset to mitigate its performance impact can be merged
with it into the mainline and backported to stable kernels.

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
Patch 13 Put IBPB usage under the mode chosen for app2app mitigation.
Patch 14 Add STIBP protection for SECCOMP tasks.
Patch 15-16 add Spectre v2 defenses for non-dumpable tasks.
Patch 15-16 reorganizes the TIF flags, and can be dropped without affecting this series 
Patch 17-18 When there are no paired SMT left, disable SMT specific code

Changes:
v6:
1. Fix bugs for UP build configuration.
2. Add protection for SECCOMP tasks. 
3. Rename TIF_STIBP to TIF_SPEC_INDIR_BRANCH.
4. Update boot options to align with other speculation mitigations.
5. Separate out IBPB change that makes it depend on TIF_SPEC_INDIR_BRANCH.
6. Move some checks for SPEC_CTRL updates to spec_ctrl_update_msr to avoid
unnecesseary MSR writes.
7. Drop TIF reorg patches.
8. Incorporate optimization to disable SMT code paths when no paired SMT is present.

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


Jiri Kosina (1):
  x86/speculation: Add 'seccomp' Spectre v2 app to app protection mode

Peter Zijlstra (1):
  sched/smt: Make sched_smt_present track topology

Tim Chen (14):
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
  x86/speculation: Enable IBPB for tasks with
    TIF_SPEC_BRANCH_SPECULATION
  security: Update speculation restriction of a process when modifying
    its dumpability
  x86/speculation: Use STIBP to restrict speculation on non-dumpable
    task
  x86/smt: Allow disabling of SMT when last SMT is offlined

 Documentation/admin-guide/kernel-parameters.txt |  34 +++
 Documentation/userspace-api/spec_ctrl.rst       |   9 +
 arch/x86/include/asm/cpufeatures.h              |   1 +
 arch/x86/include/asm/msr-index.h                |   6 +-
 arch/x86/include/asm/nospec-branch.h            |  10 +
 arch/x86/include/asm/spec-ctrl.h                |  18 +-
 arch/x86/include/asm/thread_info.h              |   5 +-
 arch/x86/kernel/cpu/bugs.c                      | 304 ++++++++++++++++++++++--
 arch/x86/kernel/process.c                       |  58 ++++-
 arch/x86/kvm/vmx.c                              |   2 +-
 arch/x86/mm/tlb.c                               |  23 +-
 fs/exec.c                                       |   3 +
 include/linux/cpu.h                             |  31 ++-
 include/linux/sched.h                           |   9 +
 include/uapi/linux/prctl.h                      |   1 +
 kernel/cpu.c                                    |  28 ++-
 kernel/cred.c                                   |   5 +-
 kernel/sched/core.c                             |  19 +-
 kernel/sched/sched.h                            |   2 -
 kernel/sys.c                                    |   7 +
 tools/include/uapi/linux/prctl.h                |   1 +
 21 files changed, 512 insertions(+), 64 deletions(-)

-- 
2.9.4

