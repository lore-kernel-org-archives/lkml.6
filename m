Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05575C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50BF20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="POOfEvpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50BF20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbeG1WuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 18:50:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:49371 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730949AbeG1WuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 18:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8VbLareIU1L09ldjHgAyfv1rddrgDGfNGulMSOOqhGA=;
        b=POOfEvpSWAJjuwy+1DtOQ8oT0KKCP1IZwNjCRg8YrD/pdtwHzSQ8JU2L8AkJ7Z3UctMEUuZoLG9R9HbnzxojFvt4PGpk2zsVl4pdjZUKqOPONRPBRpxfsPo6qbCUrbuznJIStasGUIBnp8iAhmH2/ocg45YE3wZs/XQNClOXai4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fjWfQ-0001QI-Tx; Sat, 28 Jul 2018 23:22:24 +0200
Date:   Sat, 28 Jul 2018 23:22:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Arun Parameswaran <arun.parameswaran@broadcom.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 6/7] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
Message-ID: <20180728212224.GF4792@lunn.ch>
References: <1532726613-6483-1-git-send-email-arun.parameswaran@broadcom.com>
 <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532726613-6483-7-git-send-email-arun.parameswaran@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -198,10 +219,22 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  		return PTR_ERR(md->base);
>  	}
>  
> +	md->core_clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(md->core_clk)) {
> +		md->core_clk = NULL;
> +	} else {
> +		rc = clk_prepare_enable(md->core_clk);
> +		if (rc) {
> +			dev_err(&pdev->dev, "failed to enable core clk\n");
> +			return rc;
> +		}
> +	}
> +
>  	md->mii_bus = mdiobus_alloc();
>  	if (!md->mii_bus) {
>  		dev_err(&pdev->dev, "mdiomux bus alloc failed\n");
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto out;

Hi Arun

There is a devm_mdiobus_alloc() which could make the cleanup on error
simple.

>  	}
>  
>  	bus = md->mii_bus;
> @@ -217,7 +250,7 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  	rc = mdiobus_register(bus);
>  	if (rc) {
>  		dev_err(&pdev->dev, "mdiomux registration failed\n");
> -		goto out;
> +		goto out_alloc;
>  	}
>  
>  	platform_set_drvdata(pdev, md);
> @@ -236,8 +269,11 @@ static int mdio_mux_iproc_probe(struct platform_device *pdev)
>  
>  out_register:
>  	mdiobus_unregister(bus);
> -out:
> +out_alloc:
>  	mdiobus_free(bus);
> +out:
> +	if (md->core_clk)
> +		clk_disable_unprepare(md->core_clk);
>  	return rc;
>  }

   Andrew
