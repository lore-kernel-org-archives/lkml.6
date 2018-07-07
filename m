Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A338AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBAE21A08
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBAE21A08
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932474AbeGGKBk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:01:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51674 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752890AbeGGKBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:01:39 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B11CA207BD; Sat,  7 Jul 2018 12:01:36 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 72DF920741;
        Sat,  7 Jul 2018 12:01:36 +0200 (CEST)
Date:   Sat, 7 Jul 2018 12:01:37 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: Use kasprintf() instead of fixed buffer formatting
Message-ID: <20180707120137.00220db0@bbrezillon>
In-Reply-To: <20180628082011.19553-1-geert+renesas@glider.be>
References: <20180628082011.19553-1-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2018 10:20:11 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Using "%4.4X" in the calculation of the buffer size is misleading, as
> the format string literal has no relation to the actual size needed.
> Hence this is fragile w.r.t. future modification.
> 
> As this is not a hot path, fix this by replacing the formatting in a
> fixed buffer by kasprintf().
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied.

Thanks,

Boris

> ---
> Compile-tested only.
> 
> Interestingly, this decreases code size (by 16 resp. 24 bytes on arm32
> resp. arm64).
> ---
>  drivers/mtd/chips/gen_probe.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/chips/gen_probe.c b/drivers/mtd/chips/gen_probe.c
> index 879bebf9d8b12038..837b04ab96a9c526 100644
> --- a/drivers/mtd/chips/gen_probe.c
> +++ b/drivers/mtd/chips/gen_probe.c
> @@ -202,16 +202,19 @@ static inline struct mtd_info *cfi_cmdset_unknown(struct map_info *map,
>  	struct cfi_private *cfi = map->fldrv_priv;
>  	__u16 type = primary?cfi->cfiq->P_ID:cfi->cfiq->A_ID;
>  #ifdef CONFIG_MODULES
> -	char probename[sizeof("cfi_cmdset_%4.4X")];
>  	cfi_cmdset_fn_t *probe_function;
> +	char *probename;
>  
> -	sprintf(probename, "cfi_cmdset_%4.4X", type);
> +	probename = kasprintf(GFP_KERNEL, "cfi_cmdset_%4.4X", type);
> +	if (!probename)
> +		return NULL;
>  
>  	probe_function = __symbol_get(probename);
>  	if (!probe_function) {
>  		request_module("cfi_cmdset_%4.4X", type);
>  		probe_function = __symbol_get(probename);
>  	}
> +	kfree(probename);
>  
>  	if (probe_function) {
>  		struct mtd_info *mtd;

