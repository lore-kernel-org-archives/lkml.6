Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F21C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDDD32086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jHFFYrXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDD32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeLJOEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:04:49 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36018 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbeLJOEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:04:49 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBAE4kkX018595;
        Mon, 10 Dec 2018 08:04:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544450686;
        bh=kDwfUcEwteZlmv6r9xReHZQUOZQwOcxcNNHdieWYmys=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jHFFYrXPH+Zsmv+V2JekSKBjkGcVedPiir9p2xsb4nloOTivY0XuLPKFd91cpH/aP
         VhU7wfZTcXo60ejYBRXHhPakw2Ge1sbTZP8rSCO0QayNm+gCMPnK4nFpy5Mz+rYjyV
         gYMNAQH35FRHoA5pzifJ40k33yZALQ6HWE+I7P1I=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBAE4kAX074839
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Dec 2018 08:04:46 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 10
 Dec 2018 08:04:46 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 10 Dec 2018 08:04:46 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBAE4iEE014834;
        Mon, 10 Dec 2018 08:04:44 -0600
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
 <d1ae4e93-4b17-9574-00b1-bfa268cb7574@ti.com>
 <CAPDyKFrLzEfGKkC3K9znjJUKO1MUjdBpaL0HEtHYOzbAgNO-fg@mail.gmail.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <e19a5c39-028e-8dda-aa0a-3968a213cd47@ti.com>
Date:   Mon, 10 Dec 2018 19:37:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrLzEfGKkC3K9znjJUKO1MUjdBpaL0HEtHYOzbAgNO-fg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/12/18 7:15 PM, Ulf Hansson wrote:
> On Mon, 10 Dec 2018 at 14:23, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>
>> Hi Uffe,
>>
>> On 05/12/18 7:20 PM, Ulf Hansson wrote:
>>> On Fri, 30 Nov 2018 at 06:53, Faiz Abbas <faiz_abbas@ti.com> wrote:
>>>>
>>>> Hi Kishon,
>>>>
>>>> On 30/11/18 10:10 AM, Kishon Vijay Abraham I wrote:
>>>>> Hi Faiz,
>>>>>
>>>>> On 30/11/18 12:35 AM, Faiz Abbas wrote:
>>>>>> Errata i929 in certain OMAP5/DRA7XX/AM57XX silicon revisions
>>>>>> (SPRZ426D - November 2014 - Revised February 2018 [1]) mentions
>>>>>> unexpected tuning pattern errors. A small failure band may be present
>>>>>> in the tuning range which may be missed by the current algorithm.
>>>>>> Furthermore, the failure bands vary with temperature leading to
>>>>>> different optimum tuning values for different temperatures.
>>>>>>
>>>>>> As suggested in the related Application Report (SPRACA9B - October 2017
>>>>>> - Revised July 2018 [2]), tuning should be done in two stages.
>>>>>> In stage 1, assign the optimum ratio in the maximum pass window for the
>>>>>> current temperature. In stage 2, if the chosen value is close to the
>>>>>> small failure band, move away from it in the appropriate direction.
>>>>>>
>>>>>> References:
>>>>>> [1] http://www.ti.com/lit/pdf/sprz426
>>>>>> [2] http://www.ti.com/lit/pdf/SPRACA9
>>>>>>
>>>>>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>>>>>> ---
...
>>>>>
>>>>> Can't we get thermal zone once during probe?
>>>>>
>>>>
>>>> Tuning is also (ideally) supposed to happen only once per enumeration.
>>>> Also it doesn't make sense to get a thermal zone for lower speed systems
>>>> that won't do tuning.
>>>
>>> Currently sdhci-omap calls pm_runtime_get_sync() during probe, and
>>> then keeps the host device runtime resumed until ->remove() is called
>>> on it. I assume you are going to change that, at some point!?
>>>
>>> In other words, what will happen to the host device when it becomes
>>> runtime suspended? Is re-tuning needed when it gets runtime resumed,
>>> which is the case for many other sdhci variants?
>>
>> There are no plans to support runtime_suspend()/resume() any time in the
>> near future. If its ok with you, I would like to get this patch in
>> without any changes. We can change it in case a need for
>> runtime_suspend()/_resume() does arise.
> 
> Right, I am okay with that. Due to recent changes to sdhci-omap
> $subject patch doesn't apply, can you please rebase!?
> 
> Additionally, I realized that we should fold in patch updating the DT
> doc for sdhci-omap, adding the property for the thermal zone. I
> regards to that, I am wondering if "cpu_thermal", is really the
> correct name of the zone. The point is, I am guessing the zone could
> change along with the SoCs/platforms.
> 

As you have probably noticed, we are introducing a new driver
(sdhci_am654) for newer platforms. I don't foresee using sdhci-omap
driver with any other platforms. In case we do use it, we can add the dt
property at that point of time and default to "cpu_thermal" to maintain
dt compatibility.

Will rebase and send v2 if you are ok with above.

Thanks,
Faiz
