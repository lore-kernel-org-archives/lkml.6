Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeBVIU4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 03:20:56 -0500
Received: from mga06.intel.com ([134.134.136.31]:24105 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752628AbeBVIUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 03:20:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="206063299"
Subject: Re: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
 ZynqMP Platform
To: Manish Narani <MNARANI@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: Anirudha Sarangi <anirudh@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>
References: <1517336073-18142-1-git-send-email-mnarani@xilinx.com>
 <608309c3-fc4d-25a2-f0a9-21c0f3e2db46@intel.com>
 <SN1PR0201MB1791863A71475E3F0D896DD0C1CE0@SN1PR0201MB1791.namprd02.prod.outlook.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ce9efad6-b007-4cd9-18e7-a7932835846c@intel.com>
Date: Thu, 22 Feb 2018 10:20:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <SN1PR0201MB1791863A71475E3F0D896DD0C1CE0@SN1PR0201MB1791.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/18 17:00, Manish Narani wrote:
> Hi Adrian,
> 
>> -----Original Message-----
>> From: Manish Narani
>> Sent: Wednesday, February 21, 2018 11:39 AM
>> To: Adrian Hunter <adrian.hunter@intel.com>; michal.simek@xilinx.com;
>> ulf.hansson@linaro.org; linux-arm-kernel@lists.infradead.org; linux-
>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devicetree@vger.kernel.org; mark.rutland@arm.com; robh+dt@kernel.org
>> Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
>> <sgoud@xilinx.com>
>> Subject: RE: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
>> ZynqMP Platform
>>
>> Hi Adrian,
>>
>>
>>> -----Original Message-----
>>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>>> Sent: Friday, February 16, 2018 7:37 PM
>>> To: Manish Narani <MNARANI@xilinx.com>; michal.simek@xilinx.com;
>>> ulf.hansson@linaro.org; linux-arm-kernel@lists.infradead.org; linux-
>>> mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> devicetree@vger.kernel.org; mark.rutland@arm.com; robh+dt@kernel.org
>>> Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
>>> <sgoud@xilinx.com>; Manish Narani <MNARANI@xilinx.com>
>>> Subject: Re: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support
>>> for ZynqMP Platform
>>>
>>> On 30/01/18 20:14, Manish Narani wrote:
>>>> This patch adds support of SD auto tuning for ZynqMP platform. Auto
>>>> tuning sequence sends tuning block to card when operating in UHS-1
>>>> modes. This resets the DLL and sends CMD19/CMD21 as a part of the
>>>> auto tuning process. Once the auto tuning process gets completed,
>>>> reset the DLL to load the newly obtained SDHC tuned tap value.
>>>
>>> How is this different from:
>>> 	1. reset the dll
>>> 	2. call sdhci_execute_tuning
>>> 	3. reset the dll
>>>
> Below is my take on your above comments:
> - 'Reset the dll' is a platform specific call inside 'arasan_zynqmp_execute_tuning' which is implemented in sdhci-of-arasan.c 
> - 'arasan_zynqmp_execute_tuning' is called from 'sdhci_execute_tuning' as a platform_execute_tuning routine
> - So to keep 'DLL reset' routine called from sdhci-of-arasan.c, I have implemented the execute_tuning in sdhci-of-arasan.c

I meant something like:

	if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-8.9a"))
		host->mmc_host_ops.execute_tuning = arasan_zynqmp_execute_tuning;


static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode)
{
	struct sdhci_host *host = mmc_priv(mmc);
	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
	int err;

	arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);

	err = sdhci_execute_tuning(mmc, opcode);
	if (err)
		return err;

	arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);

	return 0;
}

> 
> Alternative way (Please review):
> - Define a host->quirk2 bit (SDHCI_QUIRK2_DLL_RESET_NEEDED) in sdhci-of-arasan.c indicating DLL reset needed while tuning operation
> - Call 'dll reset' routine before and after __sdhci_execute_tuning() in sdhci.c when a host->quirk2 bit (SDHCI_QUIRK2_DLL_RESET_NEEDED) is set

We should try to avoid quirks.
