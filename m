Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A47C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DEA21501
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 07:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9DEA21501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbeHOKBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 06:01:11 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:25100 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeHOKBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 06:01:11 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 4A59A41218;
        Wed, 15 Aug 2018 09:10:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id 3KKPUjF20oni; Wed, 15 Aug 2018 09:10:09 +0200 (CEST)
Subject: Re: [PATCH v3] spi: orion: cosmetics - alias long direct_access
 variables
To:     Kosta Zertsekel <zertsekel@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Jan_Kundr=c3=a1t?= <jan.kundrat@cesnet.cz>,
        Ken Wilson <ken.wilson@opengear.com>
References: <20180813205445.17113-1-zertsekel@gmail.com>
From:   Stefan Roese <sr@denx.de>
Message-ID: <b9c9ad94-2e10-6f85-2540-c60882d9630a@denx.de>
Date:   Wed, 15 Aug 2018 09:10:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180813205445.17113-1-zertsekel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.08.2018 22:54, Kosta Zertsekel wrote:
> This change increases the source code readability.
> Instead of using `spi->child[cs].direct_access.XXX` use `dir_acc->XXX`.
> Instead of using `orion_spi->child[cs].direct_access.vaddr` use `vaddr`.
> 
> Signed-off-by: Kosta Zertsekel <zertsekel@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   drivers/spi/spi-orion.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index d01a6adc726e..184ba91abeee 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -430,6 +430,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>   	int word_len;
>   	struct orion_spi *orion_spi;
>   	int cs = spi->chip_select;
> +	void __iomem *vaddr;
>   
>   	word_len = spi->bits_per_word;
>   	count = xfer->len;
> @@ -440,8 +441,9 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>   	 * Use SPI direct write mode if base address is available. Otherwise
>   	 * fall back to PIO mode for this transfer.
>   	 */
> -	if ((orion_spi->child[cs].direct_access.vaddr) && (xfer->tx_buf) &&
> -	    (word_len == 8)) {
> +	vaddr = orion_spi->child[cs].direct_access.vaddr;
> +
> +	if (vaddr && xfer->tx_buf && word_len == 8) {
>   		unsigned int cnt = count / 4;
>   		unsigned int rem = count % 4;
>   
> @@ -449,13 +451,11 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
>   		 * Send the TX-data to the SPI device via the direct
>   		 * mapped address window
>   		 */
> -		iowrite32_rep(orion_spi->child[cs].direct_access.vaddr,
> -			      xfer->tx_buf, cnt);
> +		iowrite32_rep(vaddr, xfer->tx_buf, cnt);
>   		if (rem) {
>   			u32 *buf = (u32 *)xfer->tx_buf;
>   
> -			iowrite8_rep(orion_spi->child[cs].direct_access.vaddr,
> -				     &buf[cnt], rem);
> +			iowrite8_rep(vaddr, &buf[cnt], rem);
>   		}
>   
>   		return count;
> @@ -683,6 +683,7 @@ static int orion_spi_probe(struct platform_device *pdev)
>   
>   	/* Scan all SPI devices of this controller for direct mapped devices */
>   	for_each_available_child_of_node(pdev->dev.of_node, np) {
> +		struct orion_direct_acc *dir_acc;
>   		u32 cs;
>   
>   		/* Get chip-select number from the "reg" property */
> @@ -711,14 +712,13 @@ static int orion_spi_probe(struct platform_device *pdev)
>   		 * This needs to get extended for the direct SPI-NOR / SPI-NAND
>   		 * support, once this gets implemented.
>   		 */
> -		spi->child[cs].direct_access.vaddr = devm_ioremap(&pdev->dev,
> -							    r->start,
> -							    PAGE_SIZE);
> -		if (!spi->child[cs].direct_access.vaddr) {
> +		dir_acc = &spi->child[cs].direct_access;
> +		dir_acc->vaddr = devm_ioremap(&pdev->dev, r->start, PAGE_SIZE);
> +		if (!dir_acc->vaddr) {
>   			status = -ENOMEM;
>   			goto out_rel_axi_clk;
>   		}
> -		spi->child[cs].direct_access.size = PAGE_SIZE;
> +		dir_acc->size = PAGE_SIZE;
>   
>   		dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
>   	}
> 

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan
