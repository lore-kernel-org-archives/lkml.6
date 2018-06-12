Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0F28EC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CBF20693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 05:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wlmoIMn1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CBF20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754296AbeFLFvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 01:51:13 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:11943 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753380AbeFLFvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 01:51:10 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5C5p6fq007447;
        Tue, 12 Jun 2018 00:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528782666;
        bh=97ry/NnHHo+wcXZxPqB+v4fQYqK/X//JU+h70cmakb0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wlmoIMn1qJqB1DSMQ4hm40XvB3N76tNz/sYa9Ug8v34cysG9iWkkH7AsPLiK+xuYp
         3NEJRPe3Jw0y5IexOi/x4/27s5r0f8wzzLoaw/SRmD9UVBG7taoLZfRwLpthtN57/T
         40jMIWRLOE0saQrjWAPwQydr6Fp1uxbf+PA9NXQA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5C5p5T3031286;
        Tue, 12 Jun 2018 00:51:06 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 00:51:05 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 00:51:05 -0500
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5C5p2nO026889;
        Tue, 12 Jun 2018 00:51:03 -0500
Subject: Re: [PATCH v2 1/2] gpio: davinci: Shuffle IRQ resource fetching from
 DT to beginning of probe
To:     Alexander Stein <alexander.stein@systec-electronic.com>
CC:     <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>,
        <t-kristo@ti.com>
References: <1528781273-18098-1-git-send-email-j-keerthy@ti.com>
 <2368406.Am5sO8QqEf@ws-stein>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <ad92df49-fc9e-de25-6fd6-53b357ab17b9@ti.com>
Date:   Tue, 12 Jun 2018 11:21:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <2368406.Am5sO8QqEf@ws-stein>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 12 June 2018 11:15 AM, Alexander Stein wrote:
> On Tuesday, June 12, 2018, 7:27:52 AM CEST Keerthy wrote:
>> This is needed in case of PROBE_DEFER if IRQ resource is not yet ready.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>> [...]
>> --- a/drivers/gpio/gpio-davinci.c
>> +++ b/drivers/gpio/gpio-davinci.c
>> [...]
>> @@ -168,7 +168,7 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>>  {
>>  	static int ctrl_num, bank_base;
>>  	int gpio, bank, ret = 0;
>> -	unsigned ngpio, nbank;
>> +	unsigned ngpio, nbank, bank_irq;
> 
> bank_irq should be an int, not unsigned, no?

Yes

> 
>>  	struct davinci_gpio_controller *chips;
>>  	struct davinci_gpio_platform_data *pdata;
>>  	struct device *dev = &pdev->dev;
>> @@ -209,6 +209,12 @@ static int davinci_gpio_probe(struct platform_device *pdev)
>>  	if (IS_ERR(gpio_base))
>>  		return PTR_ERR(gpio_base);
>>  
>> +	bank_irq = platform_get_irq(pdev, 0);
>> +	if (bank_irq < 0) {
> 
> This won't work using an unsigned.

Thanks for catching this. I will correct this in v3.

> 
> Best regards,
> Alexander
> 
> 
> 
