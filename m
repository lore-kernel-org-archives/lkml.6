Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D55FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182AE2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 18:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rMfS7P27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182AE2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIDWet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 18:34:49 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15937 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeIDWet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 18:34:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536084533; x=1567620533;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=u4l4GxPJcwl+AYCWX5A8MqnPygmQri6ytFL921wx0cU=;
  b=rMfS7P27KFSAALgZQHPxfFPwfPnFLIqevEAPOLmBH/i4D4K7UOaYSHfS
   VnnK/Z+mwhkERwaMVNQA8zaZv9EZ7RmZOmNzeP4f0D4kszWZvA6r7HQ8d
   IXHxhGoz9z/zkAxtEqn4j0zRn+HFleb9bzzAVGEq6KXBAX1s50GCWkszx
   AaXaP2cipTbe/SDQtTMpitJJ9Ly5jrQCQCuOAzoxspSmDo8D8dcQepewi
   DG2jL7By2cO65rlKNn5FmnfXskOGCd7uuYw6RrbJuApgxjZxogfEvofkE
   n4BJeTxnp4OPL89K8u0DlY9sgRZoeXyHj/VbbennujrVaNOsMeMLNbWdF
   g==;
X-IronPort-AV: E=Sophos;i="5.53,330,1531756800"; 
   d="scan'208";a="186525257"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Sep 2018 02:08:52 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 04 Sep 2018 10:55:21 -0700
Received: from use204589.ad.shared (HELO [10.86.59.178]) ([10.86.59.178])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Sep 2018 11:08:36 -0700
Subject: Re: [PATCH v2 3/3] RISC-V: Support cpu hotplug.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "damein@vger.kernel.org" <damein@vger.kernel.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <1535445370-19004-4-git-send-email-atish.patra@wdc.com>
 <20180831061859.GC19292@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <0d439b9d-b3d0-7d2c-117b-abb37adf769c@wdc.com>
Date:   Tue, 4 Sep 2018 11:08:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831061859.GC19292@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/18 11:19 PM, Christoph Hellwig wrote:
>> +#else
>> +static inline bool can_hotplug_cpu(void) { return 0; }
>> +static inline void arch_send_call_wakeup_ipi(int cpu) { }
> 
> Please use normal coding style for these stubs.

Done.
> 
>>   #define INTERRUPT_CAUSE_FLAG	(1UL << (__riscv_xlen - 1))
>> +#define get_scause(cause)	(cause & ~INTERRUPT_CAUSE_FLAG)
> 
> I think this helper is misleading - the cause includes the interrupt
> flag.  I'd rather open code this in the other place as well.
> 

ok. Done.

>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> index d7c6ca7c..cb209139 100644
>> --- a/arch/riscv/kernel/process.c
>> +++ b/arch/riscv/kernel/process.c
>> @@ -42,6 +42,13 @@ void arch_cpu_idle(void)
>>   	local_irq_enable();
>>   }
>>   
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +void arch_cpu_idle_dead(void)
>> +{
>> +	cpu_play_dead();
>> +}
>> +#endif
> 
> I wonder if it might be worth to introduce a small
> arch/riscv/kernel/cpu-hotplug.c file for the various CONFIG_HOTPLUG_CPU
> only functions.
> 

I have kept it here to match all other arch. Same goes for all hotplug 
functions in smpboot.c

I can move them to a separate file if you think that provides better 
code readability and structure.


Regards,
Atish 		
