Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B4C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4A920989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfAURGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:06:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:19648 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbfAURGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:06:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 09:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="111540192"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2019 09:06:17 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 09/12] perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
Date:   Mon, 21 Jan 2019 09:05:15 -0800
Message-Id: <1548090318-19149-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548090318-19149-1-git-send-email-kan.liang@linux.intel.com>
References: <1548090318-19149-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Adds the infrastructure to sample the code address page size.

Introduce a new --code-page-size option for perf record.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h    |  4 +++-
 tools/perf/Documentation/perf-record.txt |  3 +++
 tools/perf/builtin-record.c              |  2 ++
 tools/perf/perf.h                        |  1 +
 tools/perf/util/event.h                  |  1 +
 tools/perf/util/evsel.c                  | 18 ++++++++++++++++++
 6 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 9d3d2af..e4e7e7a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
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
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c2a2875..edaaeca 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -267,6 +267,9 @@ OPTIONS
 --data-page-size::
 	Record the sampled data address data page size
 
+--code-page-size::
+	Record the sampled code address (ip) page size
+
 -T::
 --timestamp::
 	Record the sample timestamps. Use it with 'perf report -D' to see the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 50869f6..687e990 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1865,6 +1865,8 @@ static struct option __record_options[] = {
 		    "Record the sample physical addresses"),
 	OPT_BOOLEAN(0, "data-page-size", &record.opts.sample_data_page_size,
 		    "Record the sampled data address data page size"),
+	OPT_BOOLEAN(0, "code-page-size", &record.opts.sample_code_page_size,
+		    "Record the sampled code address page size"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index b17d08d..36f7b4c 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -49,6 +49,7 @@ struct record_opts {
 	bool	     sample_address;
 	bool	     sample_phys_addr;
 	bool	     sample_data_page_size;
+	bool	     sample_code_page_size;
 	bool	     sample_weight;
 	bool	     sample_time;
 	bool	     sample_time_set;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index bf0346f..14493f1 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -203,6 +203,7 @@ struct perf_sample {
 	u64 data_src;
 	u64 phys_addr;
 	u64 data_page_size;
+	u64 code_page_size;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2ef94d5..3581693 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1022,6 +1022,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	if (opts->sample_data_page_size)
 		perf_evsel__set_sample_bit(evsel, DATA_PAGE_SIZE);
 
+	if (opts->sample_code_page_size)
+		perf_evsel__set_sample_bit(evsel, CODE_PAGE_SIZE);
+
 	if (opts->no_buffering) {
 		attr->watermark = 0;
 		attr->wakeup_events = 1;
@@ -1562,6 +1565,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
 		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(DATA_PAGE_SIZE),
+		bit_name(CODE_PAGE_SIZE),
 		{ .name = NULL, }
 	};
 #undef bit_name
@@ -2384,6 +2388,12 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->code_page_size = PERF_PAGE_SIZE_NONE;
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE) {
+		data->code_page_size = *array;
+		array++;
+	}
+
 	return 0;
 }
 
@@ -2539,6 +2549,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE)
+		result += sizeof(u64);
+
 	return result;
 }
 
@@ -2713,6 +2726,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_CODE_PAGE_SIZE) {
+		*array = sample->code_page_size;
+		array++;
+	}
+
 	return 0;
 }
 
-- 
2.7.4

