Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeDZDtt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 23:49:49 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:44355 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbeDZDts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 23:49:48 -0400
X-Google-Smtp-Source: AB8JxZpyQblYTSp/aRlzKosFdHrAACJJRURfV7VE9LxjDLtg8RI1kAcsXpsu94XsR4FpEFZVbfFquQ==
Subject: Re: Affinity for GIC irq line
To: Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org
References: <2880aee6-704c-a5aa-e193-75bba1bce43d@gmail.com>
 <2d9f0678-ec5c-2b09-7ddd-407dd37c55a1@arm.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net,
        Catalin Marinas <catalin.marinas@arm.com>
From: valmiki <valmikibow@gmail.com>
Message-ID: <f7958252-8a3f-ae77-f3c9-e4c0686db1dc@gmail.com>
Date: Thu, 26 Apr 2018 09:19:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <2d9f0678-ec5c-2b09-7ddd-407dd37c55a1@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 25/04/18 04:23, valmiki wrote:
>> Hi all,
>>
>> When an IRQ line is set affinity using irq_set_affinity, which calls
>> irq_do_set_affinity, this API copies affinity mask to affinity variable
>> in irq_common_data of this irq descriptor.
>
> It does a wee bit more. Crucially, it contains the line:
>
>         ret = chip->irq_set_affinity(data, mask, force);
Yes, i overlooked this part.
>
>> But as per ARM GICv2 document in order to drive a interrupt to a
>> specific CPU we need to program GICD_ITARGETSRn register.
>>
>> But irq_set_affinity isn't writing to this register.Please correct me if
>> I'm wrong i did not find code for this register being updated in
>> irq_set_affinity flow.
>> So how affinity is being set for an IRQ line ?
>
> I would have though that a function name such as "gic_set_affinity" was
> clear enough?
>
>> If affinity was set successfully on what CPU does asm_do_IRQ run ?
>
> It runs on the CPU that the interrupt targets, I'd say.
Thanks Marc.
How does affinity for virtual irq work ?
For example pci-xgene-msi.c has xgene_msi_set_affinity function which 
sets affinity for each virq.
As per arm64/boot/dts/apm/apm-storm.dtsi they use GICv2.
They are trying to map each virq to specific cpu but already GIC lines 
affinity is set, when this affinity would be used ?

What does
/* Update MSI number to target the new CPU */
irqdata->hwirq = hwirq_to_canonical_hwirq(irqdata->hwirq) + target_cpu;

the above code do ?
Already mapping for hwirq to virq is done by this time for this domain.
Now if hwirq is updated its mapping doesn't it lead to wrong virq ?

Regards,
Valmiki


---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
