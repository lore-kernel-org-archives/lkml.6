Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C553AC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D3A206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D3A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeI3Qtp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 12:49:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38566 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbeI3Qtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 12:49:45 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9997B207D8; Sun, 30 Sep 2018 12:17:17 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 53A24206A2;
        Sun, 30 Sep 2018 12:17:07 +0200 (CEST)
Date:   Sun, 30 Sep 2018 12:17:07 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: Re: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of
 undefined bitmask for rxdata
Message-ID: <20180930121707.4724edd6@bbrezillon>
In-Reply-To: <AM0PR04MB4353B48117292E511AC1E09F97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930092535.24544-2-chuanhua.han@nxp.com>
        <20180930120659.71b0e1e5@bbrezillon>
        <AM0PR04MB4353B48117292E511AC1E09F97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2018 10:10:14 +0000
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@bootlin.com>
> > Sent: 2018年9月30日 18:07
> > To: Chuanhua Han <chuanhua.han@nxp.com>
> > Cc: broonie@kernel.org; linux-spi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; eha@deif.com
> > Subject: Re: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of
> > undefined bitmask for rxdata
> > 
> > On Sun, 30 Sep 2018 17:25:33 +0800
> > Chuanhua Han <chuanhua.han@nxp.com> wrote:
> >   
> > > This patch fixes the problem of rxdata being equal to 0 during the
> > > XSPI mode transfer of the dspi controller.
> > > In XSPI mode, If it is not deleted, the value of rxdata will be equal
> > > to 0, and the data received will not be received correctly, causing
> > > the receiving transfer of the spi to fail.
> > >
> > > Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> > > ---
> > > Changes in v2:
> > >  -The original patch is divided into multiple patches(the original
> > > patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
> > > mode"),one of which is segmented.
> > >
> > >  drivers/spi/spi-fsl-dspi.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> > > index 3082e72e4f6c..4dc1064bf408 100644
> > > --- a/drivers/spi/spi-fsl-dspi.c
> > > +++ b/drivers/spi/spi-fsl-dspi.c
> > > @@ -243,9 +243,6 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32  
> > rxdata)  
> > >  	if (!dspi->rx)
> > >  		return;
> > >
> > > -	/* Mask of undefined bits */
> > > -	rxdata &= (1 << dspi->bits_per_word) - 1;
> > > -  
> > 
> > Why not  
> In xspi mode, the value of rxdata after the statement is processed is equal to 0 no matter what data is received.

Only if dspi->bits_per_word is 0.

Actually, I just had a look, and xfer->bits_per_word should never be 0
because spi_validate() makes sure it's initialized [1]. Don't know
where dpsi->bits_per_word comes from, but maybe you have a problem
there (dpsi->bits_per_word and xfer->bits_per_word not in sync).

[1]https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/spi/spi.c#L2869
