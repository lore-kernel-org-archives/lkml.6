Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8036C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DF7222D2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437979AbfBNJnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:43:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:32216 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395247AbfBNJnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:43:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 01:43:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="124411778"
Received: from devel-ww.sh.intel.com ([10.239.48.128])
  by fmsmga008.fm.intel.com with ESMTP; 14 Feb 2019 01:42:59 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, peterz@infradead.org
Cc:     kan.liang@intel.com, mingo@redhat.com, rkrcmar@redhat.com,
        like.xu@intel.com, wei.w.wang@intel.com, jannh@google.com,
        arei.gonglei@huawei.com, jmattson@google.com
Subject: [PATCH v5 07/12] perf/x86: no counter allocation support
Date:   Thu, 14 Feb 2019 17:06:09 +0800
Message-Id: <1550135174-5423-8-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
References: <1550135174-5423-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, an event may be created without needing a counter
allocation. For example, an lbr event may be created by the host
only to help save/restore the lbr stack on the vCPU context switching.

This patch adds a "no_counter" attr boolean to let the callers
explicitly tell the perf core that no counter is needed.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 arch/x86/events/core.c          | 12 ++++++++++++
 include/linux/perf_event.h      |  5 +++++
 include/uapi/linux/perf_event.h |  3 ++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 374a197..c09f03b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -410,6 +410,9 @@ int x86_setup_perfctr(struct perf_event *event)
 	struct hw_perf_event *hwc = &event->hw;
 	u64 config;
 
+	if (is_no_counter_event(event))
+		return 0;
+
 	if (!is_sampling_event(event)) {
 		hwc->sample_period = x86_pmu.max_period;
 		hwc->last_period = hwc->sample_period;
@@ -1209,6 +1212,12 @@ static int x86_pmu_add(struct perf_event *event, int flags)
 	hwc = &event->hw;
 
 	n0 = cpuc->n_events;
+
+	if (is_no_counter_event(event)) {
+		n = n0;
+		goto done_collect;
+	}
+
 	ret = n = collect_events(cpuc, event, false);
 	if (ret < 0)
 		goto out;
@@ -1387,6 +1396,9 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto do_del;
 
+	if (is_no_counter_event(event))
+		goto do_del;
+
 	/*
 	 * Not a TXN, therefore cleanup properly.
 	 */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551..3993e66 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1009,6 +1009,11 @@ static inline bool is_sampling_event(struct perf_event *event)
 	return event->attr.sample_period != 0;
 }
 
+static inline bool is_no_counter_event(struct perf_event *event)
+{
+	return event->attr.no_counter;
+}
+
 /*
  * Return 1 for a software event, 0 for a hardware event
  */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 9de8780..ec97a70 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -372,7 +372,8 @@ struct perf_event_attr {
 				context_switch :  1, /* context switch data */
 				write_backward :  1, /* Write ring buffer from end to beginning */
 				namespaces     :  1, /* include namespaces data */
-				__reserved_1   : 35;
+				no_counter     :  1, /* no counter allocation */
+				__reserved_1   : 34;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
-- 
2.7.4

