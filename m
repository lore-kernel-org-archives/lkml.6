Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CC7C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FA02077C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fgFe/DT0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FA02077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeHaS06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:26:58 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:48908 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728404AbeHaS05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=XQ1TF1y0gfOpb1ahNQlH0XdVciW24nXROQFdeq3Lwbc=;
        b=fgFe/DT0Zf0MQrAzVED7WcUO84Rxxt73DZy+e9vYJOt0ouxtJKzRyWGsLD33qoX5Z1bxGfxVeidWLuhyK24Jq0dmILZ6cCIT/V5VpP7FXdpvhxxjVcwyryYZkLWrlpUjHKeX4caiOAM21p9lulKjj8/HigYBqTEHfIewAbe0L1c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fvkGB-0005MN-Qh; Fri, 31 Aug 2018 16:18:51 +0200
Date:   Fri, 31 Aug 2018 16:18:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        davem@davemloft.net, kishon@ti.com, gregory.clement@bootlin.com,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v3 02/10] net: mvpp2: phylink support
Message-ID: <20180831141851.GA19733@lunn.ch>
References: <20180517082939.14598-1-antoine.tenart@bootlin.com>
 <20180517082939.14598-3-antoine.tenart@bootlin.com>
 <20180827165058.GD30658@n2100.armlinux.org.uk>
 <20180831133651.GB32574@kwain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831133651.GB32574@kwain>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -4691,6 +4685,9 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>  	if (fwnode_property_read_bool(port_fwnode, "marvell,loopback"))
>  		port->flags |= MVPP2_F_LOOPBACK;
>  
> +	if (fwnode_property_present(port_fwnode, "fixed-link"))
> +		port->flags |= MVPP2_F_FIXED_LINK;
> +

Hi Antoine

There is no need to go look in device tree. When phylink calls
mac_config() it passes mode == MLO_AN_FIXED, when it is using a fixed
link.

	Andrew
