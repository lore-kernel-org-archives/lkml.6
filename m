Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6720CC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FDE721EA3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh/sqp+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDE721EA3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbeHIRZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732524AbeHIRZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:48 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51BB72183D;
        Thu,  9 Aug 2018 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826831;
        bh=A9kkUoua3a3Vha5ucFlxRqxY0FC2WIZovIdpAuH4CoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hh/sqp+YeB7t4AKPnZKDh/RifLFhpB599mib/y2x4VOoqHqA6NuF0x+aj10v30EP6
         RdBwgPU3I413Uj1rY++f1PbNLsCvcHS0pXaykpgw2DJkCk7lKNEFxKg/an84m3Qr1b
         sTFXMVyoM4l9yKJn2QqVSqHht2C4BH8pPJQgqNh4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/44] perf annotate: Add percent_type to struct annotation_options
Date:   Thu,  9 Aug 2018 11:58:02 -0300
Message-Id: <20180809145822.21391-25-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

