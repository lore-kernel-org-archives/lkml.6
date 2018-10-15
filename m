Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A7DC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF70C20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYqrIE8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF70C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbeJOQkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:40:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41173 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeJOQkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:40:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id x12-v6so20291541wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 01:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NmgfQ/Fd1Mzo+/jV4BoHRwYDy4K2reUBTtY5aIJphu8=;
        b=bYqrIE8L35ACnsUtqhP10r0e0ps9Nt6ZnsMCeRUapfl2MbYhaLDOlBskUUMlA6ZS0/
         4gTpSQWvYf7LROZ8OforH4mLstXMI7+2OuUuzcQAUPfU5hHnkOT449UUwBMjEJLYH/jD
         osKnjSDZd6fOLPZVcaQAY9J1O4pY+GoDhgP7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NmgfQ/Fd1Mzo+/jV4BoHRwYDy4K2reUBTtY5aIJphu8=;
        b=Sda55vA2QLxzWZPLGcEUgLtKKuydb8LHbDixN2od42FN/o+3m0mUERpeZNYLj+h8o6
         Scr+bcVTIBw1hMMD5cJaUaEiv6IQgIMyVKudrG0yNyJKViSU7naUptfWRJ5MLUk/Z29l
         llsmGZYfy2/H/ZLtRVLFY09PQ4n06sKAeKFMCzQe3NfQ/X+12tjCbpWXBXDrveDB4zM1
         uZXcg2zDrHiPkzssFO63vJnDv4NPbktdbDze4CwGbh/wZttSDGLoXVDPU/Jn2i1CoA/Y
         FDuk1LhfNxolkzao/OC60tSB2xrdtIKlnnhAXzyF6ewpp+5jnoh26DgJVuiIU3mNAYoV
         TS6Q==
X-Gm-Message-State: ABuFfog1m2GP8pt2g+haCfkwiX4QQG/SxK6WjpTO3phBTxVkjbOaESPi
        Oi/Q1EzbY28Gq7fciewescVywcbJnOg=
X-Google-Smtp-Source: ACcGV633lPGlWEPGq/8Yk+r6i0B1J+cIO8ZZpgT46t6S2VXtSHUHbrhF7BiMSyBIsDV5pKCckdebmw==
X-Received: by 2002:a5d:4949:: with SMTP id r9-v6mr13013213wrs.114.1539593740237;
        Mon, 15 Oct 2018 01:55:40 -0700 (PDT)
Received: from [192.168.0.40] (85.238.136.77.rev.sfr.net. [77.136.238.85])
        by smtp.googlemail.com with ESMTPSA id 130-v6sm8966470wmn.7.2018.10.15.01.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 01:55:39 -0700 (PDT)
Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
To:     Andy Tang <andy.tang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180927024204.17314-1-andy.tang@nxp.com>
 <3d1f8304-9005-23f3-2e0e-ef9c962c9f6e@linaro.org>
 <DB5PR0401MB2213D4C1874291B87F231547F3FD0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cf157e9f-a4cb-6d7d-f51d-8b9d91f3335c@linaro.org>
Date:   Mon, 15 Oct 2018 10:55:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <DB5PR0401MB2213D4C1874291B87F231547F3FD0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2018 03:41, Andy Tang wrote:
> Thanks Daniel,
> 
> Please see my reply inline.
> 
>> -----Original Message-----
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: 2018年10月14日 4:43
>> To: Andy Tang <andy.tang@nxp.com>; rui.zhang@intel.com
>> Cc: edubezval@gmail.com; linux-pm@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
>>
>>
>> Hi Yuantian,
>>
>>
>> On 27/09/2018 04:42, andy.tang@nxp.com wrote:
>>> From: Yuantian Tang <andy.tang@nxp.com>
>>>
>>> There is only one sensor supported in current driver.
>>> Multiple sensors are existing on Layscape socs. To support them,
>>> covert this driver to support multiple sensors.
>>
>> s/covert/convert/
>>
>> What about the following changelog ?
>>
>> "
>> The QorIQ Layerscape SoC has several thermal sensors but the current
>> driver only supports one.
>>
>> Massage the code to be sensor oriented and allow the support for
>> multiple sensors.
>> "
> [Andy]  Thanks, will update
> 
>>
>>> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
>>> ---
>>>  drivers/thermal/qoriq_thermal.c |  117
>>> +++++++++++++++++++++++----------------
>>>  1 files changed, 70 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/drivers/thermal/qoriq_thermal.c
>>> b/drivers/thermal/qoriq_thermal.c index c866cc1..7c1e88a 100644
>>> --- a/drivers/thermal/qoriq_thermal.c
>>> +++ b/drivers/thermal/qoriq_thermal.c
>>> @@ -69,14 +69,21 @@ struct qoriq_tmu_regs {
>>>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>>>  };
>>>
>>> +struct qoriq_tmu_data;
>>> +
>>>  /*
>>>   * Thermal zone data
>>>   */
>>> +struct qoriq_sensor {
>>> +	struct thermal_zone_device	*tzd;
>>> +	struct qoriq_tmu_data		*qdata;
>>> +	int				id;
>>> +};
>>
>> Can you move the qoriq_tmu_site_regs structure content inside the
>> qoriq_sensor structure and kill the 'sites' field in the qoriq_tmu_regs
>> structure ? Otherwise we end up with a SITES_MAX array in the
>> qoriq_tmu_data structure and another one in the qoriq_tmu_regs
>> structure.
> [Andy] I am afraid I can't.
> qoriq_tmu_site_regs structure is to define the registers. After iomap, TMU can be accessed.
> qoriq_sensor structure is used for each sensor. It DONOT include the register defines.
> qoriq_tmu_data structure is used for global TMU date.
> So there is no any duplicated or redundant data here.

It is not about duplicate but just code reorg.

This patch changes the structure as:

struct qoriq_tmu_data {
-	struct thermal_zone_device *tz;
 	struct qoriq_tmu_regs __iomem *regs;
-	int sensor_id;
 	bool little_endian;
+	struct qoriq_sensor	*sensor[SITES_MAX];
 };


So we have:

struct qoriq_tmu_data
  => struct qoriq_sensor[SITES_MAX]
  => struct qoriq_tmu_regs
     => struct qoriq_tmu_site_regs[SITES_MAX]

I'm proposing to move struct qoriq_tmu_site_regs inside the struct
qoriq_sensor.


We end up with:

struct qoriq_sensor {
   struct thermal_zone_device *tzd;
   struct struct qoriq_tmu_site_regs *regs;
   struct qoriq_tmu_data *qdata;
   int id;
};


>>> -	if (sensor_specs.args_count >= 1) {
>>> -		id = sensor_specs.args[0];
>>> -		WARN(sensor_specs.args_count > 1,
>>> -				"%s: too many cells in sensor specifier %d\n",
>>> -				sensor_specs.np->name, sensor_specs.args_count);
>>> -	} else {
>>> -		id = 0;
>>> +		if (id > SITES_MAX)
>>> +			return -EINVAL;
>>> +
>>> +		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>>> +				sizeof(struct qoriq_sensor), GFP_KERNEL);
>>> +		if (!qdata->sensor[id])
>>> +			return -ENOMEM;
>>> +
>>> +		qdata->sensor[id]->id = id;
>>> +		qdata->sensor[id]->qdata = qdata;
>>> +
>>> +		qdata->sensor[id]->tzd =
>> devm_thermal_zone_of_sensor_register(
>>> +				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
>>> +
>>> +		if (IS_ERR(qdata->sensor[id]->tzd)) {
>>> +			ret = PTR_ERR(qdata->sensor[id]->tzd);
>>> +			dev_err(&pdev->dev,
>>> +				"Failed to register thermal zone device.\n");
>>> +			return -ENODEV;
>>> +		}
>>> +
>>> +		sites |= 0x1 << (15 - id);
>>
>> The current code is reading the DT in order to get the sensor id and
>> initialize it. IOW, the DT gives the sensors to use.
>>
>> IMO, it would be more self contained if the driver initializes all the sensors
>> without taking care of the DT and let the of- code to do the binding when
>> the thermal zone, no ?
> [Andy] could you please explain more about this way? I am not sure how to implement it.
> But one thing is for sure: we must get the sensor IDs explicitly so that we can enable them by
> the following command:  tmu_write(qdata, sites | TMR_ME | TMR_ALPF, &qdata->regs->tmr);

What I meant is about code separation between the driver itself and the
of-thermal code.

The code above re-inspect the DT to find out the sensor ids in order to
enable them and somehow this is not wrong but breaks the self
encapsulation of the driver. I was suggesting if it isn't possible to
enable all the sensors without taking care of digging into the DT.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

