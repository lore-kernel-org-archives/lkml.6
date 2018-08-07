Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E6AC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B925218FC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B925218FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbeHGTPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:15:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36269 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388481AbeHGTPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:15:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AF4BF209B9; Tue,  7 Aug 2018 19:00:31 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3E0C0209AD;
        Tue,  7 Aug 2018 19:00:21 +0200 (CEST)
Date:   Tue, 7 Aug 2018 19:00:22 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 04/12] mtd: rawnand: ams-delta: request data port
 GPIO resource
Message-ID: <20180807190022.3d326034@bbrezillon>
In-Reply-To: <20180806222918.12644-5-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180806222918.12644-1-jmkrzyszt@gmail.com>
        <20180806222918.12644-5-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Aug 2018 00:29:10 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Data port used by the driver is actually an OMAP MPUIO device, already
> under control of gpio-omap driver.  For that reason we used to not
> request the memory region of the port as that would fail because the
> region is already busy.  Despite that, we are still accessing the port
> by just ioremapping it and performing read/write operations.  Moreover,
> we are doing that without any proteciton from other users legally
> manipulating the port pins over GPIO API.
> 
> The plan is to convert the driver to access the port over functions
> exposed by the gpio-omap driver.  Before that happens, already prevent
> from other users accessing the port pins by requesting an array of its
> GPIO descriptors.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/ams-delta.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 48233d638d2a..09d6901fc94d 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -161,6 +161,7 @@ static int ams_delta_init(struct platform_device *pdev)
>  	struct mtd_info *mtd;
>  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	void __iomem *io_base;
> +	struct gpio_descs *data_gpiods;
>  	int err = 0;
>  
>  	if (!res)
> @@ -261,6 +262,13 @@ static int ams_delta_init(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
>  		goto out_mtd;
>  	}
> +	/* Request array of data pins, initialize them as input */
> +	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_IN);
> +	if (IS_ERR(data_gpiods)) {
> +		err = PTR_ERR(data_gpiods);
> +		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
> +		goto out_mtd;
> +	}
>  
>  	/* Scan to find existence of the device */
>  	err = nand_scan(mtd, 1);

