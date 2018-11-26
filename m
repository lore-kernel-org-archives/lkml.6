Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F3520817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lZrkhdO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F3520817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbeK0Blf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:41:35 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:49482 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbeK0Ble (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=rCzXb9bgslmMRM6+xPqKkGqraFKFo4B2ZrIwRkfNPi4=;
        b=lZrkhdO+3ujTudcSSy27BEXxqKcToFSV18HQN+AISYmHD7Pc6lZN3ipnGeu317caPjXuK0X2maPZlNFnUZIrVv2gwGlew65cjHz0dLQQ3aIKUXjMrng00ZEg68PYqOFBb057HfG5p06FXVhGHJDgYBbl3rPPalx+C+KdvkVJjXo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gRIAI-0004aq-Li; Mon, 26 Nov 2018 15:47:10 +0100
Date:   Mon, 26 Nov 2018 15:47:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@xilinx.com>
Cc:     nicolas.ferre@microchip.com, davem@davemloft.net,
        claudiu.beznea@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        harinikatakamlinux@gmail.com, Harini Katakam <harinik@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v2 3/4] net: macb: Add pm runtime support
Message-ID: <20181126144710.GC12116@lunn.ch>
References: <1543216072-9623-1-git-send-email-harini.katakam@xilinx.com>
 <1543216072-9623-4-git-send-email-harini.katakam@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543216072-9623-4-git-send-email-harini.katakam@xilinx.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -335,6 +338,10 @@ static int macb_mdio_read(struct mii_bus *bus, int mii_id, int regnum)
>  	int value;
>  	int err;
>  
> +	err = pm_runtime_get_sync(&bp->pdev->dev);
> +	if (err < 0)
> +		return err;
> +
>  	err = macb_mdio_wait_for_idle(bp);
>  	if (err < 0)
>  		return err;

Hi Harini

Thanks for adding runtime PM support to the MDIO bus.

It looks like on the error paths you are not always undoing the
pm_runtime_get_sync(). You probably need some sort of goto err;
construct. macb_mdio_write() has the same issue.

	Andrew
