Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC817C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC952154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC952154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeHTMoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:44:15 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:30947 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTMoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:44:15 -0400
X-IronPort-AV: E=Sophos;i="5.53,264,1531810800"; 
   d="scan'208";a="18005553"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Aug 2018 02:29:22 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Mon, 20 Aug 2018
 02:29:21 -0700
Date:   Mon, 20 Aug 2018 11:28:12 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Barry Song <21cnbao@gmail.com>
CC:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dmaengine: at_xdmac: move spin_lock_bh to spin_lock
 in tasklet
Message-ID: <20180820092812.fqu3bbrzar67hmiu@M43218.corp.atmel.com>
Mail-Followup-To: Barry Song <21cnbao@gmail.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1534511023-7871-1-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1534511023-7871-1-git-send-email-21cnbao@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 06:03:43AM -0700, Barry Song wrote:
> as you are already in a tasklet, it is unnecessary to call spin_lock_bh.
> 
> Signed-off-by: Barry Song <21cnbao@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 

Thanks
> ---
>  drivers/dma/at_xdmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 4bf7256..4e55768 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1600,7 +1600,7 @@ static void at_xdmac_tasklet(unsigned long data)
>  		if (atchan->status & AT_XDMAC_CIS_ROIS)
>  			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
>  
> -		spin_lock_bh(&atchan->lock);
> +		spin_lock(&atchan->lock);
>  		desc = list_first_entry(&atchan->xfers_list,
>  					struct at_xdmac_desc,
>  					xfer_node);
> @@ -1610,7 +1610,7 @@ static void at_xdmac_tasklet(unsigned long data)
>  		txd = &desc->tx_dma_desc;
>  
>  		at_xdmac_remove_xfer(atchan, desc);
> -		spin_unlock_bh(&atchan->lock);
> +		spin_unlock(&atchan->lock);
>  
>  		if (!at_xdmac_chan_is_cyclic(atchan)) {
>  			dma_cookie_complete(txd);
> -- 
> 2.7.4
> 
