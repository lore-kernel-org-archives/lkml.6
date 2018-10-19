Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C9EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D6D20836
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DWQ6zVLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D6D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJSUXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:23:47 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2729 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbeJSUXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:23:47 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc9cb680000>; Fri, 19 Oct 2018 05:17:46 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 19 Oct 2018 05:17:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 19 Oct 2018 05:17:54 -0700
Received: from [10.26.11.35] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 19 Oct
 2018 12:17:42 +0000
Subject: Re: [PATCH v1 1/2] soc/tegra: pmc: Turn powergates_lock into spinlock
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830183635.4474-1-digetx@gmail.com>
 <7369869e-e58f-3760-d428-b00fb9cd28d9@nvidia.com>
 <57c3b1a6-0a60-613e-a4e7-5d66c199b860@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <cf5b7db9-5109-a9c6-3352-068d205c1b98@nvidia.com>
Date:   Fri, 19 Oct 2018 13:17:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <57c3b1a6-0a60-613e-a4e7-5d66c199b860@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539951466; bh=zpx9okRbwne3kIxyJRf//lOO+qtCKHAzkIVShzVgADI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DWQ6zVLmDRljGy7bGL24WH+/E+13bLR0ET3bGefujA0NHw36/ANkP9yS87JzfSW5w
         Oi0ze9hUoOylRIn6+JqRNT7bh1wp4w1DZ0l7EE9jv4Y67Skcyo0PAdi9E8okO2N6VZ
         ya5EZKs+EiYzUhxgQ8k9jplxefcwyVQSKBldpBcI0fmtiOoYEqpGm6UeVtp3d/iFr8
         hkUgankgb0Ceu4juAqnb0zLkLAN/fZuZCoaOLU81V5yqk7ts4pfSM+F/kQjOZQ8/2K
         Ow9EggZu7s/AuTGCt+H+O91SJmz/4ciRyI8QdXEPm9HCvbytuqXZjPH48u98BZI5ip
         3SwppsAR/IQLA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 15/10/2018 14:52, Dmitry Osipenko wrote:
> On 10/15/18 3:52 PM, Jon Hunter wrote:
>>
>> On 30/08/18 19:36, Dmitry Osipenko wrote:
>>> This fixes splats like the one below if CONFIG_DEBUG_ATOMIC_SLEEP=y
>>> and machine (Tegra30) booted with SMP=n or all secondary CPU's are put
>>> offline.
>>>
>>>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:254
>>>  in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/0
>>>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G         C        4.18.0-next-20180821-00180-gc3ebb6544e44-dirty #823
>>>  Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
>>>  [<c01134f4>] (unwind_backtrace) from [<c010db2c>] (show_stack+0x20/0x24)
>>>  [<c010db2c>] (show_stack) from [<c0bd0f3c>] (dump_stack+0x94/0xa8)
>>>  [<c0bd0f3c>] (dump_stack) from [<c0151df8>] (___might_sleep+0x13c/0x174)
>>>  [<c0151df8>] (___might_sleep) from [<c0151ea0>] (__might_sleep+0x70/0xa8)
>>>  [<c0151ea0>] (__might_sleep) from [<c0bec2b8>] (mutex_lock+0x2c/0x70)
>>>  [<c0bec2b8>] (mutex_lock) from [<c0589844>] (tegra_powergate_is_powered+0x44/0xa8)
>>>  [<c0589844>] (tegra_powergate_is_powered) from [<c0581a60>] (tegra30_cpu_rail_off_ready+0x30/0x74)
>>>  [<c0581a60>] (tegra30_cpu_rail_off_ready) from [<c0122244>] (tegra30_idle_lp2+0xa0/0x108)
>>>  [<c0122244>] (tegra30_idle_lp2) from [<c0853438>] (cpuidle_enter_state+0x140/0x540)
>>>  [<c0853438>] (cpuidle_enter_state) from [<c08538a4>] (cpuidle_enter+0x40/0x4c)
>>>  [<c08538a4>] (cpuidle_enter) from [<c01595e0>] (call_cpuidle+0x30/0x48)
>>>  [<c01595e0>] (call_cpuidle) from [<c01599f8>] (do_idle+0x238/0x28c)
>>>  [<c01599f8>] (do_idle) from [<c0159d28>] (cpu_startup_entry+0x28/0x2c)
>>>  [<c0159d28>] (cpu_startup_entry) from [<c0be76c8>] (rest_init+0xd8/0xdc)
>>>  [<c0be76c8>] (rest_init) from [<c1200f50>] (start_kernel+0x41c/0x430)
>>
>> Given the above, rather than converting to a spinlock I wonder if we are
>> just better off dropping the mutex completely from
>> tegra_powergate_is_powered()? Otherwise ...
>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/soc/tegra/pmc.c | 36 ++++++++++++++++++------------------
>>>  1 file changed, 18 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
>>> index 2d6f3fcf3211..d6bc9f66f1cd 100644
>>> --- a/drivers/soc/tegra/pmc.c
>>> +++ b/drivers/soc/tegra/pmc.c
>>> @@ -186,7 +186,7 @@ struct tegra_pmc_soc {
>>>   * @lp0_vec_phys: physical base address of the LP0 warm boot code
>>>   * @lp0_vec_size: size of the LP0 warm boot code
>>>   * @powergates_available: Bitmap of available power gates
>>> - * @powergates_lock: mutex for power gate register access
>>> + * @powergates_lock: lock for power gate register access
>>>   */
>>>  struct tegra_pmc {
>>>  	struct device *dev;
>>> @@ -215,7 +215,7 @@ struct tegra_pmc {
>>>  	u32 lp0_vec_size;
>>>  	DECLARE_BITMAP(powergates_available, TEGRA_POWERGATE_MAX);
>>>  
>>> -	struct mutex powergates_lock;
>>> +	spinlock_t powergates_lock;
>>>  };
>>>  
>>>  static struct tegra_pmc *pmc = &(struct tegra_pmc) {
>>> @@ -288,10 +288,10 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
>>>  	if (id == TEGRA_POWERGATE_3D && pmc->soc->has_gpu_clamps)
>>>  		return -EINVAL;
>>>  
>>> -	mutex_lock(&pmc->powergates_lock);
>>> +	spin_lock(&pmc->powergates_lock);
>>>  
>>>  	if (tegra_powergate_state(id) == new_state) {
>>> -		mutex_unlock(&pmc->powergates_lock);
>>> +		spin_unlock(&pmc->powergates_lock);
>>>  		return 0;
>>>  	}
>>>  
>>> @@ -300,7 +300,7 @@ static int tegra_powergate_set(unsigned int id, bool new_state)
>>>  	err = readx_poll_timeout(tegra_powergate_state, id, status,
>>>  				 status == new_state, 10, 100000);
>>>  
>>> -	mutex_unlock(&pmc->powergates_lock);
>>> +	spin_unlock(&pmc->powergates_lock);
>>
>> ... the above readx_poll_timeout needs to be converted to the atomic
>> version. Furthermore, the above 100ms timeout is probably not suited to
>> spinlock.
> 
> It's converted in the second patch. Seems mutex indeed could be dropped from tegra_powergate_is_powered, at least for now I can't recall why decided to keep the locking. Thank you for the review, I'll try to drop the mutex and come back with v2 if it will be fine.

Sorry if you were waiting for my response, but yes sounds good to me.

Cheers
Jon

-- 
nvpublic
