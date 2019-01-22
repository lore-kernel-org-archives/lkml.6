Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6815C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0BB20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfAVLhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:37:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36921 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfAVLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:37:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MBb8AV2929942
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 03:37:08 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MBb8q62929939;
        Tue, 22 Jan 2019 03:37:08 -0800
Date:   Tue, 22 Jan 2019 03:37:08 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for He Kuang <tipbot@zytor.com>
Message-ID: <tip-da06d568386877809532e8ec678f4a5e300f0951@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        hekuang@huawei.com, peterz@infradead.org
Reply-To: mingo@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
          alexander.shishkin@linux.intel.com, hekuang@huawei.com,
          peterz@infradead.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com
In-Reply-To: <20190120160523.4391-1-hekuang@huawei.com>
References: <20190120160523.4391-1-hekuang@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Fix wrong hottest instruction
 highlighted
Git-Commit-ID: da06d568386877809532e8ec678f4a5e300f0951
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

Commit-ID:  da06d568386877809532e8ec678f4a5e300f0951
Gitweb:     https://git.kernel.org/tip/da06d568386877809532e8ec678f4a5e300f0951
Author:     He Kuang <hekuang@huawei.com>
AuthorDate: Mon, 21 Jan 2019 00:05:22 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 11:29:07 -0300

perf top: Fix wrong hottest instruction highlighted

The annotation line percentage is compared and inserted into the rbtree,
but the percent field of 'struct annotation_data' is an array, the
comparison result between them is the address difference.

This patch compares the right slot of percent array according to
opts->percent_type and makes things right.

The problem can be reproduced by pressing 'H' in perf top annotation view.
It should highlight the instruction line which has the highest sampling
percentage.

Signed-off-by: He Kuang <hekuang@huawei.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190120160523.4391-1-hekuang@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 1d00e5ec7906..82e16bf84466 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -224,20 +224,24 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 	return ret;
 }
 
-static int disasm__cmp(struct annotation_line *a, struct annotation_line *b)
+static double disasm__cmp(struct annotation_line *a, struct annotation_line *b,
+						  int percent_type)
 {
 	int i;
 
 	for (i = 0; i < a->data_nr; i++) {
-		if (a->data[i].percent == b->data[i].percent)
+		if (a->data[i].percent[percent_type] == b->data[i].percent[percent_type])
 			continue;
-		return a->data[i].percent < b->data[i].percent;
+		return a->data[i].percent[percent_type] -
+			   b->data[i].percent[percent_type];
 	}
 	return 0;
 }
 
-static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line *al)
+static void disasm_rb_tree__insert(struct annotate_browser *browser,
+				struct annotation_line *al)
 {
+	struct rb_root *root = &browser->entries;
 	struct rb_node **p = &root->rb_node;
 	struct rb_node *parent = NULL;
 	struct annotation_line *l;
@@ -246,7 +250,7 @@ static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line
 		parent = *p;
 		l = rb_entry(parent, struct annotation_line, rb_node);
 
-		if (disasm__cmp(al, l))
+		if (disasm__cmp(al, l, browser->opts->percent_type) < 0)
 			p = &(*p)->rb_left;
 		else
 			p = &(*p)->rb_right;
@@ -329,7 +333,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 			RB_CLEAR_NODE(&pos->al.rb_node);
 			continue;
 		}
-		disasm_rb_tree__insert(&browser->entries, &pos->al);
+		disasm_rb_tree__insert(browser, &pos->al);
 	}
 	pthread_mutex_unlock(&notes->lock);
 
