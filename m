Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77863C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C35E217FE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C35E217FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbeHDPG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbeHDPGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 995A0857AB;
        Sat,  4 Aug 2018 13:05:44 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 277AE215670D;
        Sat,  4 Aug 2018 13:05:43 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 12/20] perf annotate: Add percent_type to struct annotation_options
Date:   Sat,  4 Aug 2018 15:05:13 +0200
Message-Id: <20180804130521.11408-13-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 04 Aug 2018 13:05:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sat, 04 Aug 2018 13:05:44 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will be used to carry user selection of percent
type for annotation output.

Passing the percent_type to the annotation_line__print
function as the first step and making it default to
current percentage type (PERCENT_HITS_LOCAL) value.

Link: http://lkml.kernel.org/n/tip-6ma4jjbxjcbglkkak3clhw97@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
-- 
2.17.1

