Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3BC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A625C2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AEvGpH8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A625C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeJXTT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:19:58 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4967 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJXTT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:19:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bd04edb0000>; Wed, 24 Oct 2018 03:52:11 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Oct 2018 03:52:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Oct 2018 03:52:20 -0700
Received: from [10.21.132.148] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 24 Oct
 2018 10:52:19 +0000
Subject: Re: [PATCH v1] soc/tegra: pmc: Drop locking from
 tegra_powergate_is_powered()
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181021183614.454-1-digetx@gmail.com>
 <4c318e6b-4841-dd52-d61d-1106c5f8afbc@nvidia.com>
 <11fc94af-efe2-e571-3163-efdaa91f34fc@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d7b8a4c9-11cc-471c-53d9-6cc29d076573@nvidia.com>
Date:   Wed, 24 Oct 2018 11:52:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <11fc94af-efe2-e571-3163-efdaa91f34fc@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1540378331; bh=pFDWAMRFBPe/b3rK9I6R7CXxwjIqImszqS/R/QfESJo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AEvGpH8ZkpzvK/VQBfJWK37336eaDKw9YXdRmdBCkVuACN82ErSvpnZEOGdZ+5AzH
         kzMSpGqdNDcorzl+pxtXf7gwvwUqlqTLZjwzpc7MDI8cHqd1IlNX+V/rNGTZ3s6VsV
         r21JTVaBdYSr8EOxwxBTVVZWo04Q1WcXE2TD9OKDNXLJE99O8zTV/1KK11zsVibB2h
         NDqNPm8ob8xsbz4m5cfBPvW9k/VIlVJ09i05w4gIcH59lroUbsLvHFSrn9a9wL9wEI
         rBJrEJrzmq1FoPUabgrOhkSQMG77rZer33jw6NlVQKFc/ZT/bdN+Rf2N/bberGZT9a
         thnsxwS7C7D6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/10/2018 11:44, Dmitry Osipenko wrote:
> On 10/24/18 1:20 PM, Jon Hunter wrote:
>>
>> On 21/10/2018 19:36, Dmitry Osipenko wrote:
>>> This fixes splats like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=y
>>> and machine (Tegra30) booted with SMP=n or all secondary CPU's are put
>>> offline. Locking isn't needed because it protects atomic operation.
>>>
>>> # echo 0 | tee /sys/devices/system/cpu/cpu[1-3]/online
>>>
>>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
>>> in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
>>> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C        4.18.0-next-20180821-00180-gc3ebb6544e44-dirty #823
>>> Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>> [<c01134f4>] (unwind_backtrace) from [<c010db2c>] (show_stack+0x20/0x24)
>>> [<c010db2c>] (show_stack) from [<c0bd0f3c>] (dump_stack+0x94/0xa8)
>>> [<c0bd0f3c>] (dump_stack) from [<c0151df8>] (___might_sleep+0x13c/0x174)
>>> [<c0151df8>] (___might_sleep) from [<c0151ea0>] (__might_sleep+0x70/0xa8)
>>> [<c0151ea0>] (__might_sleep) from [<c0bec2b8>] (mutex_lock+0x2c/0x70)
>>> [<c0bec2b8>] (mutex_lock) from [<c0589844>] (tegra_powergate_is_powered+0x44/0xa8)
>>> [<c0589844>] (tegra_powergate_is_powered) from [<c0581a60>] (tegra30_cpu_rail_off_ready+0x30/0x74)
>>> [<c0581a60>] (tegra30_cpu_rail_off_ready) from [<c0122244>] (tegra30_idle_lp2+0xa0/0x108)
>>> [<c0122244>] (tegra30_idle_lp2) from [<c0853438>] (cpuidle_enter_state+0x140/0x540)
>>> [<c0853438>] (cpuidle_enter_state) from [<c08538a4>] (cpuidle_enter+0x40/0x4c)
>>> [<c08538a4>] (cpuidle_enter) from [<c01595e0>] (call_cpuidle+0x30/0x48)
>>> [<c01595e0>] (call_cpuidle) from [<c01599f8>] (do_idle+0x238/0x28c)
>>> [<c01599f8>] (do_idle) from [<c0159d28>] (cpu_startup_entry+0x28/0x2c)
>>> [<c0159d28>] (cpu_startup_entry) from [<c0be76c8>] (rest_init+0xd8/0xdc)
>>> [<c0be76c8>] (rest_init) from [<c1200f50>] (start_kernel+0x41c/0x430)
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/soc/tegra/pmc.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index 1fa840e3d930..1714cd818d69 100644
>>> --- a/drivers/soc/tegra/pmc.c
>>> +++ b/drivers/soc/tegra/pmc.c
>>> @@ -543,9 +543,7 @@ int tegra_powergate_is_powered(unsigned int id)
>>>  	if (!tegra_powergate_is_valid(id))
>>>  		return -EINVAL;
>>>  
>>> -	mutex_lock(&pmc->powergates_lock);
>>>  	status = tegra_powergate_state(id);
>>> -	mutex_unlock(&pmc->powergates_lock);
>>>  
>>>  	return status;
>>
>> Can we just ...
>>
>> 	return tegra_powergate_state(id);
> 
> We can, but it is not necessary. Feel free to adjust the code as you wish while applying ;) I deliberately left the 'status' variable because I think that makes code a bit more expressive.

Thierry, please feel free to add my ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Personally I would drop the 'status' variable but up to you.

Cheers
Jon

-- 
nvpublic
