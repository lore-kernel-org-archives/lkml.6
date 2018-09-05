Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4206C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD4120836
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 01:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EA5tKBuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD4120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbeIEF2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 01:28:45 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52414 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbeIEF2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 01:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=iPB25wNW0j3A2evm6krYoGLgNydIG3XxbqcBscVhsqA=;
        b=EA5tKBuU+GG1JLAChmoAfa44m/LCQ+4DOztq/ByvLHlepylkP11YgxIzifmRJiOHgY81Gsay+AWFArs4Qd/+bl1V77TZagxirtXcHIGV37WVyPRk7+yFbbxc/iymKliGVa6cBsuTjFdJ53l6qOWZYeKruB+rzuqfkbmmNJTyLrw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fxMBo-00041v-O1; Wed, 05 Sep 2018 03:01:00 +0200
Date:   Wed, 5 Sep 2018 03:01:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, f.fainelli@gmail.com,
        alex.williams@ni.com, moritz.fischer@ettus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] net: nixge: Add PHYLINK support
Message-ID: <20180905010100.GN29121@lunn.ch>
References: <20180905001535.19168-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905001535.19168-1-mdf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 3) I'm again not sure about the 'select PHYLINK', wouldn't
>    wanna break the build again...

Hi Moritz

I think it is safe. PHYLINK has no stated dependencies on OF. But i
suspect it currently is pretty useless without OF.

> @@ -1286,7 +1329,13 @@ static int nixge_probe(struct platform_device *pdev)
>  	priv->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
>  	priv->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
>  
> -	err = nixge_mdio_setup(priv, pdev->dev.of_node);
> +	mn = of_get_child_by_name(pdev->dev.of_node, "mdio");
> +	if (!mn) {
> +		dev_warn(&pdev->dev, "No \"mdio\" subnode found, defaulting to legacy\n");
> +		mn = pdev->dev.of_node;
> +	}
> +
> +	err = nixge_mdio_setup(priv, mn);

I would suggest making this a patch of its own.

Also, do you need the legacy behaviour? If there are no boards out in
the wild which this will break, just make the change.

Please also update the device tree binding documentation.

       Andrew
