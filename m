Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B08CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB50C222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GnCFv+Lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406684AbfBNSVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:21:08 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:8019 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404761AbfBNSVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550168467; x=1581704467;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Bo+VzpBFXXwdzwQHKYuR4+jxlAb8abN0EXR3PAVtxIQ=;
  b=GnCFv+LwKqFwzCjycah/vDXSkBWK/f6Q/VUhReZCmZ7wE0aMYoPvLKcf
   5sIn/2N74FnP7tI5oaw4OKfCSw/ynpoRqSPzTEcfUgAwIyxAd301Nm8bG
   eIDNApZcwlqGWDHp+eUz0oMQoUCRaAvOMeXILBkfBpW5XOKxX5uDUqtY3
   taIlWnM0OLxgyrI4Ht817YN5gZcr/3d6jqgDGKHRXZsysINnfob9Hgy3O
   4i9WCB7NNi/waJCO2nGX9HzmrZsDlFhbHqdFaNsyAapLf2LHUwSNJ53r7
   B3QGFFSwtkYCpgdjzntjS24GSIjrjVetFv6vxd8/slcgC9DhDh+1pXJwB
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,369,1544457600"; 
   d="scan'208";a="106284464"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2019 02:21:06 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Feb 2019 09:59:39 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.66.47]) ([10.111.66.47])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Feb 2019 10:21:07 -0800
Subject: Re: [v5 PATCH 6/8] clocksource/drivers/riscv: Add required checks
 during clock source init
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Cc:     Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
 <1550089092-28783-7-git-send-email-atish.patra@wdc.com>
 <bf8f0535-26d4-843a-d89c-8ab235411b4c@linaro.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <a0917630-489c-3ca4-e965-5a4ef2e4c4ca@wdc.com>
Date:   Thu, 14 Feb 2019 10:21:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <bf8f0535-26d4-843a-d89c-8ab235411b4c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 2:24 AM, Daniel Lezcano wrote:
> On 13/02/2019 21:18, Atish Patra wrote:
>> Currently, clocksource registration happens for an invalid cpu for
>> non-smp kernels. This lead to kernel panic as cpu hotplug registration
>> will fail for those cpus. Moreover, riscv_hartid_to_cpuid can return
>> errors now.
>>
>> Do not proceed if hartid or cpuid is invalid. Take this opprtunity to
>> print appropriate error strings for different failure cases.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> 
> Hi Atish,
> 
> I applied this patch for 5.1 with the typo fixed and the reviewed-by tags.
> 
>    -- Daniel
> 

Thanks!!

Regards,
Atish
>> ---
>>   drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> index 43189220..e8163693 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -95,13 +95,30 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>   	struct clocksource *cs;
>>   
>>   	hartid = riscv_of_processor_hartid(n);
>> +	if (hartid < 0) {
>> +		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
>> +			n, hartid);
>> +		return hartid;
>> +	}
>> +
>>   	cpuid = riscv_hartid_to_cpuid(hartid);
>> +	if (cpuid < 0) {
>> +		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
>> +		return cpuid;
>> +	}
>>   
>>   	if (cpuid != smp_processor_id())
>>   		return 0;
>>   
>> +	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
>> +	       __func__, cpuid, hartid);
>>   	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
>> -	clocksource_register_hz(cs, riscv_timebase);
>> +	error = clocksource_register_hz(cs, riscv_timebase);
>> +	if (error) {
>> +		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> +		       error, cpuid);
>> +		return error;
>> +	}
>>   
>>   	sched_clock_register(riscv_sched_clock,
>>   			BITS_PER_LONG, riscv_timebase);
>> @@ -110,8 +127,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>   			 "clockevents/riscv/timer:starting",
>>   			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
>>   	if (error)
>> -		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> -		       error, cpuid);
>> +		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>> +		       error);
>>   	return error;
>>   }
>>   
>>
> 
> 

