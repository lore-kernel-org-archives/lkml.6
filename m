Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE8BECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B2C2150C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B2C2150C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeJRC3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:29:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:29659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbeJRC3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:29:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82003831"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2018 11:32:52 -0700
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
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [Patch v3 00/13] Provide process property based options to enable Spectre v2 userspace-userspace protection
Date:   Wed, 17 Oct 2018 10:59:28 -0700
Message-Id: <cover.1539798901.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to the valuable feedback from Thomas, Ingo and other
reviewers to the second version of this patchset.

The patches are now broken down into smaller functional changes
and should make them clearer and easier to review and merge.
One major change is that STIBP is not needed when enhanced
IBRS is being used.  The new code reflect this logic.

Patch 1 and 2 are clean up patches.
Patch 3 and 4 disable STIBP for enhacned IBRS.
Patch 5 to 9 reorganizes the code without affecting
 functionality for easier modification later.
Patch 10 introduces the STIBP flag on a process to dynamically
 enable STIBP for that process.
Patch 11 introduces the lite option to protect only
 processes against Spectre v2 user space attack
 for processes with STIBP flag.
Patch 12 mark the non-dumpable processes to be protected.
Patch 13 introduces prctl interface to restrict indirect
 branch speculation via prctl.
	      
Tim

Changes:
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

Application to application exploit is in general difficult due to address
space layout randomization in applications and the need to know an
application's address space layout ahead of time.  Users may not wish to
incur performance overhead from IBPB and STIBP for general non security
sensitive processes and use these mitigations only for security sensitive
processes.

This patchset provides a process property based lite protection mode that
applies IBPB and STIBP mitigation only to security sensitive non-dumpable
processes and processes that users want to protect by having indirect
branch speculation disabled via PRCTL.  So the overhead from IBPB and
STIBP are avoided for low security processes that don't require extra
protection.


Tim Chen (13):
  x86/speculation: Clean up spectre_v2_parse_cmdline
  x86/speculation: Remove unnecessary ret variable in cpu_show_common
  x86/speculation: Add static key for Enhanced IBRS
  x86/speculation: Disable STIBP when enhanced IBRS is in use
  x86/smt: Create cpu_smt_enabled static key for SMT specific code
  mm: Pass task instead of task->mm as argument to set_dumpable
  x86/process Add arch_set_dumpable
  x86/speculation: Rename SSBD update functions
  x86/speculation: Reorganize SPEC_CTRL MSR update
  x86/speculation: Add per thread STIBP flag
  x86/speculation: Add Spectre v2 lite app to app protection mode
  x86/speculation: Protect non-dumpable processes against Spectre v2
    attack
  x86/speculation: Create PRCTL interface to restrict indirect branch
    speculation

 Documentation/admin-guide/kernel-parameters.txt |  21 ++
 Documentation/userspace-api/spec_ctrl.rst       |  10 +
 arch/x86/include/asm/msr-index.h                |   6 +-
 arch/x86/include/asm/nospec-branch.h            |  10 +
 arch/x86/include/asm/spec-ctrl.h                |  18 +-
 arch/x86/include/asm/thread_info.h              |   5 +-
 arch/x86/kernel/cpu/bugs.c                      | 294 +++++++++++++++++++++---
 arch/x86/kernel/process.c                       |  53 +++--
 arch/x86/kvm/vmx.c                              |   2 +-
 arch/x86/mm/tlb.c                               |  19 +-
 fs/exec.c                                       |  20 +-
 include/linux/cpu.h                             |   1 +
 include/linux/sched.h                           |  11 +
 include/linux/sched/coredump.h                  |   2 +-
 include/uapi/linux/prctl.h                      |   1 +
 kernel/cpu.c                                    |  12 +-
 kernel/cred.c                                   |   2 +-
 kernel/sys.c                                    |   2 +-
 tools/include/uapi/linux/prctl.h                |   1 +
 19 files changed, 427 insertions(+), 63 deletions(-)

-- 
2.9.4

