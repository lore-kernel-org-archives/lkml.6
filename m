Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9321C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F07920844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfBEMfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:35:25 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62350 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEMfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:35:24 -0500
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="26329076"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 05:35:23 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Tue, 5 Feb 2019
 05:35:23 -0700
Date:   Tue, 5 Feb 2019 13:35:10 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] dmaengine: at_xdmac: only monitor overflow errors
 for peripheral xfer
Message-ID: <20190205123509.tgvqbdik5lhrb5qb@M43218.corp.atmel.com>
Mail-Followup-To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
 <4af293348e03a30746d8c0e5eead2f480b2f13f9.1549364323.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4af293348e03a30746d8c0e5eead2f480b2f13f9.1549364323.git.nicolas.ferre@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:03:43PM +0100, Nicolas Ferre wrote:
> The overflow error flag (ROI: Request Overflow Error) is only relevant
> for the case when the channel handles a peripheral synchronized transfer.
> Not in the case of memory to memory transfer where there is no hardware
> request signal.
> 
> Remove the use of this interrupt source in such a case. It's based on
> the first descriptor which holds the configuration for the whole
> linked list transfer.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/dma/at_xdmac.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index ec7a29d8e448..b558a23ffbc2 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -308,6 +308,11 @@ static inline int at_xdmac_csize(u32 maxburst)
>  	return csize;
>  };
>  
> +static inline bool at_xdmac_chan_is_peripheral_xfer(u32 cfg)
> +{
> +	return cfg & AT_XDMAC_CC_TYPE_PER_TRAN;
> +}
> +
>  static inline u8 at_xdmac_get_dwidth(u32 cfg)
>  {
>  	return (cfg & AT_XDMAC_CC_DWIDTH_MASK) >> AT_XDMAC_CC_DWIDTH_OFFSET;
> @@ -389,7 +394,13 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
>  		 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
>  
>  	at_xdmac_chan_write(atchan, AT_XDMAC_CID, 0xffffffff);
> -	reg = AT_XDMAC_CIE_RBEIE | AT_XDMAC_CIE_WBEIE | AT_XDMAC_CIE_ROIE;
> +	reg = AT_XDMAC_CIE_RBEIE | AT_XDMAC_CIE_WBEIE;
> +	/*
> +	 * Request Overflow Error is only for peripheral synchronized transfers
> +	 */
> +	if (at_xdmac_chan_is_peripheral_xfer(first->lld.mbr_cfg))
> +		reg |= AT_XDMAC_CIE_ROIE;
> +
>  	/*
>  	 * There is no end of list when doing cyclic dma, we need to get
>  	 * an interrupt after each periods.
> -- 
> 2.17.1
> 
