Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2820DC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB9F208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB9F208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeH1AkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:40:15 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36360 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1AkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:40:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 448BC606D4A7;
        Mon, 27 Aug 2018 22:51:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cCf3NR-tXWlK; Mon, 27 Aug 2018 22:51:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ED9CC603B655;
        Mon, 27 Aug 2018 22:51:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id G4dGKNsuJqqC; Mon, 27 Aug 2018 22:51:56 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A33E2608D734;
        Mon, 27 Aug 2018 22:51:56 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/25] ubifs: Add auth nodes to garbage collector journal head
Date:   Mon, 27 Aug 2018 22:51:56 +0200
Message-ID: <1660996.WYUJqu3I4M@blindfold>
In-Reply-To: <20180704124137.13396-16-s.hauer@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de> <20180704124137.13396-16-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Juli 2018, 14:41:27 CEST schrieb Sascha Hauer:
> To be able to authenticate the garbage collector journal head add
> authentication nodes to the buds the garbage collector creates.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/gc.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
> index ac3a3f7c6a6e..8feeeb12b6ed 100644
> --- a/fs/ubifs/gc.c
> +++ b/fs/ubifs/gc.c
> @@ -365,12 +365,13 @@ static int move_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb)
>  
>  	/* Write nodes to their new location. Use the first-fit strategy */
>  	while (1) {
> -		int avail;
> +		int avail, moved = 0;
>  		struct ubifs_scan_node *snod, *tmp;
>  
>  		/* Move data nodes */
>  		list_for_each_entry_safe(snod, tmp, &sleb->nodes, list) {
> -			avail = c->leb_size - wbuf->offs - wbuf->used;
> +			avail = c->leb_size - wbuf->offs - wbuf->used -
> +					ubifs_auth_node_sz(c);
>  			if  (snod->len > avail)
>  				/*
>  				 * Do not skip data nodes in order to optimize
> @@ -378,14 +379,19 @@ static int move_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb)
>  				 */
>  				break;
>  
> +			ubifs_shash_update(c, c->jheads[GCHD].log_hash,
> +					   snod->node, snod->len);
> +
>  			err = move_node(c, sleb, snod, wbuf);
>  			if (err)
>  				goto out;
> +			moved = 1;
>  		}
>  
>  		/* Move non-data nodes */
>  		list_for_each_entry_safe(snod, tmp, &nondata, list) {
> -			avail = c->leb_size - wbuf->offs - wbuf->used;
> +			avail = c->leb_size - wbuf->offs - wbuf->used -
> +					ubifs_auth_node_sz(c);
>  			if (avail < min)
>  				break;
>  
> @@ -403,7 +409,32 @@ static int move_nodes(struct ubifs_info *c, struct ubifs_scan_leb *sleb)
>  				continue;
>  			}
>  
> +			ubifs_shash_update(c, c->jheads[GCHD].log_hash,
> +					   snod->node, snod->len);
> +
>  			err = move_node(c, sleb, snod, wbuf);
> +			if (err)
> +				goto out;
> +			moved = 1;
> +		}
> +
> +		if (ubifs_authenticated(c) && moved) {
> +			struct ubifs_auth_node *auth;
> +
> +			auth = kmalloc(ubifs_auth_node_sz(c), GFP_NOFS);
> +			if (!auth) {
> +				err = -ENOMEM;
> +				goto out;
> +			}
> +
> +			ubifs_prepare_auth_node(c, auth,
> +						c->jheads[GCHD].log_hash);

ubifs_prepare_auth_node() does a crypto_shash_final(), check.
But the overall "hash life cycle" is not 100% clear to me.
For example, does move_nodes() assume that the hash is initialized
or is it allowed that an crypto_shash_update() happened before?

Thanks,
//richard


