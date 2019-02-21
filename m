Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C93C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8372086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfBUGpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:45:36 -0500
Received: from mail.windriver.com ([147.11.1.11]:45990 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfBUGpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:45:36 -0500
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x1L6ixWQ017543
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 20 Feb 2019 22:44:59 -0800 (PST)
Received: from pek-jsun4-d1.corp.ad.wrs.com (128.224.155.96) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.435.0; Wed, 20 Feb 2019 22:44:58 -0800
From:   Jiwei Sun <jiwei.sun@windriver.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <songliubraving@fb.com>, <yhs@fb.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH] perf record: Add support for limit perf output file size
Date:   Thu, 21 Feb 2019 14:44:19 +0800
Message-ID: <20190221064419.6166-1-jiwei.sun@windriver.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds a new option to limit the output file size, then based
on it, we can create a wrapper of the perf command that uses the option
to avoid exhausting the disk space by the unconscious user.

Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
---
 tools/perf/builtin-record.c | 39 +++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 882285fb9f64..28a03929166d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -81,6 +81,7 @@ struct record {
 	bool			timestamp_boundary;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
+	unsigned long		output_max_size;	/* = 0: unlimited */
 };
 
 static volatile int auxtrace_record__snapshot_started;
@@ -106,6 +107,12 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
+static bool record__output_max_size_exceeded(struct record *rec)
+{
+	return (rec->output_max_size &&
+			rec->bytes_written >= rec->output_max_size);
+}
+
 static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
 			 void *bf, size_t size)
 {
@@ -118,6 +125,9 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
 
 	rec->bytes_written += size;
 
+	if (record__output_max_size_exceeded(rec))
+		raise(SIGTERM);
+
 	if (switch_output_size(rec))
 		trigger_hit(&switch_output_trigger);
 
@@ -1639,6 +1649,33 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
 	return -1;
 }
 
+static int parse_output_max_size(const struct option *opt, const char *str,
+				 int unset)
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
@@ -1946,6 +1983,8 @@ static struct option __record_options[] = {
 		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
 		     record__aio_parse),
 #endif
+	OPT_CALLBACK(0, "output-max-size", &record.output_max_size,
+		     "size", "Output file maximum size", parse_output_max_size),
 	OPT_END()
 };
 
-- 
2.20.1

