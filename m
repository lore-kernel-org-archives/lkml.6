Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90130C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9AD2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 07:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fTzf+Am3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B9AD2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeK3TCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:02:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34042 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK3TCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543564490; x=1575100490;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=eMqnPQM6D2Ocg72x92iWxuSYSVDGXRsS9oMJncVWvWA=;
  b=fTzf+Am3AJaosgu5XaSnkrB6mE0ZUV6IY3pHg2vSX4NMveFPJy7hOzXI
   d6Vz9d1BAa/P+zAmsMUBcm5x/XxyMRVxD2PrhmC9Tjh4Q9tf0Ma3yaPqr
   orRYdlmULKZWtn31KDTpg39I2GgxY1nSZXxdaAn6mwkE+XPyr820jkL5q
   5jtXJmw6fu21zeylYyDNxRizuy1mDgGsPJwO+retUdOzKL9VD1ru2GHIV
   x2qyNecWZiPqCrcHKkp76S//bfZ5vl8+1/5MrYD/0+ZrYUrUiw959D0ou
   uHaG1J1gQlbQix5vKWMy+ziqMhX6cD0odcChLxVruimphV7gBld6D9WXT
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,297,1539619200"; 
   d="scan'208";a="193302401"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2018 15:54:50 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 29 Nov 2018 23:36:41 -0800
Received: from th2t96qc2.ad.shared (HELO [10.86.56.90]) ([10.86.56.90])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2018 23:54:17 -0800
Subject: Re: [PATCH v2 4/4] irqchip: sifive-plic: Implement irq_set_affinity()
 for SMP host
To:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181127100317.12809-1-anup@brainfault.org>
 <20181127100317.12809-5-anup@brainfault.org>
 <71aaed41-c794-ea82-8d87-ddcde3506067@wdc.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <fd970974-e461-c999-ba48-d26d8ada3ca2@wdc.com>
Date:   Thu, 29 Nov 2018 23:54:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <71aaed41-c794-ea82-8d87-ddcde3506067@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 9:59 PM, Atish Patra wrote:
> On 11/27/18 2:04 AM, Anup Patel wrote:
>> Currently on SMP host, all CPUs take external interrupts routed via
>> PLIC. All CPUs will try to claim a given external interrupt but only
>> one of them will succeed while other CPUs would simply resume whatever
>> they were doing before. This means if we have N CPUs then for every
>> external interrupt N-1 CPUs will always fail to claim it and waste
>> their CPU time.
>>
>> Instead of above, external interrupts should be taken by only one CPU
>> and we should have provision to explicity specify IRQ affinity from
> s/explicity/explicitly
> 
>> kernel-space or user-space.
>>
>> This patch provides irq_set_affinity() implementation for PLIC driver.
>> It also updates irq_enable() such that PLIC interrupts are only enabled
>> for one of CPUs specified in IRQ affinity mask.
>>
>> With this patch in-place, we can change IRQ affinity at any-time from
>> user-space using procfs.
>>
>> Example:
>>
>> / # cat /proc/interrupts
>>              CPU0       CPU1       CPU2       CPU3
>>     8:         44          0          0          0  SiFive PLIC   8  virtio0
>>    10:         48          0          0          0  SiFive PLIC  10  ttyS0
>> IPI0:        55        663         58        363  Rescheduling interrupts
>> IPI1:         0          1          3         16  Function call interrupts
>> / #
>> / #
>> / # echo 4 > /proc/irq/10/smp_affinity
>> / #
>> / # cat /proc/interrupts
>>              CPU0       CPU1       CPU2       CPU3
>>     8:         45          0          0          0  SiFive PLIC   8  virtio0
>>    10:        160          0         17          0  SiFive PLIC  10  ttyS0
>> IPI0:        68        693         77        410  Rescheduling interrupts
>> IPI1:         0          2          3         16  Function call interrupts
>>
>> Signed-off-by: Anup Patel <anup@brainfault.org>
>> ---
>>    drivers/irqchip/irq-sifive-plic.c | 35 +++++++++++++++++++++++++++++--
>>    1 file changed, 33 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> index ffd4deaca057..fec7da3797fa 100644
>> --- a/drivers/irqchip/irq-sifive-plic.c
>> +++ b/drivers/irqchip/irq-sifive-plic.c
>> @@ -98,14 +98,42 @@ static void plic_irq_toggle(const struct cpumask *mask, int hwirq, int enable)
>>    
>>    static void plic_irq_enable(struct irq_data *d)
>>    {
>> -	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 1);
>> +	unsigned int cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
>> +					   cpu_online_mask);
>> +	WARN_ON(cpu >= nr_cpu_ids);
>> +	plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
>>    }
>>    
>>    static void plic_irq_disable(struct irq_data *d)
>>    {
>> -	plic_irq_toggle(irq_data_get_affinity_mask(d), d->hwirq, 0);
>> +	plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
>>    }
>>    
>> +#ifdef CONFIG_SMP
>> +static int plic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>> +			    bool force)
>> +{
>> +	unsigned int cpu;
>> +
>> +	if (!force)
>> +		cpu = cpumask_any_and(mask_val, cpu_online_mask);
>> +	else
>> +		cpu = cpumask_first(mask_val);
>> +
>> +	if (cpu >= nr_cpu_ids)
>> +		return -EINVAL;
>> +
>> +	if (!irqd_irq_disabled(d)) {
>> +		plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
>> +		plic_irq_toggle(cpumask_of(cpu), d->hwirq, 1);
> 
> irq is disabled for a fraction of time for cpu as well.
> You can use cpumask_andnot to avoid that.
> 
> 
> Moreover, something is weird here. I tested the patch in Unleashed with
> a debug statement.
> 
> Here are the cpumask plic_set_affinity receives.
> 
> # echo 0 > /proc[  280.810000] plic: plic_set_affinity: set affinity [0-1]
> [  280.810000] plic: plic_set_affinity: cpu = [0] irq = 4
> # echo 1 > /proc[  286.290000] plic: plic_set_affinity: set affinity [0]
> [  286.290000] plic: plic_set_affinity: cpu = [0] irq = 4
> # echo 2 > /proc[  292.130000] plic: plic_set_affinity: set affinity [1]
> [  292.130000] plic: plic_set_affinity: cpu = [1] irq = 4
> # echo 3 > /proc[  297.750000] plic: plic_set_affinity: set affinity [0-1]
> [  297.750000] plic: plic_set_affinity: cpu = [0] irq = 4
> 
> # echo 2 > /proc/irq/4/smp_affinity
> [  322.850000] plic: plic_set_affinity: set affinity [1]
> [  322.850000] plic: plic_set_affinity: cpu = [1] irq = 4
> 
> I have not figured out why it receive cpu mask for 0 & 3.
> Not sure if logical cpu id to hart id mapping is responsible for other
> two case. I will continue to test tomorrow.
> 

Never mind.
The input is in hex which explains the cpumask which explains all three 
cases except 0.
If we pass zero, it just passing the previous affinity mask.

Regards,
Atish
> Regards,
> Atish
>> +	}
>> +
> 
>> +	irq_data_update_effective_affinity(d, cpumask_of(cpu));
>> +
>> +	return IRQ_SET_MASK_OK_DONE;
>> +}
>> +#endif
>> +
>>    static struct irq_chip plic_chip = {
>>    	.name		= "SiFive PLIC",
>>    	/*
>> @@ -114,6 +142,9 @@ static struct irq_chip plic_chip = {
>>    	 */
>>    	.irq_enable	= plic_irq_enable,
>>    	.irq_disable	= plic_irq_disable,
>> +#ifdef CONFIG_SMP
>> +	.irq_set_affinity = plic_set_affinity,
>> +#endif
>>    };
>>    
>>    static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>>
> 
> 

