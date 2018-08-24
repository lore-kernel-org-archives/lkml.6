Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C58C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257A621564
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 12:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257A621564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeHXQb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 12:31:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47963 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbeHXQb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 12:31:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 608AF2072C; Fri, 24 Aug 2018 14:57:23 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id C01C2206A6;
        Fri, 24 Aug 2018 14:57:19 +0200 (CEST)
Date:   Fri, 24 Aug 2018 14:57:18 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mtd: rawnand: ams-delta: Set port direction when
 needed
Message-ID: <20180824145718.07defe03@bbrezillon>
In-Reply-To: <20180820213904.13475-4-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
        <20180820213904.13475-1-jmkrzyszt@gmail.com>
        <20180820213904.13475-4-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018 23:39:04 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> In its current shape, the driver sets data port direction before each
> byte read/write operation, even during multi-byte transfers.  Improve
> performance of the driver by setting the port direction only when
> needed.
> 
> This optimisation will become particularly important as soon as
> planned conversion of the driver to GPIO API for data I/O will be
> implemented.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/mtd/nand/raw/ams-delta.c | 68 ++++++++++++++++++++++++++--------------
>  1 file changed, 45 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 48233d638d2a..4d5e5790f18e 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -45,6 +45,7 @@ struct ams_delta_nand {
>  	struct gpio_desc	*gpiod_ale;
>  	struct gpio_desc	*gpiod_cle;
>  	void __iomem		*io_base;
> +	bool			data_in;
>  };
>  
>  /*
> @@ -72,50 +73,65 @@ static const struct mtd_partition partition_info[] = {
>  	  .size		=  3 * SZ_256K },
>  };
>  
> -static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
> +static void ams_delta_io_write(struct ams_delta_nand *priv, u8 byte)
>  {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
> -	void __iomem *io_base = priv->io_base;
> -
> -	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
> -	writew(byte, this->IO_ADDR_W);
> +	writew(byte, priv->nand_chip.IO_ADDR_W);
>  	gpiod_set_value(priv->gpiod_nwe, 0);
>  	ndelay(40);
>  	gpiod_set_value(priv->gpiod_nwe, 1);
>  }
>  
> -static u_char ams_delta_read_byte(struct mtd_info *mtd)
> +static u8 ams_delta_io_read(struct ams_delta_nand *priv)
>  {
> -	u_char res;
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
> -	void __iomem *io_base = priv->io_base;
> +	u8 res;
>  
>  	gpiod_set_value(priv->gpiod_nre, 0);
>  	ndelay(40);
> -	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
> -	res = readw(this->IO_ADDR_R);
> +	res = readw(priv->nand_chip.IO_ADDR_R);
>  	gpiod_set_value(priv->gpiod_nre, 1);
>  
>  	return res;
>  }
>  
> -static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
> -				int len)
> +static void ams_delta_dir_input(struct ams_delta_nand *priv, bool in)
>  {
> +	writew(in ? ~0 : 0, priv->io_base + OMAP_MPUIO_IO_CNTL);
> +	priv->data_in = in;
> +}
> +
> +static void ams_delta_write_buf(struct mtd_info *mtd, const u8 *buf, int len)
> +{
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	int i;
>  
> -	for (i=0; i<len; i++)
> -		ams_delta_write_byte(mtd, buf[i]);
> +	if (priv->data_in)
> +		ams_delta_dir_input(priv, false);
> +
> +	for (i = 0; i < len; i++)
> +		ams_delta_io_write(priv, buf[i]);
>  }
>  
> -static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
> +static void ams_delta_read_buf(struct mtd_info *mtd, u8 *buf, int len)
>  {
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	int i;
>  
> -	for (i=0; i<len; i++)
> -		buf[i] = ams_delta_read_byte(mtd);
> +	if (!priv->data_in)
> +		ams_delta_dir_input(priv, true);
> +
> +	for (i = 0; i < len; i++)
> +		buf[i] = ams_delta_io_read(priv);
> +}
> +
> +static u8 ams_delta_read_byte(struct mtd_info *mtd)
> +{
> +	u8 res;
> +
> +	ams_delta_read_buf(mtd, &res, 1);
> +
> +	return res;
>  }
>  
>  /*
> @@ -138,8 +154,11 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
>  		gpiod_set_value(priv->gpiod_ale, !!(ctrl & NAND_ALE));
>  	}
>  
> -	if (cmd != NAND_CMD_NONE)
> -		ams_delta_write_byte(mtd, cmd);
> +	if (cmd != NAND_CMD_NONE) {
> +		u8 byte = cmd;
> +
> +		ams_delta_write_buf(mtd, &byte, 1);
> +	}
>  }
>  
>  static int ams_delta_nand_ready(struct mtd_info *mtd)
> @@ -262,6 +281,9 @@ static int ams_delta_init(struct platform_device *pdev)
>  		goto out_mtd;
>  	}
>  
> +	/* Initialize data port direction to a known state */
> +	ams_delta_dir_input(priv, true);
> +
>  	/* Scan to find existence of the device */
>  	err = nand_scan(mtd, 1);
>  	if (err)

