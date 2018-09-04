Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342BAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4C520659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 17:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oLrjWxw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD4C520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIDWZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:25:32 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:41569 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDWZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536083962; x=1567619962;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=FuBkKc7mLWWwFvCg5TBYpHiVRZl1zlicDiwT1uEST2k=;
  b=oLrjWxw4aXBnJPJCqMdLJOdc0feaMtsWIBaun97wacbqCtQS8EOffcxv
   oFEuZCIYygN3CYeBZxApGSLnay3FtzwQ3diQlD/9Ih1SZvpjOkpzNtlSG
   2Oln+0qm1BGAGpU3bhBzwamJUZHb8tj4uIHPX7Of+IORQeUp5mvpoMDQw
   mtb5Zg1gBHrFzaNc3QYDtQRTgxZxzC1/RSUQz/jSDa0RaZMNPWu3YYjkn
   83ylOEEDUwBPRaYOqBd3rQJiOHBnXOUkiO/nYwvhFltoOVTu75CQ0Qg0B
   EONs8W69sSBQx8ooaXAcuIEUvY9sAjX2jq9wqeHEu1WHmE2whwvvSP7D8
   g==;
X-IronPort-AV: E=Sophos;i="5.53,329,1531756800"; 
   d="scan'208";a="90583680"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2018 01:59:21 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 04 Sep 2018 10:46:06 -0700
Received: from use204589.ad.shared (HELO [10.86.59.178]) ([10.86.59.178])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Sep 2018 10:59:21 -0700
Subject: Re: [PATCH v2 1/3] RISC-V: Add logical CPU indexing for RISC-V
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "damein@vger.kernel.org" <damein@vger.kernel.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-2-git-send-email-atish.patra@wdc.com>
 <20180831060352.GA19292@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <5930c4f2-b091-6f20-ef6d-2358a370482d@wdc.com>
Date:   Tue, 4 Sep 2018 10:59:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831060352.GA19292@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 11:03 PM, Christoph Hellwig wrote:
> On Tue, Aug 28, 2018 at 01:36:08AM -0700, Atish Patra wrote:
>> Currently, both linux cpu id and hardware cpu id are same.
>> This is not recommended as it will lead to discontinuous cpu
>> indexing in Linux. Moreover, kdump kernel will run from CPU0
>> which would be absent if we follow existing scheme.
>>
>> Implement a logical mapping between Linux cpu id and hardware
>> cpuid to decouple these two. Always mark the boot processor as
>> cpu0 and all other cpus get the logical cpu id based on their
>> booting order.
>>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>   arch/riscv/include/asm/smp.h | 18 +++++++++++++++++-
>>   arch/riscv/kernel/setup.c    |  2 ++
>>   arch/riscv/kernel/smp.c      | 19 +++++++++++++++++++
>>   3 files changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
>> index 36016845..a5c257b3 100644
>> --- a/arch/riscv/include/asm/smp.h
>> +++ b/arch/riscv/include/asm/smp.h
>> @@ -22,6 +22,13 @@
>>   #include <linux/cpumask.h>
>>   #include <linux/irqreturn.h>
>>   
>> +#define INVALID_HARTID -1
>> +/*
>> + * Mapping between linux logical cpu index and hartid.
>> + */
>> +extern unsigned long __cpu_logical_map[NR_CPUS];
>> +#define cpu_logical_map(cpu)    __cpu_logical_map[cpu]
> 
> How about naming this cpuid_to_hardid_map to make things a little
> more obvious?  

Sure.
Also shouldn't this be signed given your INVALID_HARTID
> definition above.
> 

I don't know what I was thinking after adding INVALID_HARTID. I will fix 
this.

>> +static inline int riscv_hartid_to_cpuid(int hartid) { return 0 ; }
>> +static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
>> +				       struct cpumask *out) {
>> +	cpumask_set_cpu(cpu_logical_map(0), out);
>> +}
> 
> Please use normal coding style even for stubs:
> 
> static inline int riscv_hartid_to_cpuid(int hartid)
> {
> 	return 0;
> }
> 
> static inline void riscv_cpuid_to_hartid_mask(const struct cpumask *in,
> 			struct cpumask *out)
> {
> 	cpumask_set_cpu(cpu_logical_map(0), out);
> }
> 
>> +unsigned long __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HARTID };
> 
> Please break the line into the usual format:
> 


> unsigned long __cpu_logical_map[NR_CPUS] = {
> 	[0 ... NR_CPUS-1]	= INVALID_HARTID,
> };
> 
ok.

Regards,
Atish
