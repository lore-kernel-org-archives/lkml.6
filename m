Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F31CC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A50520838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 23:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F3F+Umbf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A50520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbeLGXgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 18:36:52 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45057 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGXgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 18:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544225811; x=1575761811;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=oqFqUSGEZ527gvndpmSeiRdE8bBlWDIBdMBjfGtFk8g=;
  b=F3F+Umbf/otdZ08dtnB1yNO3HhymLgex9fBfYcog5vyEd4eQo4BKWlDl
   k3c6LxX4BOQFVqumLIg8VR3NDTYI9FDkIzkRY5OBtYVtQHY7mMR4CCF1g
   HCNJWvKls1GKahKElWRNDH6rLsqHcFT2xe4uyypiVUZ6yHKFX+0F+xa+0
   U1dVlPD45WbdMnYrZJTQ82H42VhrWTq9/mKTC1zQgzE5kdasSGqyWwQpA
   Ai6jBhrpA4uGU7UMJ85qbCkPboisElsFzosX4PcxxZQT+UZIY/Jg4lClV
   HR1EJ/c366UWIKNQmschOlyzsIXdFOF8mOt94WDX60zGceWmxHPxiHGHX
   w==;
X-IronPort-AV: E=Sophos;i="5.56,327,1539619200"; 
   d="scan'208";a="97338775"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Dec 2018 07:36:51 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Dec 2018 15:19:35 -0800
Received: from gj0bt32.ad.shared (HELO [10.86.57.164]) ([10.86.57.164])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2018 15:36:50 -0800
Subject: Re: [PATCH 2/4] RISC-V: Support per-hart timebase-frequency
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
References: <mhng-531f9ae3-9ab2-48cb-9f1f-4e6814498753@palmer-si-x1c4>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <f9769cec-2240-b668-c9e5-387212cf317e@wdc.com>
Date:   Fri, 7 Dec 2018 15:36:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <mhng-531f9ae3-9ab2-48cb-9f1f-4e6814498753@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 8:42 AM, Palmer Dabbelt wrote:
> On Mon, 03 Dec 2018 12:57:29 PST (-0800), atish.patra@wdc.com wrote:
>> Follow the updated DT specs and read the timebase-frequency
>> from the boot cpu. Keep the old DT reading as well for backward
>> compatibility. This patch is rework of old patch from Palmer.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/kernel/time.c          |  9 +--------
>>   drivers/clocksource/riscv_timer.c | 22 ++++++++++++++++++++++
>>   2 files changed, 23 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
>> index 1911c8f6..225fe743 100644
>> --- a/arch/riscv/kernel/time.c
>> +++ b/arch/riscv/kernel/time.c
>> @@ -20,14 +20,7 @@ unsigned long riscv_timebase;
>>
>>   void __init time_init(void)
>>   {
>> -	struct device_node *cpu;
>> -	u32 prop;
>> -
>> -	cpu = of_find_node_by_path("/cpus");
>> -	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
>> -		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
>> -	riscv_timebase = prop;
>> +	timer_probe();
>>
>>   	lpj_fine = riscv_timebase / HZ;
>> -	timer_probe();
>>   }
>> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
>> index 084e97dc..96af7058 100644
>> --- a/drivers/clocksource/riscv_timer.c
>> +++ b/drivers/clocksource/riscv_timer.c
>> @@ -83,6 +83,26 @@ void riscv_timer_interrupt(void)
>>   	evdev->event_handler(evdev);
>>   }
>>
>> +static long __init riscv_timebase_frequency(struct device_node *node)
>> +{
>> +	u32 timebase;
>> +
>> +	if (!of_property_read_u32(node, "timebase-frequency", &timebase))
>> +		return timebase;
>> +
>> +	/*
>> +	 * As per the DT specification, timebase-frequency should be present
>> +	 * under individual cpu node. Unfortunately, there are already available
>> +	 * HiFive Unleashed devices where the timebase-frequency entry is under
>> +	 * CPUs. check under parent "cpus" node to cover those devices.
>> +	 */
>> +	if (!of_property_read_u32(node->parent, "timebase-frequency",
>> +				  &timebase))
>> +		return timebase;
>> +
>> +	panic("RISC-V system with no 'timebase-frequency' in DTS\n");
>> +}
>> +
>>   static int __init riscv_timer_init_dt(struct device_node *n)
>>   {
>>   	int cpuid, hartid, error;
>> @@ -94,6 +114,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>   	if (cpuid != smp_processor_id())
>>   		return 0;
>>
>> +	/* This should be called only for boot cpu */
>> +	riscv_timebase = riscv_timebase_frequency(n);
>>   	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
>>   	clocksource_register_hz(cs, riscv_timebase);
> 
> We need to check to make sure the timebase-frequency of each hart is the same.
> This is mandated by the RISC-V ISA specification but should be checked in the
> code.
> 
Fair enough. I will add a timebase-frequency verification function that 
will be executed for every cpu instead of boot cpu.

If any cpu's timebase-frequency doesn't match with boot cpu, should we 
just WARN? or Do we need panic given that DT is not following something 
that is mandated by ISA ?

Regards,
Atish
