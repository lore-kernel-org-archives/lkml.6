Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE406C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7375D21E9A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:29:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7375D21E9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933943AbeFUV3I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:29:08 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:38446 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933879AbeFUV3A (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 21 Jun 2018 17:29:00 -0400
Received: from linux-r8p5.suse.cz (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 21 Jun 2018 15:28:49 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/4] lib/rhashtable: simplify bucket_table_alloc()
Date:   Thu, 21 Jun 2018 14:28:22 -0700
Message-Id: <20180621212825.3059-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621212825.3059-1-dave@stgolabs.net>
References: <20180621212825.3059-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of ce91f6ee5 (mm: kvmalloc does not fallback to vmalloc for incompatible gfp flag),
we can simplify the caller and trust kvzalloc() to just do the right thing.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/rhashtable.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9427b5766134..26c9cd8a985a 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -175,10 +175,7 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	int i;
 
 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
-	if (gfp != GFP_KERNEL)
-		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
-	else
-		tbl = kvzalloc(size, gfp);
+	tbl = kvzalloc(size, gfp);
 
 	size = nbuckets;
 
-- 
2.16.4

