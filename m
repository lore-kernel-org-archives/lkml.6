Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1588ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A630E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 06:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A630E20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbeGSHHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:07:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51134 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbeGSHHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:07:11 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B571120884; Thu, 19 Jul 2018 08:25:39 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 44F70206F3;
        Thu, 19 Jul 2018 08:25:39 +0200 (CEST)
Date:   Thu, 19 Jul 2018 08:25:38 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 4/8] mtd: rawnand: ams-delta: Optimize pointer
 resolution on read/write
Message-ID: <20180719082538.222396bf@bbrezillon>
In-Reply-To: <20180718235710.18242-5-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180718235710.18242-5-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jul 2018 01:57:06 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Further optimize processing speed of read/write callback functions by
> resolving private structure pointer only once per callback and passing
> it to all subfunctions instead of mtd_info.

Not sure this has a real impact on perfs, but I also prefer not using
mtd_info objects within NAND drivers, so I'm good with the change
itself (its probably worth changing the commit message though)

> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 44 +++++++++++++++++++++++-----------------
>  1 file changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index dfefcd79b420..d7e4c9dbef67 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -72,10 +72,9 @@ static const struct mtd_partition partition_info[] = {
>  	  .size		=  3 * SZ_256K },
>  };
>  
> -static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
> +static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
>  {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
> +	struct nand_chip *this = &priv->nand_chip;
>  
>  	writew(byte, this->IO_ADDR_W);
>  	gpiod_set_value(priv->gpiod_nwe, 0);
> @@ -83,21 +82,18 @@ static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
>  	gpiod_set_value(priv->gpiod_nwe, 1);
>  }
>  
> -static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
> +static void ams_delta_write_first_byte(struct ams_delta_nand *priv, u_char byte)
>  {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	void __iomem *io_base = priv->io_base;
>  
>  	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
>  
> -	ams_delta_write_next_byte(mtd, byte);
> +	ams_delta_write_next_byte(priv, byte);
>  }
>  
> -static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
> +static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
>  {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
> +	struct nand_chip *this = &priv->nand_chip;
>  	u_char res;
>  
>  	gpiod_set_value(priv->gpiod_nre, 0);
> @@ -108,36 +104,46 @@ static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
>  	return res;
>  }
>  
> -static u_char ams_delta_read_byte(struct mtd_info *mtd)
> +static u_char ams_delta_read_first_byte(struct ams_delta_nand *priv)
>  {
> -	struct nand_chip *this = mtd_to_nand(mtd);
> -	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	void __iomem *io_base = priv->io_base;
>  
>  	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
>  
> -	return ams_delta_read_next_byte(mtd);
> +	return ams_delta_read_next_byte(priv);
> +}
> +
> +static u_char ams_delta_read_byte(struct mtd_info *mtd)
> +{
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
> +
> +	return ams_delta_read_first_byte(priv);
>  }
>  
>  static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
>  				int len)
>  {
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	int i;
>  
>  	if (len > 0)
> -		ams_delta_write_byte(mtd, buf[0]);
> +		ams_delta_write_first_byte(priv, buf[0]);
>  	for (i = 1; i < len; i++)
> -		ams_delta_write_next_byte(mtd, buf[i]);
> +		ams_delta_write_next_byte(priv, buf[i]);
>  }
>  
>  static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
>  {
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
>  	int i;
>  
>  	if (len > 0)
> -		buf[0] = ams_delta_read_byte(mtd);
> +		buf[0] = ams_delta_read_first_byte(priv);
>  	for (i = 1; i < len; i++)
> -		buf[i] = ams_delta_read_next_byte(mtd);
> +		buf[i] = ams_delta_read_next_byte(priv);
>  }
>  
>  /*
> @@ -161,7 +167,7 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
>  	}
>  
>  	if (cmd != NAND_CMD_NONE)
> -		ams_delta_write_byte(mtd, cmd);
> +		ams_delta_write_first_byte(priv, cmd);
>  }
>  
>  static int ams_delta_nand_ready(struct mtd_info *mtd)

