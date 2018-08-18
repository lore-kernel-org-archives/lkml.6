Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53728C43615
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186532188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186532188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbeHROjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:39:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:39:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBVTbc1286416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:31:29 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBVTYO1286413;
        Sat, 18 Aug 2018 04:31:29 -0700
Date:   Sat, 18 Aug 2018 04:31:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-796ca33d5ceb621f238021c34cff8cfaa1100623@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, dsahern@gmail.com,
        peterz@infradead.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com, mingo@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        hpa@zytor.com
Reply-To: mingo@kernel.org, eranian@google.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          peterz@infradead.org, dsahern@gmail.com,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org
In-Reply-To: <20180804130521.11408-13-jolsa@kernel.org>
References: <20180804130521.11408-13-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Add percent_type to struct
 annotation_options
Git-Commit-ID: 796ca33d5ceb621f238021c34cff8cfaa1100623
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  796ca33d5ceb621f238021c34cff8cfaa1100623
Gitweb:     https://git.kernel.org/tip/796ca33d5ceb621f238021c34cff8cfaa1100623
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:13 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:50 -0300

perf annotate: Add percent_type to struct annotation_options

It will be used to carry user selection of percent type for annotation
output.

Passing the percent_type to the annotation_line__print function as the
first step and making it default to current percentage type
(PERCENT_HITS_LOCAL) value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 13 ++++++++-----
 tools/perf/util/annotate.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e890164592b0..91528a065768 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -49,6 +49,7 @@ struct annotation_options annotation__default_options = {
 	.jump_arrows    = true,
 	.annotate_src	= true,
 	.offset_level	= ANNOTATION__OFFSET_JUMP_TARGETS,
+	.percent_type	= PERCENT_HITS_LOCAL,
 };
 
 static regex_t	 file_lineno;
@@ -1297,7 +1298,8 @@ static int disasm_line__print(struct disasm_line *dl, u64 start, int addr_fmt_wi
 static int
 annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start,
 		       struct perf_evsel *evsel, u64 len, int min_pcnt, int printed,
-		       int max_lines, struct annotation_line *queue, int addr_fmt_width)
+		       int max_lines, struct annotation_line *queue, int addr_fmt_width,
+		       int percent_type)
 {
 	struct disasm_line *dl = container_of(al, struct disasm_line, al);
 	static const char *prev_line;
@@ -1313,7 +1315,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 			double percent;
 
 			percent = annotation_data__percent(&al->data[i],
-							   PERCENT_HITS_LOCAL);
+							   percent_type);
 
 			if (percent > max_percent)
 				max_percent = percent;
@@ -1333,7 +1335,8 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 				if (queue == al)
 					break;
 				annotation_line__print(queue, sym, start, evsel, len,
-						       0, 0, 1, NULL, addr_fmt_width);
+						       0, 0, 1, NULL, addr_fmt_width,
+						       percent_type);
 			}
 		}
 
@@ -1357,7 +1360,7 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
 			struct annotation_data *data = &al->data[i];
 			double percent;
 
-			percent = annotation_data__percent(data, PERCENT_HITS_LOCAL);
+			percent = annotation_data__percent(data, percent_type);
 			color = get_percent_color(percent);
 
 			if (symbol_conf.show_total_period)
@@ -2075,7 +2078,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 
 		err = annotation_line__print(pos, sym, start, evsel, len,
 					     opts->min_pcnt, printed, opts->max_lines,
-					     queue, addr_fmt_width);
+					     queue, addr_fmt_width, opts->percent_type);
 
 		switch (err) {
 		case 0:
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 48fe2aa6b5a8..145dec845f33 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -82,6 +82,7 @@ struct annotation_options {
 	int  context;
 	const char *objdump_path;
 	const char *disassembler_style;
+	unsigned int percent_type;
 };
 
 enum {
