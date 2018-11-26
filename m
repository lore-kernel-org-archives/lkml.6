Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48379C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D5820817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vQOqud3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D5820817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeK0BeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:34:05 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49458 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbeK0BeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=RY9LEOD7aRWwx7to15Fj0jf3FoySwRiHpK+tu5rF/O0=;
        b=vQOqud3fter1syj4YLXATti1W0q678wDR4Rf6hJgmcTmYJ6cx01NvRZxIY1Q8nhBfa3Y42Ezd5xRTm5Eq9CwPxIH+uL2MCSpAKBxJoq67upTE/6IbbmkAVVRzX/r0NS/DLav9IgpFeWIm5/je5Z3yvT10FJNq/AMw9jhu+GskFg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gRI33-0004SB-5u; Mon, 26 Nov 2018 15:39:41 +0100
Date:   Mon, 26 Nov 2018 15:39:41 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        claudiu.beznea@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com, Harini Katakam <harinik@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v2 1/4] net: macb: Check MDIO state before read/write and
 use timeouts
Message-ID: <20181126143941.GB12116@lunn.ch>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543216072-9623-2-git-send-email-harini.katakam@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 12:37:49PM +0530, Harini Katakam wrote:
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
> v2 changes:
> Use readx_poll_timeout
> 
> Changes form RFC:
> Cleaned up timeout implementation and moved it to a helper.
> 
>  drivers/net/ethernet/cadence/macb.h      |  3 +++
>  drivers/net/ethernet/cadence/macb_main.c | 33 ++++++++++++++++++++++++++------
>  2 files changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
> index 3d45f4c..df7bee1 100644
> --- a/drivers/net/ethernet/cadence/macb.h
> +++ b/drivers/net/ethernet/cadence/macb.h
> @@ -714,6 +714,9 @@
>  		__v; \
>  	})
>  
> +#define MACB_IDLE_MASK		(1 << MACB_IDLE_OFFSET)

I think you could use the MACB_BIT() macro here.

But otherwise,

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
