Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756409AbeEIOAQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:00:16 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:17679 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756430AbeEIOAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:00:14 -0400
Subject: Re: [PATCH] net: phy: DP83TC811: Introduce support for the DP83TC811
 phy
To: Andrew Lunn <andrew@lunn.ch>
CC: <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180509120559.12725-1-dmurphy@ti.com>
 <20180509134315.GE14276@lunn.ch>
 <382b9d52-7cfd-ae37-244a-32c7245cb27e@ti.com>
 <20180509135826.GG14276@lunn.ch>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <4542e548-90fc-a8fa-f6b9-3bf3bd32a6e9@ti.com>
Date: Wed, 9 May 2018 09:00:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509135826.GG14276@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew

On 05/09/2018 08:58 AM, Andrew Lunn wrote:
> On Wed, May 09, 2018 at 08:50:58AM -0500, Dan Murphy wrote:
>> Andrew
>>
>> Thanks for the review
>>
>> On 05/09/2018 08:43 AM, Andrew Lunn wrote:
>>>> +static int dp83811_config_aneg(struct phy_device *phydev)
>>>> +{
>>>> +	int err;
>>>> +	int value;
>>>> +
>>>> +	value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
>>>> +	if (phydev->autoneg == AUTONEG_ENABLE) {
>>>> +		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
>>>> +				(DP83811_SGMII_AUTO_NEG_EN | value));
>>>> +		if (err < 0)
>>>> +			return err;
>>>> +	} else {
>>>> +		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
>>>> +				(~DP83811_SGMII_AUTO_NEG_EN & value));
>>>> +		if (err < 0)
>>>> +			return err;
>>>> +	}
>>>> +
>>>
>>> Hi Dan
>>>
>>> You say SGMII is unreliable on one of these devices. Should you check
>>> phydev->interface before enabling SGMII autoneg?
>>
>>
>> If SGMII enable bit(12) is not set in the device then setting auto neg has no affect on the device.
> 
> Ah, O.K. Maybe add a comment about this.
> 

I will add the check it will be clearer if written in code and explicit as opposed to explaining it.

Dan

>>>> +
>>>> +static int dp83811_config_init(struct phy_device *phydev)
>>>> +{
>>>> +	int err;
>>>> +	int value;
>>>> +
>>>> +	err = genphy_config_init(phydev);
>>>> +	if (err < 0)
>>>> +		return err;
>>>> +
>>>> +	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
>>>> +		value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
>>>> +		if (!(value & DP83811_SGMII_EN)) {
>>>> +			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
>>>> +					(DP83811_SGMII_EN | value));
>>>> +			if (err < 0)
>>>> +				return err;
>>>> +		} else {
>>>> +			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
>>>> +				(~DP83811_SGMII_EN & value));
>>>> +			if (err < 0)
>>>> +				return err;
>>>> +		}
>>>
>>> This looks to be a duplicate of dp83811_config_aneg()?
>>
>> It is almost the same but this function sets bit 12 and aneg function sets bit 13.
>> We can have SGMII with or without auto neg.
> 
> Yep, i missed the difference.
> 
>      Andrew
> 


-- 
------------------
Dan Murphy
