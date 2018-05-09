Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934968AbeEINvM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:51:12 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:51385 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934630AbeEINvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:51:11 -0400
Subject: Re: [PATCH] net: phy: DP83TC811: Introduce support for the DP83TC811
 phy
To: Andrew Lunn <andrew@lunn.ch>
CC: <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180509120559.12725-1-dmurphy@ti.com>
 <20180509134315.GE14276@lunn.ch>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <382b9d52-7cfd-ae37-244a-32c7245cb27e@ti.com>
Date: Wed, 9 May 2018 08:50:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509134315.GE14276@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew

Thanks for the review

On 05/09/2018 08:43 AM, Andrew Lunn wrote:
>> +static int dp83811_config_aneg(struct phy_device *phydev)
>> +{
>> +	int err;
>> +	int value;
>> +
>> +	value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
>> +	if (phydev->autoneg == AUTONEG_ENABLE) {
>> +		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
>> +				(DP83811_SGMII_AUTO_NEG_EN | value));
>> +		if (err < 0)
>> +			return err;
>> +	} else {
>> +		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
>> +				(~DP83811_SGMII_AUTO_NEG_EN & value));
>> +		if (err < 0)
>> +			return err;
>> +	}
>> +
> 
> Hi Dan
> 
> You say SGMII is unreliable on one of these devices. Should you check
> phydev->interface before enabling SGMII autoneg?


If SGMII enable bit(12) is not set in the device then setting auto neg has no affect on the device.
Only the SGMII has auto negotiation capability so if we set this with other MII interfaces then it is ignored by the device.

If we want to protect this with the SGMII check I can add it but it may be over kill.

Let me know what is preferred.

> 
>> +	return genphy_config_aneg(phydev);
>> +}
>> +
>> +static int dp83811_config_init(struct phy_device *phydev)
>> +{
>> +	int err;
>> +	int value;
>> +
>> +	err = genphy_config_init(phydev);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
>> +		value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
>> +		if (!(value & DP83811_SGMII_EN)) {
>> +			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
>> +					(DP83811_SGMII_EN | value));
>> +			if (err < 0)
>> +				return err;
>> +		} else {
>> +			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
>> +				(~DP83811_SGMII_EN & value));
>> +			if (err < 0)
>> +				return err;
>> +		}
> 
> This looks to be a duplicate of dp83811_config_aneg()?

It is almost the same but this function sets bit 12 and aneg function sets bit 13.
We can have SGMII with or without auto neg.

> 
>> +	}
>> +
>> +	value = DP83811_WOL_MAGIC_EN | DP83811_WOL_SECURE_ON | DP83811_WOL_EN;
>> +
>> +	return phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG,
>> +	      value);
>> +}
>> +
>> +static int dp83811_phy_reset(struct phy_device *phydev)
>> +{
>> +	int err;
>> +
>> +	err = phy_write(phydev, MII_DP83811_RESET_CTRL, DP83811_HW_RESET);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	dp83811_config_init(phydev);
> 
> I don't think you need to initialize it here. phylib should call that
> soon after the reset.

OK I will remove it.  

> 
>> +
>> +	return 0;
>> +}
>> +
> 
>> +static struct phy_driver dp83811_driver[] = {
>> +	{
>> +		.phy_id = DP83TC811_PHY_ID,
>> +		.phy_id_mask = 0xfffffff0,
>> +		.name = "TI DP83TC811",
>> +		.features = PHY_BASIC_FEATURES,
>> +		.flags = PHY_HAS_INTERRUPT,
>> +		.config_init = genphy_config_init,
> 
> ????
> 

I missed that I must have had the config init being called in my testing through the reset function.
I will update.

> 	Andrew
> 


-- 
------------------
Dan Murphy
