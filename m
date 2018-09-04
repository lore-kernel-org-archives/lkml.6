Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54493C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A08E206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A08E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbeIDTzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:55:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44904 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727154AbeIDTzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:55:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 60C6320877; Tue,  4 Sep 2018 17:29:44 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 36548206EE;
        Tue,  4 Sep 2018 17:29:34 +0200 (CEST)
Date:   Tue, 4 Sep 2018 17:29:33 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: at91_can: fix fall-through annotations
Message-ID: <20180904152933.GJ13888@piout.net>
References: <20180903183618.GA6905@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903183618.GA6905@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 13:36:18-0500, Gustavo A. R. Silva wrote:
> Properly place the "fall through" annotations at the bottom of the case,
> which is what GCC is expecting to find.
> 
> This fix is part of the ongoing efforts to enabling -Wimplicit-fallthrough
> 
> Addresses-Coverity-ID: 1222851 ("Missing break in switch")
> Addresses-Coverity-ID: 402011 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Seems good to me (but I preferred the previous annotation ;))

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/net/can/at91_can.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
> index d98c690..1718c20 100644
> --- a/drivers/net/can/at91_can.c
> +++ b/drivers/net/can/at91_can.c
> @@ -902,7 +902,8 @@ static void at91_irq_err_state(struct net_device *dev,
>  				CAN_ERR_CRTL_TX_WARNING :
>  				CAN_ERR_CRTL_RX_WARNING;
>  		}
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */
> +	case CAN_STATE_ERROR_WARNING:
>  		/*
>  		 * from: ERROR_ACTIVE, ERROR_WARNING
>  		 * to  : ERROR_PASSIVE, BUS_OFF
> @@ -951,7 +952,8 @@ static void at91_irq_err_state(struct net_device *dev,
>  		netdev_dbg(dev, "Error Active\n");
>  		cf->can_id |= CAN_ERR_PROT;
>  		cf->data[2] = CAN_ERR_PROT_ACTIVE;
> -	case CAN_STATE_ERROR_WARNING:	/* fallthrough */
> +		/* fall through */
> +	case CAN_STATE_ERROR_WARNING:
>  		reg_idr = AT91_IRQ_ERRA | AT91_IRQ_WARN | AT91_IRQ_BOFF;
>  		reg_ier = AT91_IRQ_ERRP;
>  		break;
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
