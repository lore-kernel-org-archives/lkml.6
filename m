Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDD1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4E82086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NXvva8kD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfARCfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:35:40 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:9950 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfARCfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1547778941; x=1579314941;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=S4ml2sjUF5uB3w1kBdojfKVnCcsi+CAQRaRV4WaUbvA=;
  b=NXvva8kDCAYLl0qCJteF/eloWj+PxESj7Ay32TgRrBOT+PSEKCXFa72B
   BM9slcu1Tx1JKLJstqSOU1KaBtulzVdi9Udmhuoyi6vRtwfDH70tPVMh0
   sZfoLhjC9J90oRCGOPa6lZ09t0EUzklhA4aYTBWFyDTCETiisKai9z+V5
   xY0UzNGTY+rpS6sphWzq+0b1uJq2r3hWwfqDY3x86IMJX6JkJere5uQS8
   Wkew+lZ9pUb/csh/2w5QtUTgcWOxLcIdizFGc5nXMJ42xhX+1dRmtAghJ
   KfNtpHzPSPMRCOZ03Q+/R2/Ln5p0HgQlrAz/2fiJ+FFhQnwmmjYe+6RU1
   g==;
X-IronPort-AV: E=Sophos;i="5.56,489,1539619200"; 
   d="scan'208";a="197168425"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2019 10:35:42 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 17 Jan 2019 18:15:19 -0800
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.111.68.123]) ([10.111.68.123])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Jan 2019 18:35:40 -0800
Subject: Re: [PATCH v2 1/8] RISC-V: Do not wait indefinitely in __cpu_up
To:     Christoph Hellwig <hch@infradead.org>
Cc:     =?UTF-8?Q?Patrick_St=c3=a4hlin?= <me@packi.ch>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Alan Kao <alankao@andestech.com>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Clark <michaeljclark@mac.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Andreas Schwab <schwab@suse.de>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com>
 <1546940318-9752-2-git-send-email-atish.patra@wdc.com>
 <20190115135125.GA28946@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <1995e941-a8cf-c12e-71ae-7b50cf6c0ca5@wdc.com>
Date:   Thu, 17 Jan 2019 18:35:39 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115135125.GA28946@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 5:51 AM, Christoph Hellwig wrote:
>>   
>>   void *__cpu_up_stack_pointer[NR_CPUS];
>>   void *__cpu_up_task_pointer[NR_CPUS];
>> +static DECLARE_COMPLETION(cpu_running);
>>   
>>   void __init smp_prepare_boot_cpu(void)
>>   {
>> @@ -81,6 +82,7 @@ void __init setup_smp(void)
>>   
>>   int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>   {
>> +	int ret = 0;
>>   	int hartid = cpuid_to_hartid_map(cpu);
>>   	tidle->thread_info.cpu = cpu;
>>   
>> @@ -96,10 +98,15 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>>   		  task_stack_page(tidle) + THREAD_SIZE);
>>   	WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>>   
>> -	while (!cpu_online(cpu))
>> -		cpu_relax();
>> +	wait_for_completion_timeout(&cpu_running,
>> +					    msecs_to_jiffies(1000));
> 
> Having a global completion here worries me.  I bet we have some higher
> level serialization, but can we comment or even better lockdep assert on
> that?
> 

Yes. It is serialized from smp.c in smp_init(). It brings one cpu online
at a time for preset_cpu mask.

Do we still need a lockdep assert ?

Regards,
Atish
> Also please use up your available lines (72 in commit logs, 80 in source
> files) instead of adding spurious line wraps.
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 

