Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E31C2C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD90A21A80
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 02:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iTeBba9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfAFCNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 21:13:34 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34701 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAFCNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 21:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1546740813; x=1578276813;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=o2HBpe4wq5YXplrB4SjcP/RF2pycF8MBcWWFBeXrrOk=;
  b=iTeBba9qTNqLDFQ+osZpufJGJ4HdJaBIxbQpwhfm6tdd60t8BSBFf3oO
   jjYfXjX+AYUiU14djLYngt4/GvvrHwitbK6kVkRlOAVP38W171eSHptC8
   ZK33gk9R+HNs2z65/Nh9LVjSD3wc8aMdlS3J2DgAOvRYMTy8L+BzgUJCE
   vZv6JfkPhAJ8WbD+2BeNW9LOZhu46ecHK1LgevfhaFM5CymSBJOa22CXF
   GAUDYcACyPI6Jk4w6L6hv7yWX/k8VPHgaahBw5Lk7fIcj7El/5dPb44Q6
   Ebg/MYbd5dkAza02uqqdlSErZ25OKX/d3DJ1a1S6415aKkvYe4uSW7HVP
   A==;
X-IronPort-AV: E=Sophos;i="5.56,445,1539619200"; 
   d="scan'208";a="99279234"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2019 10:13:33 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 05 Jan 2019 17:53:41 -0800
Received: from usa003333.ad.shared (HELO [10.86.60.238]) ([10.86.60.238])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Jan 2019 18:13:32 -0800
Subject: Re: [PATCH 2/3] RISC-V: Move cpuid to hartid mapping to SMP.
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
 <1545865741-22795-3-git-send-email-atish.patra@wdc.com>
 <CAAhSdy12XrVOXcSaoUj1s1DBT-qW5S1nMiVQpCvEVcQM31cRJw@mail.gmail.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <4800edf7-5963-c472-affa-b6fdc58ba602@wdc.com>
Date:   Sat, 5 Jan 2019 18:13:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAAhSdy12XrVOXcSaoUj1s1DBT-qW5S1nMiVQpCvEVcQM31cRJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/26/18 7:38 PM, Anup Patel wrote:
> On Thu, Dec 27, 2018 at 4:39 AM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> Currently, logical CPU id to physical hartid mapping is
>> defined for both smp and non-smp configurations. This
>> is not required as we need this only for smp configuration.
>> The mapping function can define directly boot_cpu_hartid
>> for non-smp usecase.
>>
>> The reverse mapping function i.e. hartid to cpuid can be called
>> for any valid but not booted harts. So it should return default
>> cpu 0 only if it is a boot hartid
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/include/asm/smp.h | 13 +++++++++++--
>>   arch/riscv/kernel/setup.c    |  2 ++
>>   2 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
>> index 41aa73b4..8f30300f 100644
>> --- a/arch/riscv/include/asm/smp.h
>> +++ b/arch/riscv/include/asm/smp.h
>> @@ -22,12 +22,13 @@
>>   /*
>>    * Mapping between linux logical cpu index and hartid.
>>    */
>> -extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
>> -#define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
>>
>> +extern unsigned long boot_cpu_hartid;
>>   struct seq_file;
>>
>>   #ifdef CONFIG_SMP
>> +extern unsigned long __cpuid_to_hartid_map[NR_CPUS];
>> +#define cpuid_to_hartid_map(cpu)    __cpuid_to_hartid_map[cpu]
>>
>>   /* print IPI stats */
>>   void show_ipi_stats(struct seq_file *p, int prec);
>> @@ -58,7 +59,15 @@ static inline void show_ipi_stats(struct seq_file *p, int prec)
>>
>>   static inline int riscv_hartid_to_cpuid(int hartid)
>>   {
>> +       if (hartid == boot_cpu_hartid)
>>                  return 0;
>> +       else
>> +               return -1;
>> +}
>> +static inline unsigned long cpuid_to_hartid_map(int cpu)
>> +{
>> +
>> +       return boot_cpu_hartid;
>>   }
>>
>>   static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
>> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
>> index 2c290e6a..bd4d7b85 100644
>> --- a/arch/riscv/kernel/setup.c
>> +++ b/arch/riscv/kernel/setup.c
>> @@ -83,6 +83,7 @@ EXPORT_SYMBOL(empty_zero_page);
>>   atomic_t hart_lottery;
>>   unsigned long boot_cpu_hartid;
>>
>> +#ifdef CONFIG_SMP
>>   unsigned long __cpuid_to_hartid_map[NR_CPUS] = {
>>          [0 ... NR_CPUS-1] = INVALID_HARTID
>>   };
>> @@ -91,6 +92,7 @@ void __init smp_setup_processor_id(void)
>>   {
>>          cpuid_to_hartid_map(0) = boot_cpu_hartid;
>>   }
>> +#endif
> 
> Please move __cpuid_to_hartid_map[] and smp_setup_processor_id()
> to arch/riscv/kernel/smp.c
> 

Will do. Thanks for the review.

> Otherwise, looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>
> 

Regards,
Atish
