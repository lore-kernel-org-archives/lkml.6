Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A3CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2CC520880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uro4dsrz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2CC520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeLJNXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:23:04 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50024 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeLJNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:23:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBADN1Eg080016;
        Mon, 10 Dec 2018 07:23:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544448181;
        bh=WpMjXMYFVh1qiGLvf6EdeivBn7nJVkLUWaq6vk8RTX8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uro4dsrzqAbDO+q8KQU6T30bhZkmlrQLTriDnXfyLOxMRE4Bu3LeAdsWDMMXsY/AJ
         Nc5mmFGCaS5QJTV0/xnYuX1ljv5Oy07Ywe/nckYYoXdilV8y/U91Pp6fIdDWR68UqP
         7qynCAdE9MjBwUzsp3eMr7YA94X4RSMlEJivwFlo=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBADN1wH026831
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 07:23:01 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 07:23:00 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 07:23:00 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBADMwgW025594;
        Mon, 10 Dec 2018 07:22:59 -0600
Subject: Re: [PATCH] mmc: sdhci-omap: Workaround errata regarding SDR104/HS200
 tuning failures (i929)
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Kishon <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20181129190503.6040-1-faiz_abbas@ti.com>
 <cb1e8e88-4c9d-741d-79cd-57b03c5e0808@ti.com>
 <c4704766-7a58-8aa4-6bc0-b9373b15096c@ti.com>
 <CAPDyKFqMW+tMaVsS_c=kPztZRjX97Nzr2W0egvDkyzkpWckHRA@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <d1ae4e93-4b17-9574-00b1-bfa268cb7574@ti.com>
Date:   Mon, 10 Dec 2018 18:55:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqMW+tMaVsS_c=kPztZRjX97Nzr2W0egvDkyzkpWckHRA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uffe,

On 05/12/18 7:20 PM, Ulf Hansson wrote:
> On Fri, 30 Nov 2018 at 06:53, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Hi Kishon,
>>
>> On 30/11/18 10:10 AM, Kishon Vijay Abraham I wrote:
>>> Hi Faiz,
>>>
>>> On 30/11/18 12:35 AM, Faiz Abbas wrote:
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
>>>> ---
>>>>  drivers/mmc/host/Kconfig      |  2 +
>>>>  drivers/mmc/host/sdhci-omap.c | 90 ++++++++++++++++++++++++++++++++++-
>>>>  2 files changed, 91 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>>> index 1b58739d9744..6d3553f06f27 100644
>>>> --- a/drivers/mmc/host/Kconfig
>>>> +++ b/drivers/mmc/host/Kconfig
>>>> @@ -969,6 +969,8 @@ config MMC_SDHCI_XENON
>>>>  config MMC_SDHCI_OMAP
>>>>      tristate "TI SDHCI Controller Support"
>>>>      depends on MMC_SDHCI_PLTFM && OF
>>>> +    select THERMAL
>>>> +    select TI_SOC_THERMAL
>>>>      help
>>>>        This selects the Secure Digital Host Controller Interface (SDHCI)
>>>>        support present in TI's DRA7 SOCs. The controller supports
>>>> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
>>>> index b3cb39d0db6f..9ccce7ef3a60 100644
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
>>>> @@ -286,14 +287,18 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>>      struct sdhci_host *host = mmc_priv(mmc);
>>>>      struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>>      struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>>>> +    struct thermal_zone_device *thermal_dev;
>>>>      struct device *dev = omap_host->dev;
>>>>      struct mmc_ios *ios = &mmc->ios;
>>>>      u32 start_window = 0, max_window = 0;
>>>> +    bool single_point_failure = false;
>>>>      u8 cur_match, prev_match = 0;
>>>>      u32 length = 0, max_len = 0;
>>>>      u32 phase_delay = 0;
>>>> +    int temperature;
>>>>      int ret = 0;
>>>>      u32 reg;
>>>> +    int i;
>>>>
>>>>      /* clock tuning is not needed for upto 52MHz */
>>>>      if (ios->clock <= 52000000)
>>>> @@ -303,6 +308,16 @@ static int sdhci_omap_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>>>      if (ios->timing == MMC_TIMING_UHS_SDR50 && !(reg & CAPA2_TSDR50))
>>>>              return 0;
>>>>
>>>> +    thermal_dev = thermal_zone_get_zone_by_name("cpu_thermal");
>>>> +    if (IS_ERR(thermal_dev)) {
>>>> +            dev_err(dev, "Unable to get thermal zone for tuning\n");
>>>> +            return PTR_ERR(thermal_dev);
>>>> +    }
>>>
>>> Can't we get thermal zone once during probe?
>>>
>>
>> Tuning is also (ideally) supposed to happen only once per enumeration.
>> Also it doesn't make sense to get a thermal zone for lower speed systems
>> that won't do tuning.
> 
> Currently sdhci-omap calls pm_runtime_get_sync() during probe, and
> then keeps the host device runtime resumed until ->remove() is called
> on it. I assume you are going to change that, at some point!?
> 
> In other words, what will happen to the host device when it becomes
> runtime suspended? Is re-tuning needed when it gets runtime resumed,
> which is the case for many other sdhci variants?

There are no plans to support runtime_suspend()/resume() any time in the
near future. If its ok with you, I would like to get this patch in
without any changes. We can change it in case a need for
runtime_suspend()/_resume() does arise.

Thanks,
Faiz




