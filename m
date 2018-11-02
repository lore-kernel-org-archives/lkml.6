Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A0C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 01:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8A820666
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 01:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8A820666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeKBKWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 06:22:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46913 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbeKBKWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 06:22:55 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2E6A1D09CC4A7;
        Fri,  2 Nov 2018 09:17:34 +0800 (CST)
Received: from [127.0.0.1] (10.177.25.132) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 2 Nov 2018
 09:17:26 +0800
Subject: Re: [PATCH] ARM:kexec:offline panic_smp_self_stop CPU
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
References: <1541071249-15660-1-git-send-email-wangyufen@huawei.com>
 <20181101113430.GO30658@n2100.armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <kstewart@linuxfoundation.org>, <rppt@linux.vnet.ibm.com>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <pombredanne@nexb.com>, <weiyongjun1@huawei.com>,
        <huawei.libin@huawei.com>
From:   wangyufen <wangyufen@huawei.com>
Message-ID: <5BDBA58C.9090803@huawei.com>
Date:   Fri, 2 Nov 2018 09:17:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20181101113430.GO30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.25.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/1 19:34, Russell King - ARM Linux wrote:
> On Thu, Nov 01, 2018 at 07:20:49PM +0800, Wang Yufen wrote:
>> From: Yufen Wang <wangyufen@huawei.com>
>>
>> In case panic() and panic() called at the same time on different CPUS.
>> For example:
>> CPU 0:
>>   panic()
>>      __crash_kexec
>>        machine_crash_shutdown
>>          crash_smp_send_stop
>>        machine_kexec
>>          BUG_ON(num_online_cpus() > 1);
>>
>> CPU 1:
>>   panic()
>>     local_irq_disable
>>     panic_smp_self_stop
>>
>> If CPU 1 calls panic_smp_self_stop() before crash_smp_send_stop(), kdump
>> fails. CPU1 can't receive the ipi irq, CPU1 will be always online.
>> I changed BUG_ON to WARN in kexec crash as arm64 does, kdump also fails.
>> Because num_online_cpus() > 1, can't disable the L2 in _soft_restart.
>> To fix this problem, this patch split out the panic_smp_self_stop()
>> and add set_cpu_online(smp_processor_id(), false).
> Thanks.
>
> I think this may as well go into arch/arm/kernel/smp.c - it won't be
> required for single-CPU systems, since there aren't "other" CPUs.
>
> It's probably also worth a comment above the function as to why we
> have this.

Thanks.

I will send v2.

>> Signed-off-by: Yufen Wang <wangyufen@huawei.com>
>> ---
>>  arch/arm/kernel/setup.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
>> index 31940bd..151861f 100644
>> --- a/arch/arm/kernel/setup.c
>> +++ b/arch/arm/kernel/setup.c
>> @@ -602,6 +602,16 @@ static void __init smp_build_mpidr_hash(void)
>>  }
>>  #endif
>>  
>> +void panic_smp_self_stop(void)
>> +{
>> +	printk(KERN_DEBUG "CPU %u will stop doing anything useful since another CPU has paniced\n",
>> +			smp_processor_id());
>> +	set_cpu_online(smp_processor_id(), false);
>> +	while (1)
>> +		cpu_relax();
>> +
>> +}
>> +
>>  static void __init setup_processor(void)
>>  {
>>  	struct proc_info_list *list;
>> -- 
>> 2.7.4
>>
>>


