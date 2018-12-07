Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4237AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC9A20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t8rfjSho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC9A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLGAWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:22:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48670 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbeLGAWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:22:55 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB70Mlfi067082;
        Thu, 6 Dec 2018 18:22:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544142167;
        bh=70e0W6vjNV96FkL9hKTnsbSvXKIJmctoaG1dNggYZOo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=t8rfjSho0zAI0RMtMpKs0ezTTXO83G0Qqtw1C0AsfdcfraRJtVrHwqbn9bmL6Ud1v
         cdIiAoW266dC+ik+tQ4Ueab924icOMbqujYTDNe6Iiqm097XjPf69tF2l6dlJt/3wS
         UET0i7vdUAE3l3d2bZf7w+lMY8gXqBqntXMUsOek=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB70MkVZ115462
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 Dec 2018 18:22:46 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 6
 Dec 2018 18:22:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 6 Dec 2018 18:22:46 -0600
Received: from [172.22.217.194] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB70MhaI013481;
        Thu, 6 Dec 2018 18:22:44 -0600
Subject: Re: [PATCH] mfd: tps65218: Use devm_regmap_add_irq_chip and clean up
 error path in probe
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     <tony@atomide.com>, <lee.jones@linaro.org>, <t-kristo@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1544117864-28276-1-git-send-email-j-keerthy@ti.com>
 <20181206205155.eucqfsq2xnk7kks5@earth.universe>
From:   "J, KEERTHY" <j-keerthy@ti.com>
Message-ID: <0b3949c5-1af0-6830-15db-01271a006615@ti.com>
Date:   Fri, 7 Dec 2018 05:52:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181206205155.eucqfsq2xnk7kks5@earth.universe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/7/2018 2:21 AM, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Dec 06, 2018 at 11:07:44PM +0530, Keerthy wrote:
>> Use devm_regmap_add_irq_chip and clean up error path in probe.
>>
>> Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> Boot tested on am437x-gp-evm.
> 
> This is missing cleanup of remove path?

Yes! Thanks for catching it. I will send v2 in a bit.

> 
> -- Sebastian
> 
>>   drivers/mfd/tps65218.c | 14 +++-----------
>>   1 file changed, 3 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
>> index 910f569..2383621 100644
>> --- a/drivers/mfd/tps65218.c
>> +++ b/drivers/mfd/tps65218.c
>> @@ -235,9 +235,9 @@ static int tps65218_probe(struct i2c_client *client,
>>   
>>   	mutex_init(&tps->tps_lock);
>>   
>> -	ret = regmap_add_irq_chip(tps->regmap, tps->irq,
>> -			IRQF_ONESHOT, 0, &tps65218_irq_chip,
>> -			&tps->irq_data);
>> +	ret = devm_regmap_add_irq_chip(&client->dev, tps->regmap, tps->irq,
>> +				       IRQF_ONESHOT, 0, &tps65218_irq_chip,
>> +				       &tps->irq_data);
>>   	if (ret < 0)
>>   		return ret;
>>   
>> @@ -253,14 +253,6 @@ static int tps65218_probe(struct i2c_client *client,
>>   			      ARRAY_SIZE(tps65218_cells), NULL, 0,
>>   			      regmap_irq_get_domain(tps->irq_data));
>>   
>> -	if (ret < 0)
>> -		goto err_irq;
>> -
>> -	return 0;
>> -
>> -err_irq:
>> -	regmap_del_irq_chip(tps->irq, tps->irq_data);
>> -
>>   	return ret;
>>   }
>>   
>> -- 
>> 1.9.1
>>
