Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1D1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70972150C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E70972150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeIZQv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:51:26 -0400
Received: from foss.arm.com ([217.140.101.70]:42714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726938AbeIZQv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:51:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5DE4ED1;
        Wed, 26 Sep 2018 03:39:06 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 67A883F5BD;
        Wed, 26 Sep 2018 03:39:05 -0700 (PDT)
Subject: Re: [PATCH 04/10] irqchip/gic-v3-its: Move pending table allocation
 to init time
To:     Julien Thierry <julien.thierry@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
 <20180921195954.21574-5-marc.zyngier@arm.com>
 <7cdac0d7-a256-5e75-5a19-8eb0fb1cf6a5@arm.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <637c7af3-cce7-4e0b-e049-366ea4b17e25@arm.com>
Date:   Wed, 26 Sep 2018 11:39:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7cdac0d7-a256-5e75-5a19-8eb0fb1cf6a5@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julien,

On 24/09/18 12:58, Julien Thierry wrote:
> Hi Marc,
> 
> On 21/09/18 20:59, Marc Zyngier wrote:
>> Pending tables for the redistributors are currently allocated
>> one at a time as each CPU boots. This is causing some grief
>> for Linux/RT (allocation from within a CPU hotplug notifier is
>> frown upon).
>>
>> Let's more this allocation to take place at init time, when we
>> only have a single CPU. It means we're allocating memory for CPUs
>> that are not online yet, but most system will boot all of their
>> CPUs anyway, so that's not completely wasted.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>    drivers/irqchip/irq-gic-v3-its.c   | 80 +++++++++++++++++++-----------
>>    include/linux/irqchip/arm-gic-v3.h |  1 +
>>    2 files changed, 53 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 7ef6baea2d78..462bba422189 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -173,6 +173,7 @@ static DEFINE_RAW_SPINLOCK(vmovp_lock);
>>    static DEFINE_IDA(its_vpeid_ida);
>>    
>>    #define gic_data_rdist()		(raw_cpu_ptr(gic_rdists->rdist))
>> +#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_rdists->rdist, cpu))
>>    #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
>>    #define gic_data_rdist_vlpi_base()	(gic_data_rdist_rd_base() + SZ_128K)
>>    
>> @@ -1625,7 +1626,7 @@ static void its_free_prop_table(struct page *prop_page)
>>    		   get_order(LPI_PROPBASE_SZ));
>>    }
>>    
>> -static int __init its_alloc_lpi_tables(void)
>> +static int __init its_alloc_lpi_prop_table(void)
> 
> A bit of a nit, but there is already a function called
> "its_allocate_prop_table" which I find very easy to confuse with this one.
> 
> And patch 3 factored the initialization out of its_allocate_prop_table.
> So I was wondering whether it would not actually be better to open-code
> it here and get rid of that function. Otherwise I'd suggest having more
> distinct names.

its_allocate_prop_table is also used by the VLPI code to allocate guest 
property tables, so I'd rather not open-code it.

How about renaming this function to its_setup_lpi_prop_table?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
