Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756427AbeDXHqp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 03:46:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43461 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755777AbeDXHqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 03:46:44 -0400
Subject: Re: [PATCH] irqchip/gic-v3: check kasprintf() for failures
To: Marc Zyngier <marc.zyngier@arm.com>
References: <20180424071036.20188-1-yuehaibing@huawei.com>
 <8636zlnk6x.wl-marc.zyngier@arm.com>
CC: <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <a9beb72c-f89b-ebfb-182c-a5dd6f4841b3@huawei.com>
Date: Tue, 24 Apr 2018 15:45:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <8636zlnk6x.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2018/4/24 15:21, Marc Zyngier wrote:
> On Tue, 24 Apr 2018 08:10:36 +0100,
> YueHaibing wrote:
>>
>> We should just return -ENOMEM here if the allocation fails,
>> otherwise it may cause a panic.
> 
> Can you explain how? From what I can see, node_name is only used as a
> parameter to pr_err/pr_info, which will perfectly deal with it by
> printing "(null)", and not causing a panic. Am I missing something?
> 
You are right

I just misunderstood,sorry for noise.

>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 3 +++
>>  drivers/irqchip/irq-gic-v3-its-platform-msi.c | 3 +++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> index 25a98de..ef3911f 100644
>> --- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> +++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
>> @@ -160,6 +160,9 @@ its_pci_msi_parse_madt(struct acpi_subtable_header *header,
>>  	its_entry = (struct acpi_madt_generic_translator *)header;
>>  	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
>>  			      (long)its_entry->base_address);
>> +	if(!node_name)
> 
> Missing space.
> 
>> +		return -ENOMEM;
>> +
>>  	dom_handle = iort_find_domain_token(its_entry->translation_id);
>>  	if (!dom_handle) {
>>  		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
>> diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
>> index 8881a05..b676fb4 100644
>> --- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
>> +++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
>> @@ -126,6 +126,9 @@ its_pmsi_parse_madt(struct acpi_subtable_header *header,
>>  	its_entry = (struct acpi_madt_generic_translator *)header;
>>  	node_name = kasprintf(GFP_KERNEL, "ITS@0x%lx",
>>  			      (long)its_entry->base_address);
>> +	if(!node_name)
>> +		return -ENOMEM;
>> +
>>  	domain_handle = iort_find_domain_token(its_entry->translation_id);
>>  	if (!domain_handle) {
>>  		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
>> -- 
>> 2.7.0
>>
>>
> 
> Thanks,
> 
> 	M.
> 
