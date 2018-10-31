Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668CDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58BA20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B58BA20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeJaWPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:15:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33053 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729266AbeJaWPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:15:44 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 20C1C20756; Wed, 31 Oct 2018 14:17:42 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-12-210.w90-88.abo.wanadoo.fr [90.88.133.210])
        by mail.bootlin.com (Postfix) with ESMTPSA id CDED12039F;
        Wed, 31 Oct 2018 14:17:41 +0100 (CET)
Date:   Wed, 31 Oct 2018 14:17:42 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Grandbois, Brett" <brett.grandbois@opengear.com>
Cc:     Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] mtd: spi-nor: Add support for SPI boot flash access
 for AMD Family 16h
Message-ID: <20181031141742.4fd2d33b@bbrezillon>
In-Reply-To: <1912426d-8189-0508-d152-8dfcf6192162@opengear.com>
References: <20181016005726.26813-1-brett.grandbois@opengear.com>
        <20181027173945.241e87b2@bbrezillon>
        <a6edf985-0d15-5b2b-a6ba-9cfcd7a67836@opengear.com>
        <20181030092605.38851906@bbrezillon>
        <1912426d-8189-0508-d152-8dfcf6192162@opengear.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 03:18:28 +0000
"Grandbois, Brett" <brett.grandbois@opengear.com> wrote:

> On 30/10/18 6:26 pm, Boris Brezillon wrote:
> > On Mon, 29 Oct 2018 23:15:42 +0000
> > "Grandbois, Brett"<brett.grandbois@opengear.com>  wrote:
> >  
> >> On 28/10/18 1:39 am, Boris Brezillon wrote:  
> >>> Hi Brett,
> >>>
> >>> On Tue, 16 Oct 2018 00:57:41 +0000
> >>> "Grandbois, Brett"<brett.grandbois@opengear.com>   wrote:
> >>>     
> >>>> Add support to expose the SPI boot flash on AMD Family 16h CPUs
> >>>> as a standard mtd device to give userspace BIOS updaters greater
> >>>> feature support.  The BIOS and Kernel Developer's Guide refers to
> >>>> this as the 'SPI ROM' controller and so the driver follows that
> >>>> naming convention for consistency.
> >>>>     
> >>> We're currently trying to convert spi-nor controller drivers to
> >>> the spi-mem interface [1]. Can you look at this new interface and
> >>> tell me if you'd be able to implement it? If that's not possible,
> >>> then I'd prefer to have this driver implement the mtd_info
> >>> interface directly.  
> >> So from going over the spi-mem interface it looks like the intent
> >> is for these sorts of devices to be a standard spi_controller with
> >> only mem_ops defined and the transfer/_one/_one_message left as
> >> NULL?  Is that correct?  
> > Yes
> >  
> >> That's a bit of a pivot from how it's currently done
> >> (it's conceptually similar to the intel-spi-pci driver so I was
> >> following that)  
> > Yes, and that's exactly what I'd like to avoid. intel-spi-pci will
> > probably be the trickiest conversion, so I'd like to avoid having
> > another one ;-).
> >  
> >> but I should be able to rework it to the new
> >> interface.  This then lives under drivers/spi and thus should be
> >> submitted to linux-spi?  
> > Actually, if the controller is only ever connected to the same SPI
> > NOR chip (no need for advanced detection scheme) and does not
> > support support Octo/Quad/Dual modes (or any other advanced
> > features), you'll be better off implementing
> > mtd->_read/_write/_erase() directly (the driver would then live in
> > drivers/mtd/devices/).  
> 
> Hmm, conceptually the device is better suited to the mtd layer than
> the spi layer.  The HW is designed to only ever access spi flash
> chips, not as a general spi master controller, so really the end
> result of it should always only ever be 1 mtd device.  Unfortunately
> as the device probing and command sequences for this are the same as
> implemented in spi-nor I'd either be duplicating a lot of existing
> code, or just wrapping around spi_nor_scan which sounds like we're
> back to the dedicated spi-nor controller you're trying to move away
> from.
> 
> The spi-mem interface ops do nicely match up with what the controller
> supports, including the new direct mapping mode which I'd be able to
> make use of, so as long as there aren't any issues with supporting
> only mem_ops and not the message transfers

That's allowed.

> then it's probably the way to go.

Sounds good then.
