Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE88EECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B49C20850
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B49C20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeGPUzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 16:55:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:49056 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728290AbeGPUzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 16:55:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5ACA5AD90;
        Mon, 16 Jul 2018 20:26:19 +0000 (UTC)
Date:   Mon, 16 Jul 2018 13:26:13 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     akpm@linux-foundation.org, tgraf@suug.ch,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        netdev@vger.kernel.org
Subject: [PATCH resend -next] lib/rhashtable: consider param->min_size when
 setting initial table size
Message-ID: <20180716202613.u6f3l3adrgjvs4wk@linux-r8p5>
References: <20180714062516.30433-1-dave@stgolabs.net>
 <20180716000046.yscgnpr256qhm2qg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180716000046.yscgnpr256qhm2qg@gondor.apana.org.au>
User-Agent: NeoMutt/20170912 (1.9.0)
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
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
Resending per Herbert's request with Cc to netdev.

 lib/rhashtable.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 62d3a976614e..310e29b51507 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -953,8 +953,16 @@ EXPORT_SYMBOL_GPL(rhashtable_walk_stop);
 
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
@@ -1010,8 +1018,6 @@ int rhashtable_init(struct rhashtable *ht,
 	struct bucket_table *tbl;
 	size_t size;
 
-	size = HASH_DEFAULT_SIZE;
-
 	if ((!params->key_len && !params->obj_hashfn) ||
 	    (params->obj_hashfn && !params->obj_cmpfn))
 		return -EINVAL;
@@ -1035,8 +1041,7 @@ int rhashtable_init(struct rhashtable *ht,
 
 	ht->p.min_size = max_t(u16, ht->p.min_size, HASH_MIN_SIZE);
 
-	if (params->nelem_hint)
-		size = rounded_hashtable_size(&ht->p);
+	size = rounded_hashtable_size(&ht->p);
 
 	if (params->locks_mul)
 		ht->p.locks_mul = roundup_pow_of_two(params->locks_mul);
-- 
2.16.4

