Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550F7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E13D21726
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbeLXJgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:36:01 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:36198 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLXJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:36:01 -0500
X-IronPort-AV: E=Sophos;i="5.56,391,1539673200"; 
   d="scan'208";a="21870182"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 24 Dec 2018 02:36:00 -0700
Received: from localhost (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Mon, 24 Dec 2018
 02:36:20 -0700
Date:   Mon, 24 Dec 2018 10:36:00 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
CC:     <kernel-janitors@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/20] dmaengine: at_hdmac: drop useless LIST_HEAD
Message-ID: <20181224093600.elloyxqa6lx7rw33@M43218.corp.atmel.com>
Mail-Followup-To: Julia Lawall <Julia.Lawall@lip6.fr>,
        kernel-janitors@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1545555435-24576-1-git-send-email-Julia.Lawall@lip6.fr>
 <1545555435-24576-8-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1545555435-24576-8-git-send-email-Julia.Lawall@lip6.fr>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 09:57:02AM +0100, Julia Lawall wrote:
> Drop LIST_HEAD where the variable it declares is never used.
> 
> tmp_list has been declared since the introduction of the driver
> and has never been used.  The two declarations of list were
> introduced with the containing functions but were also not used.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> identifier x;
> @@
> - LIST_HEAD(x);
>   ... when != x
> // </smpl>
> 
> Fixes: dc78baa2b90b ("dmaengine: at_hdmac: new driver for the Atmel AHB DMA Controller")
> Fixes: 4facfe7f09f2b ("dmaengine: hdmac: Split device_control")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks
> 
> ---
> Successfully 0-day tested on 151 configurations.
> 
>  drivers/dma/at_hdmac.c |    5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 01d936c9fe89..a0a9cd76c1d4 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -134,7 +134,6 @@ static struct at_desc *atc_desc_get(struct at_dma_chan *atchan)
>  	struct at_desc *ret = NULL;
>  	unsigned long flags;
>  	unsigned int i = 0;
> -	LIST_HEAD(tmp_list);
>  
>  	spin_lock_irqsave(&atchan->lock, flags);
>  	list_for_each_entry_safe(desc, _desc, &atchan->free_list, desc_node) {
> @@ -1387,8 +1386,6 @@ static int atc_pause(struct dma_chan *chan)
>  	int			chan_id = atchan->chan_common.chan_id;
>  	unsigned long		flags;
>  
> -	LIST_HEAD(list);
> -
>  	dev_vdbg(chan2dev(chan), "%s\n", __func__);
>  
>  	spin_lock_irqsave(&atchan->lock, flags);
> @@ -1408,8 +1405,6 @@ static int atc_resume(struct dma_chan *chan)
>  	int			chan_id = atchan->chan_common.chan_id;
>  	unsigned long		flags;
>  
> -	LIST_HEAD(list);
> -
>  	dev_vdbg(chan2dev(chan), "%s\n", __func__);
>  
>  	if (!atc_chan_is_paused(atchan))
> 
