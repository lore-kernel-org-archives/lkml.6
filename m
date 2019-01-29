Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC888C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC4B214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfA2Dae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:30:34 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbfA2Dae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:30:34 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A113CB4E9971875EEB70;
        Tue, 29 Jan 2019 11:30:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 29 Jan 2019
 11:30:28 +0800
Subject: Re: [PATCH net-next] mdio_bus: Fix PTR_ERR() usage after
 initialization to constant
To:     Andrew Lunn <andrew@lunn.ch>
References: <20190128132409.17736-1-yuehaibing@huawei.com>
 <20190128143634.GF4765@lunn.ch>
CC:     <davem@davemloft.net>, <f.fainelli@gmail.com>,
        <hkallweit1@gmail.com>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <eeb532d5-45a7-648f-f835-82448465762a@huawei.com>
Date:   Tue, 29 Jan 2019 11:30:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190128143634.GF4765@lunn.ch>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/1/28 22:36, Andrew Lunn wrote:
> On Mon, Jan 28, 2019 at 09:24:09PM +0800, YueHaibing wrote:
>> Fix coccinelle warning:
>>
>> ./drivers/net/phy/mdio_bus.c:51:5-12: ERROR: PTR_ERR applied after initialization to constant on line 44
>> ./drivers/net/phy/mdio_bus.c:52:5-12: ERROR: PTR_ERR applied after initialization to constant on line 44
>>
>> fix this by using IS_ERR before PTR_ERR
>>
>> Fixes: bafbdd527d56 ("phylib: Add device reset GPIO support")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/net/phy/mdio_bus.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
>> index 3d31358..802716a 100644
>> --- a/drivers/net/phy/mdio_bus.c
>> +++ b/drivers/net/phy/mdio_bus.c
>> @@ -42,17 +42,20 @@
>>  static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
>>  {
>>  	struct gpio_desc *gpiod = NULL;
>> +	int ret;
>>  
> 
> Hi YueHaibing
> 
> I think i prefer the simpler fix:
> 
>  static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
>  {
> -  	struct gpio_desc *gpiod = NULL;
> +       struct gpio_desc *gpiod = ERR_PTR(-ENOENT);
> 

But a56c69803f5a ("net: phy: Handle not having GPIO enabled in the kernel")
add a new check:

@@ -56,7 +56,8 @@ static int mdiobus_register_gpiod(struct mdio_device *mdiodev)
                gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
                                               "reset-gpios", 0, GPIOD_OUT_LOW,
                                               "PHY reset");
-       if (PTR_ERR(gpiod) == -ENOENT)
+       if (PTR_ERR(gpiod) == -ENOENT ||
+           PTR_ERR(gpiod) == -ENOSYS)
                gpiod = NULL;
        else if (IS_ERR(gpiod))
                return PTR_ERR(gpiod);


> Totally untested...
> 
> 	Andrew
> 
>>  	/* Deassert the optional reset signal */
>>  	if (mdiodev->dev.of_node)
>>  		gpiod = fwnode_get_named_gpiod(&mdiodev->dev.of_node->fwnode,
>>  					       "reset-gpios", 0, GPIOD_OUT_LOW,
>>  					       "PHY reset");
>> -	if (PTR_ERR(gpiod) == -ENOENT ||
>> -	    PTR_ERR(gpiod) == -ENOSYS)
>> -		gpiod = NULL;
>> -	else if (IS_ERR(gpiod))
>> -		return PTR_ERR(gpiod);
>> +	if (IS_ERR(gpiod)) {
>> +		ret = PTR_ERR(gpiod);
>> +		if (ret == -ENOENT || ret == -ENOSYS)
>> +			gpiod = NULL;
>> +		else
>> +			return ret;
>> +	}
>>  
>>  	mdiodev->reset = gpiod;
>>  
>> -- 
>> 2.7.4
>>
>>
> 
> .
> 

