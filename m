Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C89C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC2A2192C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfBQNR1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:17:27 -0500
Received: from gloria.sntech.de ([185.11.138.130]:50096 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbfBQNR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:17:27 -0500
Received: from p5b127a91.dip0.t-ipconnect.de ([91.18.122.145] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gvMJr-000220-Ox; Sun, 17 Feb 2019 14:17:19 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: add HDMI sound node for rk3328-rock64
Date:   Sun, 17 Feb 2019 14:17:18 +0100
Message-ID: <15054640.NB91u9fWWK@phil>
In-Reply-To: <16f4fcf0-e9c2-e925-e463-282cfff088c7@katsuster.net>
References: <20190202043444.9308-1-katsuhiro@katsuster.net> <2275914.n7pQDzs7mT@diego> <16f4fcf0-e9c2-e925-e463-282cfff088c7@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 17. Februar 2019, 11:58:36 CET schrieb Katsuhiro Suzuki:
> Hello Heiko,
> 
> On 2019/02/12 20:12, Heiko Stübner wrote:
> > Hi,
> > 
> > Am Montag, 4. Februar 2019, 13:59:37 CET schrieb Katsuhiro Suzuki:
> >> On 2019/02/03 18:06, Heiko Stuebner wrote:
> >>> Am Samstag, 2. Februar 2019, 05:34:44 CET schrieb Katsuhiro Suzuki:
> >>>> This patch adds HDMI sound (I2S0) node and remove dma properties
> >>>> from UART2 node for rock64.
> >>>>
> >>>> The DMAC of rk3328 can use 8 channels at same time. Currently, total
> >>>>
> >>>> 7 channels are used as follows:
> >>>>     - I2S1  2ch
> >>>>     - UART2 2ch
> >>>>     - SPDIF 1ch
> >>>>     - SPI0  2ch
> >>>>
> >>>> HDMI audio using I2S0 that requires 2ch but DMAC has only 1 channel.
> >>>>
> >>>> UART2 can work without DMA resources, so this patch removes dma
> >>>> allocation for UART2 and reuses it to I2S0.
> >>>
> >>> I don't follow that description. How can i2s0 re-use the uart2 dma
> >>> channels? Looking at the dma table in the TRM, uart2 has channels 6+7
> >>> while i2s0 uses channels 11+12. They should just run concurrently?
> >>
> >> Sorry for confusing... 6 or 7 is as ID number of slave DMA channel.
> >> TRM calls it 'Req number'. Req number 6+7 and 11+12 can work
> >> concurrently but TRM says DMAC can transfer 8 DMA channels at same
> >> time. So all 16 Req numbers cannot activate at same time. It should
> >> be keep less or equal than 8 numbers.
> > 
> > But that "shortcoming" of having more requests than channels is not
> > something specific to the pl330, instead most dma controllers have that
> > "problem", which seems to get solved by the virt-dma mechanism of
> > dmaengine - which pl330 doesn't use so far. (but see pl080 for example)
> > 
> 
> I understand. I drop these patches.
> 
> 
> > The devicetree only describes the hardware and is never meant as a
> > configuration space for kernel-code shortcomings.
> > 
> 
> Yes, right. I don't want to use device-tree as configuration space,
> so which is better?
> 
> - Fix the pl330 driver first and after that add HDMI-sound node
>    to device-tree.
> - Just add HDMI-sound node to device-tree. If someone (include me)
>    want to support virt-dma on pl330 driver, they will fix it.
>    (PL330 will face error but all sounds works fine and UART still
>    works fine with DMA error)

I'd go with this second option :-) .

Heiko


