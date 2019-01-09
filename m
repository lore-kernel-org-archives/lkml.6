Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AEEC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9D7206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfAINZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 08:25:29 -0500
Received: from olimex.com ([184.105.72.32]:57507 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbfAINZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 08:25:29 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2019 08:25:28 EST
Received: from 195.238.85.143 ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 05:15:24 -0800
Subject: Re: [PATCH 1/1] mfd: rk808: Prepare rk805 for poweroff
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1538465910-27233-1-git-send-email-stefan@olimex.com>
 <1917869.4NZ4yPfKWV@diego> <489e70a8-dbe7-e248-972e-c7de4e0f2c1a@gmail.com>
 <3397477.pQfoUNday9@diego>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <750489cb-09d7-5a6f-293d-23fbd6f60ca8@olimex.com>
Date:   Wed, 9 Jan 2019 15:15:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3397477.pQfoUNday9@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/19 3:11 PM, Heiko Stübner wrote:
> Am Mittwoch, 9. Januar 2019, 14:10:34 CET schrieb Stefan Mavrodiev:
>> On 1/9/19 3:07 PM, Heiko Stübner wrote:
>>> Hi Stefan, Lee,
>>>
>>> Am Dienstag, 2. Oktober 2018, 09:38:29 CET schrieb Stefan Mavrodiev:
>>>> RK805 has SLEEP signal, which can put the device into SLEEP or OFF
>>>> mode. The default is SLEEP mode.
>>>>
>>>> However, when the kernel performs power-off (actually the ATF) the
>>>> device will not go fully off and this will result in higher power
>>>> consumption and inability to wake the device with RTC alarm.
>>>>
>>>> The solution is to enable pm_power_off_prepare function, which will
>>>> configure SLEEP pin for OFF function.
>>>>
>>>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>>> just found this while cleaning my inbox and this change looks
>>> significant and it seems hasn't been applied yet.
>>>
>>> I guess this is still relevant, right?
>> Yes, but I guess it's out-of-sync with the latest kernel.
> you could rebase and resend it :-)

I would like to test it first. I'll resend the patch in couple of days
(I hope so).

PS: The previous email was from different mail address. Sorry about that.

Stefan Mavrodiev

>
>
>>>> ---
>>>>
>>>>    drivers/mfd/rk808.c | 24 ++++++++++++++++++++++++
>>>>    1 file changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
>>>> index 216fbf6..50f3f78 100644
>>>> --- a/drivers/mfd/rk808.c
>>>> +++ b/drivers/mfd/rk808.c
>>>> @@ -387,6 +387,25 @@ static void rk805_device_shutdown(void)
>>>>
>>>>    		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>>>>    
>>>>    }
>>>>
>>>> +static void rk805_device_shutdown_prepare(void)
>>>> +{
>>>> +	int ret;
>>>> +	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
>>>> +
>>>> +	if (!rk808) {
>>>> +		dev_warn(&rk808_i2c_client->dev,
>>>> +			 "have no rk805, so do nothing here\n");
>>>> +
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	ret = regmap_update_bits(rk808->regmap,
>>>> +				 RK805_GPIO_IO_POL_REG,
>>>> +				 SLP_SD_MSK, SHUTDOWN_FUN);
>>>> +	if (ret)
>>>> +		dev_err(&rk808_i2c_client->dev, "power off error!\n");
>>>> +}
>>>> +
>>>>
>>>>    static void rk808_device_shutdown(void)
>>>>    {
>>>>    
>>>>    	int ret;
>>>>
>>>> @@ -549,6 +568,10 @@ static int rk808_probe(struct i2c_client *client,
>>>>
>>>>    	if (pm_off && !pm_power_off) {
>>>>    	
>>>>    		rk808_i2c_client = client;
>>>>    		pm_power_off = pm_pwroff_fn;
>>>>
>>>> +	} else if (pm_off && !pm_power_off_prepare &&
>>>> +		   rk808->variant == RK805_ID) {
>>>> +		rk808_i2c_client = client;
>>>> +		pm_power_off_prepare = rk805_device_shutdown_prepare;
>>>>
>>>>    	}
>>>>    	
>>>>    	return 0;
>>>>
>>>> @@ -564,6 +587,7 @@ static int rk808_remove(struct i2c_client *client)
>>>>
>>>>    	regmap_del_irq_chip(client->irq, rk808->irq_data);
>>>>    	pm_power_off = NULL;
>>>>
>>>> +	pm_power_off_prepare = NULL;
>>>>
>>>>    	return 0;
>>>>    
>>>>    }
>
>
>
