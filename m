Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7128C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A465E218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548940371;
	bh=l+hMYyleZdMvs+nKECj68JvNPAZLYxFaw+dcGnDGAs4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TVGXz1Ek/6LUp/MAiw3la7kkz578mJbnRSK1h+2ps5byX8SwNLG06+3oWxa7qUvkf
	 JdS18JS3BeZyGB6Cy0+R1mCaFAdNzpZmmz4F6JnaW3FUY9iE3jJ4TvZY8rsFOPn2Q7
	 DybWMzffQTNhi/vO+Yo2FTSgyhWHJePGPqX1cgeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbfAaNMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726153AbfAaNMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:12:49 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E072F2087F;
        Thu, 31 Jan 2019 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548940368;
        bh=l+hMYyleZdMvs+nKECj68JvNPAZLYxFaw+dcGnDGAs4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gEry/j8ctx5y7ogEtPv/kKAh/Aq9UGxP7DPURymMwibOP2Q7787qslVCFEy6508TY
         +1u1FJKhQtXe4k5HG8Nv4Rt7CJQTvTU0K++ggUmIqJR1zHbqsYkqcPwD6K+kdaoMXu
         thKSvbyp7NEUh+nWAqQLxn6qvV2nS9iWMqC/cSh4=
Date:   Thu, 31 Jan 2019 14:12:35 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 9/9] spi: atmel-quadspi: add support for sam9x60 qspi
 controller
Message-ID: <20190131141235.418e8e9c@bbrezillon>
In-Reply-To: <5a91b6b2-0fed-f411-6e96-568e610f15fa@microchip.com>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-10-tudor.ambarus@microchip.com>
        <20190131125504.3eff449d@bbrezillon>
        <5a91b6b2-0fed-f411-6e96-568e610f15fa@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 12:40:04 +0000
<Tudor.Ambarus@microchip.com> wrote:

> On 01/31/2019 01:55 PM, Boris Brezillon wrote:
> > On Wed, 30 Jan 2019 15:08:47 +0000
> > <Tudor.Ambarus@microchip.com> wrote:
> >   
> >> +
> >> +static int atmel_sam9x60_qspi_set_cfg(struct atmel_qspi *aq,
> >> +				      const struct spi_mem_op *op,
> >> +				      struct atmel_qspi_cfg *cfg)
> >> +{
> >> +	int ret = atmel_qspi_set_mode(cfg, op);
> >> +
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	cfg->icr = QSPI_ICR_INST(op->cmd.opcode);
> >> +
> >> +	if (!op->addr.nbytes) {
> >> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
> >> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> >> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
> >> +		else
> >> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
> >> +	} else {
> >> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;  
> > 
> > Why do you use a MEM transfer here? What's the difference with a
> > regular transfer?  
> 
> QSPI_IFR_TFRTYP_TRSFR_MEM must be set when one wants to read/write in the serial
> memory, and particularly a memory data.
> 
> QSPI_IFR_TFRTYP_TRSFR_REG must be set when one wants to read or write to serial
> memory, but not a memory data.
> Read examples: JEDEC_ID or QSPI_SR
> Write examples: writing the configuration or the QSPI_SR.
> 
> Does this answers your question?

Not really :-). From the SPI bus perspective, there's no difference
between a read/write from/to actual memory blocks or a read/write
reg/param-page, so there must be something different on the controller
side. I think regular transfers should work for anything, which is why
I initially suggested to use that in the ->exec_op() implementation.
If memory accesses are optimized somehow and do not work for all
accesses, then we should keep them for the dirmap implementation.

After reading the sama5d2 datasheet, I have the feeling that the only
difference is the fact that the address is directly extracted from the
AHB window offset when using mem accesses (instead of being taken from
the IAR register), plus the possibility to enable the data
scrambler/randomize.
