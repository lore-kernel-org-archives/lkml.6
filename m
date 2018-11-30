Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C63C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95F22146F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+yL7WIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95F22146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLAFh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:37:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbeLAFhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:37:25 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B07E2146D;
        Fri, 30 Nov 2018 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543602436;
        bh=/fv6f/laK3D8TwsUde0xf9nczTSA2IjiajQcamhwOYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+yL7WIgW/5FKQc7P4rlyY+ymMWqwN7grfGxkyueY0QnY53INai54fsv2swIx+hOR
         R6zGvEW+IQmnNM8W7adlnBrGXkhp7oQJIKAXVnkwQAcZmelaNFV2BiVt5hGS4VGDxX
         +AkYnmFM4qV9nqJQfqmKsMxKgkaOV90opbPNBOt0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/22] perf map: Remove extra indirection from map__find()
Date:   Fri, 30 Nov 2018 15:26:34 -0300
Message-Id: <20181130182652.23620-5-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Saint-Etienne <eric.saint.etienne@oracle.com>

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
-- 
2.19.1

