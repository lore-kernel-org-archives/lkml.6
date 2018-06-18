Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC74C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1259B20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 16:03:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1259B20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934464AbeFRQDe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 12:03:34 -0400
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:35688 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752650AbeFRQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 12:03:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 89FC8182CF666;
        Mon, 18 Jun 2018 16:03:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scene62_7589b35777c13
X-Filterd-Recvd-Size: 3547
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 18 Jun 2018 16:03:27 +0000 (UTC)
Message-ID: <644296b273a76469baf641dd712c7a5451cd34fe.camel@perches.com>
Subject: Re: [PATCH 2/5] net: emaclite: Balance braces in else statement
From:   Joe Perches <joe@perches.com>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        davem@davemloft.net, andrew@lunn.ch, michal.simek@xilinx.com
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jun 2018 09:03:26 -0700
In-Reply-To: <1529322610-27215-3-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
         <1529322610-27215-3-git-send-email-radhey.shyam.pandey@xilinx.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-18 at 17:20 +0530, Radhey Shyam Pandey wrote:
> Remove else as it is not required with if doing a return.
> Fixes below checkpatch warning.

> WARNING: else is not generally useful after a break or return

checkpatch is stupid and doesn't understand code flow.
Always try to improve code flow instead of merely
following brainless instructions from a script.

So:

> diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
[]
> @@ -569,13 +569,11 @@ static void xemaclite_tx_handler(struct net_device *dev)
>  					(u8 *) lp->deferred_skb->data,
>  					lp->deferred_skb->len) != 0)
>  			return;
> -		else {
> -			dev->stats.tx_bytes += lp->deferred_skb->len;
> -			dev_kfree_skb_irq(lp->deferred_skb);
> -			lp->deferred_skb = NULL;
> -			netif_trans_update(dev); /* prevent tx timeout */
> -			netif_wake_queue(dev);
> -		}
> +		dev->stats.tx_bytes += lp->deferred_skb->len;
> +		dev_kfree_skb_irq(lp->deferred_skb);
> +		lp->deferred_skb = NULL;
> +		netif_trans_update(dev); /* prevent tx timeout */
> +		netif_wake_queue(dev);
>  	}
>  }

If you really want to redo this function, perhaps something like:

static void xemaclite_tx_handler(struct net_device *dev)
{
	struct net_local *lp = netdev_priv(dev);

	dev->stats.tx_packets++;

	if (!lp->deferred_skb)
		return;

	if (xemaclite_send_data(lp, (u8 *)lp->deferred_skb->data,
				lp->deferred_skb->len))
		return;

	dev->stats.tx_bytes += lp->deferred_skb->len;
	dev_kfree_skb_irq(lp->deferred_skb);
	lp->deferred_skb = NULL;
	netif_trans_update(dev); /* prevent tx timeout */
	netif_wake_queue(dev);
}
 
> @@ -1052,13 +1050,13 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
>  {
>  	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
>  
> -	if (p) {
> +	if (p)
>  		return (bool)*p;
> -	} else {
> -		dev_warn(&ofdev->dev, "Parameter %s not found,"
> +
> +	dev_warn(&ofdev->dev, "Parameter %s not found,"
>  			"defaulting to false\n", s);
> -		return false;
> -	}
> +
> +	return false;
>  }

And this function has backward logic as the failure paths
are the ones that should return early or use a goto.

Perhaps something like:

static bool get_bool(struct platform_device *ofdev, const char *s)
{
	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);

	if (!p) {
		dev_warn(&ofdev->dev,
			 "Parameter '%s' not found, defaulting to false\n", s);
		return false;
	}

	return *p;
}

