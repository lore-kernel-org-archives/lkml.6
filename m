Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CACECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFD62146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFD62146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbeITDtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:49:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:27899 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbeITDtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:49:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 15:09:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,395,1531810800"; 
   d="scan'208";a="90262488"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga004.fm.intel.com with ESMTP; 19 Sep 2018 15:09:38 -0700
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
Subject: [PATCH 0/2] Provide options to enable spectre_v2 userspace-userspace protection
Date:   Wed, 19 Sep 2018 14:35:28 -0700
Message-Id: <cover.1537392876.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The changes apply to intel cpus affected by spectre_v2. Tom,
can you update the STIBP changes for AMD cpus on  
__speculative_store_bypass_update and x86_virt_spec_ctrl
to update the SPEC_CTRL msr for AMD cpu?

Thanks.

Tim

Tim Chen (2):
  x86/speculation: Option to select app to app mitigation for spectre_v2
  x86/speculation: Provide application property based STIBP protection

 Documentation/admin-guide/kernel-parameters.txt |  11 +++
 arch/x86/include/asm/msr-index.h                |   3 +-
 arch/x86/include/asm/nospec-branch.h            |   9 ++
 arch/x86/include/asm/spec-ctrl.h                |  12 +++
 arch/x86/include/asm/thread_info.h              |   4 +-
 arch/x86/kernel/cpu/bugs.c                      | 105 ++++++++++++++++++++++--
 arch/x86/kernel/process.c                       |   9 +-
 arch/x86/mm/tlb.c                               |  41 ++++++++-
 8 files changed, 179 insertions(+), 15 deletions(-)

-- 
2.9.4

