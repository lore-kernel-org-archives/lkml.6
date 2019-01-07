Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BE7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C66A20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hQF4sWCb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfAGKcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:32:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49884 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfAGKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:32:54 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x07AWFbw123694;
        Mon, 7 Jan 2019 04:32:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1546857135;
        bh=WZOvc9w2Xgrp9UHj8feQgQ5nDtiv4OItfXo0zoeNieI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hQF4sWCbglQDl1tdMH9lYd338AIMA3wqo2wI24bpvf1fFMXk1WrPdKkQeeiSbMXy4
         QYcbTEyXVEojfLgjzff0b9HJrCEZLvf0kWVMb5fZdzVCe8RBcgXV6VSrcqCqwtiNfH
         3rfCGiAnZ5DhnBojA8pR3y4VaDzCEG6IYUbMs7fM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x07AWFwp032329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jan 2019 04:32:15 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 7
 Jan 2019 04:32:14 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 7 Jan 2019 04:32:14 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x07AWA6o032034;
        Mon, 7 Jan 2019 04:32:11 -0600
Subject: Re: [PATCH v2 2/2] mmc: sdhci-omap: Workaround errata regarding
 SDR104/HS200 tuning failures (i929)
To:     Olof Johansson <olof@lixom.net>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
 <1d83e4df-78dc-10f6-f0c0-60e84b0e1094@ti.com>
 <CAOesGMiTmR6t2h1AzkPRWQon3onXKb5db5q6yVix9D5r+ExKfA@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <88ee183f-7997-45dd-d5c3-fab615340b21@ti.com>
Date:   Mon, 7 Jan 2019 16:05:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOesGMiTmR6t2h1AzkPRWQon3onXKb5db5q6yVix9D5r+ExKfA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On 05/01/19 6:27 AM, Olof Johansson wrote:
> On Wed, Jan 2, 2019 at 9:58 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Hi Olof, Eduardo,
>>
>> On 03/01/19 1:26 AM, Eduardo Valentin wrote:
>>> On Wed, Jan 02, 2019 at 10:29:31AM -0800, Olof Johansson wrote:
>>>> Hi,
>>>>
>>>>
...
>>>>
>>>> This is throwing errors on builds of keystone_defconfig in next and mainline:
>>>>
>>>> http://arm-soc.lixom.net/buildlogs/next/next-20190102/buildall.arm.keystone_defconfig.log.passed
>>>>
>>>> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
>>>>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP [=n] ||
>>>> COMPILE_TEST [=n]) && HAS_IOMEM [=y]
>>>>   Selected by [y]:
>>>>   - MMC_SDHCI_OMAP [=y] && MMC [=y] && MMC_SDHCI_PLTFM [=y] && OF [=y]
>>>>
>>>> So, thermal depends on ARCH_HAS_BANDGAP, which keystone doesn't provide.
>>>>
>>>> Selecting a major framework such as THERMAL from a driver config is
>>>> likely not the right solution anyway, especially since THERMAL does
>>>> provide stubbed out versions of the functions if it's not enabled.
>>>
>>> Yeah, that seams a bit up-side-down. Can you guys give a bit more of
>>> context? Why do you need the cpu thermal zone ? From patch description,
>>> looks like you want to have your own zone then apply different tuning
>>> values based on temperature (range?). Why do you need to mess up with
>>> cpu_thermal zone? Don't you have a bandgap in the mem controller for
>>> this application?
>>>
>>
>> Thats correct. We don't have a bandgap in the MMC controller and thus we
>> have to use the cpu one to measure temperature.
>>
>> THERMAL is critical for tuning. The interface is supposed to fail if we
>> can't get temperature. So IMO we should ensure that it is present.
>>
>> I can fix this by "select TI_SOC_THERMAL if ARCH_HAS_BANDGAP" if you
>> guys agree.
> 
> Building elaborate select statements is usually fragile, once
> dependencies for TI_SOC_THERMAL changes you need to come back here to
> fixup the select.
> 
> Supposedly this driver works on keystone (or does it?), it doesn't

Yes. This driver works on keystone.

> actually need TI_SOC_THERMAL for basic functionality beyond tuning?
> Or, at least, it needs to fall back to a reasonable behavior if it's
> unavailable on keystone.

The scenario is this. dra7 devices (omap2plus_defconfig) support tuning
which needs THERMAL and TI_SOC_THERMAL. Keystone devices don't need
thermal at all. The tuning part of the code will never be touched by the
keystone device.

In omap2plus_defconfig, THERMAL AND TI_SOC_THERMAL are modules by
default. I need them to be built-in because MMC is built-in.

> 
> Having the driver print a warning and refuse to tune to higher speeds
> is a reasonable way to do this, I think. That would carry to all
> platforms, i.e. even the ones who have TI_SOC_THERMAL and
> ARCH_HAS_BANDGAP, without adding the select.
> 

The MMC core today doesn't support a fallback to lower speeds when
tuning fails. The interface just fails. This means a bunch cards that
were working will now fail. Also, people building with olddefconfig will
get build errors because of THERMAL=m. Thus the Kconfig architecture
should automatically select the dependencies for SDHCI_OMAP in DRA7.

An "imply TI_SOC_THERMAL" is even better here. It won't force
TI_SOC_THERMAL for keystone and doesn't cause any warnings.

So I propose the following patch:

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index e26b8145efb3..bc61eefcb695 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -978,7 +978,7 @@ config MMC_SDHCI_OMAP
        tristate "TI SDHCI Controller Support"
        depends on MMC_SDHCI_PLTFM && OF
        select THERMAL
-       select TI_SOC_THERMAL
+       imply TI_SOC_THERMAL
        help
--

Thanks,
Faiz

