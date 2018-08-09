Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E18C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F7821DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzuoQVuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F7821DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbeHIRZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:25:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIRZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:25:52 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0587721EA2;
        Thu,  9 Aug 2018 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826835;
        bh=y0Z2s47tfbJSnZ9O3Xhi+K/mwIbI9VshPh3JV/w4D3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nzuoQVuQjS6i5tducoByzzrS64FO7iiIcD4vU7KTp/Yc1tVTa8glgEcVJL2ez8dDy
         BThJIS75EDOJZUxD01Om/bdvsl6Llg3YmSX3RGtfgGWOy4SvGbaDevTcc29JNGe2f7
         pkWQKfeaQfTq7xOxkAo9EiAT68V7gOww+kfXtfCg=
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
Subject: [PATCH 25/44] perf annotate: Pass struct annotation_options to symbol__calc_lines()
Date:   Thu,  9 Aug 2018 11:58:03 -0300
Message-Id: <20180809145822.21391-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Pass struct annotation_options to symbol__calc_lines(), to carry on and
pass the percent_type value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 91528a065768..2b06476c79c2 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1868,7 +1868,8 @@ int symbol__annotate(struct symbol *sym, struct map *map,
 	return symbol__disassemble(sym, &args);
 }
 
-static void insert_source_line(struct rb_root *root, struct annotation_line *al)
+static void insert_source_line(struct rb_root *root, struct annotation_line *al,
+			       struct annotation_options *opts)
 {
 	struct annotation_line *iter;
 	struct rb_node **p = &root->rb_node;
@@ -1883,7 +1884,7 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 		if (ret == 0) {
 			for (i = 0; i < al->data_nr; i++) {
 				iter->data[i].percent_sum += annotation_data__percent(&al->data[i],
-										      PERCENT_HITS_LOCAL);
+										      opts->percent_type);
 			}
 			return;
 		}
@@ -1896,7 +1897,7 @@ static void insert_source_line(struct rb_root *root, struct annotation_line *al)
 
 	for (i = 0; i < al->data_nr; i++) {
 		al->data[i].percent_sum = annotation_data__percent(&al->data[i],
-								   PERCENT_HITS_LOCAL);
+								   opts->percent_type);
 	}
 
 	rb_link_node(&al->rb_node, parent, p);
@@ -2372,7 +2373,8 @@ void annotation__update_column_widths(struct annotation *notes)
 }
 
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
-				  struct rb_root *root)
+				   struct rb_root *root,
+				   struct annotation_options *opts)
 {
 	struct annotation_line *al;
 	struct rb_root tmp_root = RB_ROOT;
@@ -2385,7 +2387,7 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 			double percent;
 
 			percent = annotation_data__percent(&al->data[i],
-							   PERCENT_HITS_LOCAL);
+							   opts->percent_type);
 
 			if (percent > percent_max)
 				percent_max = percent;
@@ -2396,18 +2398,19 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 
 		al->path = get_srcline(map->dso, notes->start + al->offset, NULL,
 				       false, true, notes->start + al->offset);
-		insert_source_line(&tmp_root, al);
+		insert_source_line(&tmp_root, al, opts);
 	}
 
 	resort_source_line(root, &tmp_root);
 }
 
 static void symbol__calc_lines(struct symbol *sym, struct map *map,
-			      struct rb_root *root)
+			       struct rb_root *root,
+			       struct annotation_options *opts)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
-	annotation__calc_lines(notes, map, root);
+	annotation__calc_lines(notes, map, root, opts);
 }
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
@@ -2424,7 +2427,7 @@ int symbol__tty_annotate2(struct symbol *sym, struct map *map,
 
 	if (opts->print_lines) {
 		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(sym, map, &source_line);
+		symbol__calc_lines(sym, map, &source_line, opts);
 		print_summary(&source_line, dso->long_name);
 	}
 
@@ -2451,7 +2454,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 
 	if (opts->print_lines) {
 		srcline_full_filename = opts->full_path;
-		symbol__calc_lines(sym, map, &source_line);
+		symbol__calc_lines(sym, map, &source_line, opts);
 		print_summary(&source_line, dso->long_name);
 	}
 
-- 
2.14.4

