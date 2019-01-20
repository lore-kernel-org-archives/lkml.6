Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CB3C7113C
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B032085A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 16:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfATQFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 11:05:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfATQFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 11:05:48 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AF1A94449C8B7FB1D0A4;
        Mon, 21 Jan 2019 00:05:44 +0800 (CST)
Received: from huawei.com (100.95.165.100) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Mon, 21 Jan 2019
 00:05:35 +0800
From:   He Kuang <hekuang@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <hekuang@huawei.com>
Subject: [PATCH] perf top: Fix wrong hottest instruction highlighted
Date:   Mon, 21 Jan 2019 00:05:22 +0800
Message-ID: <20190120160523.4391-1-hekuang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [100.95.165.100]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Annotation line's percentage is compared and inserted into rbtree, but the
percent field of 'struct annotation_data' is an array, the comparison
result between them is the address difference.

This patch compares the right slot of percent array according to
opts->percent_type and makes things right.

The problem can be reproduced by pressing 'H' in perf top annotation view.
It should highlight the instruction line which has the highest sampling
percentage.

Signed-off-by: He Kuang <hekuang@huawei.com>
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
 
-- 
2.20.1

