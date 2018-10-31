Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE9720664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pM8kZQD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE9720664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeJaWqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:46:21 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:47183 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728849AbeJaWqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=VvzyrPCQQvm51D8pcXiYfmEq+4lollpwZhoa5CLFeEo=;
        b=pM8kZQD6c8Ng9jdk5hYhHqf7vSu5bmrP2xDE9t5A9hQHV8k8RlBUZECELZ6ywnrqKfUYVr7NwKNm1yNw8UjfUG2UXr7PB7z6aq1AXqNJIol03xssmgGaJ70ENWziGQgzhr5Z+al86F9eti23v6sMV2KLr1X3AMyZnS6VLNqBph8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gHqqw-0005mJ-Bg; Wed, 31 Oct 2018 14:48:10 +0100
Date:   Wed, 31 Oct 2018 14:48:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        claudiu.beznea@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com, Harini Katakam <harinik@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Message-ID: <20181031134810.GD20889@lunn.ch>
References: <1540957223-30984-1-git-send-email-harini.katakam@xilinx.com>
 <1540957223-30984-2-git-send-email-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540957223-30984-2-git-send-email-harini.katakam@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:10:20AM +0530, Harini Katakam wrote:
> From: Harini Katakam <harinik@xilinx.com>
> 
> Replace the while loop in MDIO read/write functions with a timeout.
> In addition, add a check for MDIO bus busy before initiating a new
> operation as well to make sure there is no ongoing MDIO operation.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> ---
> Changes form RFC:
> Cleaned up timeout implementation and moved it to a helper.
> 
>  drivers/net/ethernet/cadence/macb_main.c | 44 +++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index 0acaef3..b4e26c1 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -318,10 +318,36 @@ static void macb_get_hwaddr(struct macb *bp)
>  	eth_hw_addr_random(bp->dev);
>  }
>  
> +static int macb_mdio_wait_for_idle(struct macb *bp)
> +{
> +	ulong timeout;
> +
> +	timeout = jiffies + msecs_to_jiffies(1000);
> +	/* wait for end of transfer */
> +	while (1) {
> +		if (MACB_BFEXT(IDLE, macb_readl(bp, NSR)))
> +			break;
> +
> +		if (time_after_eq(jiffies, timeout)) {
> +			netdev_err(bp->dev, "wait for end of transfer timed out\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		cpu_relax();
> +	}
> +
> +	return 0;
> +}

Hi Harini

Could you make use of readx_poll_timeout(). You will need to add a
helper for the read of the register, since readx_poll_timeout() only
allows one parameter.

Otherwise, this looks O.K.

	   Andrew
