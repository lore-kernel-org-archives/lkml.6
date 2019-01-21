Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E3AC31686
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8442089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfAURGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:06:24 -0500
Received: from mga03.intel.com ([134.134.136.65]:19642 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfAURGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:06:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 09:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="111540185"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga008.jf.intel.com with ESMTP; 21 Jan 2019 09:06:17 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 02/12] perf tools: Support new sample type for data page size
Date:   Mon, 21 Jan 2019 09:05:08 -0800
Message-Id: <1548090318-19149-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548090318-19149-1-git-send-email-kan.liang@linux.intel.com>
References: <1548090318-19149-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Support new sample type PERF_SAMPLE_DATA_PAGE_SIZE for page size.

Add new option --data-page-size to record sample data page size.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h    | 16 +++++++++++++++-
 tools/perf/Documentation/perf-record.txt |  3 +++
 tools/perf/builtin-record.c              |  2 ++
 tools/perf/perf.h                        |  1 +
 tools/perf/util/event.h                  |  1 +
 tools/perf/util/evsel.c                  | 19 ++++++++++++++++++-
 6 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ea19b5d..9d3d2af 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -141,8 +141,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
+	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 20,
 
-	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
@@ -861,6 +862,7 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
+	 *	{ u64			data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -1099,6 +1101,18 @@ union perf_mem_data_src {
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
+
+enum perf_mem_page_size {
+	PERF_PAGE_SIZE_NONE,
+	PERF_PAGE_SIZE_4K,
+	PERF_PAGE_SIZE_8K,
+	PERF_PAGE_SIZE_16K,
+	PERF_PAGE_SIZE_64K,
+	PERF_PAGE_SIZE_2M,
+	PERF_PAGE_SIZE_1G,
+	PERF_PAGE_SIZE_512G,
+};
+
 /*
  * single taken branch record layout:
  *
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d232b13..c2a2875 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -264,6 +264,9 @@ OPTIONS
 --phys-data::
 	Record the sample physical addresses.
 
+--data-page-size::
+	Record the sampled data address data page size
+
 -T::
 --timestamp::
 	Record the sample timestamps. Use it with 'perf report -D' to see the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 882285f..50869f6 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1863,6 +1863,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN('d', "data", &record.opts.sample_address, "Record the sample addresses"),
 	OPT_BOOLEAN(0, "phys-data", &record.opts.sample_phys_addr,
 		    "Record the sample physical addresses"),
+	OPT_BOOLEAN(0, "data-page-size", &record.opts.sample_data_page_size,
+		    "Record the sampled data address data page size"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 388c6dd..b17d08d 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -48,6 +48,7 @@ struct record_opts {
 	bool	     raw_samples;
 	bool	     sample_address;
 	bool	     sample_phys_addr;
+	bool	     sample_data_page_size;
 	bool	     sample_weight;
 	bool	     sample_time;
 	bool	     sample_time_set;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index eb95f33..9772296 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -202,6 +202,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 data_page_size;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbc0466..2ef94d5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1019,6 +1019,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	if (opts->sample_phys_addr)
 		perf_evsel__set_sample_bit(evsel, PHYS_ADDR);
 
+	if (opts->sample_data_page_size)
+		perf_evsel__set_sample_bit(evsel, DATA_PAGE_SIZE);
+
 	if (opts->no_buffering) {
 		attr->watermark = 0;
 		attr->wakeup_events = 1;
@@ -1558,7 +1561,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(PERIOD), bit_name(STREAM_ID), bit_name(RAW),
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
-		bit_name(WEIGHT), bit_name(PHYS_ADDR),
+		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(DATA_PAGE_SIZE),
 		{ .name = NULL, }
 	};
 #undef bit_name
@@ -2375,6 +2378,12 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->data_page_size = 0;
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE) {
+		data->data_page_size = *array;
+		array++;
+	}
+
 	return 0;
 }
 
@@ -2527,6 +2536,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE)
+		result += sizeof(u64);
+
 	return result;
 }
 
@@ -2696,6 +2708,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_DATA_PAGE_SIZE) {
+		*array = sample->data_page_size;
+		array++;
+	}
+
 	return 0;
 }
 
-- 
2.7.4

