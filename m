Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDEB21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YoXm9wrO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CDEB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeKUUP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 15:15:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54315 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbeKUUPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 15:15:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so4811531wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kk1UOSfXkLSJM4hUu8dq3YnajqZ70m3B9nolNZn6xeA=;
        b=YoXm9wrOL6as9mpxzKkYwf4CbtuBhTaZwLLcqxE0uZ+qz1+X3IKlDHTtUnlIB2VD5P
         HBbuz3rs9fealtlXgJDZqOj/1EIIsn8HctGpXqriCJwHZWc3lCRrkLLbEZD0IrqyvSAf
         8S64YBL7oZlNUbPo2A9ghxs9EW3Mwz3qy9yFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kk1UOSfXkLSJM4hUu8dq3YnajqZ70m3B9nolNZn6xeA=;
        b=drKmTWkQ7EdD3243GTm+HVr/wF0F9jFO0+nAfd8tQQo7+ky4iG4GkqpEP9DIMTck2a
         zqsNjEW4eVAXtjM77Zp5AtqIjL8icxnt7pOB1ylGzBbbUqNg43NogQ+qiZ8J+jjvQuXV
         ujTvfyPOCSR3NpRfRkS8gd1yg0urewxjqFtRKTFv3x7e6JYsuomB08nk2uQP6u1gQ+kA
         20GLxbds3MedSHmIkIwguMaZBPxaKk1dFPI2L84fCtYhDrDDHMBO2Isg++BkWFaiwLdj
         wjIAzXIN/6WSfMaH9ze6k+qLrfRaJadvXR8NznkOA/Tz1c0BKZynJzecGCQ9Cs5oMz/6
         yTLQ==
X-Gm-Message-State: AA+aEWbTEqiAZ2qJM7RRMMu5dWXcK4qh1ziLioLwMSwFBZwhwkH8fSfX
        KTdPLU7ciKBlIYm64JLgIePHcvJZxVQ=
X-Google-Smtp-Source: AJdET5esCoNUcX9S8mGi+uFlkRssd4bl81kVZil2MgDc4Mk+5OKtL4Auko+sAC6Umm7sNgCJ3PjQPg==
X-Received: by 2002:a1c:7e8e:: with SMTP id z136mr5489464wmc.140.1542793298523;
        Wed, 21 Nov 2018 01:41:38 -0800 (PST)
Received: from [192.168.0.40] (239.22.136.77.rev.sfr.net. [77.136.22.239])
        by smtp.googlemail.com with ESMTPSA id 184-v6sm387683wmh.36.2018.11.21.01.41.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:41:37 -0800 (PST)
Subject: Re: [PATCH v3] thermal: qoriq: add multiple sensors support
To:     Andy Tang <andy.tang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181030010008.27237-1-andy.tang@nxp.com>
 <VI1PR04MB4333200BCB4E2DABE1DC5B55F3C30@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <VI1PR04MB433384F335FBE426117B2188F3DA0@VI1PR04MB4333.eurprd04.prod.outlook.com>
 <16bf9114-8403-a11a-0a29-f78bc139b480@linaro.org>
 <VI1PR04MB433317D3D03FFD29D65755F9F3DA0@VI1PR04MB4333.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c061e602-efbe-7a83-144c-4a50924e724f@linaro.org>
Date:   Wed, 21 Nov 2018 10:41:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB433317D3D03FFD29D65755F9F3DA0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2018 10:16, Andy Tang wrote:
> Hi Daniel,
> 
> Thanks for your explanation. The problem is these two trees are not synced well.
> Let's take our driver(qoriq_thermal.c) for example.
> 
> Git log on Rui's tree next branch:
> 2dfef65 thermal: qoriq: Switch to SPDX identifier
> 1a893a5 thermal: qoriq: Simplify the 'site' variable assignment
> f1506a6 thermal: qoriq: Use devm_thermal_zone_of_sensor_register()
> c30d5d5 thermal: qoriq: constify thermal_zone_of_device_ops structures
> 0e77488 thermal: qoriq: remove useless call for of_thermal_get_trip_points()
> 4352844 thermal: qoriq: Add thermal management support
> 
> Git log on linux-soc-thermal tree branch next:
> 6017e2a thermal: qoriq: add i.mx8mq support
> 9b96566 thermal: Convert to using %pOFn instead of device_node.name
> c30d5d5 thermal: qoriq: constify thermal_zone_of_device_ops structures
> 0e77488 thermal: qoriq: remove useless call for of_thermal_get_trip_points()
> 4352844 thermal: qoriq: Add thermal management support
> 
> You can see that the first 2-3 commits on these two tress are different.
> 
> The strange thing is they seems sync well on Linus' tree:
> 0ef7791 Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal
> 6017e2a thermal: qoriq: add i.mx8mq support
> 9b96566 thermal: Convert to using %pOFn instead of device_node.name
> 2dfef65 thermal: qoriq: Switch to SPDX identifier
> 1a893a5 thermal: qoriq: Simplify the 'site' variable assignment
> f1506a6 thermal: qoriq: Use devm_thermal_zone_of_sensor_register()
> c30d5d5 thermal: qoriq: constify thermal_zone_of_device_ops structures
> 0e77488 thermal: qoriq: remove useless call for of_thermal_get_trip_points()
> 4352844 thermal: qoriq: Add thermal management support
> 
> Currently my patch was created based on Run's tree, probably I should rebase it to soc tree.
> But whichever tree I use, it can't be merged to Linus' tree without conflict.
> 
> Something I missed?

No.

Eduardo, Rui,

why not create a 'thermal' group ala 'tip' group with a single tree and
two branches:

thermal/next
thermal/fixes

 - Rui takes the core changes.
 - Eduardo takes the SoC changes.

 - Both commit to thermal/next
 - Both commit to thermal/fixes
 - Both merge thermal/fixes into thermal/core as often as possible.

That will help to have a more up to date branch, simplify the patch
submission path and reduce the latency for the merge windows.

If you need help, I can take care of applying the fixes only and merge
them to thermal/next.

That is how the tip subsystem works, Peter Ziljstra, Ingo Molnar, Thomas
Gleixner, have all permissions to commit in the tip tree but they take
care of their subsystems. If one is away for vacations or whatever,
someone else can take over during the absence.





>> -----Original Message-----
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: 2018年11月21日 16:44
>> To: Andy Tang <andy.tang@nxp.com>; rui.zhang@intel.com;
>> edubezval@gmail.com
>> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v3] thermal: qoriq: add multiple sensors support
>>
>> On 21/11/2018 02:34, Andy Tang wrote:
>>> Hi all,
>>>
>>> Do you have any comments on this patch?
>>>
>>> I found for our thermal driver(qoriq_thermal.c) there are different
>> between the following two git trees:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
>>> branch: next
>>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.gi
>> t.
>>> branch: next
>>>
>>> Could you please clarify which git tree/branch should I use?
>>
>> SoC changes are submitted against linux-soc-thermal.git.
>>
>> Generic thermal framework are sent against Zhang Rui's tree but it
>> happens sometimes Eduardo pick them also when the changes are related
>> to SoC behavior.
>>
>> However, I agree that can be confusing :)
>>
>> Eduardo, Rui,
>>
>> how about to add a section in the maintainer handbook for the thermal to
>> clarify the expectations and the flow?
>>
>>>> -----Original Message-----
>>>> From: Andy Tang
>>>> Sent: 2018年11月14日 15:29
>>>> To: rui.zhang@intel.com; daniel.lezcano@linaro.org
>>>> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org
>>>> Subject: RE: [PATCH v3] thermal: qoriq: add multiple sensors support
>>>>
>>>> PING.
>>>>
>>>> BR,
>>>> Andy
>>>>
>>>>> -----Original Message-----
>>>>> From: andy.tang@nxp.com <andy.tang@nxp.com>
>>>>> Sent: 2018年10月30日 9:00
>>>>> To: rui.zhang@intel.com; daniel.lezcano@linaro.org
>>>>> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org;
>>>>> linux-kernel@vger.kernel.org; Andy Tang <andy.tang@nxp.com>
>>>>> Subject: [PATCH v3] thermal: qoriq: add multiple sensors support
>>>>>
>>>>> From: Yuantian Tang <andy.tang@nxp.com>
>>>>>
>>>>> The QorIQ Layerscape SoC has several thermal sensors but the
>> current
>>>>> driver only supports one.
>>>>>
>>>>> Massage the code to be sensor oriented and allow the support for
>>>>> multiple sensors.
>>>>>
>>>>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>>>>> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> ---
>>>>> v3:
>>>>>   - add Reviewed-by
>>>>> v2:
>>>>>   - update the commit message
>>>>>   - refine the qoriq_tmu_register_tmu_zone()
>>>>>
>>>>>  drivers/thermal/qoriq_thermal.c |  100
>>>>> ++++++++++++++++++---------------------
>>>>>  1 files changed, 46 insertions(+), 54 deletions(-)
>>>>>
>>>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>>>> b/drivers/thermal/qoriq_thermal.c index 450ed66..8beb344 100644
>>>>> --- a/drivers/thermal/qoriq_thermal.c
>>>>> +++ b/drivers/thermal/qoriq_thermal.c
>>>>> @@ -59,14 +59,21 @@ struct qoriq_tmu_regs {
>>>>>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>>>>>  };
>>>>>
>>>>> +struct qoriq_tmu_data;
>>>>> +
>>>>>  /*
>>>>>   * Thermal zone data
>>>>>   */
>>>>> +struct qoriq_sensor {
>>>>> +	struct thermal_zone_device	*tzd;
>>>>> +	struct qoriq_tmu_data		*qdata;
>>>>> +	int				id;
>>>>> +};
>>>>> +
>>>>>  struct qoriq_tmu_data {
>>>>> -	struct thermal_zone_device *tz;
>>>>>  	struct qoriq_tmu_regs __iomem *regs;
>>>>> -	int sensor_id;
>>>>>  	bool little_endian;
>>>>> +	struct qoriq_sensor	*sensor[SITES_MAX];
>>>>>  };
>>>>>
>>>>>  static void tmu_write(struct qoriq_tmu_data *p, u32 val, void
>>>>> __iomem
>>>>> *addr) @@ -87,48 +94,51 @@ static u32 tmu_read(struct
>>>> qoriq_tmu_data
>>>>> *p, void __iomem *addr)
>>>>>
>>>>>  static int tmu_get_temp(void *p, int *temp)  {
>>>>> +	struct qoriq_sensor *qsensor = p;
>>>>> +	struct qoriq_tmu_data *qdata = qsensor->qdata;
>>>>>  	u32 val;
>>>>> -	struct qoriq_tmu_data *data = p;
>>>>>
>>>>> -	val = tmu_read(data, &data->regs->site[data->sensor_id].tritsr);
>>>>> +	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
>>>>>  	*temp = (val & 0xff) * 1000;
>>>>>
>>>>>  	return 0;
>>>>>  }
>>>>>
>>>>> -static int qoriq_tmu_get_sensor_id(void)
>>>>> +static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>>>>> +	.get_temp = tmu_get_temp,
>>>>> +};
>>>>> +
>>>>> +static int qoriq_tmu_register_tmu_zone(struct platform_device
>>>>> +*pdev)
>>>>>  {
>>>>> -	int ret, id;
>>>>> -	struct of_phandle_args sensor_specs;
>>>>> -	struct device_node *np, *sensor_np;
>>>>> +	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
>>>>> +	int id, sites = 0;
>>>>>
>>>>> -	np = of_find_node_by_name(NULL, "thermal-zones");
>>>>> -	if (!np)
>>>>> -		return -ENODEV;
>>>>> +	for (id = 0; id < SITES_MAX; id++) {
>>>>> +		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>>>>> +				sizeof(struct qoriq_sensor), GFP_KERNEL);
>>>>> +		if (!qdata->sensor[id])
>>>>> +			return -ENOMEM;
>>>>>
>>>>> -	sensor_np = of_get_next_child(np, NULL);
>>>>> -	ret = of_parse_phandle_with_args(sensor_np,
>> "thermal-sensors",
>>>>> -			"#thermal-sensor-cells",
>>>>> -			0, &sensor_specs);
>>>>> -	if (ret) {
>>>>> -		of_node_put(np);
>>>>> -		of_node_put(sensor_np);
>>>>> -		return ret;
>>>>> -	}
>>>>> +		qdata->sensor[id]->id = id;
>>>>> +		qdata->sensor[id]->qdata = qdata;
>>>>>
>>>>> -	if (sensor_specs.args_count >= 1) {
>>>>> -		id = sensor_specs.args[0];
>>>>> -		WARN(sensor_specs.args_count > 1,
>>>>> -				"%s: too many cells in sensor specifier %d\n",
>>>>> -				sensor_specs.np->name,
>> sensor_specs.args_count);
>>>>> -	} else {
>>>>> -		id = 0;
>>>>> -	}
>>>>> +		qdata->sensor[id]->tzd =
>>>>> devm_thermal_zone_of_sensor_register(
>>>>> +				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
>>>>> +		if (IS_ERR(qdata->sensor[id]->tzd)) {
>>>>> +			if (PTR_ERR(qdata->sensor[id]->tzd) == -ENODEV)
>>>>> +				continue;
>>>>> +			else
>>>>> +				return PTR_ERR(qdata->sensor[id]->tzd);
>>>>>
>>>>> -	of_node_put(np);
>>>>> -	of_node_put(sensor_np);
>>>>> +		}
>>>>> +
>>>>> +		sites |= 0x1 << (15 - id);
>>>>> +	}
>>>>> +	/* Enable monitoring */
>>>>> +	if (sites != 0)
>>>>> +		tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
>>>>> &qdata->regs->tmr);
>>>>>
>>>>> -	return id;
>>>>> +	return 0;
>>>>>  }
>>>>>
>>>>>  static int qoriq_tmu_calibration(struct platform_device *pdev) @@
>>>>> -178,16 +188,11 @@ static void qoriq_tmu_init_device(struct
>>>>> qoriq_tmu_data *data)
>>>>>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);  }
>>>>>
>>>>> -static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>>>>> -	.get_temp = tmu_get_temp,
>>>>> -};
>>>>> -
>>>>>  static int qoriq_tmu_probe(struct platform_device *pdev)  {
>>>>>  	int ret;
>>>>>  	struct qoriq_tmu_data *data;
>>>>>  	struct device_node *np = pdev->dev.of_node;
>>>>> -	u32 site;
>>>>>
>>>>>  	if (!np) {
>>>>>  		dev_err(&pdev->dev, "Device OF-Node is NULL"); @@
>> -203,13
>>>>> +208,6 @@ static int qoriq_tmu_probe(struct platform_device
>> *pdev)
>>>>>
>>>>>  	data->little_endian = of_property_read_bool(np, "little-endian");
>>>>>
>>>>> -	data->sensor_id = qoriq_tmu_get_sensor_id();
>>>>> -	if (data->sensor_id < 0) {
>>>>> -		dev_err(&pdev->dev, "Failed to get sensor id\n");
>>>>> -		ret = -ENODEV;
>>>>> -		goto err_iomap;
>>>>> -	}
>>>>> -
>>>>>  	data->regs = of_iomap(np, 0);
>>>>>  	if (!data->regs) {
>>>>>  		dev_err(&pdev->dev, "Failed to get memory region\n");
>> @@
>>>>> -223,19 +221,13 @@ static int qoriq_tmu_probe(struct
>> platform_device
>>>>> *pdev)
>>>>>  	if (ret < 0)
>>>>>  		goto err_tmu;
>>>>>
>>>>> -	data->tz = devm_thermal_zone_of_sensor_register(&pdev->dev,
>>>>> -							data->sensor_id,
>>>>> -							data, &tmu_tz_ops);
>>>>> -	if (IS_ERR(data->tz)) {
>>>>> -		ret = PTR_ERR(data->tz);
>>>>> -		dev_err(&pdev->dev,
>>>>> -			"Failed to register thermal zone device %d\n", ret);
>>>>> -		goto err_tmu;
>>>>> +	ret = qoriq_tmu_register_tmu_zone(pdev);
>>>>> +	if (ret < 0) {
>>>>> +		dev_err(&pdev->dev, "Failed to register sensors\n");
>>>>> +		ret = -ENODEV;
>>>>> +		goto err_iomap;
>>>>>  	}
>>>>>
>>>>> -	/* Enable monitoring */
>>>>> -	site = 0x1 << (15 - data->sensor_id);
>>>>> -	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
>>>>>
>>>>>  	return 0;
>>>>>
>>>>> --
>>>>> 1.7.1
>>>
>>
>>
>> --
>>
>> <https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2F
>> www.linaro.org%2F&amp;data=02%7C01%7Candy.tang%40nxp.com%7Ca0
>> d265f95a424d33256b08d64f8d74c8%7C686ea1d3bc2b4c6fa92cd99c5c
>> 301635%7C0%7C0%7C636783866299399290&amp;sdata=AVw3XdjmiRO
>> XP7Xz7MTNMVgzI8hYG9aWsR02opMZqjM%3D&amp;reserved=0>
>> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:
>> <https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2F
>> www.facebook.com%2Fpages%2FLinaro&amp;data=02%7C01%7Candy.tan
>> g%40nxp.com%7Ca0d265f95a424d33256b08d64f8d74c8%7C686ea1d3b
>> c2b4c6fa92cd99c5c301635%7C0%7C0%7C636783866299399290&amp;s
>> data=NM8wm4ri%2F2kdBW0FdCSXrL5ogg6owPfoRGacqm%2BKsEw%3D&a
>> mp;reserved=0> Facebook |
>> <https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Ft
>> witter.com%2F%23!%2Flinaroorg&amp;data=02%7C01%7Candy.tang%40n
>> xp.com%7Ca0d265f95a424d33256b08d64f8d74c8%7C686ea1d3bc2b4c6
>> fa92cd99c5c301635%7C0%7C0%7C636783866299399290&amp;sdata=
>> Wplqwpisgmqrf3yLhTzdo5O6TvN2Jfu5IjBTvS4xOWk%3D&amp;reserved=0>
>> Twitter |
>> <https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2F
>> www.linaro.org%2Flinaro-blog%2F&amp;data=02%7C01%7Candy.tang%40
>> nxp.com%7Ca0d265f95a424d33256b08d64f8d74c8%7C686ea1d3bc2b4c
>> 6fa92cd99c5c301635%7C0%7C0%7C636783866299399290&amp;sdata=I
>> b6KFIP3LNPGuDDb1dpnOllrqAAsc%2BZNCUuJZUPso6k%3D&amp;reserve
>> d=0> Blog
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

