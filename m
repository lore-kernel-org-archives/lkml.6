Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D9C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D11A2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SeTeN5zF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbfARCKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:10:07 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:49217 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfARCKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547777411; x=1579313411;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3UlpWrGy5l0hFV1x1u49o8+zyWo/VDTedhrwg8pOEms=;
  b=SeTeN5zFQFZg3vvH6NqVHptlukNujJ9d6fqDp7WoYQG4Qun8YU8aU3+3
   KVAmT4bkVWNBlvdDf9VLju2NeMgHpydXsib4VH2UUo1KrGQ7Mq2qq3gK4
   bJSMQaUiQJDKKquujBO6bcMZ5opYN7rgPs5FIHTstNku5i/izszhR0dbq
   VgchDoxRc2kh0M+RRYMIg6ki6c3wzzfhf11X5QDQhDc7c13E9mQq2T1cN
   HqaHGPu5UoWMFmKRC4HRFYYbov9tdivj8v28u82W8Gfy7OxlZzJJShkt5
   Mz47/VXIk9x0X4Q0maMkNN2ITD0njbePHnoJzcw/8rXZVig8U1z3hNvVr
   A==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="197166813"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 10:10:10 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 17 Jan 2019 17:51:23 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.68.123]) ([10.111.68.123])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Jan 2019 18:10:06 -0800
Subject: Re: [PATCH v2 6/8] RISC-V: Add required checks during clock source
 init
To:     Anup Patel <anup@brainfault.org>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-7-git-send-email-atish.patra@wdc.com>
 <CAAhSdy0VsOjiSRhBY7fdXVOccWV+4j_UJwKdNX4cNWHBJKyGeA@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <839bee2a-12a0-6bdd-8d59-b83cc0403c96@wdc.com>
Date:   Thu, 17 Jan 2019 18:10:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0VsOjiSRhBY7fdXVOccWV+4j_UJwKdNX4cNWHBJKyGeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/19 3:57 AM, Anup Patel wrote:
> Few nit changes..
> 
> Prefer, "clocksource/drivers/riscv:" prefix instead of "RISC-V:" for
> this patch.
> 
> On Tue, Jan 8, 2019 at 3:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> Currently, clocksource registration happens for an invalid cpu
>> for non-smp kernels. This lead to kernel panic as cpu hotplug
>> registration will fail for those cpus. Moreover,
>> riscv_hartid_to_cpuid can return errors now.
>>
>> Do not proceed if hartid or cpuid is invalid. Take this opprtunity
>> to print appropriate error strings for different failure cases.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
>>   1 file changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
>> index 43189220..d9b914e9 100644
>> --- a/drivers/clocksource/timer-riscv.c
>> +++ b/drivers/clocksource/timer-riscv.c
>> @@ -95,14 +95,31 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>          struct clocksource *cs;
>>
>>          hartid = riscv_of_processor_hartid(n);
>> +       if (hartid < 0) {
>> +               pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
>> +                       n, hartid);
>> +               return hartid;
>> +       }
> 
> Add empty line here.
> 
>>          cpuid = riscv_hartid_to_cpuid(hartid);
>>
> 
> Remove empty line here
> 
>> +       if (cpuid < 0) {
>> +               pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
>> +               return cpuid;
>> +       }
>> +
>>          if (cpuid != smp_processor_id())
>>                  return 0;
>>
>> +       pr_err("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
>> +              __func__, cpuid, hartid);
>>          cs = per_cpu_ptr(&riscv_clocksource, cpuid);
>> -       clocksource_register_hz(cs, riscv_timebase);
>> +       error = clocksource_register_hz(cs, riscv_timebase);
>>
> 
> Remove empty line here.
> 
>> +       if (error) {
>> +               pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> +                      error, cpuid);
>> +               return error;
>> +       }
> 
> Add empty line here.
> 
>>          sched_clock_register(riscv_sched_clock,
>>                          BITS_PER_LONG, riscv_timebase);
>>
>> @@ -110,8 +127,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>                           "clockevents/riscv/timer:starting",
>>                           riscv_timer_starting_cpu, riscv_timer_dying_cpu);
>>          if (error)
>> -               pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> -                      error, cpuid);
>> +               pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>> +                      error);
>>          return error;
>>   }
>>
>> --
>> 2.7.4
>>
> 
> Apart from above, looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
>

Thanks for the review. I will fix the empty line issues and subject line.


> Regards,
> Anup
> 

