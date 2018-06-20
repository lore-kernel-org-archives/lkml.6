Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34EFC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E9720846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 10:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E9720846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeFTKL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 06:11:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48309 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeFTKL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 06:11:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 65372207EB; Wed, 20 Jun 2018 12:11:26 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2FB9E206D8;
        Wed, 20 Jun 2018 12:11:16 +0200 (CEST)
Date:   Wed, 20 Jun 2018 12:11:16 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] ubi: Fix assert in ubi_wl_init
Message-ID: <20180620121116.09996426@bbrezillon>
In-Reply-To: <20180613212344.11608-3-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
        <20180613212344.11608-3-richard@nod.at>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 23:23:32 +0200
Richard Weinberger <richard@nod.at> wrote:

> When multiple PEBs are used for a fastmap, found_pebs
> can be wrong and the assert triggers.
> 
> The current approach is broken in two ways:
> 1. The "continue" in list_for_each_entry() over all fastmap PEBs
>    misses the counter at all.
> 2. When the fastmap changes in size, growing due to a preseeded fastmap
>    or shrinking due to new bad blocks, iterating over the current
>    fastmap will give wrong numbers. We have to exclude the fastmap size
>    at all from the calculation to be able to compare the numbers.
>    At this stage we simply have no longer the information whether the
>    fastmap changed in size.

Should this patch be backported to stable releases? You say the problem
arises when new bad blocks appear, so it's not only a problem you'll
have with the preseeded fastmap changes.

> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/mtd/ubi/wl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
> index f66b3b22f328..6bbb968fe9da 100644
> --- a/drivers/mtd/ubi/wl.c
> +++ b/drivers/mtd/ubi/wl.c
> @@ -1695,11 +1695,19 @@ int ubi_wl_init(struct ubi_device *ubi, struct ubi_attach_info *ai)
>  			err = erase_aeb(ubi, aeb, sync);
>  			if (err)
>  				goto out_free;
> -		}
>  
> -		found_pebs++;
> +			/*
> +			 * If no fastmap is used, all fastmap PEBs will get be

				remove either "get" or "be" here ^

> +			 * erased and are member of ai->fastmap.
> +			 */
> +			if (!ubi->fm)
> +				found_pebs++;
> +		}
>  	}
>  
> +	if (ubi->fm)
> +		found_pebs += ubi->fm->used_blocks;
> +

Hm, are we sure this is always correct? I mean, what if you had an old
fastmap scheduled for erasure but a power-cut happened before it was
erased. Are you sure we won't have an inconsistent found_pebs number
(found_pebs != ubi->good_peb_count).

I understand that this problem already exists because of

	if (ubi->lookuptbl[aeb->pnum])
		continue;

but I'm not sure your solution fixes that.

>  	dbg_wl("found %i PEBs", found_pebs);
>  
>  	ubi_assert(ubi->good_peb_count == found_pebs);

