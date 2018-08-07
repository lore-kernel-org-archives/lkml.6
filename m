Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3C3C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E2D2089C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="tunz7met"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E2D2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbeHGLWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:22:32 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:43384 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbeHGLWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:22:32 -0400
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:10])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 4C04021268;
        Tue,  7 Aug 2018 12:09:09 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtpcorp1p.mail.yandex.net (Yandex) with ESMTP id 486836E40E5F;
        Tue,  7 Aug 2018 12:09:09 +0300 (MSK)
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:854c:7dcd:9203:76a5])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id VY0GHRByZS-99werGDp;
        Tue, 07 Aug 2018 12:09:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1533632949; bh=KYOvM3TbVkY7Ey+iT2GFlYKRXfEF1WUjtz2h8BP9e14=;
        h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References;
        b=tunz7metJEHozpYfohIFXLALA9szVgQ494Na9SzdGx+9cYvY0nnHZYajUasoS+NMr
         NW2okYM9gK21ASYF2zXEVZSuKecXyJ+aZDwV6lV/cLFoxyhkM65qkhP/uxElfdPOHv
         Wju25QPKFq1dY8taRglI/JAneQ2Cj5GFaO0X8N3M=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH 2/2] perf map: optimize maps__fixup_overlappings()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Date:   Tue, 07 Aug 2018 12:09:05 +0300
Message-ID: <153363294565.396323.4605638589903548668.stgit@buzz>
In-Reply-To: <153363294102.396323.6277944760215058174.stgit@buzz>
References: <153363294102.396323.6277944760215058174.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function splits and removes overlapping areas.

Maps in tree are ordered by start address thus we could find
first overlap and stop if next map does not overlap.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 tools/perf/util/map.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 89ac5b5dc218..9b3f4d244ad4 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -675,20 +675,35 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
 static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 {
 	struct rb_root *root;
-	struct rb_node *next;
+	struct rb_node *next, *first;
 	int err = 0;
 
 	down_write(&maps->lock);
 
 	root = &maps->entries;
-	next = rb_first(root);
 
+	/* find first where end > map->start, same as find_vma() */
+	next = root->rb_node;
+	first = NULL;
+	while (next) {
+		struct map *pos = rb_entry(next, struct map, rb_node);
+
+		if (pos->end > map->start) {
+			first = next;
+			if (pos->start <= map->start)
+				break;
+			next = next->rb_left;
+		} else
+			next = next->rb_right;
+	}
+
+	next = first;
 	while (next) {
 		struct map *pos = rb_entry(next, struct map, rb_node);
 		next = rb_next(&pos->rb_node);
 
 		if (!map__overlap(pos, map))
-			continue;
+			break;
 
 		if (verbose >= 2) {
 

