Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B21FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F65218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hhqVK5Z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfAXPvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:51:43 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:54220 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXPvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:51:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=i1fezm4aBAKQY2KkkwCINvHF/gqTkX8n99ORGJ5P5kI=; b=hhqVK5Z1Qkpkf+JCQhgiJc0HpF
        K5HnjrCwz5qBdiaJLOJTvPrCi9CIZjx8M+PbPUU1ycy0oKCwZzOTGvoEv88TXIUlu7xMy4IfXp2pA
        xseyOm+P4pg92J+Rpvv4LoJeuSTZFSUirj94H1RPeXhJh2xvYHxVIAmlTiX8LjxtIeH8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1gmhI1-0001Rz-9A; Thu, 24 Jan 2019 16:51:37 +0100
Date:   Thu, 24 Jan 2019 16:51:37 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        antoine.tenart@bootlin.com, maxime.chevallier@bootlin.com
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH net] net: mvpp2: fix condition for setting up link
 interrupt
Message-ID: <20190124155137.GD482@lunn.ch>
References: <20190124131803.14038-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124131803.14038-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 02:18:03PM +0100, Thomas Bogendoerfer wrote:
> Set up link interrupt if connection is handled by phylink otherwise
> link state change detection for in-band-status doesn't work.

Hi Thomas

Please ensure the maintainers of the driver are at least on Cc:

Thanks
	Andrew

> 
> Fixes: 4bb043262878 ("net: mvpp2: phylink support")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 16066c2d5b3a..0fbfe1945a69 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -3405,7 +3405,7 @@ static int mvpp2_open(struct net_device *dev)
>  		valid = true;
>  	}
>  
> -	if (priv->hw_version == MVPP22 && port->link_irq && !port->phylink) {
> +	if (priv->hw_version == MVPP22 && port->link_irq && port->phylink) {
>  		err = request_irq(port->link_irq, mvpp2_link_status_isr, 0,
>  				  dev->name, port);
>  		if (err) {
> -- 
> 2.16.4
> 
