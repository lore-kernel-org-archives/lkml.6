Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BF3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDA42083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:07:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDA42083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937394AbeFSIHk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:07:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:59350 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937236AbeFSIHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:07:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0BE5F263BCE
Subject: Re: [PATCH] devfreq: rk3399_dmc: Fix duplicated opp table on reload.
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        cwchoi00@gmail.com
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20180615151217.29872-1-enric.balletbo@collabora.com>
 <CAGTfZH16O6u_3QJ2u1eecUnGptSBf1ho47RPefOTmrw+Syxr0w@mail.gmail.com>
 <CGME20180618091029epcas3p498708535c8f8df019bf3785a199d58b4@epcas3p4.samsung.com>
 <CAFqH_51ptafw-Z_8-FqtxbTH9LU560cHoM5TFiF01ZwG_jW3VQ@mail.gmail.com>
 <5B288430.2040600@samsung.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <65546a48-3291-9836-cb0c-1e65ff7c9d41@collabora.com>
Date:   Tue, 19 Jun 2018 10:07:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <5B288430.2040600@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

On 19/06/18 06:18, Chanwoo Choi wrote:
> Hi Enric,
> 
> On 2018년 06월 18일 18:10, Enric Balletbo Serra wrote:
>> Hi Chanwoo,
>>
>> Missatge de Chanwoo Choi <cwchoi00@gmail.com> del dia dg., 17 de juny
>> 2018 a les 5:23:
>>>
>>> Hi Enric,
>>>
>>> 2018-06-16 0:12 GMT+09:00 Enric Balletbo i Serra <enric.balletbo@collabora.com>:
>>>> The opp table is not removed when the driver is unloaded neither when
>>>> there is an error within probe, so if the driver is reloaded the opp
>>>> core shows the following warning:
>>>>
>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>                200000000, volt: 900000, enabled: 1. New: freq: 200000000,
>>>>                volt: 900000, enabled: 1
>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>                400000000, volt: 900000, enabled: 1. New: freq: 400000000,
>>>>                volt: 900000, enabled: 1
>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>                666000000, volt: 900000, enabled: 1. New: freq: 666000000,
>>>>                volt: 900000, enabled: 1
>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>                800000000, volt: 900000, enabled: 1. New: freq: 800000000,
>>>>                volt: 900000, enabled: 1
>>>>   rk3399-dmc-freq dmc: _opp_add: duplicate OPPs detected. Existing: freq:
>>>>                928000000, volt: 900000, enabled: 1. New: freq: 928000000,
>>>>                volt: 900000, enabled: 1
>>>>
>>>> This patch fixes the error path in the probe function and adds a .remove
>>>> function to properly cleanup the opp table on unloading.
>>>>
>>>> Fixes: 5a893e31a636c (PM / devfreq: rockchip: add devfreq driver for rk3399 dmc)
>>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>> ---
>>>>
>>>>  drivers/devfreq/rk3399_dmc.c | 31 +++++++++++++++++++++++++++----
>>>>  1 file changed, 27 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>>>> index d5c03e5abe13..e795ad2b3f6b 100644
>>>> --- a/drivers/devfreq/rk3399_dmc.c
>>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>>> @@ -375,8 +375,10 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>>         data->rate = clk_get_rate(data->dmc_clk);
>>>>
>>>>         opp = devfreq_recommended_opp(dev, &data->rate, 0);
>>>> -       if (IS_ERR(opp))
>>>> -               return PTR_ERR(opp);
>>>> +       if (IS_ERR(opp)) {
>>>> +               ret = PTR_ERR(opp);
>>>> +               goto err_free_opp;
>>>> +       }
>>>>
>>>>         data->rate = dev_pm_opp_get_freq(opp);
>>>>         data->volt = dev_pm_opp_get_voltage(opp);
>>>> @@ -388,13 +390,33 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
>>>>                                            &rk3399_devfreq_dmc_profile,
>>>>                                            DEVFREQ_GOV_SIMPLE_ONDEMAND,
>>>>                                            &data->ondemand_data);
>>>> -       if (IS_ERR(data->devfreq))
>>>> -               return PTR_ERR(data->devfreq);
>>>> +       if (IS_ERR(data->devfreq)) {
>>>> +               ret = PTR_ERR(data->devfreq);
>>>> +               goto err_free_opp;
>>>> +       }
>>>> +
>>>>         devm_devfreq_register_opp_notifier(dev, data->devfreq);
>>>>
>>>>         data->dev = dev;
>>>>         platform_set_drvdata(pdev, data);
>>>>
>>>> +       return 0;
>>>
>>> It looks strange. Because rk3399_dmcfreq_probe() already include
>>> 'return 0' when success.
>>> What is the base commit of this patch?
>>>
>>
>> Sorry, I am not sure I understand your question, If I am not answering
>> below could you rephrase?
> 
> When I check the rk3399_dmcfreq_probe()[1], as I commented,
> rk3399_dmcfreq_probe() already 'return 0' after platform_set_drvdata().
> You can check it on link[1].
> [1] https://elixir.bootlin.com/linux/v4.18-rc1/source/drivers/devfreq/rk3399_dmc.c#L443
> 
> But, this patch add new '+       return 0;' line again in rk3399_dmcfreq_probe().
> So, just I asked what is base commit of this patch.
> 

I think that this is just how git did the diff and if you only look at the diff
is a bit confusing, if you apply the patch on top of mainline you will see that
there is only one return 0 in the probe function.

+       return 0; (this new return ...)
+
+err_free_opp:
+       dev_pm_opp_of_remove_table(&pdev->dev);
+       return ret;
+}
+
+static int rk3399_dmcfreq_remove(struct platform_device *pdev)
+{
+       struct rk3399_dmcfreq *dmcfreq = dev_get_drvdata(&pdev->dev);
+
+       /*
+        * Before remove the opp table we need to unregister the opp notifier.
+        */
+       devm_devfreq_unregister_opp_notifier(dmcfreq->dev, dmcfreq->devfreq);
+       dev_pm_opp_of_remove_table(dmcfreq->dev);
+
        return 0; (was this before the patch, but now is in another function)

Cheers,
 Enric

>>
>> So, once the opp table is added we need an error path to free it if an
>> error occurs later. When the probe returns 0, we need to free the opp
>> table when we remove the module.
>>
>>> [snip]
>>>
>>> Anyway, if probe fail, device driver have to remove registered OPP table.
>>> Looks good to me.
>>>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>
>>
>> Thanks,
>>  Enric
>>
>>> --
>>> Best Regards,
>>> Chanwoo Choi
>>> Samsung Electronics
>>
>>
>>
> 
> 
