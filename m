Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236BBC6787A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AF82087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cOWDsYRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AF82087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJIIFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:05:15 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57749 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeJIIFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=z7FeYIZJR4DoQeQv9T7Bj1p4c4IsgcaVxMSwM+Q2S0Y=;
        b=cOWDsYRxosSrv5HjOimHXh3EByobldgeuWYCZ0/xflSOoO/8yST4V5IjBVLwDdDCUqQXFVGYrpUWqipLYuvP5WWrX0cHPbFoYLO66CffisG3KflM0PKnBgdh+E3NlR076Ktb7PzHf8ql/oRIZ7lX1ul6ynqT47i2WEwx3dAmNl4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g9gEa-00070v-8K; Tue, 09 Oct 2018 02:50:48 +0200
Date:   Tue, 9 Oct 2018 02:50:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 05/11] net: ethernet: ti: cpsw: add support for port
 interface mode selection phy
Message-ID: <20181009005048.GB23588@lunn.ch>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-6-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008234949.15416-6-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	/* Configure GMII_SEL register */
> -	cpsw_phy_sel(cpsw->dev, slave->phy->interface, slave->slave_num);
> +	if (!IS_ERR(slave->data->ifphy))
> +		phy_set_netif_mode(slave->data->ifphy, slave->data->phy_if);

Is slave->data->phy_if also passed to phy_connect()? So you are going
to end up with both the MAC and the PHY inserting RGMII delays, and it
not working.

You need to somehow decide if the MAC is going to do the delay, or the
PHY. But not both.

	Andrew
