Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0F1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E44222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406047AbfBNHZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:25:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59398 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727324AbfBNHZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:25:10 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D525DEA63667857F8E4D;
        Thu, 14 Feb 2019 15:25:05 +0800 (CST)
Received: from [127.0.0.1] (10.65.91.35) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 14 Feb 2019
 15:24:53 +0800
Subject: Re: [PATCH net-next 1/2] net: phy: marvell: add new m88e1510 LED
 configuration
To:     Florian Fainelli <f.fainelli@gmail.com>, <andrew@lunn.ch>,
        <hkallweit1@gmail.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <1550118667-119947-1-git-send-email-shenjian15@huawei.com>
 <1550118667-119947-2-git-send-email-shenjian15@huawei.com>
 <da37103d-ad41-7e27-bd6e-3a402bbaf096@gmail.com>
From:   "shenjian (K)" <shenjian15@huawei.com>
Message-ID: <53ba940a-f940-0655-d747-baa2d5ed46a9@huawei.com>
Date:   Thu, 14 Feb 2019 15:24:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <da37103d-ad41-7e27-bd6e-3a402bbaf096@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.65.91.35]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2019/2/14 12:06, Florian Fainelli 写道:
> 
> 
> On 2/13/2019 8:31 PM, Jian Shen wrote:
>> The default m88e1510 LED configuration is 0x1177, used LED[0]
>> for 1000M link, LED[1] for 100M link, and LED[2] for active.
>> But for our boards, we want to use 0x1040, which use LED[0] for
>> link, and LED[1] for active.
>>
>> This patch adds a new m88e1510 LED configuration for it.
> 
> There appears to be a precedent with the DNS323 flag that was defined
> for the same purpose, but this unfortunately does not scale we cannot
> have every new platform come up with its own LED configuration without
> having a more structured approach to representing the LED configuration.
> 
> Maybe we can encode the desired LED behavior in a more generic way and
> utilize the 32 flag bits available to denote a selection, e.g.:
> 
> MARVELL_PHY_FLAG_LED0_100M	BIT(3)
> MARVELL_PHY_FLAG_LED0_1000M	BIT(4)
> 
> etc.
> 
> or maybe even better would be to expose the LEDs using the standard LEDs
> class subsystem and allow configuring different triggers. We have some
> amount of support for PHY LEDs already in tree, but AFAIR what we do not
> have support for is a "hardware blinking" trigger which those LEDs are.
> 
Thanks Florian.

I agree that we should use a generic way.
Maybe I understood incorrectly, for "utilize the 32 flag bits available to denote a selection",
do you mean to define a serial flags for each usage of each led ?
For each led can be configured to several usages, include link/10M link/100M link/1000M link/active/...,
it needs a lot bits for these combination, e.g:

#define MARVELL_PHY_FLAG_LED0_LINK		BIT(2)
#define MARVELL_PHY_FLAG_LED0_LINK_100M		BIT(3)
#define MARVELL_PHY_FLAG_LED0_LINK_1000M	BIT(4)
#define MARVELL_PHY_FLAG_LED0_ACTIVE		BIT(5)
#define MARVELL_PHY_FLAG_LED1_LINK		BIT(6)
#define MARVELL_PHY_FLAG_LED1_LINK_100M		BIT(7)
#define MARVELL_PHY_FLAG_LED1_LINK_1000M	BIT(8)
#define MARVELL_PHY_FLAG_LED1_ACTIVE		BIT(9)
...

Jian Shen
>>
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> ---
>>  drivers/net/phy/marvell.c   | 22 +++++++++++++++++++++-
>>  include/linux/marvell_phy.h |  1 +
>>  2 files changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
>> index 3ccba37..c195286 100644
>> --- a/drivers/net/phy/marvell.c
>> +++ b/drivers/net/phy/marvell.c
>> @@ -128,6 +128,10 @@
>>  #define MII_PHY_LED_CTRL	        16
>>  #define MII_88E1121_PHY_LED_DEF		0x0030
>>  #define MII_88E1510_PHY_LED_DEF		0x1177
>> +#define MII_88E1510_PHY_HNS3_LED_DEF	0x1040
>> +
>> +#define MII_88E1510_PHY_LED_POLARITY_CTRL	0x11
>> +#define MII_88E1510_PHY_HNS3_LED_POLARITY	0x4415
>>  
>>  #define MII_M1011_PHY_STATUS		0x11
>>  #define MII_M1011_PHY_STATUS_1000	0x8000
>> @@ -619,12 +623,19 @@ static void marvell_config_led(struct phy_device *phydev)
>>  		def_config = MII_88E1121_PHY_LED_DEF;
>>  		break;
>>  	/* Default PHY LED config:
>> +	 * For hns3:
>> +	 * LED[0] .. Link
>> +	 * LED[1] .. Activity
>> +	 * For others:
>>  	 * LED[0] .. 1000Mbps Link
>>  	 * LED[1] .. 100Mbps Link
>>  	 * LED[2] .. Blink, Activity
>>  	 */
>>  	case MARVELL_PHY_FAMILY_ID(MARVELL_PHY_ID_88E1510):
>> -		def_config = MII_88E1510_PHY_LED_DEF;
>> +		if (phydev->dev_flags & MARVELL_PHY_M1510_HNS3_LEDS)
>> +			def_config = MII_88E1510_PHY_HNS3_LED_DEF;
>> +		else
>> +			def_config = MII_88E1510_PHY_LED_DEF;
>>  		break;
>>  	default:
>>  		return;
>> @@ -634,6 +645,15 @@ static void marvell_config_led(struct phy_device *phydev)
>>  			      def_config);
>>  	if (err < 0)
>>  		phydev_warn(phydev, "Fail to config marvell phy LED.\n");
>> +
>> +	if (phydev->dev_flags & MARVELL_PHY_M1510_HNS3_LEDS) {
>> +		err = phy_write_paged(phydev, MII_MARVELL_LED_PAGE,
>> +				      MII_88E1510_PHY_LED_POLARITY_CTRL,
>> +				      MII_88E1510_PHY_HNS3_LED_POLARITY);
>> +		if (err < 0)
>> +			phydev_warn(phydev,
>> +				    "Fail to config marvell phy LED polarity.\n");
>> +	}
>>  }
>>  
>>  static int marvell_config_init(struct phy_device *phydev)
>> diff --git a/include/linux/marvell_phy.h b/include/linux/marvell_phy.h
>> index 1eb6f24..99e0bbb 100644
>> --- a/include/linux/marvell_phy.h
>> +++ b/include/linux/marvell_phy.h
>> @@ -32,5 +32,6 @@
>>  /* struct phy_device dev_flags definitions */
>>  #define MARVELL_PHY_M1145_FLAGS_RESISTANCE	0x00000001
>>  #define MARVELL_PHY_M1118_DNS323_LEDS		0x00000002
>> +#define MARVELL_PHY_M1510_HNS3_LEDS		0x00000004
>>  
>>  #endif /* _MARVELL_PHY_H */
>>
> 

