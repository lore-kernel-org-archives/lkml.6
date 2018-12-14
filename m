Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C70C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5406D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbeLNUVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:21:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58497 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730733AbeLNUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:21:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKKfpL1450887
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:20:41 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKKfHP1450884;
        Fri, 14 Dec 2018 12:20:41 -0800
Date:   Fri, 14 Dec 2018 12:20:41 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eric Saint-Etienne <tipbot@zytor.com>
Message-ID: <tip-97dfc3423ca701212802a02994d1ec3e688f4891@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        jolsa@kernel.org, eric.saint.etienne@oracle.com,
        eric.saintetienne@gmail.com, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org
Reply-To: eric.saintetienne@gmail.com, hpa@zytor.com, acme@redhat.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          peterz@infradead.org, tglx@linutronix.de, jolsa@kernel.org,
          eric.saint.etienne@oracle.com
In-Reply-To: <1542969759-24346-1-git-send-email-eric.saint.etienne@oracle.com>
References: <1542969759-24346-1-git-send-email-eric.saint.etienne@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf map: Remove extra indirection from map__find()
Git-Commit-ID: 97dfc3423ca701212802a02994d1ec3e688f4891
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

Commit-ID:  97dfc3423ca701212802a02994d1ec3e688f4891
Gitweb:     https://git.kernel.org/tip/97dfc3423ca701212802a02994d1ec3e688f4891
Author:     Eric Saint-Etienne <eric.saint.etienne@oracle.com>
AuthorDate: Fri, 23 Nov 2018 02:42:39 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:46 -0300

perf map: Remove extra indirection from map__find()

A double pointer is used in map__find() where a single pointer is enough
because the function doesn't affect the rbtree and the rbtree is locked.

Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Eric Saint-Etienne <eric.saintetienne@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1542969759-24346-1-git-send-email-eric.saint.etienne@oracle.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 781eed8e3265..a0d58b4d9c32 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -873,19 +873,18 @@ void maps__remove(struct maps *maps, struct map *map)
 
 struct map *maps__find(struct maps *maps, u64 ip)
 {
-	struct rb_node **p, *parent = NULL;
+	struct rb_node *p;
 	struct map *m;
 
 	down_read(&maps->lock);
 
-	p = &maps->entries.rb_node;
-	while (*p != NULL) {
-		parent = *p;
-		m = rb_entry(parent, struct map, rb_node);
+	p = maps->entries.rb_node;
+	while (p != NULL) {
+		m = rb_entry(p, struct map, rb_node);
 		if (ip < m->start)
-			p = &(*p)->rb_left;
+			p = p->rb_left;
 		else if (ip >= m->end)
-			p = &(*p)->rb_right;
+			p = p->rb_right;
 		else
 			goto out;
 	}
