Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49128C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070E0208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070E0208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeH1BE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:04:58 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36852 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbeH1BE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:04:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 61A0F606D4A7;
        Mon, 27 Aug 2018 23:16:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rgwAOVD4G5h4; Mon, 27 Aug 2018 23:16:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BD0B0605A932;
        Mon, 27 Aug 2018 23:16:33 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NQ-KbQLaibgb; Mon, 27 Aug 2018 23:16:33 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 70F43603B551;
        Mon, 27 Aug 2018 23:16:33 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/25] ubifs: authenticate replayed journal
Date:   Mon, 27 Aug 2018 23:16:32 +0200
Message-ID: <2400170.163Ix3ckZ8@blindfold>
In-Reply-To: <20180704124137.13396-17-s.hauer@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de> <20180704124137.13396-17-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 4. Juli 2018, 14:41:28 CEST schrieb Sascha Hauer:
> Make sure that during replay all buds can be authenticated. To do
> this we calculate the hash chain until we find an authentication
> node and check the HMAC in that node against the current status
> of the hash chain.
> 
> After a power cut it can happen that some nodes have been written, but
> not yet the authentication node for them. These nodes have to be
> discarded during replay.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  fs/ubifs/replay.c | 116 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 114 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
> index 07a66ae90e89..45da17d1a74e 100644
> --- a/fs/ubifs/replay.c
> +++ b/fs/ubifs/replay.c
> @@ -34,6 +34,8 @@
>  
>  #include "ubifs.h"
>  #include <linux/list_sort.h>
> +#include <crypto/hash.h>
> +#include <crypto/algapi.h>
>  
>  /**
>   * struct replay_entry - replay list entry.
> @@ -530,6 +532,79 @@ static int is_last_bud(struct ubifs_info *c, struct ubifs_bud *bud)
>  	return data == 0xFFFFFFFF;
>  }
>  
> +/**
> + * authenticate_sleb - authenticate one scan LEB
> + * @c: UBIFS file-system description object
> + * @sleb: the scan LEB to authenticate
> + * @log_hash:
> + * @is_last: if true, this is is the last LEB
> + *
> + * This function iterates over the buds of a single LEB authenticating all buds
> + * with the authentication nodes on this LEB. Authentication nodes are written
> + * after some buds and contain a HMAC covering the authentication node itself
> + * and the buds between the last authentication node and the current
> + * authentication node. It can happen that the last buds cannot be authenticated
> + * because a powercut happened when some nodes were written but not the
> + * corresponding authentication node. This function returns the number of nodes
> + * that could be authenticated or a negative error code.
> + */
> +static int authenticate_sleb(struct ubifs_info *c, struct ubifs_scan_leb *sleb,
> +			     struct shash_desc *log_hash, int is_last)
> +{
> +	int n_not_auth = 0;
> +	struct ubifs_scan_node *snod;
> +	int n_nodes = 0;
> +	int err;
> +
> +	if (!ubifs_authenticated(c))
> +		return sleb->nodes_cnt;
> +
> +	list_for_each_entry(snod, &sleb->nodes, list) {
> +
> +		n_nodes++;
> +
> +		if (snod->type == UBIFS_AUTH_NODE) {
> +			struct ubifs_auth_node *auth = snod->node;
> +			SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
> +			u8 hash[crypto_shash_descsize(c->hash_tfm)];
> +			SHASH_DESC_ON_STACK(hmac_desc, c->hmac_tfm);
> +			u8 hmac[c->hmac_desc_len];
> +
> +			hash_desc->tfm = c->hash_tfm;
> +			hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> +
> +			ubifs_shash_copy_state(c, log_hash, hash_desc);
> +			crypto_shash_final(hash_desc, hash);
> +
> +			hmac_desc->tfm = c->hmac_tfm;
> +			hmac_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
> +			crypto_shash_digest(hmac_desc, hash, c->hash_len, hmac);
> +
> +			err = ubifs_check_hmac(c, auth->hmac, hmac);
> +			if (err) {
> +				err = -EPERM;
> +				goto out;
> +			}
> +			n_not_auth = 0;
> +		} else {
> +			crypto_shash_update(log_hash, snod->node, snod->len);
> +			n_not_auth++;
> +		}
> +	}
> +
> +	/*
> +	 * A powercut can happen when some nodes were written, but not yet
> +	 * the corresponding authentication node. This may only happen on
> +	 * the last bud though.
> +	 */

Can you please add a little debug prints around that?

Thanks,
//richard


