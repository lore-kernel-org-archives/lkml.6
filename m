Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A26DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC022086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 17:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC022086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbeIKWPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 18:15:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:31116 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbeIKWPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 18:15:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 10:14:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,361,1531810800"; 
   d="scan'208";a="79642208"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Sep 2018 10:14:58 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH V3 2/6] perf/core: Add helper to obtain performance counter index
Date:   Tue, 11 Sep 2018 10:14:33 -0700
Message-Id: <6f93048a74c66a275f8eb6e1298f10552d1e5d95.1536685533.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1536685533.git.reinette.chatre@intel.com>
References: <cover.1536685533.git.reinette.chatre@intel.com>
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

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 include/linux/perf_event.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f0ca79..c04dc666425c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1025,6 +1025,27 @@ static inline int in_software_context(struct perf_event *event)
 	return event->ctx->pmu->task_ctx_nr == perf_sw_context;
 }
 
+/**
+ * perf_rdpmc_index - Return PMC counter used for event
+ * @event: the perf_event to which the PMC counter was assigned
+ *
+ * The counter assigned to this performance event may change if interrupts
+ * are enabled. This counter should thus never be used while interrupts are
+ * enabled. Before this function is used to obtain the assigned counter the
+ * event could be checked for validity using, for example,
+ * perf_event_read_local(), within the same interrupt disabled section in
+ * which this counter is planned to be used.
+ *
+ * Return: The index of the performance monitoring counter assigned to
+ * @perf_event.
+ */
+static inline int perf_rdpmc_index(struct perf_event *event)
+{
+	lockdep_assert_irqs_disabled();
+
+	return event->hw.event_base_rdpmc;
+}
+
 extern struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
 
 extern void ___perf_sw_event(u32, u64, struct pt_regs *, u64);
@@ -1319,7 +1340,10 @@ static inline int perf_event_refresh(struct perf_event *event, int refresh)
 {
 	return -EINVAL;
 }
-
+static inline int perf_rdpmc_index(struct perf_event *event)
+{
+	return -1;
+}
 static inline void
 perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
 static inline void
-- 
2.17.0

