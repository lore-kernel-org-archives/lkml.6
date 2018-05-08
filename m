Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754690AbeEHMFn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 08:05:43 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51916 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeEHMFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 08:05:41 -0400
Date: Tue, 8 May 2018 13:05:27 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Antoine Tenart <antoine.tenart@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net] net: phy: sfp: fix the BR,min computation
Message-ID: <20180508120527.GI16141@n2100.armlinux.org.uk>
References: <20180504151054.17525-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504151054.17525-1-antoine.tenart@bootlin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 05:10:54PM +0200, Antoine Tenart wrote:
> In an SFP EEPROM values can be read to get information about a given SFP
> module. One of those is the bitrate, which can be determined using a
> nominal bitrate in addition with min and max values (in %). The SFP code
> currently compute both BR,min and BR,max values thanks to this nominal
> and min,max values.
> 
> This patch fixes the BR,min computation as the min value should be
> subtracted to the nominal one, not added.
> 
> Fixes: 9962acf7fb8c ("sfp: add support for 1000Base-PX and 1000Base-BX10")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

I know David has already applied it, but for the record, your fix looks
correct, thanks.

> ---
>  drivers/net/phy/sfp-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
> index 0381da78d228..fd6c23f69c2f 100644
> --- a/drivers/net/phy/sfp-bus.c
> +++ b/drivers/net/phy/sfp-bus.c
> @@ -125,7 +125,7 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
>  	if (id->base.br_nominal) {
>  		if (id->base.br_nominal != 255) {
>  			br_nom = id->base.br_nominal * 100;
> -			br_min = br_nom + id->base.br_nominal * id->ext.br_min;
> +			br_min = br_nom - id->base.br_nominal * id->ext.br_min;
>  			br_max = br_nom + id->base.br_nominal * id->ext.br_max;
>  		} else if (id->ext.br_max) {
>  			br_nom = 250 * id->ext.br_max;
> -- 
> 2.17.0
> 

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
