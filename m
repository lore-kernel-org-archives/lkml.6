Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB0CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F02E22419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 11:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F02E22419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387657AbeKOVKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:10:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36615 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbeKOVKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:10:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 15B8A20746; Thu, 15 Nov 2018 12:03:07 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id BA94D2039F;
        Thu, 15 Nov 2018 12:02:56 +0100 (CET)
Date:   Thu, 15 Nov 2018 12:02:56 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <liu.xiang6@zte.com.cn>, <cyrille.pitchen@wedev4u.fr>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <liuxiang_1999@126.com>
Subject: Re: [PATCH] mtd: spi-nor: Return error when nor->addr_width not
 match the device size
Message-ID: <20181115120256.4e1a86b2@bbrezillon>
In-Reply-To: <96397ec0-14de-f09a-a18d-c67396e33fba@microchip.com>
References: <1542200165-3073-1-git-send-email-liu.xiang6@zte.com.cn>
        <20181114145129.568e4bb3@bbrezillon>
        <96397ec0-14de-f09a-a18d-c67396e33fba@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018 10:54:39 +0000
<Tudor.Ambarus@microchip.com> wrote:

> Hi, Liu, Boris, Cyrille,
> 
> On 11/14/2018 03:51 PM, Boris Brezillon wrote:
> > On Wed, 14 Nov 2018 20:56:05 +0800
> > Liu Xiang <liu.xiang6@zte.com.cn> wrote:
> >   
> >> In is25lp256, the DWORD1 of JEDEC Basic Flash Parameter Header
> >> is 0xfff920e5. So the DWORD1[18:17] Address Bytes bits are 0b00,  
> 
> Liu, can you point us to a datasheet that has the JEDEC BFPT tables described? I
> couldn't find one ...
> 
> >> means that 3-Byte only addressing.  
> > 
> > According to your other patch this NOR supports 4B opcode, which means
> > the SFDP table is wrong.
> >   
> >> But the device size is larger
> >> than 16MB, nor->addr_width must be 4 to access the whole address.
> >> An error should be returned when nor->addr_width not match  
> > 
> > 						   ^does not
> >   
> >> the device size in spi_nor_parse_sfdp().
> >>
> >> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> >> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> >> ---
> >>  drivers/mtd/spi-nor/spi-nor.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> >> index 3eba13a..77eaf22 100644
> >> --- a/drivers/mtd/spi-nor/spi-nor.c
> >> +++ b/drivers/mtd/spi-nor/spi-nor.c
> >> @@ -2669,6 +2669,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
> >>  	}
> >>  	params->size >>= 3; /* Convert to bytes. */
> >>  
> >> +	/*if the device exceeds 16MiB, addr_width must be 4*/  
> > 
> > Please add a white space after '/*' and before '*/':
> > 
> > 	/* If the device exceeds 16MiB, ->addr_width must be 4. */
> >   
> >> +	if ((params->size > 0x1000000) && (nor->addr_width == 3))  
> > 
> > Parens are not needed around sub-conditions:
> > 
> > 	if (params->size > 0x1000000 && nor->addr_width == 3)
> >   
> >> +		return -EINVAL;
> >> +  
> > 
> > I'm not sure this is correct. Looks like some NORs only support 3B
> > opcodes but have a "4-byte addressing" mode (see set_4byte() [1]).
> > Don't know what's reported by the BFPT section in this case though
> > (BFPT_DWORD1_ADDRESS_BYTES_3_ONLY or BFPT_DWORD1_ADDRESS_BYTES_3_OR_4).  
> 
> Boris, this is in close relation with your second patch: [PATCH v3 2/2] mtd:
> spi-nor: Use 4B opcodes when the NOR advertises both 3B and 4B.
> 
> When looking again at this, I would say that for the flashes that have a "4-byte
> addressing" mode, but just 3B opcodes, I would expect the DWORD1[18:17] to be of
> value BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 (enters 4-Byte mode on command - uses 3B
> opcodes).

The NOR we have and which is exposing BFPT_DWORD1_ADDRESS_BYTES_3_OR_4
actually supports both 3B and 4B commands, so, in this particular case,
BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 does not mean "3B opcode+4-byte
addressing mode"

> 
> If BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 and 4B opcodes, then we can query BFPT
> DWORD16[31:24]: it should have value xx1x_xxxxb to indicate that 4B opcodes are
> supported. But which 4B opcodes are supported?

I hope all of them. Wouldn't make sense to have only some of them
supported.

> Do all 3B opcodes have a 4B
> opcode correspondent if SFDP 4-byte table is not available? This might be a good
> assumption, but I can't see it anywhere in jesd216c.

I hope so...
