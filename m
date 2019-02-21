Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA60FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A487F20880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550742154;
	bh=TsvNBLcnOftsvSMlfWDOrff+Rl4m9ocTFD9DIP04u6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOotHuSd4HxEhpWhD7cG4HdBI7O7Ej/PtZWrGzaoxzq8rUEMS1Av43314IpHHwIoo
	 kpNTAOmpW95co7N0J0F6ebOJiuCKapxstS72wGZ9lY6P0QVu4mM4Bq3o7I3jkWwtwz
	 v0bGFUmnbIx8Ok954bFG/3JOXkZYkAuOVmVn4FYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfBUJmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:42:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36188 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbfBUJm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:42:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 151648552E;
        Thu, 21 Feb 2019 09:42:28 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C847560BF3;
        Thu, 21 Feb 2019 09:42:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 16/17] perf record: Add --output-dir option to store data in directory
Date:   Thu, 21 Feb 2019 10:41:44 +0100
Message-Id: <20190221094145.9151-17-jolsa@kernel.org>
In-Reply-To: <20190221094145.9151-1-jolsa@kernel.org>
References: <20190221094145.9151-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 21 Feb 2019 09:42:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --output-dir option to mimic -o and --dir options.
following commands do the same:

  $ perf record -o perf.dir.data --dir ...
  $ perf record --output-dir perf.dir.data ...

User cannot use both -o and output-dir together,
error is displayed.

Link: http://lkml.kernel.org/n/tip-76ldd2ss6vjvlnjgwy7wxfzt@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/subcmd/parse-options.h         |  4 ++++
 tools/perf/Documentation/perf-record.txt |  3 +++
 tools/perf/builtin-record.c              | 13 +++++++++++--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index af9def589863..8a3be77a3346 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -146,6 +146,10 @@ struct option {
 	  .value = check_vtype(v, const char **), .argh = (a), .help = (h), \
 	  .flags = PARSE_OPT_OPTARG, .defval = (intptr_t)(d), \
 	  .set = check_vtype(os, bool *)}
+#define OPT_STRING_SET(s, l, v, os, a, h) \
+	{ .type = OPTION_STRING, .short_name = (s), .long_name = (l), \
+	  .value = check_vtype(v, const char **), .argh = (a), .help = (h), \
+	  .set = check_vtype(os, bool *)}
 #define OPT_STRING_NOEMPTY(s, l, v, a, h)   { .type = OPTION_STRING,  .short_name = (s), .long_name = (l), .value = check_vtype(v, const char **), .argh = (a), .help = (h), .flags = PARSE_OPT_NOEMPTY}
 #define OPT_DATE(s, l, v, h) \
 	{ .type = OPTION_CALLBACK, .short_name = (s), .long_name = (l), .value = (v), .argh = "time", .help = (h), .callback = parse_opt_approxidate_cb }
diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 445b7a4eb130..aac609887fb7 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -527,6 +527,9 @@ Implies --tail-synthesize.
 --dir::
 Store data into directory with one data file for cpu.
 
+--output-dir::
+Same as --dir option, can't be used together with -o option.
+
 SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-list[1]
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 26981be13aa0..115316e94b34 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -80,6 +80,7 @@ struct record {
 	bool			buildid_all;
 	bool			timestamp_filename;
 	bool			timestamp_boundary;
+	bool			output_is_file;
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	cpu_set_t		affinity_mask;
@@ -1921,8 +1922,10 @@ static struct option __record_options[] = {
 	OPT_STRING('C', "cpu", &record.opts.target.cpu_list, "cpu",
 		    "list of cpus to monitor"),
 	OPT_U64('c', "count", &record.opts.user_interval, "event period to sample"),
-	OPT_STRING('o', "output", &record.data.path, "file",
-		    "output file name"),
+	OPT_STRING_SET('o', "output", &record.data.path, &record.output_is_file,
+		       "file", "output file name"),
+	OPT_STRING_SET(0, "output-dir", &record.data.path, &record.data.is_dir,
+		       "file", "output directory name"),
 	OPT_BOOLEAN_SET('i', "no-inherit", &record.opts.no_inherit,
 			&record.opts.no_inherit_set,
 			"child tasks do not inherit counters"),
@@ -2101,6 +2104,12 @@ int cmd_record(int argc, const char **argv)
 			"cgroup monitoring only available in system-wide mode");
 
 	}
+
+	if (perf_data__is_dir(&rec->data) && record.output_is_file) {
+		ui__error("cannot use both -o and --output-dir\n");
+		return -EINVAL;
+	}
+
 	if (rec->opts.record_switch_events &&
 	    !perf_can_record_switch_events()) {
 		ui__error("kernel does not support recording context switch events\n");
-- 
2.17.2

