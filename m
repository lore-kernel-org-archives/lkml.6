Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AF0FCC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F3F5208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 09:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3F5208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935137AbeFMJyu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 05:54:50 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56491 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934987AbeFMJyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 05:54:49 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fT2UH-0001K1-9e; Wed, 13 Jun 2018 11:54:45 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fT2UG-0005NC-Td; Wed, 13 Jun 2018 11:54:44 +0200
Date:   Wed, 13 Jun 2018 11:54:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: Re: [PATCH v3 5/6] dmaengine: imx-sdma: remove the maximum limation
 for bd numbers
Message-ID: <20180613095444.uek6uzczdhx3rh56@pengutronix.de>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
 <1528729173-28684-6-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528729173-28684-6-git-send-email-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:53:45 up 19:02, 42 users,  load average: 0.01, 0.07, 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the subject: s/limation/limitation/

Sascha

On Mon, Jun 11, 2018 at 10:59:32PM +0800, Robin Gong wrote:
> No this limitation now after virtual dma used since bd is allocated
> dynamically instead of static.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f150b38..0b0588d2 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -292,7 +292,6 @@ struct sdma_context_data {
>  	u32  scratch7;
>  } __attribute__ ((packed));
>  
> -#define NUM_BD (int)(PAGE_SIZE / sizeof(struct sdma_buffer_descriptor))
>  
>  struct sdma_engine;
>  
> @@ -1296,13 +1295,6 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(
>  	if (ret)
>  		goto err_bd_out;
>  
> -	if (sg_len > NUM_BD) {
> -		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
> -				channel, sg_len, NUM_BD);
> -		ret = -EINVAL;
> -		goto err_bd_out;
> -	}
> -
>  	desc->chn_count = 0;
>  	for_each_sg(sgl, sg, sg_len, i) {
>  		struct sdma_buffer_descriptor *bd = &desc->bd[i];
> @@ -1412,12 +1404,6 @@ static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
>  	if (ret)
>  		goto err_bd_out;
>  
> -	if (num_periods > NUM_BD) {
> -		dev_err(sdma->dev, "SDMA channel %d: maximum number of sg exceeded: %d > %d\n",
> -				channel, num_periods, NUM_BD);
> -		goto err_bd_out;
> -	}
> -
>  	if (period_len > 0xffff) {
>  		dev_err(sdma->dev, "SDMA channel %d: maximum period size exceeded: %zu > %d\n",
>  				channel, period_len, 0xffff);
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
