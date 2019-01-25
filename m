Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ECFC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9218120870
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lVIfnXMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfAYLgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:36:05 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6855 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAYLgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:36:05 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4af4800000>; Fri, 25 Jan 2019 03:35:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 03:36:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 03:36:04 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 11:36:02 +0000
Subject: Re: [PATCH] ALSA: hda/tegra: enable clock during probe
To:     Takashi Iwai <tiwai@suse.de>, Sameer Pujar <spujar@nvidia.com>
CC:     <pierre-louis.bossart@linux.intel.com>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <thierry.reding@gmail.com>,
        <rlokhande@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1548351403-1875-1-git-send-email-spujar@nvidia.com>
 <s5h5zudc1qw.wl-tiwai@suse.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <06c00ce1-32ed-8aa9-0340-d00202a8fa62@nvidia.com>
Date:   Fri, 25 Jan 2019 11:36:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5h5zudc1qw.wl-tiwai@suse.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548416128; bh=AK/2Ab17Z+3DPwVcPaHl4ZOWhA6T4/CaNjWKT8C3ICg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lVIfnXMwfgTotqT/x6XeuAog1i7j+cg3yYvaWQlnK7zAYaZGIbp0w9doQztesgKQj
         TTh1imUKoybuEKo5i0bsUQsIF6N2X4JH0GsLR7lK8zCcueB2jtJ4+fcH/xqj5QdzO3
         4ein37xwOGlKL1FlffqWc0CZ28cz/JW6Gw8fl/x9p5ynu9qoMteg69SZdJd17FCA2J
         KONnRkuQVDYMXwwx9tqB7aL1F15X0ncewKLTea3l9sH/3AYBsBU6qMN6hMfHulaL2j
         qdcuE+99IdPs2HaQx4oPE60KG+Au3rLSMaCsb/vfhs8Mvu8cTc59S13PY5dzYQDsW9
         EWNvSA8dL04mw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/01/2019 19:08, Takashi Iwai wrote:
> On Thu, 24 Jan 2019 18:36:43 +0100,
> Sameer Pujar wrote:
>>
>> If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
>> will not be ON. This could cause issue during probe, where hda init
>> setup is done. This patch checks whether runtime PM is enabled or not.
>> If disabled, clocks are enabled in probe() and disabled in remove()
>>
>> This patch does following minor changes as cleanup,
>>   * return code check for pm_runtime_get_sync() to take care of failure
>>     and exit gracefully.
>>   * In remove path runtime PM is disabled before calling snd_card_free().
>>   * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
>>   * runtime PM callbacks moved out of CONFIG_PM check
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> (snip)
>> @@ -555,6 +553,13 @@ static int hda_tegra_probe(struct platform_device *pdev)
>>  	if (!azx_has_pm_runtime(chip))
>>  		pm_runtime_forbid(hda->dev);
>>  
>> +	/* explicit resume if runtime PM is disabled */
>> +	if (!pm_runtime_enabled(hda->dev)) {
>> +		err = hda_tegra_runtime_resume(hda->dev);
>> +		if (err)
>> +			goto out_free;
>> +	}
>> +
>>  	schedule_work(&hda->probe_work);
> 
> Calling runtime_resume here is really confusing...

Why? IMO it is better to have a single handler for resuming the device
and so if RPM is not enabled we call the handler directly. This is what
we have been advised to do in the past and do in other drivers. See ...

sound/soc/tegra/tegra30_i2s.c

> 
>> @@ -571,7 +576,14 @@ static void hda_tegra_probe_work(struct work_struct *work)
>>  	struct platform_device *pdev = to_platform_device(hda->dev);
>>  	int err;
>>  
>> -	pm_runtime_get_sync(hda->dev);
>> +	err = pm_runtime_get_sync(hda->dev);
>> +	if (err < 0) {
>> +		dev_err(hda->dev,
>> +			"failed in pm_runtime_get_syc with err = %d\n",
>> +			err);
>> +		return;
>> +	}
> 
> This pm_runtime_get_sync() is needed just because you enabled runtime
> PM before probe_work.  Why not deferring the runtime PM enablement
> after probing done?

That would be fine with me.

> That is what we need is the hda_tegra_enable_clocks() call at probe
> unconditionally before enabling runtime PM.

I think that calling hda_tegra_runtime_resume as above is sufficient.
The nice thing about calling the runtime_resume function is that if for
a future device there is something else in addition to clocks, say a
reset, that also needs to be handled, we just added to the
runtime_resume/suspend handlers and we are done.

Cheers
Jon

-- 
nvpublic
