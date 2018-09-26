Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9559FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C7B21502
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C7B21502
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeIZH3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:29:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:52990 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeIZH3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:29:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 18:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,304,1534834800"; 
   d="scan'208";a="72890282"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga007.fm.intel.com with ESMTP; 25 Sep 2018 18:17:15 -0700
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
Subject: [Patch v2 0/4] Provide options to enable spectre_v2 userspace-userspace protection 
Date:   Tue, 25 Sep 2018 17:43:55 -0700
Message-Id: <cover.1537920575.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have merged Tom's changes to extend the patchset for AMD cpus, and
also added a prctl option to control per process indirect branch
speculation per Peter's comments.

Tim

Changes:
v2:
1. Extend per process STIBP to AMD cpus
2. Add prctl option to control per process indirect branch speculation
3. Bug fixes and cleanups 

This patchset provides an option to apply IBPB and STIBP mitigation
to only non-dumpable processes.

Jiri's patch to harden spectre_v2 makes IBPB and STIBP available for
general spectre v2 app to app mitigation.  IBPB will be issued for
switching to an app that's not ptraceable by the previous
app and STIBP will be always turned on.

However, leaving STIBP on all the time is expensive for certain
applications that have frequent indirect branches. One such application
is perlbench in the SpecInt Rate 2006 test suite which shows a
21% reduction in throughput.  Other application like bzip2 in
the same test suite with  minimal indirct branches have
only a 0.7% reduction in throughput. IBPB will also impose
overhead during context switches.

App to app exploit is in general difficult
due to address space layout randomization in apps and
the need to know an app's address space layout ahead of time.
Users may not wish to incur app to app performance
overhead from IBPB and STIBP for general non security sensitive apps
and use these mitigations only for non-dumpable apps.

The first patch provides a lite option for spectre_v2 app to app
mitigation where IBPB is only issued for security sensitive
non-dumpable app.  The second patch extends this option
where STIBP is only issued for non-dumpable app.
The third patch extends per process STIBP update for AMD cpus.
The fourth patch adds a prctl option to control per process
indirect branch speculation.

Thomas Lendacky (1):
  x86/speculation: Extend per process STIBP to AMD cpus.

Tim Chen (3):
  x86/speculation: Option to select app to app mitigation for spectre_v2
  x86/speculation: Provide application property based STIBP protection
  x86/speculation: Add prctl to control indirect branch speculation per
    process

 Documentation/admin-guide/kernel-parameters.txt |  13 ++
 Documentation/userspace-api/spec_ctrl.rst       |   8 +
 arch/x86/include/asm/msr-index.h                |   3 +-
 arch/x86/include/asm/nospec-branch.h            |   9 ++
 arch/x86/include/asm/spec-ctrl.h                |  12 ++
 arch/x86/include/asm/thread_info.h              |   4 +-
 arch/x86/kernel/cpu/bugs.c                      | 185 +++++++++++++++++++++++-
 arch/x86/kernel/process.c                       |  58 ++++++--
 arch/x86/mm/tlb.c                               |  21 ++-
 fs/exec.c                                       |  13 +-
 include/linux/sched.h                           |   5 +
 include/linux/sched/coredump.h                  |   2 +-
 include/uapi/linux/prctl.h                      |   1 +
 kernel/cred.c                                   |   2 +-
 kernel/sys.c                                    |   2 +-
 tools/include/uapi/linux/prctl.h                |   1 +
 16 files changed, 310 insertions(+), 29 deletions(-)

-- 
2.9.4

