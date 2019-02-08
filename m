Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884BDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B10221916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 21:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfBHVpp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 16:45:45 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55947 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfBHVpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 16:45:45 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 279CC240006;
        Fri,  8 Feb 2019 21:45:41 +0000 (UTC)
Date:   Fri, 8 Feb 2019 22:45:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] mtd: rawnand: call onfi_fill_data_interface() once
 again after nand_detect
Message-ID: <20190208224540.7e5b628c@xps13>
In-Reply-To: <CAK7LNAQ7P8iEkhyRBbHLdt6yN-dDgpLZOs256qwk2BpADiGcGw@mail.gmail.com>
References: <1549533476-3742-1-git-send-email-yamada.masahiro@socionext.com>
        <20190207111606.6b72dc34@xps13>
        <CAK7LNASEvAUeJsBcp4eh+XW+gaVp921SU-d1m-DEs+Hs+YA8TA@mail.gmail.com>
        <20190207140136.2ae62982@xps13>
        <CAK7LNAQ7P8iEkhyRBbHLdt6yN-dDgpLZOs256qwk2BpADiGcGw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Fri, 8 Feb
2019 17:35:32 +0900:

> HI Miquel,
> 
> On Thu, Feb 7, 2019 at 10:02 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hi Masahiro,
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu, 7 Feb
> > 2019 19:46:54 +0900:
> >  
> > > On Thu, Feb 7, 2019 at 7:16 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:  
> > > >
> > > > Hi Masahiro,
> > > >
> > > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote on Thu,  7 Feb
> > > > 2019 18:57:56 +0900:
> > > >  
> > > > > nand_scan_ident() calls onfi_fill_data_interface() at its entry
> > > > > to set up the initial timing parameters.
> > > > >
> > > > > The timing parameters are needed not only for ->setup_data_interface(),
> > > > > but also for giving the correct delay to NAND_OP_WAIT_RDY, for example.
> > > > >
> > > > > If the driver sets the NAND_KEEP_TIMINGS flag, or does not support  
> > > > > ->setup_data_interface() hook, those parameters will never updated.  
> > > >
> > > >                                                             ^ be  
> > >
> > > Will fix (if v2 is welcome)
> > >
> > >  
> > > > >
> > > > > Before nand_detect(), we never know whether the chip is ONFi or not.
> > > > > So, onfi_fill_data_interface() has to assume the worst case, i.e.
> > > > > non-ONFi.  
> > > >
> > > > s/ONFi/ONFI/?  
> > >
> > > Will fix.
> > >
> > > Looks like I was misunderstanding
> > > maybe because the letter 'I' in the logo
> > > (http://www.onfi.org/)
> > > looks like a lowercase...
> > >
> > >  
> >
> > Oh right. I don't know what's best. Pick your favorite :)
> >  
> > >
> > >  
> > > >  
> > > > >
> > > > > After nand_detect(), if the chip turns out to be ONFi-compliant,
> > > > > we can optimize tPROG_max, tBERS_max, etc.
> > > > >
> > > > > Call onfi_fill_data_interface() once again.  
> > > >
> > > > Sorry but I don't get why this is needed as there is the same call at
> > > > the top of this function. Can you be more specific on where/when the
> > > > missing call produces a failure?  
> > >
> > >
> > > onfi_fill_data_interface() sets different values
> > > for tPROG_max, tBER_max, tR_max, tCCS_min
> > > depending on whether the chip is ONFI or not.
> > >
> > > For the first call, onfi_fill_data_interface()
> > > chooses the else-part since we never know
> > > the chip specification at this point.
> > >
> > > If we call onfi_fill_data_interface() once again
> > > after nand_detect(), it may choose the if-part.
> > >
> > >
> > > If a driver supports ->setup_data_interface(),
> > > nand_init_data_interface() will set the optimal
> > > timing parameters anyway.
> > >
> > > But, if a driver does not support ->setup_data_interface(),
> > > it will not happen since nand_has_setup_data_iface() returns false.  
> >
> > And I think this is the expected behavior. Calling again
> > onfi_fill_data_interface() would probably enhance a bit the timings.
> > The effect is that later exchanges with the NAND chip would be just a
> > bit faster. But if you care about performance, then why not implementing  
> > ->setup_data_interface()? Even a dummy implementation would do the  
> > trick: only accept timing mode 0 without any changes on the controller
> > side.  
> 
> 
> My driver (denali) does implement ->setup_data_interface().

Fortunately, yes! :)

> 
> When I was testing this thoroughly on my board,
> I noticed the timing parameters were slightly changed
> after nand_detect() detected ONFI chip.

I see.

> 
> > Unless you give me a use case where this is not possible, I don't think
> > it is worth changing this path.  
> 
> Only the use case I can come up with is when NAND_KEEP_TIMINGS was set.
> But, it is just a matter of timeout values.
> 
> So, please throw away this patch.

Ok!


Thanks anyway for the proposal!
Miquèl
