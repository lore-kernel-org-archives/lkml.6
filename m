Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4164C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27FB208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27FB208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeG0PXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 11:23:01 -0400
Received: from verein.lst.de ([213.95.11.211]:41496 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730561AbeG0PXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 11:23:01 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E8B4F68D60; Fri, 27 Jul 2018 16:04:48 +0200 (CEST)
Date:   Fri, 27 Jul 2018 16:04:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Fugang Duan <fugang.duan@nxp.com>
Subject: Re: [BUG BISECT] Ethernet fail on VF50 (OF: Don't set default
        coherent DMA mask)
Message-ID: <20180727140448.GA29001@lst.de>
References: <CAJKOXPeaguNxRr7pCArJ5Db4tS6Kr5BDheCxskY+vd0dUN+0GQ@mail.gmail.com> <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPfageiBVXddtdJRBS+092O3QfD0yoS_Mk+PoX7+qNYNUA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 03:18:14PM +0200, Krzysztof Kozlowski wrote:
> On 27 July 2018 at 15:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > Hi,
> >
> > On today's next, the bisect pointed commit
> > ff33d1030a6ca87cea9a41e1a2ea7750a781ab3d as fault for my boot failures
> > with NFSv4 root on Toradex Colibri VF50 (Iris carrier board).
> >
> > Author: Robin Murphy <robin.murphy@arm.com>
> > Date:   Mon Jul 23 23:16:12 2018 +0100
> >     OF: Don't set default coherent DMA mask
> >
> > Board: Toradex Colibri VF50 (NXP VF500, Cortex A5, serial configured
> > with DMA) on Iris Carrier.
> >
> > It looks like problem with Freescale Ethernet driver:
> > [   15.458477] fsl-edma 40018000.dma-controller: coherent DMA mask is unset
> > [   15.465284] fsl-lpuart 40027000.serial: Cannot prepare cyclic DMA
> > [   15.472086] Root-NFS: no NFS server address
> > [   15.476359] VFS: Unable to mount root fs via NFS, trying floppy.
> > [   15.484228] VFS: Cannot open root device "nfs" or
> > unknown-block(2,0): error -6
> > [   15.491664] Please append a correct "root=" boot option; here are
> > the available partitions:
> > [   15.500188] 0100           16384 ram0
> > [   15.500200]  (driver?)
> > [   15.506406] Kernel panic - not syncing: VFS: Unable to mount root
> > fs on unknown-block(2,0)
> > [   15.514747] ---[ end Kernel panic - not syncing: VFS: Unable to
> > mount root fs on unknown-block(2,0) ]---
> >
> > Attached - defconfig and full boot log.
> >
> > Any hints?
> > Let me know if you need any more information.
> 
> My Exynos boards also fail to boot on missing network:
> https://krzk.eu/#/builders/21/builds/799/steps/10/logs/serial0
> 
> As expected there are plenty of "DMA mask not set" warnings... and
> later dwc3 driver fails with:
>     dwc3: probe of 12400000.dwc3 failed with error -12
> which is probably the answer why LAN attached to USB is not present.

Looks like all the drivers failed to set a dma mask and were lucky.
