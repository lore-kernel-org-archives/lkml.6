Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F273ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126F42150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126F42150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbeISXJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:09:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:33318 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733038AbeISXJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:09:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 10:30:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,394,1531810800"; 
   d="scan'208";a="87551429"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2018 10:30:01 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V5 2/6] perf/x86: Add helper to obtain performance counter index
Date:   Wed, 19 Sep 2018 10:29:07 -0700
Message-Id: <b277ffa78a51254f5414f7b1bc1923826874566e.1537377064.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1537377064.git.reinette.chatre@intel.com>
References: <cover.1537377064.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1537377064.git.reinette.chatre@intel.com>
References: <cover.1537377064.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_event_read_local() is the safest way to obtain measurements
associated with performance events. In some cases the overhead
introduced by perf_event_read_local() affects the measurements and the
use of rdpmcl() is needed. rdpmcl() requires the index
of the performance counter used so a helper is introduced to determine
the index used by a provided performance event.

The index used by a performance event may change when interrupts are
enabled. A check is added to ensure that the index is only accessed
with interrupts disabled. Even with this check the use of this counter
needs to be done with care to ensure it is queried and used within the
same disabled interrupts section.

This change introduces a new checkpatch warning:
CHECK: extern prototypes should be avoided in .h files
+extern int x86_perf_rdpmc_index(struct perf_event *event);

This warning was discussed and designated as a false positive in
http://lkml.kernel.org/r/20180919091759.GZ24124@hirez.programming.kicks-ass.net

Link: http://lkml.kernel.org/r/20180917230758.GA3117@worktop.programming.kicks-ass.net
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/events/core.c            | 21 +++++++++++++++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index dfb2f7c0d019..3550d800b030 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1033,6 +1033,27 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	}
 }
 
+/**
+ * x86_perf_rdpmc_index - Return PMC counter used for event
+ * @event: the perf_event to which the PMC counter was assigned
+ *
+ * The counter assigned to this performance event may change if interrupts
+ * are enabled. This counter should thus never be used while interrupts are
+ * enabled. Before this function is used to obtain the assigned counter the
+ * event should be checked for validity using, for example,
+ * perf_event_read_local(), within the same interrupt disabled section in
+ * which this counter is planned to be used.
+ *
+ * Return: The index of the performance monitoring counter assigned to
+ * @perf_event.
+ */
+int x86_perf_rdpmc_index(struct perf_event *event)
+{
+	lockdep_assert_irqs_disabled();
+
+	return event->hw.event_base_rdpmc;
+}
+
 static inline int match_prev_assignment(struct hw_perf_event *hwc,
 					struct cpu_hw_events *cpuc,
 					int i)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 12f54082f4c8..b2cf84c35a6d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -270,6 +270,7 @@ struct perf_guest_switch_msr {
 extern struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr);
 extern void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap);
 extern void perf_check_microcode(void);
+extern int x86_perf_rdpmc_index(struct perf_event *event);
 #else
 static inline struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
 {
-- 
2.17.0

