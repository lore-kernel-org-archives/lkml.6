Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC74C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA28621925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d9PtjzjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394943AbfBONfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:35:07 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53649 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbfBONfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sae7oI0BakmA1YYtB52K/s24aAoF9FG6Hk2jAt8wpiw=; b=d9PtjzjVgLlBZikcGn6EOet4oT
        ras8mlPdntQ4UIz5AzE7m0zsC/rJrOk3lHGaKLrzqDVvC/D7mNpo7uZaPwpjPstICpTTyeaB6fPY4
        z+4wsSftF7BrnSO2q6fseMfUqBRemX/2HxdPn3Y0c46b20MwY5IMIJhJZe/B4DQO+wWc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1guddr-00055W-Q5; Fri, 15 Feb 2019 14:34:59 +0100
Date:   Fri, 15 Feb 2019 14:34:59 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        alexandru.marginean@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] enetc: Add ENETC PF level external MDIO
 support
Message-ID: <20190215133459.GH5699@lunn.ch>
References: <1550225414-12125-1-git-send-email-claudiu.manoil@nxp.com>
 <1550225414-12125-4-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550225414-12125-4-git-send-email-claudiu.manoil@nxp.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 12:10:14PM +0200, Claudiu Manoil wrote:
> Each ENETC PF has its own MDIO interface, the corresponding
> MDIO registers are mapped in the ENETC's Port register block.
> The current patch adds a driver for these PF level MDIO buses,
> so that each PF can manage directly its own external link.
> 
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v2 - used readx_poll_timeout()
>    - added mdio node child to the port node

Hi Claudiu

Please document this in the device tree binding.

> +	/* return all Fs if nothing was there */
> +	if (enetc_rd_reg(&regs->mdio_cfg) & MDIO_CFG_RD_ER) {
> +		dev_err(&bus->dev,
> +			"Error while reading PHY%d reg at %d.%hhu\n",
> +			phy_id, dev_addr, regnum);
> +		return 0xffff;

I'm not sure you want a dev_err() here. The device tree binding allows
you to have a phy node without a reg value. When that happens, the
core code will scan all 32 addresses to find the PHY. This is going to
spam the log. dev_dbg() might be better.

     Andrew
