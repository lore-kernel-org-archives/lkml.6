Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D85FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF5F208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 07:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DF5F208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeFNHIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 03:08:04 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40367 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754589AbeFNHIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 03:08:02 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 13FE720734; Thu, 14 Jun 2018 09:08:00 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6A6A420650;
        Thu, 14 Jun 2018 09:07:59 +0200 (CEST)
Date:   Thu, 14 Jun 2018 09:07:58 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 01/10] i3c: Add core I3C infrastructure
Message-ID: <20180614090758.17180594@bbrezillon>
In-Reply-To: <20180614041941.4i2cadzoevujmzha@ninjato>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
        <20180330074751.25987-2-boris.brezillon@bootlin.com>
        <20180614041941.4i2cadzoevujmzha@ninjato>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 13:19:42 +0900
Wolfram Sang <wsa@the-dreams.de> wrote:

> Hi Boris,
> 
> > +/**
> > + * struct i3c_priv_xfer - I3C SDR private transfer
> > + * @rnw: encodes the transfer direction. true for a read, false for a write
> > + * @len: transfer length in bytes of the transfer
> > + * @data: input/output buffer
> > + */
> > +struct i3c_priv_xfer {
> > +	bool rnw;
> > +	u16 len;
> > +	union {
> > +		void *in;
> > +		const void *out;
> > +	} data;  
> 
> So, this is probably where most payloads end up?
> 
> I didn't notice any sign of DMA in these patches, but given my
> experiences, DMA will come sooner or later. And in I2C, this was
> problematic because then a lot of drivers were in the wild getting their
> buffers from everywhere (stack!). We now have an opt-in approach to mark
> buffers as DMA-safe.
> 
> I don't know if typical I3C transfers will be similar to I2C with
> usually small payloads where DMA usually makes not much sense. Yet, I
> think, that it might be a good idea to think about how this shall be
> handled with I3C right away. Maybe simply enforcing buffers to be
> DMA-safe. Or whatever.
> 
> A clear rule on that might save you hazzle later.

I completely agree. I'll clarify that and for people to pass DMA-able
buffers to this struct (just as the SPI framework does). Note that we
don't really have a way to ensure that the buffer is actually
DMA-safe from the core, because this notion is architecture/SoC
dependent.

> 
> Regards,
> 
>    Wolfram
> 

