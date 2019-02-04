Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945252087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549288905;
	bh=3KNwqHnHGZNCWkch9CrjOjSh+cKQ+OW5kIx/iou8hsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e05v5VC0V0BVLwXXQjziKzCMuDHGD1HbZmP3ltPG87Rj0AXM9sEzvfBWziZTA8xoX
	 aXl4jiQbG2J4P/2/W5V6BufMtdw13sqLsrnW1VCkeUbc1XtUS8kX0W+HyCJLvz/8M4
	 PMPNS12rh9brhlgiZ9tCpjs84mRnqx7OxqFXh7UU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfBDOBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:01:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfBDOBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:01:43 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BACA2082F;
        Mon,  4 Feb 2019 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549288902;
        bh=3KNwqHnHGZNCWkch9CrjOjSh+cKQ+OW5kIx/iou8hsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EKh2xoBo4ZacXyPGZI9QCUvf4sv2duUHecD7SFeuuOMxbLdHBl0YrcDDjO+muuxGP
         Lel8MDvrwy5GqsX8Lyt+DrHPxiCkPhJoP9RwCAZqKU8fAkFHm5GVMd6B1KDiQpGVAy
         EU4EqBuw+nXxWOGdkcEyJInQGzIyG5N0Hn2COmus=
Date:   Mon, 4 Feb 2019 15:01:36 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v4 08/13] spi: atmel-quadspi: rework transfer macros
Message-ID: <20190204150136.519060ff@bbrezillon>
In-Reply-To: <20190204100910.26701-9-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
        <20190204100910.26701-9-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 10:09:53 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Split the TFRTYP_TRSFR_ bitfields in 2: one bit encoding the
> mem/reg transfer type and one bit encoding the direction of
> the transfer (read/write).
> 
> Remove NOP when setting read transfer type. Remove useless
> setting of write transfer type when
> op->data.dir == SPI_MEM_DATA_IN && !op->data.nbytes.
> 
> QSPI_IFR_TFRTYP_TRSFR_WRITE is specific just to sama5d2 qspi,
> rename it to QSPI_IFR_SAMA5D2_WRITE_TRSFR.
> 
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v4: introduce QSPI_IFR_TFRTYP_MEM, reword commit
> v3: new patch
> 
>  drivers/spi/atmel-quadspi.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index ce4f8a648f45..19a3980775ad 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -113,11 +113,8 @@
>  #define QSPI_IFR_OPTL_4BIT              (2 << 8)
>  #define QSPI_IFR_OPTL_8BIT              (3 << 8)
>  #define QSPI_IFR_ADDRL                  BIT(10)
> -#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
> -#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
> -#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
> -#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
> +#define QSPI_IFR_TFRTYP_MEM		BIT(12)
> +#define QSPI_IFR_SAMA5D2_WRITE_TRSFR	BIT(13)
>  #define QSPI_IFR_CRM                    BIT(14)
>  #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
>  #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
> @@ -275,10 +272,8 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	if (op->data.nbytes)
>  		ifr |= QSPI_IFR_DATAEN;
>  
> -	if (op->data.dir == SPI_MEM_DATA_IN && op->data.nbytes)
> -		ifr |= QSPI_IFR_TFRTYP_TRSFR_READ;
> -	else
> -		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
>  
>  	/* Clear pending interrupts */
>  	(void)readl_relaxed(aq->regs + QSPI_SR);

