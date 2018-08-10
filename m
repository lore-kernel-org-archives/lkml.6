Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE6DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8844C223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8844C223F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbeHJQHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:07:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:31349 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbeHJQHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:07:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 06:37:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,219,1531810800"; 
   d="scan'208";a="80633125"
Received: from otc-lr-04.jf.intel.com ([10.54.39.114])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2018 06:37:53 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, jolsa@redhat.com, namhyung@kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH RFC 2/7] perf tools: Support new sample type for page size
Date:   Fri, 10 Aug 2018 06:36:22 -0700
Message-Id: <1533908187-25204-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
References: <1533908187-25204-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Support new sample type PERF_SAMPLE_PAGE_SIZE for page size.

Add new option --page-size to record sample page size.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h    | 13 ++++++++++++-
 tools/perf/Documentation/perf-record.txt |  3 +++
 tools/perf/builtin-record.c              |  2 ++
 tools/perf/perf.h                        |  1 +
 tools/perf/util/event.h                  |  1 +
 tools/perf/util/evsel.c                  | 19 ++++++++++++++++++-
 6 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index eeb787b..5473443 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -141,8 +141,9 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_TRANSACTION			= 1U << 17,
 	PERF_SAMPLE_REGS_INTR			= 1U << 18,
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
+	PERF_SAMPLE_PAGE_SIZE			= 1U << 20,
 
-	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63,
 };
@@ -861,6 +862,7 @@ enum perf_event_type {
 	 *	{ u64			abi; # enum perf_sample_regs_abi
 	 *	  u64			regs[weight(mask)]; } && PERF_SAMPLE_REGS_INTR
 	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
+	 *	{ u64			page_size;} && PERF_SAMPLE_PAGE_SIZE
 	 * };
 	 */
 	PERF_RECORD_SAMPLE			= 9,
@@ -1099,6 +1101,15 @@ union perf_mem_data_src {
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
+
+enum perf_mem_page_size {
+	PERF_MEM_PAGE_SIZE_NONE,
+	PERF_MEM_PAGE_SIZE_4K,
+	PERF_MEM_PAGE_SIZE_2M,
+	PERF_MEM_PAGE_SIZE_1G,
+	PERF_MEM_PAGE_SIZE_512G,
+};
+
 /*
  * single taken branch record layout:
  *
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 246dee0..ddfe4be 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -264,6 +264,9 @@ OPTIONS
 --phys-data::
 	Record the sample physical addresses.
 
+--page-size::
+	Record the sample page size
+
 -T::
 --timestamp::
 	Record the sample timestamps. Use it with 'perf report -D' to see the
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 22ebeb92..7f27dbe 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1600,6 +1600,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN('d', "data", &record.opts.sample_address, "Record the sample addresses"),
 	OPT_BOOLEAN(0, "phys-data", &record.opts.sample_phys_addr,
 		    "Record the sample physical addresses"),
+	OPT_BOOLEAN(0, "page-size", &record.opts.sample_page_size,
+		    "Record the sample page size"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
 	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
 			&record.opts.sample_time_set,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 21bf7f5..db06458 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -48,6 +48,7 @@ struct record_opts {
 	bool	     raw_samples;
 	bool	     sample_address;
 	bool	     sample_phys_addr;
+	bool	     sample_page_size;
 	bool	     sample_weight;
 	bool	     sample_time;
 	bool	     sample_time_set;
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index bfa60bc..51456b8 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -202,6 +202,7 @@ struct perf_sample {
 	u32 raw_size;
 	u64 data_src;
 	u64 phys_addr;
+	u64 page_size;
 	u32 flags;
 	u16 insn_len;
 	u8  cpumode;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index ddf84b9..8cf7ec3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1015,6 +1015,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	if (opts->sample_phys_addr)
 		perf_evsel__set_sample_bit(evsel, PHYS_ADDR);
 
+	if (opts->sample_page_size)
+		perf_evsel__set_sample_bit(evsel, PAGE_SIZE);
+
 	if (opts->no_buffering) {
 		attr->watermark = 0;
 		attr->wakeup_events = 1;
@@ -1540,7 +1543,7 @@ static void __p_sample_type(char *buf, size_t size, u64 value)
 		bit_name(PERIOD), bit_name(STREAM_ID), bit_name(RAW),
 		bit_name(BRANCH_STACK), bit_name(REGS_USER), bit_name(STACK_USER),
 		bit_name(IDENTIFIER), bit_name(REGS_INTR), bit_name(DATA_SRC),
-		bit_name(WEIGHT), bit_name(PHYS_ADDR),
+		bit_name(WEIGHT), bit_name(PHYS_ADDR), bit_name(PAGE_SIZE),
 		{ .name = NULL, }
 	};
 #undef bit_name
@@ -2357,6 +2360,12 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		array++;
 	}
 
+	data->page_size = 0;
+	if (type & PERF_SAMPLE_PAGE_SIZE) {
+		data->page_size = *array;
+		array++;
+	}
+
 	return 0;
 }
 
@@ -2509,6 +2518,9 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	if (type & PERF_SAMPLE_PHYS_ADDR)
 		result += sizeof(u64);
 
+	if (type & PERF_SAMPLE_PAGE_SIZE)
+		result += sizeof(u64);
+
 	return result;
 }
 
@@ -2678,6 +2690,11 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 		array++;
 	}
 
+	if (type & PERF_SAMPLE_PAGE_SIZE) {
+		*array = sample->page_size;
+		array++;
+	}
+
 	return 0;
 }
 
-- 
2.7.4

