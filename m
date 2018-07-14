Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578F9ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6377208CC
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 06:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6377208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeGNGnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 02:43:25 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:57288 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeGNGnZ (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Sat, 14 Jul 2018 02:43:25 -0400
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Sat, 14 Jul 2018 00:25:29 -0600
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     herbert@gondor.apana.org.au, tgraf@suug.ch,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] lib/rhashtable: consider param->min_size when setting initial table size
Date:   Fri, 13 Jul 2018 23:25:16 -0700
Message-Id: <20180714062516.30433-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rhashtable_init() currently does not take into account the user-passed
min_size parameter unless param->nelem_hint is set as well. As such,
the default size (number of buckets) will always be HASH_DEFAULT_SIZE
even if the smallest allowed size is larger than that. Remediate this
by unconditionally calling into rounded_hashtable_size() and handling
things accordingly.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/rhashtable.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 411c4041ce83..89c3cfc8334d 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -962,8 +962,16 @@ EXPORT_SYMBOL_GPL(rhashtable_walk_stop);
 
 static size_t rounded_hashtable_size(const struct rhashtable_params *params)
 {
-	return max(roundup_pow_of_two(params->nelem_hint * 4 / 3),
-		   (unsigned long)params->min_size);
+	size_t retsize;
+
+	if (params->nelem_hint)
+		retsize = max(roundup_pow_of_two(params->nelem_hint * 4 / 3),
+			      (unsigned long)params->min_size);
+	else
+		retsize = max(HASH_DEFAULT_SIZE,
+			      (unsigned long)params->min_size);
+
+	return retsize;
 }
 
 static u32 rhashtable_jhash2(const void *key, u32 length, u32 seed)
@@ -1020,8 +1028,6 @@ int rhashtable_init(struct rhashtable *ht,
 	struct bucket_table *tbl;
 	size_t size;
 
-	size = HASH_DEFAULT_SIZE;
-
 	if ((!params->key_len && !params->obj_hashfn) ||
 	    (params->obj_hashfn && !params->obj_cmpfn))
 		return -EINVAL;
@@ -1048,8 +1054,7 @@ int rhashtable_init(struct rhashtable *ht,
 
 	ht->p.min_size = max_t(u16, ht->p.min_size, HASH_MIN_SIZE);
 
-	if (params->nelem_hint)
-		size = rounded_hashtable_size(&ht->p);
+	size = rounded_hashtable_size(&ht->p);
 
 	if (params->locks_mul)
 		ht->p.locks_mul = roundup_pow_of_two(params->locks_mul);
-- 
2.16.4

