Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2ADC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8592086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfBVHUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:20:19 -0500
Received: from mail1.windriver.com ([147.11.146.13]:48064 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfBVHUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:20:18 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x1M7JhM0023911
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 21 Feb 2019 23:19:44 -0800 (PST)
Received: from pek-jsun4-d1.corp.ad.wrs.com (128.224.155.96) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.435.0; Thu, 21 Feb 2019 23:19:43 -0800
From:   Jiwei Sun <jiwei.sun@windriver.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] perf record: Add support for limit perf output file size
Date:   Fri, 22 Feb 2019 15:19:04 +0800
Message-ID: <20190222071904.25073-1-jiwei.sun@windriver.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds a new option to limit the output file size, then based
on it, we can create a wrapper of the perf command that uses the option
to avoid exhausting the disk space by the unconscious user.

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
---
v2 changes:
  - make patch based on latest Arnaldo's perf/core,
  - display warning message when reached the limit.
---
 tools/perf/builtin-record.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 6c3719ac901d..dc3648c0816d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -83,6 +83,7 @@ struct record {
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	cpu_set_t		affinity_mask;
+	unsigned long		output_max_size;	/* = 0: unlimited */
 };
 
 static volatile int auxtrace_record__snapshot_started;
@@ -112,6 +113,12 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
+static bool record__output_max_size_exceeded(struct record *rec)
+{
+	return (rec->output_max_size &&
+	       rec->bytes_written >= rec->output_max_size);
+}
+
 static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
 			 void *bf, size_t size)
 {
@@ -124,6 +131,12 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
 
 	rec->bytes_written += size;
 
+	if (record__output_max_size_exceeded(rec)) {
+		pr_warning("WARNING: The perf data has already reached "
+			   "the limit, stop recording!\n");
+		raise(SIGTERM);
+	}
+
 	if (switch_output_size(rec))
 		trigger_hit(&switch_output_trigger);
 
@@ -1671,6 +1684,33 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
 	return 0;
 }
 
+static int parse_output_max_size(const struct option *opt,
+				 const char *str, int unset)
+{
+	unsigned long *s = (unsigned long *)opt->value;
+	static struct parse_tag tags_size[] = {
+		{ .tag  = 'B', .mult = 1       },
+		{ .tag  = 'K', .mult = 1 << 10 },
+		{ .tag  = 'M', .mult = 1 << 20 },
+		{ .tag  = 'G', .mult = 1 << 30 },
+		{ .tag  = 0 },
+	};
+	unsigned long val;
+
+	if (unset) {
+		*s = 0;
+		return 0;
+	}
+
+	val = parse_tag_value(str, tags_size);
+	if (val != (unsigned long) -1) {
+		*s = val;
+		return 0;
+	}
+
+	return -1;
+}
+
 static int record__parse_mmap_pages(const struct option *opt,
 				    const char *str,
 				    int unset __maybe_unused)
@@ -1982,6 +2022,8 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
+	OPT_CALLBACK(0, "output-max-size", &record.output_max_size,
+		     "size", "Output file maximum size", parse_output_max_size),
 	OPT_END()
 };
 
-- 
2.20.1

