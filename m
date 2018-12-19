Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83726C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D7F21850
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 03:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Yt5E5gzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeLSDAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 22:00:18 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6556 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLSDAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 22:00:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c19b4390004>; Tue, 18 Dec 2018 19:00:10 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Dec 2018 19:00:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Dec 2018 19:00:15 -0800
Received: from [10.19.225.182] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 03:00:13 +0000
Subject: Re: [PATCH v6 3/4] thermal: tegra: parse sensor id before sensor
 register
To:     Eduardo Valentin <edubezval@gmail.com>
CC:     <rui.zhang@intel.com>, <thierry.reding@gmail.com>,
        <daniel.lezcano@linaro.org>, <linux-tegra@vger.kernel.org>,
        <srikars@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <1544780993-20744-1-git-send-email-wni@nvidia.com>
 <1544780993-20744-4-git-send-email-wni@nvidia.com>
 <20181219012450.GA2842@localhost.localdomain>
From:   Wei Ni <wni@nvidia.com>
Message-ID: <5c48701f-aafc-2db0-2191-41f169c8f33f@nvidia.com>
Date:   Wed, 19 Dec 2018 11:00:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181219012450.GA2842@localhost.localdomain>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545188410; bh=ZH4zDz7Voz/74rS/PqEvFfurz9qlCkM0HOyFVmkIWok=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Yt5E5gzOsJ9HUrK0B1mJPUCq/GXMWd8qJlyczAADMWxL7UbmncQG4hMEprD+Eas4G
         GfWNWwoyM4JaA23boGsBbFlEdPs82iAdQh/uRvmSdQWxN52cZNtZVQjgxBsKTIPPb1
         NfA74Yvw2Vj3IXhiU+CQ7JfHRvzKv/TdXPGrBIETFqXWIXVpP7//WNY+ZIW0XJCYIe
         1DyySgLSZ/JMFMJWs4mUvzyDIRgEQc7f4B+W6sstsU91S84v0R9Fi6OsV7H5wrks9m
         THaNFMhIGx2wMhP0mOhNkNucOTLui0N1AIYVFV16atXlgUR4jcvCHEkPUxaj+OfbfA
         m69QGbiREw2Cw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/2018 9:24 AM, Eduardo Valentin wrote:
> On Fri, Dec 14, 2018 at 05:49:52PM +0800, Wei Ni wrote:
>> Since different platforms may not support all 4
>> sensors, so the sensor registration may be failed.
>> Add codes to parse dt to find sensor id which
>> need to be registered. So that the registration
>> can be successful on all platform.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>> ---
>>  drivers/thermal/tegra/soctherm.c | 45 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
>> index fd2703c0cfc5..6bee31cd4621 100644
>> --- a/drivers/thermal/tegra/soctherm.c
>> +++ b/drivers/thermal/tegra/soctherm.c
>> @@ -1224,6 +1224,41 @@ static void soctherm_init(struct platform_device *pdev)
>>  	tegra_soctherm_throttle(&pdev->dev);
>>  }
>>  
>> +static bool tegra_soctherm_find_sensor_id(unsigned int sensor_id)
>> +{
>> +	bool ret = false;
>> +	struct of_phandle_args sensor_specs;
>> +	struct device_node *np, *sensor_np;
>> +
>> +	np = of_find_node_by_name(NULL, "thermal-zones");
>> +	if (!np)
>> +		return ret;
>> +
>> +	for_each_available_child_of_node(np, sensor_np) {
>> +		if (of_parse_phandle_with_args(sensor_np, "thermal-sensors",
>> +						 "#thermal-sensor-cells",
>> +						 0, &sensor_specs))
>> +			continue;
>> +
>> +		if (sensor_specs.args_count != 1) {
>> +			WARN(sensor_specs.args_count != 1,
>> +			     "%s: wrong cells in sensor specifier %d\n",
>> +			     sensor_specs.np->name, sensor_specs.args_count);
>> +			continue;
>> +		}
>> +
>> +		if (sensor_specs.args[0] == sensor_id) {
>> +			of_node_put(sensor_np);
>> +			ret = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	of_node_put(np);
>> +
>> +	return ret;
>> +}
> 
> So, I am still failing to see why this is really needed. 
> 
> Why can't you simply resolve this with different compatibles?
> If the sensor is not present or disabled, the compatible is not, well,
> compatible anymore.

This driver can support three Tegra chip t124, t132 and t210. And we
also support some platforms for every chips. As the description in the
commit, different platforms may not support all 4 sensors, so I
upstreamed this patch.
If we use different compatibles, I think we can't resolve it simply,
because we also need to add codes to configure which platform support
which sensors, and may add more in the future. If use this patch, we
doesn't need to do any more in the future.
Actually in my original change, I just ignore the registration failure
to fix this issue, it will not affect loading driver, but as Daniel's
comment, it's not better to ignore, so I followed his comment to refer
the QORIQ thermal driver to get the sensor id.

Thanks.
Wei.

> 
>> +
>>  static const struct of_device_id tegra_soctherm_of_match[] = {
>>  #ifdef CONFIG_ARCH_TEGRA_124_SOC
>>  	{
>> @@ -1365,13 +1400,16 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>>  		zone->sg = soc->ttgs[i];
>>  		zone->ts = tegra;
>>  
>> +		if (!tegra_soctherm_find_sensor_id(soc->ttgs[i]->id))
>> +			continue;
>> +
>>  		z = devm_thermal_zone_of_sensor_register(&pdev->dev,
>>  							 soc->ttgs[i]->id, zone,
>>  							 &tegra_of_thermal_ops);
>>  		if (IS_ERR(z)) {
>>  			err = PTR_ERR(z);
>> -			dev_err(&pdev->dev, "failed to register sensor: %d\n",
>> -				err);
>> +			dev_err(&pdev->dev, "failed to register sensor %s: %d\n",
>> +				soc->ttgs[i]->name, err);
>>  			goto disable_clocks;
>>  		}
>>  
>> @@ -1434,6 +1472,9 @@ static int __maybe_unused soctherm_resume(struct device *dev)
>>  		struct thermal_zone_device *tz;
>>  
>>  		tz = tegra->thermctl_tzs[soc->ttgs[i]->id];
>> +		if (!tz)
>> +			continue;
>> +
>>  		err = tegra_soctherm_set_hwtrips(dev, soc->ttgs[i], tz);
>>  		if (err) {
>>  			dev_err(&pdev->dev,
>> -- 
>> 2.7.4
>>
