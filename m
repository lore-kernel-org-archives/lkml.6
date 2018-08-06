Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88785C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362A521916
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362A521916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbeHFOx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:53:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60551 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbeHFOxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:53:25 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fmes1-0001o0-9m; Mon, 06 Aug 2018 14:44:21 +0200
Message-ID: <1533559459.2809.3.camel@pengutronix.de>
Subject: Re: [PATCH v5 7/7] dmaengine: imx-sdma: alloclate bd memory from
 dma pool
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>, vkoul@kernel.org,
        s.hauer@pengutronix.de, dan.j.williams@intel.com,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Date:   Mon, 06 Aug 2018 14:44:19 +0200
In-Reply-To: <1529427424-12321-8-git-send-email-yibin.gong@nxp.com>
References: <1529427424-12321-1-git-send-email-yibin.gong@nxp.com>
         <1529427424-12321-8-git-send-email-yibin.gong@nxp.com>
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

Hi Vinod, hi Robin,

this patch is already in your slave-dma tree, but upon closer
inspection this is totally doing the wrong thing and should be dropped,
see inline comments. The patchset in your tree will regress without
this patch, though. So I think we need to delay getting this set
upstream until this issue is properly fixed. 


Am Mittwoch, den 20.06.2018, 00:57 +0800 schrieb Robin Gong:
> dma_terminate_all maybe called in interrupt context which means
> WARN_ON() will be triggered as below when bd memory freed. Allocat
> bd memory from dma pool instead.

While the dma_pool usage works around this WARN_ON, it doesn't fix the
underlying issue. Freeing of the descriptor memory should only happen
after the SDMA is not accessing it anymore. The comment in
sdma_disable_channel_with_delay() suggests that we need to wait some
time for this to be safe.

So rather than using a dma_pool for this memory, setting up a delayed
worker to clean up the channel would work much better and even allow to
drop that nasty mdelay() from the terminate callback. Then
device_synchronize function needs to be implemented properly, but
that's much better as than the blocking wait in atomic context.

> [   29.161079] WARNING: CPU: 1 PID: 533 at ./include/linux/dma-mapping.h:541 sdma_free_bd+0xa4/0xb4
> [   29.169883] Modules linked in:
> [   29.172990] CPU: 1 PID: 533 Comm: mpegaudioparse0 Not tainted 4.18.0-rc1-next-20180618-00009-gf79f22c #20
> [   29.182597] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   29.189163] Backtrace:
> [   29.191685] [<c010d1e0>] (dump_backtrace) from [<c010d4a0>] (show_stack+0x18/0x1c)
> [   29.199306]  r7:00000000 r6:600f0093 r5:00000000 r4:c107db7c
> [   29.205029] [<c010d488>] (show_stack) from [<c0a5bba0>] (dump_stack+0xb4/0xe8)
> [   29.212312] [<c0a5baec>] (dump_stack) from [<c012703c>] (__warn+0x104/0x130)
> [   29.219411]  r9:ec3e817c r8:0000021d r7:00000009 r6:c0d1d440 r5:00000000 r4:00000000
> [   29.227204] [<c0126f38>] (__warn) from [<c0127180>] (warn_slowpath_null+0x44/0x50)
> [   29.234821]  r8:ed129dc4 r7:c0b01978 r6:c04d4e90 r5:0000021d r4:c0d1d440
> [   29.241574] [<c012713c>] (warn_slowpath_null) from [<c04d4e90>] (sdma_free_bd+0xa4/0xb4)
> [   29.249706]  r6:4c001000 r5:f082e000 r4:00000024
> [   29.254376] [<c04d4dec>] (sdma_free_bd) from [<c04d4eb4>] (sdma_desc_free+0x14/0x20)
> [   29.262163]  r7:ec3e8110 r6:00000100 r5:00000200 r4:ecf89a00
> [   29.267873] [<c04d4ea0>] (sdma_desc_free) from [<c04d229c>] (vchan_dma_desc_free_list+0xa4/0xac)
> [   29.276697]  r5:00000200 r4:ed129d9c
> [   29.280326] [<c04d21f8>] (vchan_dma_desc_free_list) from [<c04d482c>] (sdma_disable_channel_with_delay+0x14c/0x188)
> [   29.290808]  r9:ecae560c r8:ec3e815c r7:00000000 r6:c1008908 r5:ed129dc4 r4:ec3e8110
> [   29.298605] [<c04d46e0>] (sdma_disable_channel_with_delay) from [<c07c5c84>] (snd_dmaengine_pcm_trigger+0x90/0x1b0)
> [   29.309087]  r8:ecae5000 r7:ec940800 r6:ed31bd80 r5:ecadb200 r4:ec26a700
> [   29.315855] [<c07c5bf4>] (snd_dmaengine_pcm_trigger) from [<c07dd800>] (soc_pcm_trigger+0xb4/0x130)
> [   29.324953]  r8:ecae5000 r7:ec940800 r6:00000000 r5:ecadb200 r4:ec26a700
> [   29.331716] [<c07dd74c>] (soc_pcm_trigger) from [<c07bc008>] (snd_pcm_do_stop+0x58/0x5c)
> [   29.339859]  r9:ecaed5a8 r8:ed31bdc0 r7:00000000 r6:00000001 r5:ecadb200 r4:c0b9c4d0
> [   29.347652] [<c07bbfb0>] (snd_pcm_do_stop) from [<c07bbde8>] (snd_pcm_action_single+0x40/0x80)
> [   29.356315] [<c07bbda8>] (snd_pcm_action_single) from [<c07bbf1c>] (snd_pcm_action+0xf4/0xfc)
> [   29.364883]  r7:00000001 r6:c0b9c4d0 r5:ecadb2d4 r4:ecadb200
> [   29.370593] [<c07bbe28>] (snd_pcm_action) from [<c07bc8dc>] (snd_pcm_drop+0x58/0x9c)
> 
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f8becaf..7dab7e9 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -24,6 +24,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
>  #include <linux/firmware.h>
>  #include <linux/slab.h>
>  #include <linux/platform_device.h>
> @@ -343,6 +344,7 @@ struct sdma_channel {
> > >  	u32				shp_addr, per_addr;
> > >  	enum dma_status			status;
> > >  	struct imx_dma_data		data;
> > > +	struct dma_pool			*bd_pool;
>  };
>  
> >  #define IMX_DMA_SG_LOOP		BIT(0)
> @@ -1153,11 +1155,10 @@ static int sdma_request_channel0(struct sdma_engine *sdma)
>  
>  static int sdma_alloc_bd(struct sdma_desc *desc)
>  {
> > -	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
> >  	int ret = 0;
>  
> > -	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
> > -					GFP_ATOMIC);
> > +	desc->bd = dma_pool_alloc(desc->sdmac->bd_pool, GFP_ATOMIC,
> +					&desc->bd_phys);

This is replacing a allocation of num_bd * sizeof(descriptor) by a
single call to dma_pool_alloc, which provides enough memory for a
single descriptor, so this will lead to invalid usage of descriptor
memory for all transfers with more than a single descriptor.

Regards,
Lucas

>  	if (!desc->bd) {
> >  		ret = -ENOMEM;
> >  		goto out;
> @@ -1168,9 +1169,7 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
>  
>  static void sdma_free_bd(struct sdma_desc *desc)
>  {
> > -	u32 bd_size = desc->num_bd * sizeof(struct sdma_buffer_descriptor);
> -
> > -	dma_free_coherent(NULL, bd_size, desc->bd, desc->bd_phys);
> > +	dma_pool_free(desc->sdmac->bd_pool, desc->bd, desc->bd_phys);
>  }
>  
>  static void sdma_desc_free(struct virt_dma_desc *vd)
> @@ -1218,6 +1217,10 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
> >  	if (ret)
> >  		goto disable_clk_ahb;
>  
> > +	sdmac->bd_pool = dma_pool_create("bd_pool", chan->device->dev,
> > +				sizeof(struct sdma_buffer_descriptor),
> > +				32, 0);
> +
> >  	return 0;
>  
>  disable_clk_ahb:
> @@ -1246,6 +1249,9 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
>  
> >  	clk_disable(sdma->clk_ipg);
> >  	clk_disable(sdma->clk_ahb);
> +
> > +	dma_pool_destroy(sdmac->bd_pool);
> > +	sdmac->bd_pool = NULL;
>  }
>  
>  static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
