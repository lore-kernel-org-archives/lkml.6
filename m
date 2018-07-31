Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE18C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3923208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:38:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3923208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeGaVUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:20:34 -0400
Received: from mga06.intel.com ([134.134.136.31]:3846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732282AbeGaVUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:20:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 12:38:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,428,1526367600"; 
   d="scan'208";a="77594083"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2018 12:38:43 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, fenghua.yu@intel.com,
        tony.luck@intel.com, vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 2/2] x86/intel_rdt: Coordinate performance monitoring with perf
Date:   Tue, 31 Jul 2018 12:38:29 -0700
Message-Id: <5024d59405fe6d005f3fb81a478f7dcaa9f78df5.1533064851.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1533064851.git.reinette.chatre@intel.com>
References: <cover.1533064851.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1533064851.git.reinette.chatre@intel.com>
References: <cover.1533064851.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to measure cache pseudo-locking success using performance
monitoring counters. This measurement is triggered from user space via
the resctrl debugfs interface.

At this time the usage of the performance monitoring counters are not
coordinated with other users. If any other system measurement is in
progress, for example using perf, then the registers would be clobbered
between the multiple users.

Now that users have access to reserve_pmc_hardware() and
release_pmc_hardware() these functions can be used to ensure that only
one user has access to PMC hardware at a time. Internally this was
already used by perf - the cache pseudo-locking debugging needs to use
it also.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 Documentation/x86/intel_rdt_ui.txt          | 4 ----
 arch/x86/kernel/cpu/intel_rdt.h             | 2 ++
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 8 ++++++++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/intel_rdt_ui.txt b/Documentation/x86/intel_rdt_ui.txt
index f662d3c530e5..a98e05d3e233 100644
--- a/Documentation/x86/intel_rdt_ui.txt
+++ b/Documentation/x86/intel_rdt_ui.txt
@@ -520,10 +520,6 @@ the pseudo-locked region:
 2) Cache hit and miss measurements using model specific precision counters if
    available. Depending on the levels of cache on the system the pseudo_lock_l2
    and pseudo_lock_l3 tracepoints are available.
-   WARNING: triggering this  measurement uses from two (for just L2
-   measurements) to four (for L2 and L3 measurements) precision counters on
-   the system, if any other measurements are in progress the counters and
-   their corresponding event registers will be clobbered.
 
 When a pseudo-locked region is created a new debugfs directory is created for
 it in debugfs as /sys/kernel/debug/resctrl/<newdir>. A single
diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index 4e588f36228f..280dde8c8229 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -558,5 +558,7 @@ void cqm_setup_limbo_handler(struct rdt_domain *dom, unsigned long delay_ms);
 void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
+extern bool reserve_pmc_hardware(void);
+extern void release_pmc_hardware(void);
 
 #endif /* _ASM_X86_INTEL_RDT_H */
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index f80c58f8adc3..164e9b8b070b 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -1010,6 +1010,8 @@ static int measure_cycles_perf_fn(void *_plr)
 	}
 
 	local_irq_disable();
+	if (!reserve_pmc_hardware())
+		goto out_intr;
 	/*
 	 * Call wrmsr direcly to avoid the local register variables from
 	 * being overwritten due to reordering of their assignment with
@@ -1066,6 +1068,7 @@ static int measure_cycles_perf_fn(void *_plr)
 		l3_miss = native_read_pmc(3);
 	}
 	wrmsr(MSR_MISC_FEATURE_CONTROL, 0x0, 0x0);
+	release_pmc_hardware();
 	local_irq_enable();
 	/*
 	 * On BDW we count references and misses, need to adjust. Sometimes
@@ -1083,6 +1086,11 @@ static int measure_cycles_perf_fn(void *_plr)
 		trace_pseudo_lock_l3(l3_hits, l3_miss);
 	}
 
+	goto out;
+
+out_intr:
+	local_irq_enable();
+	pr_err_ratelimited("Failed to reserve performance monitoring regs\n");
 out:
 	plr->thread_done = 1;
 	wake_up_interruptible(&plr->lock_thread_wq);
-- 
2.17.0

