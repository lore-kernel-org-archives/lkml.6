Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C98DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA79720865
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 18:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eHT7ubda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA79720865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441111AbeKXEtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:49:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:47254 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbeKXEtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=dFQ6lTpKyBaHJddzTcdgW5OlLcPBdBvxdHEB9G6yEtA=;
        b=eHT7ubdaeapOGbq7O6JLkJBmtwtmZcTjm61fEaLErsBs0wmNEhYFGBBiiWD7ubJqTogbx/4DpqtTAF57Fnj36KIKJGcfR5nWrSgnz86B/NrnzC3MvPtSI4NBdQf6VyTe+fiX8ezTbtEG9xRDcDoqZTYzq2E0pwzAXikHnaguPkw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gQFo6-0001ZS-Kv; Fri, 23 Nov 2018 19:03:58 +0100
Date:   Fri, 23 Nov 2018 19:03:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com
Subject: Re: [PATCH net v3] net: phy: mscc: fix deadlock in
 vsc85xx_default_config
Message-ID: <20181123180358.GC5273@lunn.ch>
References: <20181123180151.14183-1-quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123180151.14183-1-quentin.schulz@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 07:01:51PM +0100, Quentin Schulz wrote:
> The vsc85xx_default_config function called in the vsc85xx_config_init
> function which is used by VSC8530, VSC8531, VSC8540 and VSC8541 PHYs
> mistakenly calls phy_read and phy_write in-between phy_select_page and
> phy_restore_page.
> 
> phy_select_page and phy_restore_page actually take and release the MDIO
> bus lock and phy_write and phy_read take and release the lock to write
> or read to a PHY register.
> 
> Let's fix this deadlock by using phy_modify_paged which handles
> correctly a read followed by a write in a non-standard page.
> 
> Fixes: 6a0bfbbe20b0 ("net: phy: mscc: migrate to phy_select/restore_page functions")
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
