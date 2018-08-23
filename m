Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019A8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1FD420839
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FD420839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbeHWMXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:23:02 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34131 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHWMXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:23:01 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fslNi-0004th-QY; Thu, 23 Aug 2018 10:54:18 +0200
Message-ID: <1535014456.2724.1.camel@pengutronix.de>
Subject: Re: [RFC] etnaviv: missing dma_mask
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Christoph Hellwig <hch@lst.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Date:   Thu, 23 Aug 2018 10:54:16 +0200
In-Reply-To: <20180817064222.GB10811@lst.de>
References: <20180814141225.6123-1-Eugeniy.Paltsev@synopsys.com>
         <20180817064222.GB10811@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, den 17.08.2018, 08:42 +0200 schrieb Christoph Hellwig:
> On Tue, Aug 14, 2018 at 05:12:25PM +0300, Eugeniy Paltsev wrote:
> > Hi Lucas, Christoph,
> > 
> > After switching ARC to generic dma_noncoherent cache ops 
> > etnaviv driver start failing on dma maping functions because of
> > dma_mask lack.
> > 
> > So I'm wondering is it valid case to have device which is
> > DMA capable and doesn't have dma_mask set?
> > 
> > If not, then I guess something like that should work
> > (at least it works for ARC):
> 
> This looks ok is a minimal fix:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But why doesn't this device have a dma-range property in DT?

Because the etnaviv device is a virtual device not represented in DT,
as it is only used to expose the DRM device, which may cover multiple
GPU core devices. The GPU core devices are properly configured from DT,
but unfortunately many of the dma related operations happen through the
DRM device. We could fix this by replacing many of the DRM helpers with
etnaviv specific functions handling dma per GPU core, but it isn't a
clear win right now, as generally on SoCs with multiple GPU cores, the
devices are on the same bus and have the same dma requirements.

Regards,
Lucas
