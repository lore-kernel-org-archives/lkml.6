Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeC1IBN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:01:13 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:17338 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbeC1IBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:01:11 -0400
X-IronPort-AV: E=Sophos;i="5.48,370,1517900400";
   d="scan'208";a="10088959"
Subject: Re: [PATCH v3 2/2] net: macb: Try to retrieve MAC addess from nvmem
 provider
To: Mike Looijmans <mike.looijmans@topic.nl>, <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <andrew@lunn.ch>, <f.fainelli@gmail.com>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
References: <1522144346-32367-1-git-send-email-mike.looijmans@topic.nl>
 <1522144346-32367-3-git-send-email-mike.looijmans@topic.nl>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <d7187b2b-a6df-dfba-64ac-f1770c540159@microchip.com>
Date: Wed, 28 Mar 2018 10:00:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522144346-32367-3-git-send-email-mike.looijmans@topic.nl>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2018 at 11:52, Mike Looijmans wrote:
> Call of_get_nvmem_mac_address() to fetch the MAC address from an nvmem
> cell, if one is provided in the device tree. This allows the address to
> be stored in an I2C EEPROM device for example.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

For this part:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   drivers/net/ethernet/cadence/macb_main.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index e84afcf..eabe14f 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -3950,10 +3950,16 @@ static int macb_probe(struct platform_device *pdev)
>   		dev->max_mtu = ETH_DATA_LEN;
>   
>   	mac = of_get_mac_address(np);
> -	if (mac)
> +	if (mac) {
>   		ether_addr_copy(bp->dev->dev_addr, mac);
> -	else
> -		macb_get_hwaddr(bp);
> +	} else {
> +		err = of_get_nvmem_mac_address(np, bp->dev->dev_addr);
> +		if (err) {
> +			if (err == -EPROBE_DEFER)
> +				goto err_out_free_netdev;
> +			macb_get_hwaddr(bp);
> +		}
> +	}
>   
>   	err = of_get_phy_mode(np);
>   	if (err < 0) {
> 


-- 
Nicolas Ferre
