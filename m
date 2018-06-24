Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B609CC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0DF24EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:05:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0DF24EEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751909AbeFXNFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:05:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:52639 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbeFXNE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:04:59 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2CE1C2087B; Sun, 24 Jun 2018 15:04:57 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 003E9206A0;
        Sun, 24 Jun 2018 15:04:46 +0200 (CEST)
Date:   Sun, 24 Jun 2018 15:04:47 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/14] ubi: fastmap: Change a WARN_ON() to ubi_err()
Message-ID: <20180624150447.0a2c745d@bbrezillon>
In-Reply-To: <20180613212344.11608-11-richard@nod.at>
References: <20180613212344.11608-1-richard@nod.at>
        <20180613212344.11608-11-richard@nod.at>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2018 23:23:40 +0200
Richard Weinberger <richard@nod.at> wrote:

> This WARN_ON() was used while development of fastmap, now
> it can be a regular ubi_err().
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/mtd/ubi/fastmap.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/fastmap.c b/drivers/mtd/ubi/fastmap.c
> index dabeb01af24a..d5506152c9f7 100644
> --- a/drivers/mtd/ubi/fastmap.c
> +++ b/drivers/mtd/ubi/fastmap.c
> @@ -949,14 +949,16 @@ static int ubi_attach_fastmap(struct ubi_device *ubi,
>  	ubi_assert(list_empty(&free));
>  
>  	/*
> -	 * If fastmap is leaking PEBs (must not happen), raise a
> -	 * fat warning and fall back to scanning mode.
> -	 * We do this here because in ubi_wl_init() it's too late
> -	 * and we cannot fall back to scanning.
> +	 * The orginal purpose of this check was detecting fastmap bugs were
> +	 * it missed blocks. Now it helps to detect mis-flashed UBIs.
> +	 * E.g. when a fastmap enabled UBI is copied to another target with
> +	 * different bad blocks.
>  	 */
> -	if (WARN_ON(count_fastmap_pebs(ai) != ubi->peb_count -
> -		    ai->bad_peb_count - fm->used_blocks))
> +	if (count_fastmap_pebs(ai) != ubi->peb_count - ai->bad_peb_count -
> +		fm->used_blocks) {

Nitpick, but can you align things like that:

	if (count_fastmap_pebs(ai) != ubi->peb_count - ai->bad_peb_count -
				      fm->used_blocks) {

or

	if (count_fastmap_pebs(ai) !=
	    ubi->peb_count - ai->bad_peb_count - fm->used_blocks) {

or even better, have an avail_peb_count variable:

	avail_peb_count = ubi->peb_count - ai->bad_peb_count - fm->used_blocks;
	if (count_fastmap_pebs(ai) != avail_peb_count)

> +		ubi_err(ubi, "number of PEBs referenced by fastmap does not match MTD!");
>  		goto fail_bad;

Also, I'm not sure I get it. Why is that an error now that we have
preseeded fastmap? Isn't it expected to have a potential mismatch the
first time we boot, or is it already taken into account before we reach
this point?



> +	}
>  
>  	return 0;
>  

