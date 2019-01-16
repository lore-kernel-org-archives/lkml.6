Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA0DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0156C20652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfAPVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:44:04 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:64320 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730413AbfAPVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:44:04 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 544BFA1197;
        Wed, 16 Jan 2019 22:44:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id b6WWOh3NJk6u; Wed, 16 Jan 2019 22:44:00 +0100 (CET)
Subject: Re: [PATCH 1/3] net: dsa: lantiq_gswip: fix use-after-free on failed
 probe
To:     Andrew Lunn <andrew@lunn.ch>, Johan Hovold <johan@kernel.org>
Cc:     Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
References: <20190116102335.30433-1-johan@kernel.org>
 <20190116102335.30433-2-johan@kernel.org> <20190116150009.GE25731@lunn.ch>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <1e158c63-c578-1eb3-916e-d6d5a477270e@hauke-m.de>
Date:   Wed, 16 Jan 2019 22:43:58 +0100
MIME-Version: 1.0
In-Reply-To: <20190116150009.GE25731@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/19 4:00 PM, Andrew Lunn wrote:
> On Wed, Jan 16, 2019 at 11:23:33AM +0100, Johan Hovold wrote:
>> Make sure to disable and deregister the switch on late probe errors to
>> avoid use-after-free when the device-resource-managed switch is freed.
>>
>> Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
>> Cc: stable <stable@vger.kernel.org>	# 4.20
>> Cc: Hauke Mehrtens <hauke@hauke-m.de>
>> Signed-off-by: Johan Hovold <johan@kernel.org>
>> ---
>>  drivers/net/dsa/lantiq_gswip.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
>> index 693a67f45bef..b06c41c98de9 100644
>> --- a/drivers/net/dsa/lantiq_gswip.c
>> +++ b/drivers/net/dsa/lantiq_gswip.c
>> @@ -1099,7 +1099,7 @@ static int gswip_probe(struct platform_device *pdev)
>>  		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
>>  			priv->hw_info->cpu_port);
>>  		err = -EINVAL;
>> -		goto mdio_bus;
>> +		goto disable_switch;
>>  	}
>>  
>>  	platform_set_drvdata(pdev, priv);
>> @@ -1109,6 +1109,9 @@ static int gswip_probe(struct platform_device *pdev)
>>  		 (version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
>>  	return 0;
>>  
>> +disable_switch:
>> +	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
>> +	dsa_unregister_switch(priv->ds);
> 
> This is correct. But it would be nice if somebody in the future could
> move the disabling of the switch to the inverse of the gswip_setup()
> function to make the code symmetrical.

Should we add an uninit callback?

Hauke
