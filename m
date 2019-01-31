Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FD7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB2B21939
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbfAaU3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:29:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:4820 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbfAaU25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:28:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jan 2019 12:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,545,1539673200"; 
   d="scan'208";a="143176584"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by fmsmga001.fm.intel.com with ESMTP; 31 Jan 2019 12:28:57 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, luto@amacapital.net,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 09/13] perf/core, x86: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Thu, 31 Jan 2019 12:28:02 -0800
Message-Id: <1548966486-49963-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
References: <1548966486-49963-1-git-send-email-kan.liang@linux.intel.com>
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

No changes since V3

 include/linux/perf_event.h      |  1 +
 include/uapi/linux/perf_event.h |  4 +++-
 kernel/events/core.c            | 11 ++++++++++-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0e048ab..10c23f9 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -938,6 +938,7 @@ struct perf_sample_data {
 
 	u64				phys_addr;
 	u64				data_page_size;
+	u64				code_page_size;
 } ____cacheline_aligned;
 
 /* default value for data source */
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 0e8d222..045e218 100644
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
@@ -865,6 +866,7 @@ enum perf_event_type {
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
 	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
+	 *	{ u64			code_page_size;} && PERF_SAMPLE_CODE_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index d233f45..a1575b4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1756,6 +1756,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		size += sizeof(data->data_page_size);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		size += sizeof(data->code_page_size);
+
 	event->header_size = size;
 }
 
@@ -6311,6 +6314,9 @@ void perf_output_sample(struct perf_output_handle *handle,
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		perf_output_put(handle, data->data_page_size);
 
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		perf_output_put(handle, data->code_page_size);
+
 	if (!event->attr.watermark) {
 		int wakeup_events = event->attr.wakeup_events;
 
@@ -6399,7 +6405,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	__perf_event_header__init_id(header, data, event);
 
-	if (sample_type & PERF_SAMPLE_IP)
+	if (sample_type & (PERF_SAMPLE_IP | PERF_SAMPLE_CODE_PAGE_SIZE))
 		data->ip = perf_instruction_pointer(regs);
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
@@ -6508,6 +6514,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 
 	if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		data->data_page_size = perf_get_page_size(data->addr);
+
+	if (sample_type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		data->code_page_size = perf_get_page_size(data->ip);
 }
 
 static __always_inline int
-- 
2.7.4

