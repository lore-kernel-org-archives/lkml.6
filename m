Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbeCFPk4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 10:40:56 -0500
Received: from foss.arm.com ([217.140.101.70]:40350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753859AbeCFPko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 10:40:44 -0500
Subject: Re: [PATCH] net: smsc911x: Fix unload crash when link is up
To: Andrew Lunn <andrew@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "steve.glendinning@shawell.net" <steve.glendinning@shawell.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180306150006.31512-1-jeremy.linton@arm.com>
 <20180306152345.GD30557@lunn.ch>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <166f6d54-4079-50a1-144d-b68afba5a7a6@arm.com>
Date: Tue, 6 Mar 2018 09:40:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180306152345.GD30557@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/06/2018 09:23 AM, Andrew Lunn wrote:
>> This is caused by the mdiobus being unregistered/free'd
>> and the code in phy_detach() attempting to manipulate mdio
>> related structures from unregister_netdev() calling close()
>>
>> To fix this, we delay the mdiobus teardown until after
>> the netdev is deregistered.
>>
>> Reported-by: Matt Sealey <matt.sealey@arm.com>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/net/ethernet/smsc/smsc911x.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
>> index 012fb66eed8d..f0afb88d7bc2 100644
>> --- a/drivers/net/ethernet/smsc/smsc911x.c
>> +++ b/drivers/net/ethernet/smsc/smsc911x.c
>> @@ -2335,14 +2335,14 @@ static int smsc911x_drv_remove(struct platform_device *pdev)
>>   	pdata = netdev_priv(dev);
>>   	BUG_ON(!pdata);
>>   	BUG_ON(!pdata->ioaddr);
>> -	WARN_ON(dev->phydev);
> 
> Hi Jeremy
> 
> I assume this WARN_ON() also fired? It would be good to comment about
> why you removed it, that the code now handles that case.

Yes, the phydev is started and assigned in the netdev _open and 
stopped/set to null in the _stop. Since the module remove is not blocked 
by having the netdev active, and unregister_netdev closes out active 
connections, the WARN_ON would needlessly trigger if the netdev was 
still open.

> 
> Apart from that
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks for looking at this.
