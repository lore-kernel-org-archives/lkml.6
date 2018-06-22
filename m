Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D243C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3278A24740
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3278A24740
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934176AbeFVSfK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:35:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:54205 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933820AbeFVSfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:35:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CE385AB9F;
        Fri, 22 Jun 2018 18:35:06 +0000 (UTC)
Date:   Fri, 22 Jun 2018 11:35:02 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, mhocko@kernel.org,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        neilb@suse.com
Subject: Re: [PATCH v2 1/4] lib/rhashtable: simplify bucket_table_alloc()
Message-ID: <20180622183502.i5dv4d3tbwh5sw6u@linux-r8p5>
References: <20180621212825.3059-1-dave@stgolabs.net>
 <20180621212825.3059-2-dave@stgolabs.net>
 <20180622181540.5gul4lx5dteqzzk3@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180622181540.5gul4lx5dteqzzk3@linux-r8p5>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jun 2018, Davidlohr Bueso wrote:

>This slightly changes the gfp flags passed on to nested_table_alloc() as it will now
>also use GFP_ATOMIC | __GFP_NOWARN. However, I consider this a positive consequence
>as for the same reasons we want nowarn semantics in bucket_table_alloc().

If this is not acceptable, we can just keep the caller's current semantics - the
atomic flag could also be labeled 'rehash' or something considering that it comes
only from insert_rehash() when we get EAGAIN after trying to insert the first time:

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9427b5766134..18740b052aec 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -172,17 +172,15 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 {
 	struct bucket_table *tbl = NULL;
 	size_t size, max_locks;
+	bool atomic = (gfp == GFP_ATOMIC);
 	int i;
 
 	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
-	if (gfp != GFP_KERNEL)
-		tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
-	else
-		tbl = kvzalloc(size, gfp);
+	tbl = kvzalloc(size, atomic ? gfp | __GFP_NOWARN : gfp);
 
 	size = nbuckets;
 
-	if (tbl == NULL && gfp != GFP_KERNEL) {
+	if (tbl == NULL && atomic) {
 		tbl = nested_bucket_table_alloc(ht, nbuckets, gfp);
 		nbuckets = 0;
 	}


