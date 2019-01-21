Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015B1C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D124E2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfAURG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:06:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:19648 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbfAURGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:06:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 09:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="111540191"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2019 09:06:17 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 08/12] perf/core, x86: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Mon, 21 Jan 2019 09:05:14 -0800
Message-Id: <1548090318-19149-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548090318-19149-1-git-send-email-kan.liang@linux.intel.com>
References: <1548090318-19149-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

When studying code layout, it is useful to capture the page size of the
sampled code address.

Add a new sample type for code page size.
The new sample type requires collecting the ip. The code page size can
be calculated from the IRQ-safe perf_get_page_size().

Only the generic support is covered. The large PEBS will be disabled
with this sample type.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  4 +++-
 kernel/events/core.c            | 11 ++++++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3f94d0a..3551e20 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -939,6 +939,7 @@ struct perf_sample_data {
 
 	u64				phys_addr;
 	u64				data_page_size;
+	u64				code_page_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 513c8ae..dc29149 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -142,8 +142,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 20,
+	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 21,
 
-	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -863,6 +864,7 @@ enum perf_event_type {
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
+	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0ddb9c2..35871cd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1754,6 +1754,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		size += sizeof(data->data_page_size);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		size += sizeof(data->code_page_size);
+
 	event->header_size = size;
 }
 
@@ -6305,6 +6308,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		perf_output_put(handle, data->data_page_size);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		perf_output_put(handle, data->code_page_size);
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -6393,7 +6399,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	__perf_event_header__init_id(header, data, event);
 
-	if (sample_type & PERF_SAMPLE_IP)
+	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
@@ -6502,6 +6508,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		data->data_page_size = perf_get_page_size(data->addr);
+
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		data->code_page_size = perf_get_page_size(data->ip);
 }
 
 static __always_inline void
-- 
2.7.4

