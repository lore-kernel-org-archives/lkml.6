Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A51C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBB62077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r4ugSk1P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DBB62077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeIEBB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:01:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37721 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEBB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536093312; x=1567629312;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RXijzOu18ihbaLhEOq+p9ovKv+df55+NCvlqoCK6Ee4=;
  b=r4ugSk1PBt2e+itByj/JQv2PpLItKN0Wbm/kRllktL6hfZJ2P+DIbWRp
   7hOn1w91s4asEx9daZeJ9wP10ttaO8DEw9bN0Wdy5qAxUN1kOAt8WTFrf
   har1REXztzLsF8+axIOuEN5iW2+Prp2VwMm6YZUC/aQDmlAWXS8SjEZV0
   PPZ7bOopIlS+rXsFVThD6QgrG8G8yatY9etGQxYg3ORLodJz0+tyLYW2j
   ZZ39RKPCrnmPsMq/A1HqC3d5IykMKBU6wI21NAetu7CU0Wmi1Pf++buMq
   noOdQl99lKD+KyVsUxju2jrc4EspNPhBhhNKot0mO1lQjY7cvFtBt64QW
   A==;
X-IronPort-AV: E=Sophos;i="5.53,330,1531756800"; 
   d="scan'208";a="89986994"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2018 04:35:11 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 04 Sep 2018 13:21:53 -0700
Received: from use204589.ad.shared (HELO [10.86.59.178]) ([10.86.59.178])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Sep 2018 13:35:11 -0700
From:   Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH v2 2/3] RISC-V: Use Linux logical cpu number instead of
 hartid
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "damein@vger.kernel.org" <damein@vger.kernel.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-3-git-send-email-atish.patra@wdc.com>
 <20180831061104.GB19292@infradead.org>
Message-ID: <ec0819d5-9dc6-6b25-47a9-cd9d9e5099a8@wdc.com>
Date:   Tue, 4 Sep 2018 13:35:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831061104.GB19292@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 11:11 PM, Christoph Hellwig wrote:
>> -#define flush_tlb_all() sbi_remote_sfence_vma(NULL, 0, -1)
>> +static inline void remote_sfence_vma(struct cpumask *cmask, unsigned long start,
>> +				     unsigned long size)
>> +{
>> +	struct cpumask hmask;
>> +
>> +	riscv_cpuid_to_hartid_mask(cmask, &hmask);
>> +	sbi_remote_sfence_vma(hmask.bits, start, size);
>> +}
>> +
>> +#define flush_tlb_all() remote_sfence_vma(NULL, 0, -1)
> 
> flush_tlb_all passed NULL to sbi_remote_sfence_vma before, so this
> changes what we pass.  I think we should keep the existing behavior.
> 

sure. How about this ?


--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -55,8 +55,13 @@ static inline void remote_sfence_vma(struct cpumask 
*cmask, unsigned long start,
  {
         struct cpumask hmask;

-       riscv_cpuid_to_hartid_mask(cmask, &hmask);
-       sbi_remote_sfence_vma(hmask.bits, start, size);
+       if (cmask == NULL) {
+               sbi_remote_sfence_vma(NULL, start, size);
+       } else {
+               cpumask_clear(&hmask);
+               riscv_cpuid_to_hartid_mask(cmask, &hmask);
+               sbi_remote_sfence_vma(hmask.bits, start, size);
+       }
  }

>> @@ -93,10 +94,11 @@ static inline void plic_toggle(int ctxid, int hwirq, int enable)
>>   static inline void plic_irq_toggle(struct irq_data *d, int enable)
>>   {
>>   	int cpu;
>> +	struct plic_handler *handler;
>>   
>>   	writel(enable, plic_regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
>>   	for_each_cpu(cpu, irq_data_get_affinity_mask(d)) {
>> -		struct plic_handler *handler = per_cpu_ptr(&plic_handlers, cpu);
>> +		handler = per_cpu_ptr(&plic_handlers, cpu);
> 
> This looks like a spurious change.
> 

I think I did this to avoid possible compiler warnings. Will revert it.

Regards,
Atish

