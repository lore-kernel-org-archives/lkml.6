Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BA6C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934482080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934482080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeJaERS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:17:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:23873 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeJaERS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:17:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 12:22:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="103876716"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 12:22:33 -0700
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
Subject: [Patch v4 00/18] Provide process property based options to enable Spectre v2 userspace-userspace protection*
Date:   Tue, 30 Oct 2018 11:49:07 -0700
Message-Id: <cover.1540923609.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the feedback from all reviewers.

The major change in this version is that I've updated defenses of all
threads of a process when there's a dumpability change on the process.

I've also added a patch to signal the need of a forced update of SPEC_CTRL
MSR on remote CPU. We could change the TIF flag affecting speculation
on a task running on remote CPU but not immediately update the MSR.
So we need to force the MSR update on the next context switch to make
sure that the MSR is in sync with the running task's flags.

Wonder if this needs to be extended to SSBD update.  It seems like SSBD's
update via prctl is on current task so it is not affected by the
remote CPU update issue, but I can be wrong.

Thomas also suggested grouping the x86 TIF_* flags according to their
functionality and I made a stab at it.  But this is not essential to
this patchset.  I can drop this if there are compatability reason not
to change the bit position associated with the TIF_* flags.

Patch 1 to 3 are clean up patches.
Patch 4 and 5 disable STIBP for enhacned IBRS.
Patch 6 to 12 reorganizes and clean up the code without affecting
 functionality for easier modification later.
Patch 13 introduces security hook to update defense mechanisms
for a process.
Patch 14 introduces the STIBP flag on a process to dynamically
 enable STIBP for that process.
Patch 15 introduces different modes to protect
 processes against Spectre v2 user space attack.
Patch 16 to 17 adds Spectre v2 user mode defenses on a per task basis. 
Patch 18 introduces prctl interface to restrict indirect
 branch speculation via prctl.
	      
Tim

Changes:
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
21% reduction in throughput.  Other application like bzip2 in
the same test suite with  minimal indirct branches have
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


Tim Chen (18):
  x86/speculation: Clean up spectre_v2_parse_cmdline()
  x86/speculation: Remove unnecessary ret variable in cpu_show_common()
  x86/speculation: Reorganize cpu_show_common()
  x86/speculation: Add X86_FEATURE_USE_IBRS_ENHANCED
  x86/speculation: Disable STIBP when enhanced IBRS is in use
  smt: Create cpu_smt_enabled static key for SMT specific code
  x86/smt: Convert cpu_smt_control check to cpu_smt_enabled static key
  sched: Deprecate sched_smt_present and use cpu_smt_enabled static key
  x86/speculation: Rename SSBD update functions
  x86/speculation: Reorganize speculation control MSRs update
  x86/speculation: Update comment on TIF_SSBD
  x86: Group thread info flags by functionality
  security: Update security level of a process when modifying its
    dumpability
  x86/speculation: Turn on or off STIBP according to a task's TIF_STIBP
  x86/speculation: Add Spectre v2 app to app protection modes
  x86/speculation: Enable STIBP to protect security sensitive tasks
  x86/speculation: Update SPEC_CTRL MSRs of remote CPUs
  x86/speculation: Create PRCTL interface to restrict indirect branch
    speculation

 Documentation/admin-guide/kernel-parameters.txt |  21 ++
 Documentation/userspace-api/spec_ctrl.rst       |   9 +
 arch/x86/include/asm/cpufeatures.h              |   1 +
 arch/x86/include/asm/msr-index.h                |   6 +-
 arch/x86/include/asm/nospec-branch.h            |   9 +
 arch/x86/include/asm/spec-ctrl.h                |  18 +-
 arch/x86/include/asm/thread_info.h              | 104 ++++----
 arch/x86/kernel/cpu/bugs.c                      | 309 +++++++++++++++++++++---
 arch/x86/kernel/process.c                       |  76 +++++-
 arch/x86/kvm/vmx.c                              |   2 +-
 arch/x86/mm/tlb.c                               |  23 +-
 fs/exec.c                                       |   2 +
 include/linux/cpu.h                             |   1 +
 include/linux/sched.h                           |   9 +
 include/linux/security.h                        |   6 +
 include/uapi/linux/prctl.h                      |   1 +
 kernel/cpu.c                                    |  12 +-
 kernel/cred.c                                   |   5 +-
 kernel/sched/core.c                             |  12 -
 kernel/sched/fair.c                             |   6 +-
 kernel/sched/sched.h                            |   4 +-
 kernel/sys.c                                    |   1 +
 security/security.c                             |  31 +++
 tools/include/uapi/linux/prctl.h                |   1 +
 24 files changed, 553 insertions(+), 116 deletions(-)

-- 
2.9.4

