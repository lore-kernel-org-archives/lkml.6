Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeDFPNl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:13:41 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43424 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeDFPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:13:39 -0400
Date: Fri, 06 Apr 2018 11:13:37 -0400 (EDT)
Message-Id: <20180406.111337.1908168293065420432.davem@davemloft.net>
To: andrew@lunn.ch
Cc: esben.haabendal@gmail.com, netdev@vger.kernel.org, eha@deif.com,
        richardcochran@gmail.com, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dp83640: Ensure against premature access to PHY
 registers after reset
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180406141410.GI17495@lunn.ch>
References: <20180406140540.13511-1-esben.haabendal@gmail.com>
        <20180406141410.GI17495@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 6 Apr 2018 16:14:10 +0200

> On Fri, Apr 06, 2018 at 04:05:40PM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>> 
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>> ---
>>  drivers/net/phy/dp83640.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>> 
>> diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
>> index 654f42d00092..48403170096a 100644
>> --- a/drivers/net/phy/dp83640.c
>> +++ b/drivers/net/phy/dp83640.c
>> @@ -1207,6 +1207,22 @@ static void dp83640_remove(struct phy_device *phydev)
>>  	kfree(dp83640);
>>  }
>>  
>> +static int dp83640_soft_reset(struct phy_device *phydev)
>> +{
>> +	int ret;
>> +
>> +	ret = genphy_soft_reset(phydev);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* From DP83640 datasheet: "Software driver code must wait 3 us
>> +	 * following a software reset before allowing further serial MII
>> +	 * operations with the DP83640." */
>> +	udelay(3);
> 
> Hi Esben
> 
> The accuracy of udelay() is not guaranteed. So you probably want to be
> a bit pessimistic, and use 10.

Agreed.
