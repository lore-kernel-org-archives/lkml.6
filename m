Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeCORjV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:39:21 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:18319 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbeCORjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:39:19 -0400
Subject: Re: [PATCH v2] net: ethernet: ti: cpsw: add check for in-band mode
 setting with RGMII PHY interface
To: =?UTF-8?B?U1ogTGluICjmnpfkuIrmmbop?= <sz.lin@moxa.com>
CC: Schuyler Patton <spatton@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-omap@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180315165603.30471-1-sz.lin@moxa.com>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <b866b57c-2e15-978b-e1e5-5b2c7aa0a06a@ti.com>
Date: Thu, 15 Mar 2018 12:39:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315165603.30471-1-sz.lin@moxa.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/15/2018 11:56 AM, SZ Lin (林上智) wrote:
> According to AM335x TRM[1] 14.3.6.2, AM437x TRM[2] 15.3.6.2 and
> DRA7 TRM[3] 24.11.4.8.7.3.3, in-band mode in EXT_EN(bit18) register is only
> available when PHY is configured in RGMII mode with 10Mbps speed. It will
> cause some networking issues without RGMII mode, such as carrier sense
> errors and low throughput. TI also mentioned this issue in their forum[4].
> 
> This patch adds the check mechanism for PHY interface with RGMII interface
> type, the in-band mode can only be set in RGMII mode with 10Mbps speed.
> 
> References:
> [1]: https://www.ti.com/lit/ug/spruh73p/spruh73p.pdf
> [2]: http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf
> [3]: http://www.ti.com/lit/ug/spruic2b/spruic2b.pdf
> [4]: https://e2e.ti.com/support/arm/sitara_arm/f/791/p/640765/2392155
> 
> Suggested-by: Holsety Chen (陳憲輝) <Holsety.Chen@moxa.com>
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> Signed-off-by: Schuyler Patton <spatton@ti.com>
> ---
> Changes from v1:
> - Use phy_interface_is_rgmii helper function
> - Remove blank line
> 

Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

>   drivers/net/ethernet/ti/cpsw.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 1b1b78fdc138..b2b30c9df037 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -1014,7 +1014,8 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
>   		/* set speed_in input in case RMII mode is used in 100Mbps */
>   		if (phy->speed == 100)
>   			mac_control |= BIT(15);
> -		else if (phy->speed == 10)
> +		/* in band mode only works in 10Mbps RGMII mode */
> +		else if ((phy->speed == 10) && phy_interface_is_rgmii(phy))
>   			mac_control |= BIT(18); /* In Band mode */
>   
>   		if (priv->rx_pause)
> 

-- 
regards,
-grygorii
