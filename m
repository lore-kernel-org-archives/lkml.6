Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3AFC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5C52085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YUvIBcuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B5C52085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbeJKQXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:23:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52823 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbeJKQXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:23:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so8146007wmw.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uV8y7pmtdnMv3FU3C7SMnZ7zAlGlB+ADcRtxp3UNEt4=;
        b=YUvIBcuAAU6ZxUrALu+rCPREMql+yhJgVRTiCDS2FS40Z1EDgmtVSJavMowJD3YR/H
         ktWfN2WcMV4vk40rCtCtAKAPhklZnZkFm5mVXzR1Eex1e9gkuMhr2HSkl8y6rAqdQSC/
         llMP3hxWLde4JvtpUpsDP9gqTq+d8MI+mGjgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uV8y7pmtdnMv3FU3C7SMnZ7zAlGlB+ADcRtxp3UNEt4=;
        b=L5SWytvsqh3ikzRQm059GqscJsPKmV1K+voO8ng0bUIwvTBLAI7CPA9ZEMJcKyow8E
         /OlMs2hJKjK5178UAuoJCKFQ+cMY9A9QTUaMkTpYnhNZWumnw3tGMgFa6r4aD43SeX0+
         ujTsDxWiUie0DZuHp2Z7zTtD9dmMjfiMUYiWc2PxiaepfEYyoU0m6PqL0jbz+k6DzV9X
         7i6LwEZm8wX03eBE4XMPCK8q/Piq8rJ4ZHgAKqritiuQeRAjg8Z/TZyhwivc7KUC1OsY
         0Ud/6jc3c860/h0GGtHM20M6awp5KuoVMiFjSxT/YubYPPODGSjdgXoEUeHaNzU2MZcE
         I1bw==
X-Gm-Message-State: ABuFfohcvIlLD/ncOqtArNphS/4NedpMGRbWGj1yurqo9Z1gzmjsC/cm
        OhNxNVB3QOopgHV8SaH0YXd8HaNOl98=
X-Google-Smtp-Source: ACcGV63GF8Ag6pbOMzZdR/ykJqwy4RvgOGs3nttUEHd2TRlX3Rn64OeeCiNngEJdU8s0nLsyoXqNOA==
X-Received: by 2002:a1c:19c2:: with SMTP id 185-v6mr977764wmz.4.1539248216595;
        Thu, 11 Oct 2018 01:56:56 -0700 (PDT)
Received: from [192.168.0.40] (138.168.88.92.rev.sfr.net. [92.88.168.138])
        by smtp.googlemail.com with ESMTPSA id v129-v6sm13115523wme.45.2018.10.11.01.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 01:56:55 -0700 (PDT)
Subject: Re: [PATCH] thermal: qoriq: add multiple sensors support
To:     Andy Tang <andy.tang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc:     "edubezval@gmail.com" <edubezval@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180927024204.17314-1-andy.tang@nxp.com>
 <VI1PR0401MB222469D81006CCD5CA3369C3F3E10@VI1PR0401MB2224.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d43575c0-d9c1-f17b-73b8-40b4303599b6@linaro.org>
Date:   Thu, 11 Oct 2018 10:56:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB222469D81006CCD5CA3369C3F3E10@VI1PR0401MB2224.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 10:07, Andy Tang wrote:
> Hi Rui,
> 
> Appreciate if you can give it a review.

Thanks for the heads up. I'll take care of that.

  -- Daniel


>> -----Original Message-----
>> From: andy.tang@nxp.com <andy.tang@nxp.com>
>> Sent: 2018Äê9ÔÂ27ÈÕ 10:42
>> To: rui.zhang@intel.com
>> Cc: edubezval@gmail.com; daniel.lezcano@linaro.org;
>> linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Andy Tang
>> <andy.tang@nxp.com>
>> Subject: [PATCH] thermal: qoriq: add multiple sensors support
>>
>> From: Yuantian Tang <andy.tang@nxp.com>
>>
>> There is only one sensor supported in current driver.
>> Multiple sensors are existing on Layscape socs. To support them, covert
>> this driver to support multiple sensors.
>>
>> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
>> ---
>>  drivers/thermal/qoriq_thermal.c |  117
>> +++++++++++++++++++++++----------------
>>  1 files changed, 70 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/thermal/qoriq_thermal.c
>> b/drivers/thermal/qoriq_thermal.c index c866cc1..7c1e88a 100644
>> --- a/drivers/thermal/qoriq_thermal.c
>> +++ b/drivers/thermal/qoriq_thermal.c
>> @@ -69,14 +69,21 @@ struct qoriq_tmu_regs {
>>  	u32 ttr3cr;		/* Temperature Range 3 Control Register */
>>  };
>>
>> +struct qoriq_tmu_data;
>> +
>>  /*
>>   * Thermal zone data
>>   */
>> +struct qoriq_sensor {
>> +	struct thermal_zone_device	*tzd;
>> +	struct qoriq_tmu_data		*qdata;
>> +	int				id;
>> +};
>> +
>>  struct qoriq_tmu_data {
>> -	struct thermal_zone_device *tz;
>>  	struct qoriq_tmu_regs __iomem *regs;
>> -	int sensor_id;
>>  	bool little_endian;
>> +	struct qoriq_sensor	*sensor[SITES_MAX];
>>  };
>>
>>  static void tmu_write(struct qoriq_tmu_data *p, u32 val, void __iomem
>> *addr) @@ -97,48 +104,83 @@ static u32 tmu_read(struct
>> qoriq_tmu_data *p, void __iomem *addr)
>>
>>  static int tmu_get_temp(void *p, int *temp)  {
>> +	struct qoriq_sensor *qsensor = p;
>> +	struct qoriq_tmu_data *qdata = qsensor->qdata;
>>  	u32 val;
>> -	struct qoriq_tmu_data *data = p;
>>
>> -	val = tmu_read(data, &data->regs->site[data->sensor_id].tritsr);
>> +	val = tmu_read(qdata, &qdata->regs->site[qsensor->id].tritsr);
>>  	*temp = (val & 0xff) * 1000;
>>
>>  	return 0;
>>  }
>>
>> -static int qoriq_tmu_get_sensor_id(void)
>> +static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>> +	.get_temp = tmu_get_temp,
>> +};
>> +
>> +static int qoriq_tmu_register_tmu_zone(struct platform_device *pdev)
>>  {
>> -	int ret, id;
>> +	struct qoriq_tmu_data *qdata = platform_get_drvdata(pdev);
>>  	struct of_phandle_args sensor_specs;
>>  	struct device_node *np, *sensor_np;
>> +	int ret, id, sites = 0;
>>
>>  	np = of_find_node_by_name(NULL, "thermal-zones");
>>  	if (!np)
>>  		return -ENODEV;
>>
>> -	sensor_np = of_get_next_child(np, NULL);
>> -	ret = of_parse_phandle_with_args(sensor_np, "thermal-sensors",
>> -			"#thermal-sensor-cells",
>> -			0, &sensor_specs);
>> -	if (ret) {
>> +	for_each_available_child_of_node(np, sensor_np) {
>> +		ret = of_parse_phandle_with_args(sensor_np,
>> "thermal-sensors",
>> +				"#thermal-sensor-cells",
>> +				0, &sensor_specs);
>> +		if (ret) {
>> +			of_node_put(np);
>> +			of_node_put(sensor_np);
>> +			return ret;
>> +		}
>> +
>> +		if (sensor_specs.args_count >= 1) {
>> +			id = sensor_specs.args[0];
>> +			WARN(sensor_specs.args_count > 1,
>> +					"%s: too many cells in sensor specifier %d\n",
>> +					sensor_specs.np->name,
>> +					sensor_specs.args_count);
>> +		} else {
>> +			id = 0;
>> +		}
>> +
>>  		of_node_put(np);
>>  		of_node_put(sensor_np);
>> -		return ret;
>> -	}
>>
>> -	if (sensor_specs.args_count >= 1) {
>> -		id = sensor_specs.args[0];
>> -		WARN(sensor_specs.args_count > 1,
>> -				"%s: too many cells in sensor specifier %d\n",
>> -				sensor_specs.np->name, sensor_specs.args_count);
>> -	} else {
>> -		id = 0;
>> +		if (id > SITES_MAX)
>> +			return -EINVAL;
>> +
>> +		qdata->sensor[id] = devm_kzalloc(&pdev->dev,
>> +				sizeof(struct qoriq_sensor), GFP_KERNEL);
>> +		if (!qdata->sensor[id])
>> +			return -ENOMEM;
>> +
>> +		qdata->sensor[id]->id = id;
>> +		qdata->sensor[id]->qdata = qdata;
>> +
>> +		qdata->sensor[id]->tzd =
>> devm_thermal_zone_of_sensor_register(
>> +				&pdev->dev, id, qdata->sensor[id], &tmu_tz_ops);
>> +
>> +		if (IS_ERR(qdata->sensor[id]->tzd)) {
>> +			ret = PTR_ERR(qdata->sensor[id]->tzd);
>> +			dev_err(&pdev->dev,
>> +				"Failed to register thermal zone device.\n");
>> +			return -ENODEV;
>> +		}
>> +
>> +		sites |= 0x1 << (15 - id);
>>  	}
>>
>> -	of_node_put(np);
>> -	of_node_put(sensor_np);
>> +	/* Enable monitoring */
>> +	if (sites != 0)
>> +		tmu_write(qdata, sites | TMR_ME | TMR_ALPF,
>> &qdata->regs->tmr);
>>
>> -	return id;
>> +	return 0;
>>  }
>>
>>  static int qoriq_tmu_calibration(struct platform_device *pdev) @@
>> -188,16 +230,11 @@ static void qoriq_tmu_init_device(struct
>> qoriq_tmu_data *data)
>>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);  }
>>
>> -static const struct thermal_zone_of_device_ops tmu_tz_ops = {
>> -	.get_temp = tmu_get_temp,
>> -};
>> -
>>  static int qoriq_tmu_probe(struct platform_device *pdev)  {
>>  	int ret;
>>  	struct qoriq_tmu_data *data;
>>  	struct device_node *np = pdev->dev.of_node;
>> -	u32 site = 0;
>>
>>  	if (!np) {
>>  		dev_err(&pdev->dev, "Device OF-Node is NULL"); @@ -213,13
>> +250,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>>
>>  	data->little_endian = of_property_read_bool(np, "little-endian");
>>
>> -	data->sensor_id = qoriq_tmu_get_sensor_id();
>> -	if (data->sensor_id < 0) {
>> -		dev_err(&pdev->dev, "Failed to get sensor id\n");
>> -		ret = -ENODEV;
>> -		goto err_iomap;
>> -	}
>> -
>>  	data->regs = of_iomap(np, 0);
>>  	if (!data->regs) {
>>  		dev_err(&pdev->dev, "Failed to get memory region\n"); @@
>> -233,18 +263,13 @@ static int qoriq_tmu_probe(struct platform_device
>> *pdev)
>>  	if (ret < 0)
>>  		goto err_tmu;
>>
>> -	data->tz = thermal_zone_of_sensor_register(&pdev->dev,
>> data->sensor_id,
>> -				data, &tmu_tz_ops);
>> -	if (IS_ERR(data->tz)) {
>> -		ret = PTR_ERR(data->tz);
>> -		dev_err(&pdev->dev,
>> -			"Failed to register thermal zone device %d\n", ret);
>> -		goto err_tmu;
>> +	ret = qoriq_tmu_register_tmu_zone(pdev);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "Failed to register sensors\n");
>> +		ret = -ENODEV;
>> +		goto err_iomap;
>>  	}
>>
>> -	/* Enable monitoring */
>> -	site |= 0x1 << (15 - data->sensor_id);
>> -	tmu_write(data, site | TMR_ME | TMR_ALPF, &data->regs->tmr);
>>
>>  	return 0;
>>
>> @@ -261,8 +286,6 @@ static int qoriq_tmu_remove(struct
>> platform_device *pdev)  {
>>  	struct qoriq_tmu_data *data = platform_get_drvdata(pdev);
>>
>> -	thermal_zone_of_sensor_unregister(&pdev->dev, data->tz);
>> -
>>  	/* Disable monitoring */
>>  	tmu_write(data, TMR_DISABLE, &data->regs->tmr);
>>
>> --
>> 1.7.1
> 


-- 
 <http://www.linaro.org/> Linaro.org ©¦ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

