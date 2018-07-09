Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4420AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E022F2087C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E022F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbeGISlt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:41:49 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39146 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932789AbeGISls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:41:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A74B42084E; Mon,  9 Jul 2018 20:41:46 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 60E7B20733;
        Mon,  9 Jul 2018 20:41:46 +0200 (CEST)
Date:   Mon, 9 Jul 2018 20:41:44 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Message-ID: <20180709204144.30d1033e@bbrezillon>
In-Reply-To: <20180709183124.22f39f1b@bbrezillon>
References: <c27f10f9efc14fed817c1a343d8b67d4@SIWEX5A.sing.micron.com>
        <20180709183124.22f39f1b@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jul 2018 18:31:24 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Hi Bean,
> 
> On Mon, 9 Jul 2018 15:54:11 +0000
> "Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:
> 
> > Hi, Boris and Chris
> >   
> > >>
> > >> I see 2 solutions to this problem:
> > >> 1/ Bean provides us a solution to reliably detect when ECC can be
> > >>    de-actived and when it can't
> > >> 2/ We only ever expose 64 bytes of OOB to the user and consider that
> > >>    ECC can be disabled, even if it can't in reality
> > >>    
> > >
> > >After reading the doc again, I forgot one thing you can try before deciding to
> > >go for option #2.
> > >
> > >8th bit in byte 5 of READID's result encodes whether the on-die ECC state
> > >(enabled or not). I remember we had a discussion with Bean where he told us
> > >this was a runtime status reflecting the on-die ECC state, which is crazy, since
> > >READID might return different values depending on the NAND state, and most
> > >of the code in the core assumes READID provides a fixed ID that encodes the
> > >chip characteristics/capabilities, not its state.
> > >
> > >Anyway, if this bit is actually reflecting the on-die ECC state and on-die
> > >cannot be disabled on your chip, it should stay at 1 even after you have sent
> > >the SET_FEATURES(DISABLE_ECC) command. Let's hope this works as I expect,
> > >otherwise we're back to option #2 until Bean suggest something else.    
> > 
> > MT29F1G08ABAFAWP-ITE:F is Micron 70s SLC NAND with on-die ECC.
> > If the bit7 in the byte 5 of READID default is 1(ECC Enabled), it is true on-die ECC
> > Cannot be disabled by SET Feature command.
> > In case sending Set Feature command, you can check previous command is success or not by
> > Get Feature  
> 
> Chris tried that already and it didn't work. GET_FEATURES(ECC) returns a
> value with the bit cleared (meaning that ECC is supposedly disabled)
> after SET_FEATURES(ECC, DISABLE) has been sent. Are you sure that
> GET_FEATURES(ECC) is supposed to return the actual state of the ECC
> engine and not the last value you wrote in the internal reg (would be
> the case if this reg is just a dummy reg when on-die ECC is forcibly
> enabled).

My bad, that's not exactly what Chris reported. He said that the
SET_FEATURES(ECC)/GET_FEATURES(ECC) detection logic was reporting the
NAND as "not supporting on-die ECC", which kind of reflects what's
described in the datasheet (in "Table 10: Feature Address 90h – Array
Operation Mode" of MT29F1G08ABAFAWP-ITE:F spec, there's no ECC
enable/disable bit).

This means the detection logic we have simply doesn't work.

> 
> > or check this bit7 in byte 5 of READID later.  
> 
> This, we'll have to test.
> 
> > 
> > To check if this device supports on-die ECC or not, you can use inter ECC level (bit 0 and bit1 in byte 5 of READID)  
> > http://lists.infradead.org/pipermail/linux-mtd/2017-April/073370.html  
> 
> Okay, I think we already had this discussion, but I'm asking it again.
> What are the possible values for that field and what do they mean?

Still, it's not clear to me what "Internal ECC level" means. It seems
that NAND chips having on-die ECC have this field set to 10b (0x2), 00b
seems to be reserved for "no on-die ECC", but what are 01b and 11b
reserved for?

> Also, is it even used to encode the fact that the NAND has on-die ECC
> on all your NANDs? We already had the problem of incompatible ID
> schemes, so I wouldn't be surprised if that was the case here, hence my
> initial suggestion to base the detection on the model name.

I'd really need to have an answer on that one to take a decision. Also,
I couldn't find a datasheet for an IT (without E) version of the
MT29F1G08ABAFAWP part. Does it exist, or can we assume MT29F1G08ABAFAWP
chips always come with forcibly enabled on-die ECC?
