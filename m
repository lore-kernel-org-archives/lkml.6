Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DEEC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB4A2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:45:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB4A2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbeKFLIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 06:08:37 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:46178 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726368AbeKFLIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 06:08:37 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F00E164CB5B28;
        Tue,  6 Nov 2018 09:45:52 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 6 Nov 2018
 09:45:47 +0800
Subject: Re: [PATCH v2] bit_spinlock: introduce smp_cond_load_relaxed
To:     Will Deacon <will.deacon@arm.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Chao Yu <chao@kernel.org>, <peterz@infradead.org>
References: <1539413249-4402-1-git-send-email-hsiangkao@aol.com>
 <20181030060441.16107-1-gaoxiang25@huawei.com>
 <20181105224654.GA25864@brain-police>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <e31a6864-823b-ac6e-2223-88fa3888502e@huawei.com>
Date:   Tue, 6 Nov 2018 09:45:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181105224654.GA25864@brain-police>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2018/11/6 6:49, Will Deacon wrote:
> Hi Gao,
> 
> On Tue, Oct 30, 2018 at 02:04:41PM +0800, Gao Xiang wrote:
>> It is better to use wrapped smp_cond_load_relaxed
>> instead of open-coded busy waiting for bit_spinlock.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> ---
>>
>> change log v2:
>>  - fix the incorrect expression !(VAL >> (bitnum & (BITS_PER_LONG-1)))
>>  - the test result is described in the following reply.
> Please include the results in the commit message, so that this change is
> justified.

Will add in the next version...

> 
> This appears to introduce a bunch of overhead for the uncontended fastpath.
> How about the much-simpler-but-completely-untested (tm) patch below?

Actually I thought to do like the following (much simpler indeed) at first...

But the current implementation of smp_cond_load_relaxed will do a judgement immediately
which seems unnecessary (right after the test_and_set_bit_lock rather than after
__cmpwait_relaxed...)
        for (;;) {							\
		VAL = READ_ONCE(*__PTR);				\
		if (cond_expr)						\
			break;						\
		__cmpwait_relaxed(__PTR, VAL);				\
	}								\

p.s. I have no idea the original uncontended fastpath really works effectively...
some idea about this? Thanks in advance...


Thanks,
Gao Xiang


> 
> Will
> 
> --->8
> 
> diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/lock.h
> index 3ae021368f48..9de8d3544630 100644
> --- a/include/asm-generic/bitops/lock.h
> +++ b/include/asm-generic/bitops/lock.h
> @@ -6,6 +6,15 @@
>  #include <linux/compiler.h>
>  #include <asm/barrier.h>
>  
> +static inline void spin_until_bit_unlock(unsigned int nr,
> +					 volatile unsigned long *p)
> +{
> +	unsigned long mask = BIT_MASK(bitnum);
> +
> +	p += BIT_WORD(nr);
> +	smp_cond_load_relaxed(p, VAL & mask);
> +}
> +
>  /**
>   * test_and_set_bit_lock - Set a bit and return its old value, for lock
>   * @nr: Bit to set
> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
> index bbc4730a6505..d711c62e718c 100644
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -26,9 +26,7 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>  	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
>  		preempt_enable();
> -		do {
> -			cpu_relax();
> -		} while (test_bit(bitnum, addr));
> +		spin_until_bit_unlock(bitnum, addr);
>  		preempt_disable();
>  	}
>  #endif
