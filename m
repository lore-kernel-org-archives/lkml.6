Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47350C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FC120837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dbSRsnv5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01FC120837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeLGXbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:31:25 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:32908 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeLGXbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544225486; x=1575761486;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gp8yzVzUL8W53fQqIVpzt3aNkutFWi/UJL35JdE9sP4=;
  b=dbSRsnv5N6bhzOyRalTVD+TJGRov7HmMoi+Hk73eRUp8W3jdbl6N4U8y
   u6XekUa5UVzu/bXYusITZsyFIpFMeENirqYeHTxtWE259wNyTRHTnb3jB
   dPQw2lUhAAg1ClPOBt6/SFbaJxEKDCH6gXMmODO9jxgbftYB424k6nJiV
   snzcM9ehqfEL133zJV8ZKD+uY+LEUJn/Y1BvpO4HmpixzqpG5CCV+o476
   kkcmC5Tk4c+jUjAnhL8QYpEhleEGZ6BumL+hslslR9qswkSgRFYHsRdI7
   L091Wmm2O1k4kXAu8Ps2vC3gRNNOXPHVEqRHcpi3xayNWKPylcurgQdGz
   A==;
X-IronPort-AV: E=Sophos;i="5.56,327,1539619200"; 
   d="scan'208";a="97868972"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2018 07:31:25 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Dec 2018 15:14:09 -0800
Received: from gj0bt32.ad.shared (HELO [10.86.57.164]) ([10.86.57.164])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Dec 2018 15:31:24 -0800
Subject: Re: [PATCH 4/4] RISC-V: Fix non-smp kernel boot on SMP systems
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmitriy@oss-tech.org" <dmitriy@oss-tech.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <mhng-4a071ea7-ddf5-4204-8343-790f9bbb3a09@palmer-si-x1c4>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <74dcf9b4-2343-0f56-1b56-80cc064728fb@wdc.com>
Date:   Fri, 7 Dec 2018 15:31:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <mhng-4a071ea7-ddf5-4204-8343-790f9bbb3a09@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 9:00 AM, Palmer Dabbelt wrote:
> On Mon, 03 Dec 2018 12:57:31 PST (-0800), atish.patra@wdc.com wrote:
>> Currently, clocksource registration happens for an invalid cpu
>> for non-smp kernels. This lead to kernel panic as cpu hotplug
>> registration will fail for those cpus.
>>
>> Do not proceed if hartid is invalid. Take this opprtunity to
>> print appropriate error strings for different failure cases.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   drivers/clocksource/riscv_timer.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
>> index 39de6e49..4af4af47 100644
>> --- a/drivers/clocksource/riscv_timer.c
>> +++ b/drivers/clocksource/riscv_timer.c
>> @@ -108,6 +108,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>   	int cpuid, hartid, error;
>>
>>   	hartid = riscv_of_processor_hartid(n);
>> +	if (hartid < 0)
>> +		return hartid;
> 
> This seems like it's just hiding a bug somewhere else.  We should at least put
> out a WARN here, as I'm not sure the error will propagate anywhere useful.
> 
ok. I will add a warning here. That's what we are doing in plic as well.

Regards,
Atish
>>   	cpuid = riscv_hartid_to_cpuid(hartid);
>>
>>   	if (cpuid != smp_processor_id())
>> @@ -115,14 +117,19 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>
>>   	/* This should be called only for boot cpu */
>>   	riscv_timebase = riscv_timebase_frequency(n);
>> -	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>> +	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
>>
>> +	if (error) {
>> +		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> +		       error, cpuid);
>> +		return error;
>> +	}
>>   	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>>   			 "clockevents/riscv/timer:starting",
>>   			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
>>   	if (error)
>> -		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> -		       error, cpuid);
>> +		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>> +		       error);
>>   	return error;
>>   }
> 

