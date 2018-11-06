Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3A4C46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD5120869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD5120869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbeKFTrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:47:10 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14177 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387921AbeKFTrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:47:10 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 968AFAE36FA40;
        Tue,  6 Nov 2018 18:22:35 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 6 Nov 2018
 18:22:31 +0800
Subject: Re: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
 <20181105224654.GA25864@brain-police>
 <20181106090642.GH22431@hirez.programming.kicks-ass.net>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <5eb42b84-5195-69f2-e7a7-97568f360506@huawei.com>
Date:   Tue, 6 Nov 2018 18:22:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181106090642.GH22431@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2018/11/6 17:06, Peter Zijlstra wrote:
> On Mon, Nov 05, 2018 at 10:49:21PM +0000, Will Deacon wrote:
>> diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
>> index 3ae021368f48..9de8d3544630 100644
>> --- a/include/asm-generic/bitops/lock.h
>> +++ b/include/asm-generic/bitops/lock.h
>> @@ -6,6 +6,15 @@
>>  #include <linux/compiler.h>
>>  #include <asm/barrier.h>
>>  
>> +static inline void spin_until_bit_unlock(unsigned int nr,
>> +					 volatile unsigned long *p)
>> +{
>> +	unsigned long mask = BIT_MASK(bitnum);
>> +
>> +	p += BIT_WORD(nr);
>> +	smp_cond_load_relaxed(p, VAL & mask);
>> +}
>> +
>>  /**
>>   * test_and_set_bit_lock - Set a bit and return its old value, for lock
>>   * @nr: Bit to set
>> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
>> index bbc4730a6505..d711c62e718c 100644
>> --- a/include/linux/bit_spinlock.h
>> +++ b/include/linux/bit_spinlock.h
>> @@ -26,9 +26,7 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
>>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>>  	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
>>  		preempt_enable();
>> -		do {
>> -			cpu_relax();
>> -		} while (test_bit(bitnum, addr));
>> +		spin_until_bit_unlock(bitnum, addr);
>>  		preempt_disable();
>>  	}
>>  #endif
> 
> Yes, that's much better. Ideally though, we'd get rid of bit spinlocks
> that have significant enough contention for this to matter.

OK, I will send v3 to fix like the above.

Thanks,
Gao Xiang

> 
> 
