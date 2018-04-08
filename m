Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeDHQmN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 12:42:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47031 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752596AbeDHQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 12:42:11 -0400
X-Google-Smtp-Source: AIpwx4/hdtfNAD4RGsoj5gSoidnpFksoqMJ9xnQ0KWlKXQKB1lHQf9aHhi1UudAxXkoiGrW9eg27Yg==
Subject: Re: [PATCH] mtd: spi-nor: clear Extended Address Reg on switch to
 3-byte addressing.
To: NeilBrown <neil@brown.name>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <874lkmw54j.fsf@notabene.neil.brown.name>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <61e255fa-ece4-5566-d63a-730aaa25f18c@gmail.com>
Date: Sun, 8 Apr 2018 12:53:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <874lkmw54j.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2018 09:04 AM, NeilBrown wrote:
> 
> According to section
>    8.2.7 Write Extended Address Register (C5h)
> 
> of the Winbond W25Q256FV data sheet (256M-BIT SPI flash)
> 
>    The Extended Address Register is only effective when the device is
>    in the 3-Byte Address Mode.  When the device operates in the 4-Byte
>    Address Mode (ADS=1), any command with address input of A31-A24
>    will replace the Extended Address Register values. It is
>    recommended to check and update the Extended Address Register if
>    necessary when the device is switched from 4-Byte to 3-Byte Address
>    Mode.
> 
> This patch adds code to implement that recommendation.  Without this,
> my GNUBEE-PC1 will not successfully reboot, as the Extended Address
> Register is left with a value of '1'. When the SOC attempts to read
> (in 3-byte address mode) the boot loader, it reads from the wrong
> location.

Your board is broken by design and does not implement proper reset logic
for the SPI NOR chip, right ? That is, when the CPU resets, the SPI NOR
is left in some random undefined state instead of being reset too, yes?

Doesn't this chip support 4-byte addressing opcodes ? If so, we should
use those and keep the chip in 3-byte addressing mode. Would that work?

> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 10 ++++++++++
>  include/linux/mtd/spi-nor.h   |  2 ++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index d445a4d3b770..c303bf0d2982 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -269,6 +269,7 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
>  	int status;
>  	bool need_wren = false;
>  	u8 cmd;
> +	u8 val;
>  
>  	switch (JEDEC_MFR(info)) {
>  	case SNOR_MFR_MICRON:
> @@ -283,6 +284,15 @@ static inline int set_4byte(struct spi_nor *nor, const struct flash_info *info,
>  		status = nor->write_reg(nor, cmd, NULL, 0);
>  		if (need_wren)
>  			write_disable(nor);
> +		if (!status && !enable &&
> +		    nor->read_reg(nor, SPINOR_OP_RDXA, &val, 1) == 0 &&
> +		    val != 0) {
> +			/* need to reset the Extended Address Register */
> +			write_enable(nor);
> +			val = 0;
> +			nor->write_reg(nor, SPINOR_OP_WRXA, &val, 1);
> +			write_disable(nor);
> +		}
>  
>  		return status;
>  	default:
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index de36969eb359..42954419cfdf 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -62,6 +62,8 @@
>  #define SPINOR_OP_RDCR		0x35	/* Read configuration register */
>  #define SPINOR_OP_RDFSR		0x70	/* Read flag status register */
>  #define SPINOR_OP_CLFSR		0x50	/* Clear flag status register */
> +#define SPINOR_OP_RDXA		0xc8	/* Read Extended Address Register */
> +#define SPINOR_OP_WRXA		0xc5	/* Write Extended Address Register */
>  
>  /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
>  #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
> 


-- 
Best regards,
Marek Vasut
