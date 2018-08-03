Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB6BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92FAC2172A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 08:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xTrJzNES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FAC2172A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeHCKQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 06:16:22 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38382 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbeHCKQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 06:16:22 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w738Kl3H089301;
        Fri, 3 Aug 2018 03:20:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1533284447;
        bh=fXfUOsy9i0CE3rQ7bFvQxIq+2BUCrNfMUuwc6hsRkak=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xTrJzNESSl/5mtgXDGudc0MVsEuYhxmZ3rm4R6LVe5jMGMVvqEEVDQ0CjM6t39bQ6
         kKm2Lc1Rz3IUTU3fWt+JpRAqenS/iUrIYjFbRQgVZYd14SoMLKud/qrmjbLeZPG6v/
         Tt9Ef0TNQ3kVgjScC1+A03KGXqgaVNpf0lfRGCK4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w738KlpW022675;
        Fri, 3 Aug 2018 03:20:47 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 3 Aug
 2018 03:20:47 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 3 Aug 2018 03:20:47 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w738Kg2A017916;
        Fri, 3 Aug 2018 03:20:43 -0500
Subject: Re: [PATCH 00/46] Use dmaenginem_async_device_register to simplify
 code
To:     Huang Shijie <sjhuang@iluvatar.ai>, <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dave.jiang@intel.com>, <radhey.shyam.pandey@xilinx.com>,
        <appana.durga.rao@xilinx.com>, <jmkrzyszt@gmail.com>,
        <gomonovych@gmail.com>, <keescook@chromium.org>,
        <horms+renesas@verge.net.au>, <geert+renesas@glider.be>,
        <shawnguo@kernel.org>, <baoyou.xie@linaro.org>,
        <michal.simek@xilinx.com>, <baohua@kernel.org>,
        <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <david.brown@linaro.org>
References: <20180803072016.21544-1-sjhuang@iluvatar.ai>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <5d8b222c-6798-aebc-43fc-d4dab9b6f43b@ti.com>
Date:   Fri, 3 Aug 2018 11:20:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180803072016.21544-1-sjhuang@iluvatar.ai>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-08-03 10:19, Huang Shijie wrote:
> All the patches are using dmaenginem_async_device_register to simplify code
> except the last one:
>   dmaengine: add COMPILE_TEST for the drivers
> 
> I use the last one to do the compiler test.  
> There are still 20 drivers which do not use the dmaenginem_async_device_register.
> Let me take a rest, if this patch set is accepted, I will do the rest.

I think for most of the drivers this series is going to open a race
which is essentially:

prior:
_remove()
{
...
	dma_async_device_register()
	/* Free resources, disable HW, etc */
	return 0;
}

after:
_remove()
{
...
	/* Free resources, disable HW, etc */
	/*
	 * The dma device is still registered and a channel can be
	 * requested
	 */

	dma_async_device_register()
	return 0;
}

It might be theoretical, but conversion to managed device resources is
not straight forward in some cases.

- Péter

> 
> Huang Shijie (46):
>   dmaengine: zx_dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: zynqmp_dma: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: xilinx_dma: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: xgene-dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: txx9dmac: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: timb_dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: omap-dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: edma: use dmaenginem_async_device_register to simplify the
>     code
>   dmaengine: cppi41: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: tegra210-adma: use helper dmaenginem_async_device_register
>   dmaengine: tegra20-apb-dma: use helper
>     dmaenginem_async_device_register
>   dmaengine: sun6i-dma: use helper dmaenginem_async_device_register
>   dmaengine: sun4i-dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: coh901318: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: s3c24xx-dma: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: ste_dma40: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: stm32-mdma: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: stm32-dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: sprd-dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: sirf-dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: bam_dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: sudmac: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: sa11x0-dma: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: nbpfaxi: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: mmp_tdma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: shdmac: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: usb-dmac: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: rcar-dmac: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: hidma: use dmaenginem_async_device_register to simplify the
>     code
>   dmaengine: pxa_dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: moxart-dma: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: pl330: use dmaenginem_async_device_register to simplify the
>     code
>   dmaengine: pch_dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: mxs-dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: mtk-hsdma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: k3dma: use dmaenginem_async_device_register to simplify the
>     code
>   dmaengine: imx-sdma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: imx-dma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: img-mdc-dma: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: fsl-edma: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: at_hdmac: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: at_xdmac: use dmaenginem_async_device_register to simplify
>     the code
>   dmaengine: dma-jz4780: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: dma-jz4740: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: dma-axi-dmac: use dmaenginem_async_device_register to
>     simplify the code
>   dmaengine: add COMPILE_TEST for the drivers
> 
>  drivers/dma/Kconfig              | 24 ++++++++++++------------
>  drivers/dma/at_hdmac.c           |  4 +---
>  drivers/dma/at_xdmac.c           |  7 ++-----
>  drivers/dma/coh901318.c          | 14 ++++----------
>  drivers/dma/dma-axi-dmac.c       |  7 ++-----
>  drivers/dma/dma-jz4740.c         |  7 ++-----
>  drivers/dma/dma-jz4780.c         |  8 ++------
>  drivers/dma/fsl-edma.c           |  4 +---
>  drivers/dma/img-mdc-dma.c        |  7 ++-----
>  drivers/dma/imx-dma.c            |  8 ++------
>  drivers/dma/imx-sdma.c           |  7 ++-----
>  drivers/dma/k3dma.c              |  7 ++-----
>  drivers/dma/mediatek/mtk-hsdma.c |  4 +---
>  drivers/dma/mmp_tdma.c           |  7 ++-----
>  drivers/dma/moxart-dma.c         |  5 +----
>  drivers/dma/mxs-dma.c            |  3 +--
>  drivers/dma/nbpfaxi.c            |  7 ++-----
>  drivers/dma/pch_dma.c            |  4 +---
>  drivers/dma/pl330.c              |  4 +---
>  drivers/dma/pxa_dma.c            |  3 +--
>  drivers/dma/qcom/bam_dma.c       |  7 ++-----
>  drivers/dma/qcom/hidma.c         |  3 +--
>  drivers/dma/s3c24xx-dma.c        | 11 +++--------
>  drivers/dma/sa11x0-dma.c         |  4 +---
>  drivers/dma/sh/rcar-dmac.c       |  5 +----
>  drivers/dma/sh/shdmac.c          |  5 +----
>  drivers/dma/sh/sudmac.c          |  4 +---
>  drivers/dma/sh/usb-dmac.c        |  3 +--
>  drivers/dma/sirf-dma.c           |  7 ++-----
>  drivers/dma/sprd-dma.c           |  7 ++-----
>  drivers/dma/ste_dma40.c          | 14 +++++---------
>  drivers/dma/stm32-dma.c          |  3 +--
>  drivers/dma/stm32-mdma.c         |  4 +---
>  drivers/dma/sun4i-dma.c          |  7 ++-----
>  drivers/dma/sun6i-dma.c          |  7 ++-----
>  drivers/dma/tegra20-apb-dma.c    |  8 ++------
>  drivers/dma/tegra210-adma.c      |  8 ++------
>  drivers/dma/ti/Kconfig           |  2 +-
>  drivers/dma/ti/cppi41.c          |  7 ++-----
>  drivers/dma/ti/edma.c            |  8 ++------
>  drivers/dma/ti/omap-dma.c        |  5 +----
>  drivers/dma/timb_dma.c           |  3 +--
>  drivers/dma/txx9dmac.c           |  4 +---
>  drivers/dma/xgene-dma.c          | 16 ++--------------
>  drivers/dma/xilinx/xilinx_dma.c  |  5 +----
>  drivers/dma/xilinx/zynqmp_dma.c  |  4 +---
>  drivers/dma/zx_dma.c             |  7 ++-----
>  47 files changed, 88 insertions(+), 221 deletions(-)
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
