Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD93CECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C8520854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C8520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389632AbeGWNc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:32:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbeGWNcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:32:55 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B71C840B;
        Mon, 23 Jul 2018 12:31:55 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 16/28] lib/rhashtable: consider param->min_size when setting initial table size
Date:   Mon, 23 Jul 2018 14:25:16 +0200
Message-Id: <20180723122426.192114453@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122425.241418073@linuxfoundation.org>
References: <20180723122425.241418073@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Davidlohr Bueso <dave@stgolabs.net>

[ Upstream commit 107d01f5ba10f4162c38109496607eb197059064 ]

rhashtable_init() currently does not take into account the user-passed
min_size parameter unless param->nelem_hint is set as well. As such,
the default size (number of buckets) will always be HASH_DEFAULT_SIZE
even if the smallest allowed size is larger than that. Remediate this
by unconditionally calling into rounded_hashtable_size() and handling
things accordingly.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/rhashtable.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -783,8 +783,16 @@ EXPORT_SYMBOL_GPL(rhashtable_walk_stop);
 
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
@@ -841,8 +849,6 @@ int rhashtable_init(struct rhashtable *h
 	struct bucket_table *tbl;
 	size_t size;
 
-	size = HASH_DEFAULT_SIZE;
-
 	if ((!params->key_len && !params->obj_hashfn) ||
 	    (params->obj_hashfn && !params->obj_cmpfn))
 		return -EINVAL;
@@ -869,8 +875,7 @@ int rhashtable_init(struct rhashtable *h
 
 	ht->p.min_size = max(ht->p.min_size, HASH_MIN_SIZE);
 
-	if (params->nelem_hint)
-		size = rounded_hashtable_size(&ht->p);
+	size = rounded_hashtable_size(&ht->p);
 
 	/* The maximum (not average) chain length grows with the
 	 * size of the hash table, at a rate of (log N)/(log log N).


