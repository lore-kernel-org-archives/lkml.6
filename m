Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE218C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA232082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549289819;
	bh=59B7Fg/2o4Q9e4KH7S+tznSA4OHF6+depqmX3mzbg+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UqJpLH5148ZahRJ7gPgx6G4PjiygCCL6JqHHp0ObKPo3X3o4eHheWQ6cJWxdJoHAd
	 wZau4/yCdThlT7sLuHT5eb/E81kYdvFTs4hmmWvd5uL0zGe6RfY8BHPW4pY2exrfuo
	 Jt5YIGgTsfWBSnlpOlq/QxzD7b1oIA2u/QDr9/uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfBDOQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:16:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfBDOQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:16:51 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3F62082E;
        Mon,  4 Feb 2019 14:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549289810;
        bh=59B7Fg/2o4Q9e4KH7S+tznSA4OHF6+depqmX3mzbg+A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JJv0ESeqQZgbulbEEIH2pFrDz2c0tp5Vy69CrMIymAhDgJ6KL7yzjw73LlOjEUnrK
         cVQdYZxqXQZTvQZym/CZh+7JVXi9u1tuclD8H4hRE+PlrZPrBDkTqikpyEl9BfABI6
         3rwR6+WuACsbarZP3DmXdBVSvBW5OHhf9YkKcWjw=
Date:   Mon, 4 Feb 2019 15:16:43 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190204151643.0354180d@bbrezillon>
In-Reply-To: <20190204100910.26701-14-tudor.ambarus@microchip.com>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
        <20190204100910.26701-14-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 10:10:21 +0000
<Tudor.Ambarus@microchip.com> wrote:

> +
> +static void atmel_qspi_sam9x60_write_regs(const struct atmel_qspi *aq,
> +					  const struct spi_mem_op *op,
> +					  const struct atmel_qspi_cfg *cfg)
> +{
> +	/* Clear pending interrupts */
> +	(void)readl_relaxed(aq->regs + QSPI_SR);
> +
> +	/* Set QSPI Instruction Frame registers */
> +	writel_relaxed(cfg->iar, aq->regs + QSPI_IAR);
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		writel_relaxed(cfg->icr, aq->regs + QSPI_RICR);
> +	else
> +		writel_relaxed(cfg->icr, aq->regs + QSPI_ICR);

Can you use WICR here (even if ICR == WICR)?

> +	writel_relaxed(cfg->ifr, aq->regs + QSPI_IFR);
> +}

Hm, so the only difference we have is the RICR vs ICR reg and the
APBTFRTYP_READ vs SAMA5D2_WRITE_TRSFR bit. Not sure it deserves
creating 2 hooks for that. Can we have something like ->has_ricr in
the caps and then have an if/else block directly in
atmel_qspi_set_cfg()?
