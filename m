Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E65C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275EE252FA
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 20:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275EE252FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbeFXUAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 16:00:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57898 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbeFXUAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 16:00:05 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D7CB020834; Sun, 24 Jun 2018 22:00:03 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8770D206A0;
        Sun, 24 Jun 2018 22:00:03 +0200 (CEST)
Date:   Sun, 24 Jun 2018 22:00:03 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <cyrille.pitchen@microchip.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Cristian.Birsan@microchip.com,
        nicolas.ferre@microchip.com
Subject: Re: [PATCH] mtd: spi-nor: add support to non-uniform SFDP SPI NOR
 flash memories
Message-ID: <20180624220003.5faaae8c@bbrezillon>
In-Reply-To: <20180608134818.21387-2-tudor.ambarus@microchip.com>
References: <20180608134818.21387-1-tudor.ambarus@microchip.com>
        <20180608134818.21387-2-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

Just one minor comment, I'll let Marek review the patch in more details.

On Fri, 8 Jun 2018 16:48:18 +0300
Tudor Ambarus <tudor.ambarus@microchip.com> wrote:

>  /*
>   * Erase an address range on the nor chip.  The address range may extend
>   * one or more erase sectors.  Return an error is there is a problem erasing.
> @@ -511,9 +721,11 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
>  			(long long)instr->len);
>  
> -	div_u64_rem(instr->len, mtd->erasesize, &rem);
> -	if (rem)
> -		return -EINVAL;
> +	if (likely(spi_nor_has_uniform_erase(nor))) {

To be honest, I don't think the likely() makes any difference here,
given the time it takes to actually erase the block. Can we just drop
it?

> +		div_u64_rem(instr->len, mtd->erasesize, &rem);
> +		if (rem)
> +			return -EINVAL;
> +	}

Regards,

Boris
