Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCPUwR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:52:17 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:60119 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbeCPUwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:52:15 -0400
X-ME-Helo: [192.168.1.12]
X-ME-Date: Fri, 16 Mar 2018 21:52:12 +0100
X-ME-IP: 86.244.119.222
Subject: Re: [PATCH] net: ethernet: arc: Fix a potential memory leak if an
 optional regulator is deferred
To: David Miller <davem@davemloft.net>
Cc: heiko@sntech.de, branislav@radocaj.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel,gmane.linux.network,gmane.linux.ports.arm.kernel,gmane.linux.ports.arm.rockchip,gmane.linux.kernel.janitors
References: <7fd57a4e7f7a41dccf55430cbc43de3b0a7f7826.1521061530.git.christophe.jaillet@wanadoo.fr>
 <20180316.152712.1584177628223195375.davem@davemloft.net>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <4593afd4-8578-d724-4eae-dcaaa609120c@wanadoo.fr>
Date: Fri, 16 Mar 2018 21:52:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316.152712.1584177628223195375.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/03/2018 à 20:27, David Miller a écrit :
> From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Date: Wed, 14 Mar 2018 22:09:34 +0100
>
>> diff --git a/drivers/net/ethernet/arc/emac_rockchip.c b/drivers/net/ethernet/arc/emac_rockchip.c
>> index 16f9bee992fe..8ee9dfd0e363 100644
>> --- a/drivers/net/ethernet/arc/emac_rockchip.c
>> +++ b/drivers/net/ethernet/arc/emac_rockchip.c
>> @@ -169,8 +169,10 @@ static int emac_rockchip_probe(struct platform_device *pdev)
>>   	/* Optional regulator for PHY */
>>   	priv->regulator = devm_regulator_get_optional(dev, "phy");
>>   	if (IS_ERR(priv->regulator)) {
>> -		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER)
>> -			return -EPROBE_DEFER;
>> +		if (PTR_ERR(priv->regulator) == -EPROBE_DEFER) {
>> +			ret = -EPROBE_DEFER;
>> +			goto out_clk_disable;
>> +		}
> Please build test your changes.
>
> There is no 'ret' variable in this function, perhaps you meant 'err'.
>
Yes, obviously, this is 'err'.

I apologize. I usually build-test all my patches before submission.
This one seems to have gone out of my normal process.

Can you fix it yourself or do you want me to re-submit?

CJ
