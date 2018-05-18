Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeERON6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:13:58 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:57870 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeERONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:13:54 -0400
From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To: "hch@lst.de" <hch@lst.de>
CC: "deanbo422@gmail.com" <deanbo422@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
 implementation
Thread-Topic: [PATCH 02/20] dma-mapping: provide a generic dma-noncoherent
 implementation
Thread-Index: AQHT7rJwE0RiyYL8c0WIr1H3arr2Xg==
Date: Fri, 18 May 2018 14:13:47 +0000
Message-ID: <913e288c5aabf0224cedcf2eb0c9be309745eace.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
         <20180511075945.16548-3-hch@lst.de>
         <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
         <20180518132731.GA31125@lst.de>
In-Reply-To: <20180518132731.GA31125@lst.de>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.8.87]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C702843E962C4C4087A6422611F424FA@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4IEE4do025531

Hi Christoph,

On Fri, 2018-05-18 at 15:27 +0200, hch@lst.de wrote:
> On Fri, May 18, 2018 at 01:03:46PM +0000, Alexey Brodkin wrote:
> > Note mmc_get_dma_dir() is just "data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE".
> > I.e. if we're preparing for sending data dma_noncoherent_map_sg() will have DMA_TO_DEVICE which
> > is quite OK for passing to dma_noncoherent_sync_sg_for_device() but in case of reading we'll have
> > DMA_FROM_DEVICE which we'll pass to dma_noncoherent_sync_sg_for_device() in dma_noncoherent_map_sg().
> > 
> > I'd say this is not entirely correct because IMHO arch_sync_dma_for_cpu() is supposed to only be used
> > in case of DMA_FROM_DEVICE and arch_sync_dma_for_device() only in case of DMA_TO_DEVICE.
> 
> arc overrides the dir paramter of the dma_sync_single_for_device/
> dma_sync_single_for_cpu calls.  My patches dropped that, and I have
> restored that, and audit for the other architectures is pending.

Well at least for me that's a confusion what is a reason to pass direction
to function which purpose is already known.

I'd say that XXX_sync_for_device() doesn't need _variable_ direction as an argument,
otherwise what does that mean if we pass DMA_FROM_DEVICE to that function?

> That being said the existing arc code still looks rather odd as it
> didn't do the same thing for the scatterlist versions of the calls.

That might easily be the case so good we caught that now and it will be fixed :)

> I've thrown in a few patches into my new tree to make the sg versions
> make the normal calls, and to clean up the area a bit.

I'll try your newer series now, thanks!

-Alexey
