Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC7FC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C502075E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 10:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C502075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeI3RMu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 13:12:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38746 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbeI3RMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 13:12:50 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 39B8A207D8; Sun, 30 Sep 2018 12:40:18 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id EF6FA20379;
        Sun, 30 Sep 2018 12:40:07 +0200 (CEST)
Date:   Sun, 30 Sep 2018 12:40:08 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Chuanhua Han <chuanhua.han@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eha@deif.com" <eha@deif.com>
Subject: Re: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Message-ID: <20180930124008.365831bf@bbrezillon>
In-Reply-To: <AM0PR04MB4353635C85F0D744D090A14C97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
        <20180930120425.7715cb29@bbrezillon>
        <AM0PR04MB4353635C85F0D744D090A14C97EE0@AM0PR04MB4353.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2018 10:18:18 +0000
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> > -----Original Message-----
> > From: Boris Brezillon <boris.brezillon@bootlin.com>
> > Sent: 2018年9月30日 18:04
> > To: Chuanhua Han <chuanhua.han@nxp.com>
> > Cc: broonie@kernel.org; linux-spi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; eha@deif.com
> > Subject: Re: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
> > 
> > Hi Chuanhua,
> > 
> > On Sun, 30 Sep 2018 17:25:32 +0800
> > Chuanhua Han <chuanhua.han@nxp.com> wrote:
> >   
> > > Before we add this spi_transfer to the spi_message chain table, we
> > > need bits_per_word_mask based on spi_control to set the bits_per_word
> > > of this spi_transfer.  
> > 
> > Let's make it clearer: this is wrong. The spi-mem protocol is just using bytes,
> > not custom size words. Fix the fsl-dspi driver if needed, but don't try to adjust
> > xfer->bits_per_word in spi-mem.c, because this is inappropriate.  
> The value of bits_per_word is only known before the spi_message_add_tail function is called,

No, it's not. It's known from the beginning, and spi_setup() defaults
to 8 when spidev->bits_per_word is 0, which is exactly what we
want. Then, when you send a message through, spi_sync(), spi_validate()
makes sure that each transfer in the message has a
xfer->bits_per_word != 0 and when that's not the case, it sets it to
spi->bits_per_word [2].

Really, there's nothing to fix in spi-mem.c, because it's already doing
the right thing (leaving ->bits_per_word to 0 so that it's set to
spi->bits_per_word, which should be 8). Maybe we have a bug somewhere
else though.

[1]https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/spi/spi.c#L2803
[2]https://elixir.bootlin.com/linux/v4.19-rc5/source/drivers/spi/spi.c#L2869
