Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D951C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C75217BB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 13:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C75217BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbeHDPG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 11:06:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728835AbeHDPG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 11:06:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55CD68197021;
        Sat,  4 Aug 2018 13:05:46 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA4A4215670D;
        Sat,  4 Aug 2018 13:05:44 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 13/20] perf annotate: Pass struct annotation_options to symbol__calc_lines
Date:   Sat,  4 Aug 2018 15:05:14 +0200
Message-Id: <20180804130521.11408-14-jolsa@kernel.org>
In-Reply-To: <20180804130521.11408-1-jolsa@kernel.org>
References: <20180804130521.11408-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Sat, 04 Aug 2018 13:05:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing struct annotation_options to symbol__calc_lines,
to carry on and pass the percent_type value.

Link: http://lkml.kernel.org/n/tip-hsutsg6zepd5o9dxdz0di4pb@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.1

