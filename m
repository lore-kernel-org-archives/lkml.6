Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD974ECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6636B2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 12:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6636B2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbeIRSYb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 14:24:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41515 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbeIRSYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 14:24:31 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 64A1920737; Tue, 18 Sep 2018 14:52:01 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-99-10.w90-88.abo.wanadoo.fr [90.88.4.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id F30FB206FF;
        Tue, 18 Sep 2018 14:52:00 +0200 (CEST)
Date:   Tue, 18 Sep 2018 14:52:01 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Message-ID: <20180918145201.68adcb8d@bbrezillon>
In-Reply-To: <VI1PR04MB1038EDE4B2F5AFC5B0FDE8DF991D0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1537177710-9379-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <9a80752f-2db3-bf76-fbf4-e5efaa3974d7@exceet.de>
        <VI1PR04MB1038EDE4B2F5AFC5B0FDE8DF991D0@VI1PR04MB1038.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yogesh,

On Tue, 18 Sep 2018 11:34:18 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > 
> > Do we really need all those macros for registers and modes, that
> > aren't even used in the driver? I don't know what the common
> > practice is, but to me it seems like removing all the unused macros
> > would make the driver much smaller and more readable.
> >   
> We don't need all Macros currently, but can be needed in future and
> then have to add again. Generally, we add them all so that in future
> don't have to dig in datasheet to add basic register details.

I guess it's just a matter of taste, but I also prefer when all regs are
defined even if not all of them are used.

[...]

> > 
> > You are only considering 3 and 4 byte long addresses, which is fine
> > for NOR chips, but the SPI mem interface allows to connect other
> > chips like SPI NAND which also use 1 byte addresses.
> > 
> > In the QSPI driver Boris worked around this restriction by using
> > LUT_MODE instead of LUT_ADDRESS.
> > 
> > Does this restriction also exist for FSPI?  
> 
> Yes, I have seen that implementation and first tries with that same
> logic, using LUT_MODE instead of LUT_ADDR, but didn’t work for the
> FlexSPI controller.
> 
> In this controller, we are having separate LUT_XX for RowAddress and
> ColumnAddress. For case of the Nand flash, we need to program both
> RowAddress and ColumnAddress in single LUT sequence.

Hm, I don't get it. LUT_MODE was just a way to pass raw data on the I/O
bus, so the row vs column thing has no meaning in this case, and the
offset withing the QSPI AHB range should just be ignored.

> 
> IMO, when support needs to be added for NAND flash, then slight
> modification can be done in the logic. As per my discussion with
> controller validation guys, needs to send 16-bit addrlen for
> RowAddress, LUT_ADDR (0x2) Addrlen can vary for the column-address
> and needs to be programmed for sequence LUT_CADDR_SDR (0x3)

And that's again flash specific details leaking into the spi-mem layer,
which I'd like to avoid (as repeated many times before).

> > 
> > You are using the remapping procedure as in the QSPI NOR driver.
> > The original purpose was to start with a rather small mapping size
> > and increase it when a larger memory device is used.
> > 
> > At the same time you use the logic from the QSPI SPI mem driver,
> > that adjusts the data.nbytes of each read op to a maximum of
> > ahb_buf_size in nxp_fspi_adjust_op_size().
> > This is the logic that Boris introduced for the QSPI driver until
> > we replace it with something like dirmap.
> > 
> > Unless there is something I missed, this means the ramapping is
> > useless and it's enough to reserve memory with the fixed size of
> > ahb_buf_size. 
> 
> My concern was for performance and that's why has done remap for the
> 4MB buffer size so that if any subsequent Read request would come
> within the range then don’t have to perform remap and can just
> directly do memcpy()
> 
> I would re-visit again and see if getting any issue in doing direct
> memcpy() instead of remap. We need to perform AHB buffer invalidation
> when using controller in both IP(write, erase etc) and AHB (read)
> mode.

Then you should really review my dirmap proposal instead of trying to
hack things directly into your driver. The only reason I did no send a
new version of the dirmap patchset is because I got no reviews from
people that might need it, so please have a look at it, try to
implement a backend for your controller, and let me know if you face
any issues or think things should be done differently.

Thanks,

Boris
