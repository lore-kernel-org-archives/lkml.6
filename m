Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeCWVI3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:08:29 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38686 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeCWVI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:08:26 -0400
X-Google-Smtp-Source: AG47ELtr9rb8uYKXhRzknjnfeqAaBN9Q/MPDitzbxVe1C9b1gnVY5z0YkKoVhXLjr9bUSTvqb+SE/Q==
Subject: Re: [PATCH net-next 1/8] net: phy: Add initial support for Microsemi
 Ocelot internal PHYs.
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org,
        Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-2-alexandre.belloni@bootlin.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1caa7359-9ca3-be22-fae0-475daf8b220f@gmail.com>
Date: Fri, 23 Mar 2018 14:08:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323201117.8416-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
> Add Microsemi Ocelot internal PHY ids. For now, simply use the genphy
> functions but more features are available.
> 
> Cc: Raju Lakkaraju <Raju.Lakkaraju@microsemi.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/net/phy/mscc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
> index 650c2667d523..e1ab3acd1cdb 100644
> --- a/drivers/net/phy/mscc.c
> +++ b/drivers/net/phy/mscc.c
> @@ -91,6 +91,7 @@ enum rgmii_rx_clock_delay {
>  #define SECURE_ON_PASSWD_LEN_4		  0x4000
>  
>  /* Microsemi PHY ID's */
> +#define PHY_ID_OCELOT			  0x00070540
>  #define PHY_ID_VSC8530			  0x00070560
>  #define PHY_ID_VSC8531			  0x00070570
>  #define PHY_ID_VSC8540			  0x00070760
> @@ -658,6 +659,19 @@ static int vsc85xx_probe(struct phy_device *phydev)
>  
>  /* Microsemi VSC85xx PHYs */
>  static struct phy_driver vsc85xx_driver[] = {
> +{
> +	.phy_id		= PHY_ID_OCELOT,
> +	.name		= "Microsemi OCELOT",
> +	.phy_id_mask    = 0xfffffff0,
> +	.features	= PHY_GBIT_FEATURES,
> +	.soft_reset	= &genphy_soft_reset,
> +	.config_init	= &genphy_config_init,
> +	.config_aneg	= &genphy_config_aneg,
> +	.aneg_done	= &genphy_aneg_done,
> +	.read_status	= &genphy_read_status,
> +	.suspend	= &genphy_suspend,
> +	.resume		= &genphy_resume,

With the exception of config_init(), suspend and resume, everything else
is already the default when you don't provide a callback. To echo to
what Andrew wrote already, if the purpose is just to show a nice name,
and do nothing else, consider using the Generic PHY driver (default).
-- 
Florian
