Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E0BC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E48E20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 15:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E48E20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeI2WMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:12:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56110 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbeI2WMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:12:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id EA90520734; Sat, 29 Sep 2018 17:43:40 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id B5A3820711;
        Sat, 29 Sep 2018 17:43:40 +0200 (CEST)
Date:   Sat, 29 Sep 2018 17:43:40 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Esben Haabendal <esben.haabendal@gmail.com>
Cc:     Chuanhua Han <chuanhua.han@nxp.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: spi-fsl-dspi: Fix support for XSPI transport
 mode
Message-ID: <20180929174340.53290075@bbrezillon>
In-Reply-To: <87y3bkcpym.fsf@gmail.com>
References: <20180921070628.35153-1-chuanhua.han@nxp.com>
        <20180921070628.35153-2-chuanhua.han@nxp.com>
        <87y3bkcpym.fsf@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Esben,

On Sat, 29 Sep 2018 16:56:17 +0200
Esben Haabendal <esben.haabendal@gmail.com> wrote:

> Chuanhua Han <chuanhua.han@nxp.com> writes:
> 
> > This patch fixes the problem that the XSPI mode of the dspi controller
> > cannot transfer data properly.
> > In XSPI mode, cmd_fifo is written before tx_fifo, which transforms the
> > byte order of sending and receiving data.  
> 
> Did you find documentation on proper ordering of writes to related
> TX FIFO and CMD FIFO entries?
> 
> I have failed to find such information, and thus opted for what I
> believed would be the safe approach, writing to TX FIFO first, so that
> when CMD FIFO is written, it will already have data in place.  And it
> seems to work.
> 
> But, I now see that SPIx_SR[TFIWF] hints that it should be done the
> other way around.
> 
>     Tranmit FIFO Invalid Write Flag - Indicates Data Write on TX FIFO
>     while CMD FIFO is empty. Without a Command, the Data entries present
>     in TXFIFO are invalid.
> 
> But I fail to see how that should be related to byte ordering.
> 
> So I believe this patch is doing two things.
> 
> 1. Changing write ordering of TX FIFO and CMD FIFO.
> 2. Handling byte ordering based on SPIx_CTARn[LSBFE] flag.
> 
> It would be nice if we could get clarification from NXP on
> what is the right way to do the TX FIFO and CMD FIFO write ordering.
> 
> But as for the byte ordering changes, I don't think it looks write.  The
> meaning of SPIx_CTARn[LSBFE] is according to the documentaiton the bit
> ordering on the wire, and should not be related to register byte
> ordering.
> 
> You should probably split this patch in two, so they can be reviewed and
> merged independently.

Yes, I forgot to mention that, but this patch should definitely be
split in at least 2 patches.

Regards,

Boris 
