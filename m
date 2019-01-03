Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355C4C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FAF2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 05:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vl1yAWbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfACF6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 00:58:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56064 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfACF6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 00:58:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x035w7ha082098;
        Wed, 2 Jan 2019 23:58:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546495087;
        bh=DMonJPesLzTK7RUt4Qi+i2C+wUMW/qQYLxtoFWs33YM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Vl1yAWboyQwbg2n2xGWrdIprmd2aSBUIAsd/57jtTIriXj9B7IvEfX0t09OnyrPOz
         gUzsCa8Z/qbR0IKmMHvuTFaVjlRSwTA3nfmkN6OCk4dg53tRvb79iYce8M0MzqzpCi
         W0O7+6EutitsE3yrocG7s6HdsVGvChmjHfQT9bAY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x035w7fV043709
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jan 2019 23:58:07 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 2
 Jan 2019 23:58:06 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 2 Jan 2019 23:58:07 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x035w2CA016760;
        Wed, 2 Jan 2019 23:58:03 -0600
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Workaround errata regarding
 SDR104/HS200 tuning failures (i929)
To:     Eduardo Valentin <edubezval@gmail.com>,
        Olof Johansson <olof@lixom.net>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kishon <kishon@ti.com>, Keerthy <j-keerthy@ti.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>
References: <20181211142253.23747-1-faiz_abbas@ti.com>
 <20181211142253.23747-3-faiz_abbas@ti.com>
 <CAPDyKFoi+NzS-d8E8oz-h_ab70jY7owwqPXsEoJWnRg6J2zcNA@mail.gmail.com>
 <CAOesGMjXcpY1c0Bpf2tMACVVXNW1W-Gp3HO+yjK8f6dQ-cp5bQ@mail.gmail.com>
 <20190102195626.GA2024@localhost.localdomain>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <1d83e4df-78dc-10f6-f0c0-60e84b0e1094@ti.com>
Date:   Thu, 3 Jan 2019 11:31:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190102195626.GA2024@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof, Eduardo,

On 03/01/19 1:26 AM, Eduardo Valentin wrote:
> On Wed, Jan 02, 2019 at 10:29:31AM -0800, Olof Johansson wrote:
>> Hi,
>>
>>
>> On Wed, Dec 12, 2018 at 1:20 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> + Thermal maintainers
>>>
>>> On Tue, 11 Dec 2018 at 15:20, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>>
>>>> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
>>>> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
>>>> unexpected tuning pattern errors. A small failure band may be present
>>>> in the tuning range which may be missed by the current algorithm.
>>>> Furthermore, the failure bands vary with temperature leading to
>>>> different optimum tuning values for different temperatures.
>>>>
>>>> As suggested in the related Application Report (SPRACA9B - October 2017
>>>> - Revised July 2018 [2]), tuning should be done in two stages.
>>>> In stage 1, assign the optimum ratio in the maximum pass window for the
>>>> current temperature. In stage 2, if the chosen value is close to the
>>>> small failure band, move away from it in the appropriate direction.
>>>>
>>>> References:
>>>> [1] http://www.ti.com/lit/pdf/sprz426
>>>> [2] http://www.ti.com/lit/pdf/SPRACA9
>>>>
>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  drivers/mmc/host/Kconfig      |  2 +
>>>>  drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
>>>>  2 files changed, 91 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index 5fa580cec831..d8f984483ab0 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -977,6 +977,8 @@ config MMC_SDHCI_XENON
>>>>  config MMC_SDHCI_OMAP
>>>>         tristate "TI SDHCI Controller Support"
>>>>         depends on MMC_SDHCI_PLTFM && OF
>>>> +       select THERMAL
>>>> +       select TI_SOC_THERMAL
>>>>         help
>>>>           This selects the Secure Digital Host Controller Interface (SDHCI)
>>>>           support present in TI's DRA7 SOCs. The controller supports
>>>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>>>> index f588ab679cb0..b75c55011fcb 100644
>>>> --- a/drivers/mmc/host/sdhci-omap.c
>>>> +++ b/drivers/mmc/host/sdhci-omap.c
>>>> @@ -27,6 +27,7 @@
>>>>  #include <linux/regulator/consumer.h>
>>>>  #include <linux/pinctrl/consumer.h>
>>>>  #include <linux/sys_soc.h>
>>>> +#include <linux/thermal.h>
>>>>
>>>>  #include "sdhci-pltfm.h"
>>>>
>>>> @@ -286,15 +287,19 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>>         struct sdhci_host *host = mmc_priv(mmc);
>>>>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>         struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>>>> +       struct thermal_zone_device *thermal_dev;
>>>>         struct device *dev = omap_host->dev;
>>>>         struct mmc_ios *ios = &mmc->ios;
>>>>         u32 start_window = 0, max_window = 0;
>>>> +       bool single_point_failure = false;
>>>>         bool dcrc_was_enabled = false;
>>>>         u8 cur_match, prev_match = 0;
>>>>         u32 length = 0, max_len = 0;
>>>>         u32 phase_delay = 0;
>>>> +       int temperature;
>>>>         int ret = 0;
>>>>         u32 reg;
>>>> +       int i;
>>>>
>>>>         /* clock tuning is not needed for upto 52MHz */
>>>>         if (ios->clock <= 52000000)
>>>> @@ -304,6 +309,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>>         if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
>>>>                 return 0;
>>>>
>>>> +       thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");
>>>
>>> I couldn't find a corresponding call to a put function, like
>>> "thermal_zone_put()" or whatever, which made me realize that the
>>> thermal zone API is incomplete. Or depending on how you put it, it
>>> lacks object reference counting, unless I am missing something.
>>>
>>> For example, what happens if the thermal zone becomes unregistered
>>> between this point and when you call thermal_zone_get_temp() a couple
>>> of line below. I assume it's a known problem, but just wanted to point
>>> it out.
>>>
> 
> Yes, there is no ref counting. Specially because the get zones usages
> were too specific, and mostly used in application cases that module
> would not really be removed. Though not a good excuse, still, not very
> problematic. Now, if the API is getting other usages, then refcounting
> may be necessary.
> 
>>>> +       if (IS_ERR(thermal_dev)) {
>>>> +               dev_err(dev, "Unable to get thermal zone for tuning\n");
>>>> +               return PTR_ERR(thermal_dev);
>>>> +       }
>>>> +
>>>> +       ret = thermal_zone_get_temp(thermal_dev, &temperature);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>
>>> [...]
>>>
>>> Anyway, I have applied this for next, thanks!
>>
>> This is throwing errors on builds of keystone_defconfig in next and mainline:
>>
>> http://arm-soc.lixom.net/buildlogs/next/next-20190102/buildall.arm.keystone_defconfig.log.passed
>>
>> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
>>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP [=n] ||
>> COMPILE_TEST [=n]) && HAS_IOMEM [=y]
>>   Selected by [y]:
>>   - MMC_SDHCI_OMAP [=y] && MMC [=y] && MMC_SDHCI_PLTFM [=y] && OF [=y]
>>
>> So, thermal depends on ARCH_HAS_BANDGAP, which keystone doesn't provide.
>>
>> Selecting a major framework such as THERMAL from a driver config is
>> likely not the right solution anyway, especially since THERMAL does
>> provide stubbed out versions of the functions if it's not enabled.
> 
> Yeah, that seams a bit up-side-down. Can you guys give a bit more of
> context? Why do you need the cpu thermal zone ? From patch description,
> looks like you want to have your own zone then apply different tuning
> values based on temperature (range?). Why do you need to mess up with
> cpu_thermal zone? Don't you have a bandgap in the mem controller for
> this application?
> 

Thats correct. We don't have a bandgap in the MMC controller and thus we
have to use the cpu one to measure temperature.

THERMAL is critical for tuning. The interface is supposed to fail if we
can't get temperature. So IMO we should ensure that it is present.

I can fix this by "select TI_SOC_THERMAL if ARCH_HAS_BANDGAP" if you
guys agree.
Thanks,
Faiz
