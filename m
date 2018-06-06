Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P9aM1sTy"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7ADA607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeFFMjv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:39:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:56017 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbeFFMju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:39:50 -0400
Date: Wed, 6 Jun 2018 14:39:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Onnasch <alexander.onnasch@landisgyr.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/phy: Micrel KSZ8061 PHY link failure after cable
 connect
Message-ID: <20180606123947.GB14898@lunn.ch>
References: <1528272198-10825-1-git-send-email-alexander.onnasch@landisgyr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528272198-10825-1-git-send-email-alexander.onnasch@landisgyr.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 10:03:18AM +0200, Alexander Onnasch wrote:
> With Micrel KSZ8061 PHY, the link may occasionally not come up after
> Ethernet cable connect. The vendor's (Microchip, former Micrel) errata
> sheet 80000688A.pdf describes the problem and possible workarounds in
> detail, see below.
> The patch implements workaround 1, which permanently fixes the issue.
> 
> DESCRIPTION
> Link-up may not occur properly when the Ethernet cable is initially
> connected. This issue occurs more commonly when the cable is connected
> slowly, but it may occur any time a cable is connected. This issue occurs
> in the auto-negotiation circuit, and will not occur if auto-negotiation
> is disabled (which requires that the two link partners be set to the
> same speed and duplex).
> 
> END USER IMPLICATIONS
> When this issue occurs, link is not established. Subsequent cable
> plug/unplug cycles will not correct the issue.
> 
> WORK AROUND
> There are four approaches to work around this issue:
> 1.  This issue can be prevented by setting bit 15 in MMD device address 1,
>     register 2, prior to connecting the  cable or prior to setting the
>     Restart Auto-Negotiation bit in register 0h.The MMD registers are
>     accessed via the indirect access registers Dh and Eh, or via the Micrel
>     EthUtil utility as shown here:
>     •  If using the EthUtil utility (usually with a Micrel KSZ8061
>        Evaluation Board), type the following commands:
>        > address 1
>        > mmd 1
>        > iw 2 b61a
>     •  Alternatively, write the following registers to write to the
>        indirect MMD register:
>        Write register Dh, data 0001h
>        Write register Eh, data 0002h
>        Write register Dh, data 4001h
>        Write register Eh, data B61Ah
> 2.  The issue can be avoided by disabling auto-negotiation in the KSZ8061,
>     either by the strapping option, or by clearing bit 12 in register 0h.
>     Care must be taken to ensure that the KSZ8061 and the link partner
>     will link with the same speed and duplex. Note that the KSZ8061
>     defaults to full-duplex when auto-negotiation is off, but other
>     devices may default to half-duplex in the event of failed
>     auto-negotiation.
> 3.  The issue can be avoided by connecting the cable prior to powering-up
>     or resetting the KSZ8061, and leaving it plugged in thereafter.
> 4.  If the above measures are not taken and the problem occurs, link can
>     be recovered by setting the Restart Auto-Negotiation bit in
>     register 0h, or by resetting or power cycling the device. Reset may
>     be either hardware reset or software reset (register 0h, bit 15).
> 
> PLAN
> This errata will not be corrected in a future revision.
> 
> Signed-off-by: Alexander Onnasch <alexander.onnasch@landisgyr.com>
> ---
>  drivers/net/phy/micrel.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
> index 6c45ff6..7d80a00 100644
> --- a/drivers/net/phy/micrel.c
> +++ b/drivers/net/phy/micrel.c
> @@ -339,6 +339,28 @@ static int ksz8041_config_aneg(struct phy_device *phydev)
>  	return genphy_config_aneg(phydev);
>  }
>  
> +#define MII_KSZ8061RN_MMD_CTRL_REG	    0x0d
> +#define MII_KSZ8061RN_MMD_REGDATA_REG	0x0e
> +
> +static int ksz8061_extended_write(struct phy_device *phydev,
> +				  u8 mode, u32 dev_addr, u32 regnum, u16 val)
> +{
> +	phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, dev_addr);
> +	phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, regnum);
> +	phy_write(phydev, MII_KSZ8061RN_MMD_CTRL_REG, (mode << 14) | dev_addr);
> +	return phy_write(phydev, MII_KSZ8061RN_MMD_REGDATA_REG, val);
> +}

Hi Alexander

This looks a lot like phy_write_mmd().

     Andrew
