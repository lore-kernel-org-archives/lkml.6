Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC0DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F26520871
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F26520871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbeGFI7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:59:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753535AbeGFI7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:59:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F256D81A4EA9;
        Fri,  6 Jul 2018 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.32.181.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4A067C44;
        Fri,  6 Jul 2018 08:59:33 +0000 (UTC)
Message-ID: <0a44916eacea6c3899152a07321ff69d96ed8c52.camel@redhat.com>
Subject: Re: [PATCH 1/3] rhashtable: further improve stability of
 rhashtable_walk
From:   Paolo Abeni <pabeni@redhat.com>
To:     NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Herbert <tom@quantonium.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 06 Jul 2018 10:59:32 +0200
In-Reply-To: <153086109256.2825.15329014177598382684.stgit@noble>
References: <153086101070.2825.6850140624411927465.stgit@noble>
         <153086109256.2825.15329014177598382684.stgit@noble>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 06 Jul 2018 08:59:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 06 Jul 2018 08:59:35 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pabeni@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-06 at 17:11 +1000, NeilBrown wrote:
> If the sequence:
>    obj = rhashtable_walk_next(iter);
>    rhashtable_walk_stop(iter);
>    rhashtable_remove_fast(ht, &obj->head, params);
>    rhashtable_walk_start(iter);
> 
>  races with another thread inserting or removing
>  an object on the same hash chain, a subsequent
>  rhashtable_walk_next() is not guaranteed to get the "next"
>  object. It is possible that an object could be
>  repeated, or missed.

The above scenario is very similar to the one I'm running:

   rhashtable_walk_next(iter);
   rhashtable_walk_stop(iter);     
   // rhashtable change not yet identified, could be either
   // remove, insert or even rehash
   rhashtable_walk_start(iter);
   rhashtable_walk_next(iter);

but I'm seeing use-after-free there. I'll try this patch to see if
solves my issue.

Note: the code under test is a pending new patch I'm holding due to the
above issue, I can send it as RFC to share the code if you think it may
help.

> @@ -867,15 +866,39 @@ void *rhashtable_walk_next(struct rhashtable_iter *iter)
>  	bool rhlist = ht->rhlist;
>  
>  	if (p) {
> -		if (!rhlist || !(list = rcu_dereference(list->next))) {
> -			p = rcu_dereference(p->next);
> -			list = container_of(p, struct rhlist_head, rhead);
> -		}
> -		if (!rht_is_a_nulls(p)) {
> -			iter->skip++;
> -			iter->p = p;
> -			iter->list = list;
> -			return rht_obj(ht, rhlist ? &list->rhead : p);
> +		if (!rhlist && iter->p_is_unsafe) {
> +			/*
> +			 * First time next() was called after start().
> +			 * Need to find location of 'p' in the list.
> +			 */
> +			struct rhash_head *p;
> +
> +			iter->skip = 0;
> +			rht_for_each_rcu(p, iter->walker.tbl, iter->slot) {
> +				iter->skip++;
> +				if (p <= iter->p)
> +					continue;

Out of sheer ignorance, I really don't understand the goal of the above
conditional ?!?

Should it possibly be something like:
				if (p != iter->p->next)

instead? 
But I think we can't safely dereference 'p' yet ?!?

I'm sorry for the possibly dumb comments, rhashtable internals are
somewhat obscure to me, but I'm really interested in this topic.

Cheers,

Paolo

