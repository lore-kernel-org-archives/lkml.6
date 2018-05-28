Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754348AbeE1KCu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:02:50 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:40966 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754200AbeE1KCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:02:47 -0400
Date: Mon, 28 May 2018 18:02:37 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/6] lib/rhashtable: guarantee initial hashtable
 allocation
Message-ID: <20180528100237.needq2u5e3v2n642@gondor.apana.org.au>
References: <20180524211135.27760-1-dave@stgolabs.net>
 <20180524211135.27760-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524211135.27760-3-dave@stgolabs.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 02:11:31PM -0700, Davidlohr Bueso wrote:
>
> +	/*
> +	 * This is api initialization and thus we need to guarantee the
> +	 * initial rhashtable allocation. Upon failure, retry with a
> +	 * smallest possible size, otherwise we exhaust our options with
> +	 * __GFP_NOFAIL.
> +	 */
>  	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
> -	if (tbl == NULL)
> -		return -ENOMEM;
> +	if (unlikely(tbl == NULL)) {
> +		size = HASH_MIN_SIZE;

You should also take min_size into account.  Yes I know the current
code ignores it unless you also set nelem_hint.  But that's just a
bug.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
