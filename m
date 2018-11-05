Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69D8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8429B2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8429B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbeKFIRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:17:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58974 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388122AbeKFIRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:17:50 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D3C6520798; Mon,  5 Nov 2018 23:55:47 +0100 (CET)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8D1AC206D8;
        Mon,  5 Nov 2018 23:55:47 +0100 (CET)
Date:   Mon, 5 Nov 2018 23:55:47 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: docg3: don't set conflicting BCH_CONST_PARAMS
 option
Message-ID: <20181105235547.062dbf9f@bbrezillon>
In-Reply-To: <20181011110639.2649053-1-arnd@arndb.de>
References: <20181011110639.2649053-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 13:06:16 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> I noticed during the creation of another bugfix that the BCH_CONST_PARAMS
> option that is set by DOCG3 breaks setting variable parameters for any
> other users of the BCH library code.
> 
> The only other user we have today is the MTD_NAND software BCH
> implementation (most flash controllers use hardware BCH these days
> and are not affected). I considered removing BCH_CONST_PARAMS entirely
> because of the inherent conflict, but according to the description in
> lib/bch.c there is a significant performance benefit in keeping it.
> 
> To avoid the immediate problem of the conflict between MTD_NAND_BCH
> and DOCG3, this only sets the constant parameters if MTD_NAND_BCH
> is disabled, which should fix the problem for all cases that
> are affected. This should also work for all stable kernels.
> 
> Note that there is only one machine that actually seems to use the
> DOCG3 driver (arch/arm/mach-pxa/mioa701.c), so most users should have
> the driver disabled, but it almost certainly shows up if we wanted
> to test random kernels on machines that use software BCH in MTD.
> 
> Fixes: d13d19ece39f ("mtd: docg3: add ECC correction code")
> Cc: stable@vger.kernel.org
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/devices/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> index e514d57a0419..aa983422aa97 100644
> --- a/drivers/mtd/devices/Kconfig
> +++ b/drivers/mtd/devices/Kconfig
> @@ -207,7 +207,7 @@ comment "Disk-On-Chip Device Drivers"
>  config MTD_DOCG3
>  	tristate "M-Systems Disk-On-Chip G3"
>  	select BCH
> -	select BCH_CONST_PARAMS
> +	select BCH_CONST_PARAMS if !MTD_NAND_BCH
>  	select BITREVERSE
>  	help
>  	  This provides an MTD device driver for the M-Systems DiskOnChip

