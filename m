Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D644C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7EF224B3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7EF224B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753612AbeGGG6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 02:58:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50135 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750988AbeGGG6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 02:58:35 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 390992079F; Sat,  7 Jul 2018 08:58:32 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id DB4F2206A6;
        Sat,  7 Jul 2018 08:58:21 +0200 (CEST)
Date:   Sat, 7 Jul 2018 08:58:22 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Joachim Eastwood <manabian@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org, Julia Lawall <julia.lawall@lip6.fr>,
        sil2review@lists.osadl.org
Subject: Re: [PATCH v3] mtd: nxp-spifi: release flash_np in
 nxp_spifi_probe()
Message-ID: <20180707085822.0daad388@bbrezillon>
In-Reply-To: <1525878680-22005-1-git-send-email-khoroshilov@ispras.ru>
References: <20180509170310.65d19c49@bbrezillon>
        <1525878680-22005-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 May 2018 18:11:20 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> nxp_spifi_probe() increments refcnt of SPI flash device node by
> of_get_next_available_child() and leaves it undecremented on both
> successful and error paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Applied after fixing the subject prefix.

> ---
> v3: Move of_node_put() before return value check as Boris Brezillon suggested.
> 
>  drivers/mtd/spi-nor/nxp-spifi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi-nor/nxp-spifi.c b/drivers/mtd/spi-nor/nxp-spifi.c
> index 15374216d4d9..0c9094ec5966 100644
> --- a/drivers/mtd/spi-nor/nxp-spifi.c
> +++ b/drivers/mtd/spi-nor/nxp-spifi.c
> @@ -436,6 +436,7 @@ static int nxp_spifi_probe(struct platform_device *pdev)
>  	}
>  
>  	ret = nxp_spifi_setup_flash(spifi, flash_np);
> +	of_node_put(flash_np);
>  	if (ret) {
>  		dev_err(&pdev->dev, "unable to setup flash chip\n");
>  		goto dis_clks;

