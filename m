Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218A7C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB6320989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548095760;
	bh=tA1gftCIFZFJKS+Mo3rmGZVt+0IlMJ4sOPNrCrYV6Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aQUnC3FNy+RLuTYPLNSlhGUd2Svee62DoEDnnVzAoCl/shttyBWq6UDVt9TeVm9If
	 dDPdgfp4JDaBNHuWmUQfV1Qqzf33n8xcwY6e9X81KoSxjIZWHetLBZfmmoBMWl0w67
	 3PlWX5ZO2Eoimai/rnPpfEOMg1+IR9Uy30kwHFxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfAUSf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:35:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:43250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbfAUSf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:35:56 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22AC121721;
        Mon, 21 Jan 2019 18:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548095755;
        bh=tA1gftCIFZFJKS+Mo3rmGZVt+0IlMJ4sOPNrCrYV6Y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDuv6lEZ6IP9eZJ2IIGIUYXaxLAT2wqhqhGsCXZS+vWlQbVmiFcAQy9DJwSN59zfN
         FvmioHj8JWBkgI58pKEbZ3V1EX3Y7m5lOTg9wxPleeTnd1Aprt273WGsh3yko5tGaj
         cLBL1r7E6elx+rhIc0/TABEOxrH8bGKoqp75zu5g=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, He Kuang <hekuang@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 6/7] perf top: Fix wrong hottest instruction highlighted
Date:   Mon, 21 Jan 2019 15:35:06 -0300
Message-Id: <20190121183507.23490-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121183507.23490-1-acme@kernel.org>
References: <20190121183507.23490-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Kuang <hekuang@huawei.com>

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
 
-- 
2.20.1

