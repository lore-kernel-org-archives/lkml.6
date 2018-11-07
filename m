Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A92CC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E372081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26E372081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeKGUiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:38:03 -0500
Received: from eddie.linux-mips.org ([148.251.95.138]:60132 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeKGUiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:38:03 -0500
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990946AbeKGLIIX61HE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 12:08:08 +0100
Date:   Wed, 7 Nov 2018 11:08:08 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: SiByte: Set 32-bit bus mask for BCM1250 PCI
In-Reply-To: <20181107075828.GC24381@lst.de>
Message-ID: <alpine.LFD.2.21.1811071100030.20378@eddie.linux-mips.org>
References: <alpine.LFD.2.21.1811050350070.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1811050428180.20378@eddie.linux-mips.org> <20181107075828.GC24381@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Nov 2018, Christoph Hellwig wrote:

> > +static int sb1250_bus_dma_mask(struct pci_dev *dev, void *data)
> > +{
> > +	struct sb1250_bus_dma_mask_exclude *exclude = data;
> > +
> > +	if (!exclude->set && (dev->vendor == PCI_VENDOR_ID_SIBYTE &&
> > +			      dev->device == PCI_DEVICE_ID_BCM1250_HT)) {
> > +		exclude->start = dev->subordinate->number;
> > +		exclude->end = pci_bus_max_busnr(dev->subordinate);
> > +		exclude->set = true;
> > +		dev_dbg(&dev->dev, "not disabling DAC for [bus %02x-%02x]",
> > +			exclude->start, exclude->end);
> > +	} else if (!exclude->set ||
> > +		   (exclude->set && (dev->bus->number < exclude->start ||
> > +				     dev->bus->number > exclude->end))) {
> > +		dev_dbg(&dev->dev, "disabling DAC for device");
> > +		dev->dev.bus_dma_mask = DMA_BIT_MASK(32);
> > +	} else {
> > +		dev_dbg(&dev->dev, "not disabling DAC for device");
> > +	}
> > +	return 0;
> 
> Hmm, these conditions look very hard to read to me.  Wouldn't this
> have the same effect?
> 
> 	if (exclude->set)
> 		return;

 Nope, `exclude->set' only means we already know what range to exclude 
(and that gets set mid-way through scanning as the HT bridge is 
encountered).  Then if it's unset, we know we are (still) outside that 
range.

 Maybe I can flatten the conditions at the small cost of executing some 
code unnecessarily.  But that won't be a big deal as this stuff is only 
executed once at boot and isn't performance critical.

 It'll have to wait until next week though as I'll be travelling 
throughout the rest of this and won't be able to test anything.

  Maciej
