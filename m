Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD60C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1D32145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 05:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1D32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbeKPQHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 11:07:02 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:37510 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbeKPQHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 11:07:02 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1gNX6j-0004ib-LK; Fri, 16 Nov 2018 13:55:57 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1gNX6d-0007FF-KE; Fri, 16 Nov 2018 13:55:51 +0800
Date:   Fri, 16 Nov 2018 13:55:51 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     NeilBrown <neilb@suse.com>
Cc:     David Miller <davem@davemloft.net>, tgraf@suug.ch,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        eric.dumazet@gmail.com
Subject: Re: [PATCH] rhashtable: detect when object movement between tables
 might have invalidated a lookup
Message-ID: <20181116055551.zxfydbpoicslsfkg@gondor.apana.org.au>
References: <87muqbtev6.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87muqbtev6.fsf@notabene.neil.brown.name>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:32:13AM +1100, NeilBrown wrote:
>
> +#define	RHT_NULLS_MARKER(ptr)	\
> +	((void *)NULLS_MARKER(((unsigned long) (ptr)) >> 1))
>  #define INIT_RHT_NULLS_HEAD(ptr)	\
> -	((ptr) = (typeof(ptr)) NULLS_MARKER(0))
> +	((ptr) = RHT_NULLS_MARKER(&(ptr)))

Why are you shifting this by one?

> diff --git a/lib/rhashtable.c b/lib/rhashtable.c
> index 30526afa8343..852ffa5160f1 100644
> --- a/lib/rhashtable.c
> +++ b/lib/rhashtable.c
> @@ -1179,8 +1179,7 @@ struct rhash_head __rcu **rht_bucket_nested(const struct bucket_table *tbl,
>  					    unsigned int hash)
>  {
>  	const unsigned int shift = PAGE_SHIFT - ilog2(sizeof(void *));
> -	static struct rhash_head __rcu *rhnull =
> -		(struct rhash_head __rcu *)NULLS_MARKER(0);
> +	static struct rhash_head __rcu *rhnull;

I don't understand why you can't continue to do NULLS_MARKER(0) or
RHT_NULLS_MARKER(0).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
