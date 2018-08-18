Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ABDC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F21321878
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F21321878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeHROju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:39:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57587 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:39:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBW6Do1286467
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:32:06 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBW6pY1286464;
        Sat, 18 Aug 2018 04:32:06 -0700
Date:   Sat, 18 Aug 2018 04:32:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-c849c12cf344e4b99dbf98df642b622b6c91bbfd@git.kernel.org>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, dsahern@gmail.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, peterz@infradead.org, eranian@google.com,
        tglx@linutronix.de
Reply-To: peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de,
          eranian@google.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
          dsahern@gmail.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, acme@redhat.com, jolsa@kernel.org
In-Reply-To: <20180804130521.11408-14-jolsa@kernel.org>
References: <20180804130521.11408-14-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf annotate: Pass struct annotation_options to
 symbol__calc_lines()
Git-Commit-ID: c849c12cf344e4b99dbf98df642b622b6c91bbfd
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

Commit-ID:  c849c12cf344e4b99dbf98df642b622b6c91bbfd
Gitweb:     https://git.kernel.org/tip/c849c12cf344e4b99dbf98df642b622b6c91bbfd
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sat, 4 Aug 2018 15:05:14 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:50 -0300

perf annotate: Pass struct annotation_options to symbol__calc_lines()

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
 
