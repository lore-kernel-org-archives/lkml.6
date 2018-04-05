Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeDEQCq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:02:46 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:39019 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751195AbeDEQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:02:45 -0400
X-Google-Smtp-Source: AIpwx4/cz7dpElz9VmBGYKICuJZjOMjFJ+CU2ELRoJ7YmpY8aEGPH3zLQ5pTceHiDVnBs1jsB/N/0A==
Subject: Re: [PATCH 2/2] net: phy: dp83640: Read strapped configuration
 settings
To: esben.haabendal@gmail.com, Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "open list:PTP HARDWARE CLOCK SUPPORT" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc: Esben Haabendal <eha@deif.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
References: <20180405114424.8519-1-esben.haabendal@gmail.com>
 <20180405114424.8519-2-esben.haabendal@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <95678797-bd17-ba3f-8a70-a00b4792a258@gmail.com>
Date: Thu, 5 Apr 2018 09:02:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180405114424.8519-2-esben.haabendal@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2018 04:44 AM, esben.haabendal@gmail.com wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> Read configration settings, to allow automatic forced speed/duplex setup
> by hardware strapping.

OK but why? What problem is this solving for you? In general, we do not
really want to preserve too much of what the PHY has been previously
configured with, provided that the PHY driver can re-instate these
configuration values.

I just wonder how this can be robust when you connect this PHY with
auto-negotiation disabled to a peer that expects a set of link
parameters not covered by the default advertisement values? This really
looks like a recipe for disaster when you could just disable
auto-negotiation with ethtool.

> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> ---
>  drivers/net/phy/dp83640.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
> index 654f42d00092..01e21b4998ad 100644
> --- a/drivers/net/phy/dp83640.c
> +++ b/drivers/net/phy/dp83640.c
> @@ -1134,6 +1134,10 @@ static int dp83640_probe(struct phy_device *phydev)
>  	if (!dp83640)
>  		goto no_memory;
>  
> +	err = genphy_read_config(phydev);
> +	if (err)
> +		goto no_config;
> +
>  	dp83640->phydev = phydev;
>  	INIT_DELAYED_WORK(&dp83640->ts_work, rx_timestamp_work);
>  
> @@ -1166,6 +1170,7 @@ static int dp83640_probe(struct phy_device *phydev)
>  
>  no_register:
>  	clock->chosen = NULL;
> +no_config:
>  	kfree(dp83640);
>  no_memory:
>  	dp83640_clock_put(clock);
> 

-- 
Florian
