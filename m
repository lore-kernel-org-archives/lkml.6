Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CADC43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB26D2229F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Jn/wU00c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfAFCOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:14:50 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24173 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAFCOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546740889; x=1578276889;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=rdvOEnYrJjR/e7+3f5M1QrxD+1TIDi7QoJOdRa4Y+yI=;
  b=Jn/wU00cUBd8BoLp4WeW95JTPFNYNs+doEbI/3mjpKDqT8m2zWh8BlpM
   BRClamOi7xl7SYbxXBzf6R7Q3DWFZ4HhmjXEWgm755L0Q2NgCOWJd2Ypq
   dha8sErfpjUc8XSRYVsbFVtfqwHrvUZLjsnJyRqwj8e6l9IaD1KVDpg8m
   6RVyO8b4u6nOwRkjm5R5SzDkqL7vFY+ukr2VraJKVqlbk4FEp+aRAGT2a
   lW2GcC61lRHmMwF4H5/mnFW+AFnaY7AG1qsq4fW1p5llA7ZPQh3+pg5xB
   7HhR14LYlFDxqVBsp1ddcQiv4w0XX0uXyGPCyR9MwvjHfUoBREzsmcZLN
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,445,1539619200"; 
   d="scan'208";a="202905306"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2019 10:14:49 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 05 Jan 2019 17:54:58 -0800
Received: from usa003333.ad.shared (HELO [10.86.60.238]) ([10.86.60.238])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Jan 2019 18:14:49 -0800
Subject: Re: [PATCH 3/3] RISC-V: Fix non-smp kernel boot on SMP systems
To:     Anup Patel <anup@brainfault.org>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <1545865741-22795-1-git-send-email-atish.patra@wdc.com>
 <1545865741-22795-4-git-send-email-atish.patra@wdc.com>
 <CAAhSdy20-r5e1EQ7yTawbxXs0NgFkfg8L8VLRUFLL=NcXfCD2w@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <49e75ab8-a210-75b5-25d0-5d523f532ea1@wdc.com>
Date:   Sat, 5 Jan 2019 18:14:48 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAhSdy20-r5e1EQ7yTawbxXs0NgFkfg8L8VLRUFLL=NcXfCD2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/18 7:58 PM, Anup Patel wrote:
> On Thu, Dec 27, 2018 at 4:39 AM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> In non-smp configuration, hartid can be higher that NR_CPUS.
>> riscv_of_processor_hartid should not be compared to hartid to
>> NR_CPUS in that case. Moreover, this function checks all the
>> DT properties of a hart node. NR_CPUS comparison seems out of
>> place.
> 
> This only explains change in arch/riscv/kernel/cpu.c
> 
> Create separate patch for it.
> 
>>
>> Do cpuid comparison with NR_CPUs in smp setup code. Update the
> 
> Create separate patch for change in arch/riscv/kernel/smp.c
> 
>> drivers to handle appropriate code as well.
> 
> Create separate patches for riscv_timer and irq-sifive-plic.c
> because they will probably go via different gitrepos.
> 
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/kernel/cpu.c           |  4 ----
>>   arch/riscv/kernel/smp.c           |  1 -
>>   arch/riscv/kernel/smpboot.c       |  5 +++++
>>   drivers/clocksource/riscv_timer.c | 21 ++++++++++++++++++---
>>   drivers/irqchip/irq-sifive-plic.c |  5 +++++
>>   5 files changed, 28 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>> index b4a7d442..251ffab6 100644
>> --- a/arch/riscv/kernel/cpu.c
>> +++ b/arch/riscv/kernel/cpu.c
>> @@ -34,10 +34,6 @@ int riscv_of_processor_hartid(struct device_node *node)
>>                  pr_warn("Found CPU without hart ID\n");
>>                  return -(ENODEV);
>>          }
>> -       if (hart >= NR_CPUS) {
>> -               pr_info("Found hart ID %d, which is above NR_CPUs.  Disabling this hart\n", hart);
>> -               return -(ENODEV);
>> -       }
>>
>>          if (of_property_read_string(node, "status", &status)) {
>>                  pr_warn("CPU with hartid=%d has no \"status\" property\n", hart);
>> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
>> index 57b1383e..9ea7ac7d 100644
>> --- a/arch/riscv/kernel/smp.c
>> +++ b/arch/riscv/kernel/smp.c
>> @@ -49,7 +49,6 @@ int riscv_hartid_to_cpuid(int hartid)
>>                          return i;
>>
>>          pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
>> -       BUG();
> 
> Have a separate patch with explanation about why
> we don't need BUG() here.
> 

Ok. I will split the patch into multiple ones as suggested.

Regards,
Atish
>>          return i;
>>   }
>>
>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>> index bb8cd242..05291840 100644
>> --- a/arch/riscv/kernel/smpboot.c
>> +++ b/arch/riscv/kernel/smpboot.c
>> @@ -66,6 +66,11 @@ void __init setup_smp(void)
>>                          found_boot_cpu = 1;
>>                          continue;
>>                  }
>> +               if (cpuid >= NR_CPUS) {
>> +                       pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
>> +                               cpuid, hart);
>> +                       break;
>> +               }
>>
>>                  cpuid_to_hartid_map(cpuid) = hart;
>>                  set_cpu_possible(cpuid, true);
>> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
>> index 084e97dc..acf2af10 100644
>> --- a/drivers/clocksource/riscv_timer.c
>> +++ b/drivers/clocksource/riscv_timer.c
>> @@ -89,20 +89,35 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>>          struct clocksource *cs;
>>
>>          hartid = riscv_of_processor_hartid(n);
>> +       if (hartid < 0) {
>> +               pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
>> +                       n, hartid);
>> +               return hartid;
>> +       }
>>          cpuid = riscv_hartid_to_cpuid(hartid);
>>
>> +       if (cpuid < 0)
>> +               pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
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
>> +       if (error) {
>> +               pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
>> +                      error, cpuid);
>> +               return error;
>> +       }
>>          error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
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
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> index 357e9daf..254ecd76 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -237,6 +237,11 @@ static int __init plic_init(struct device_node *node,
>>                  }
>>
>>                  cpu = riscv_hartid_to_cpuid(hartid);
>> +               if (cpu < 0) {
>> +                       pr_warn("Invalid cpuid for context %d\n", i);
>> +                       continue;
>> +               }
>> +
>>                  handler = per_cpu_ptr(&plic_handlers, cpu);
>>                  handler->present = true;
>>                  handler->ctxid = i;
>> --
>> 2.7.4
>>
> 
> Regards,
> Anup
> 

