Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A170BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6533920858
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 20:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pmYHwEcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6533920858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389000AbeKPGVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 01:21:53 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:36473 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbeKPGVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 01:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=fSGfgKaQR3+VNuCpmAQk+/qqVKIU6He0zp4tJUZiEGg=;
        b=pmYHwEcGRGw800jexc8oj6BtMPRm3RyHbU0wSGVkneXnAdFYNj4V2JUROAMPWRzdK+HTMP8eqKsqPrOe5X8LBfcVSLGjrj5wBokjx8czvy8bssWtRYhGIDqyTrH0xXslyUVFmkFesi6CVQmjTIf4kaMR13bFvoQ1Yt3LXfDKCmg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gNO09-0000QA-4j; Thu, 15 Nov 2018 21:12:33 +0100
Date:   Thu, 15 Nov 2018 21:12:33 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Martin Schiller <ms@dev.tdt.de>
Cc:     sergei.shtylyov@cogentembedded.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] net: phy: mdio-gpio: Fix working over slow can_sleep
 GPIOs
Message-ID: <20181115201233.GE32274@lunn.ch>
References: <20181114061703.11026-1-ms@dev.tdt.de>
 <20181115052428.8133-1-ms@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115052428.8133-1-ms@dev.tdt.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 06:24:28AM +0100, Martin Schiller wrote:
> Up until commit 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod
> functions where possible"), the _cansleep variants of the gpio_ API was
> used. After that commit and the change to gpiod_ API, the _cansleep()
> was dropped. This then results in WARN_ON() when used with GPIO
> devices which do sleep. Add back the _cansleep() to avoid this.
> 
> Fixes: 7e5fbd1e0700 ("net: mdio-gpio: Convert to use gpiod functions where possible")
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
> v5:
>  - reworked commit message
>  - added "Fixes:" tag
>  - based on DaveM net tree instead of mainline

Hi Martin

Thanks for these changes. We are much closer now.

> @@ -162,6 +162,10 @@ static int mdio_gpio_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (gpiod_cansleep(bitbang->mdc) || gpiod_cansleep(bitbang->mdio) ||
> +	    gpiod_cansleep(bitbang->mdo))
> +		dev_warn(&pdev->dev, "Slow GPIO pins might wreak havoc into MDIO bus timing");
> +

I talked with Florian about this. We would like this hunk of the patch
dropped

1) For a patch which is going to stable, it does not fit. It does not
actually fix anything.

2) I'm not sure it has any value. The hardware has been designed like
that. There is nothing which can be done about it. Printing a message
is not going to help users.

   Andrew
