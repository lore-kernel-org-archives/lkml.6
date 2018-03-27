Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751493AbeC0Tho (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 15:37:44 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:18518 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751088AbeC0Thg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 15:37:36 -0400
Subject: Re: [net-next PATCH v2 03/10] net: netcp: ethss: make call to
 gbe_sgmii_config() conditional
To: Andrew Lunn <andrew@lunn.ch>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
 <1522168309-12338-4-git-send-email-m-karicheri2@ti.com>
 <20180327171817.GO5862@lunn.ch>
From: Murali Karicheri <m-karicheri2@ti.com>
Organization: Texas Instruments
Message-ID: <1ef3864e-1cb7-ddf1-d03d-9c937736616f@ti.com>
Date: Tue, 27 Mar 2018 15:39:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180327171817.GO5862@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/2018 01:18 PM, Andrew Lunn wrote:
> On Tue, Mar 27, 2018 at 12:31:42PM -0400, Murali Karicheri wrote:
>> As a preparatory patch to add support for 2u cpsw hardware found on
>> K2G SoC, make call to gbe_sgmii_config() conditional. This is required
>> since 2u uses RGMII interface instead of SGMII and to allow for driver
>> re-use.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> ---
>>  drivers/net/ethernet/ti/netcp_ethss.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
>> index 56dbc0b..1dea891 100644
>> --- a/drivers/net/ethernet/ti/netcp_ethss.c
>> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
>> @@ -2271,7 +2271,8 @@ static int gbe_slave_open(struct gbe_intf *gbe_intf)
>>  
>>  	void (*hndlr)(struct net_device *) = gbe_adjust_link;
>>  
>> -	gbe_sgmii_config(priv, slave);
>> +	if ((priv->ss_version == GBE_SS_VERSION_14) || IS_SS_ID_NU(priv))
>> +		gbe_sgmii_config(priv, slave);
> 
> Or maybe:
> 
>    if (slave->phy_node == PHY_INTERFACE_MODE_SGMII)
>    	gbe_sgmii_config(priv, slave);

Yeah. Based on my response to your other comment, this would become

if ((slave->link_interface == SGMII_LINK_MAC_PHY) &&
    (IS_SS_ID_VER_14(priv) || IS_SS_ID_NU(priv)))
	gbe_sgmii_config(priv, slave);

We can't solely depends on phy_mode here. Phy interface is one of several
interface possible. There is MAC_TO_MAC_FORCED, NO_MDIO etc. So we check the
link_interface above.

If we can agree, here is what will appear in v3

1) Add another patch to do conversion of priv->ss_version == GBE_SS_VERSION_14 check 
with a macro, IS_SS_ID_VER_14
2) modify this patch as above.

Murali
> 
> 	Andrew
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
