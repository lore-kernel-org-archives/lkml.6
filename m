Return-Path: <kernel-hardening-return-12156-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvwCAH3DJCagY8dBS5LvuI3OWQglaRim9jNOhsthQKXlkr0PtaCy06coyJUfuPPrBQpk84Z
ARC-Seal: i=1; a=rsa-sha256; t=1520358006; cv=none;
        d=google.com; s=arc-20160816;
        b=YMvx8pQ7Wp6PA9ydZe1mboPZQ3dzXS7U5e98tpyxVo/c1dRORXuT+Bh/z2Own6uLaz
         73jGWhJZPq++8UdwJV/ExfwjfHckE/ROys1wyA4XFzibgWatVmCNEE0pAi4a1eLX5vJP
         XFR5B4EQ0C374863zf+aZsPmN6RIKgdAe5LTKEeyeM9SqpQF4tlsQZR54Lby+zvP4RMk
         HVg9Fohg76b7OVf4wgkpdlxjDriPdjfwb2zewq2U7IvJdN4uq3H4oUbqwuciDirQciQr
         o3vH48opm3k1QuQF6gjvaXIDIJbUthAd3swn0m7H+K+rted/Uy1hc8LNBq2GAWqx9Br4
         HK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=seGI/jKkjMKBT1amFCdCvdmsurDRoTFTARmqcQoAhkg=;
        b=YkG0qU3v/p7A0IBo2aLC2o/viYMXUFoRr8CPO/lj51BEC0CjCpq+I9p88ETu9hb7CC
         pFQdIb6PksqDkLxnpB/55/qA9c3N4mFzeIsUEds12+n7Y2DQ++pLsBlLP2RxAWCX8pKp
         W05s5l/RqVdBPRIE89rLb+wBuzig7vgWv6+pOT0R3Qw+Rh1BggffPT9DaKvDiPEWeZ+C
         pEVetXOF//vbpCrJHgqM183SJj1WB2Ths8mqfUz/ltYQbixdqKP6tgxmT5nx+xAWtRRA
         +Tk1dnZm8SLRi42jpubo+sQ9neBmZWQ2nkZCgIRiZD7ecQfnx3SrSmy6fTgF/VUl+hny
         jyGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12156-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12156-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12156-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12156-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 1/7] genalloc: track beginning of allocations
To: J Freyensee <why2jjj.linux@gmail.com>, <david@fromorbit.com>,
	<willy@infradead.org>, <keescook@chromium.org>, <mhocko@kernel.org>
CC: <labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-2-igor.stoppa@huawei.com>
 <6a31164a-af3f-91ea-d385-7c6d1888b28c@gmail.com>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <05bde73d-6c0a-8309-4150-7225862c28e0@huawei.com>
Date: Tue, 6 Mar 2018 19:39:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6a31164a-af3f-91ea-d385-7c6d1888b28c@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.185.64]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676614912638441?=
X-GMAIL-MSGID: =?utf-8?q?1594210917785064275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/03/2018 21:00, J Freyensee wrote:
> .
> .
> 
> 
> On 2/28/18 12:06 PM, Igor Stoppa wrote:
>> +
>> +/**
>> + * gen_pool_dma_alloc() - allocate special memory from the pool for DMA usage
>> + * @pool: pool to allocate from
>> + * @size: number of bytes to allocate from the pool
>> + * @dma: dma-view physical address return value.  Use NULL if unneeded.
>> + *
>> + * Allocate the requested number of bytes from the specified pool.
>> + * Uses the pool allocation function (with first-fit algorithm by default).
>> + * Can not be used in NMI handler on architectures without
>> + * NMI-safe cmpxchg implementation.
>> + *
>> + * Return:
>> + * * address of the memory allocated	- success
>> + * * NULL				- error
>> + */
>> +void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma);
>> +
> 
> OK, so gen_pool_dma_alloc() is defined here, which believe is the API 
> line being drawn for this series.
> 
> so,
> .
> .
> .
>>
>>   
>>   /**
>> - * gen_pool_dma_alloc - allocate special memory from the pool for DMA usage
>> + * gen_pool_dma_alloc() - allocate special memory from the pool for DMA usage
>>    * @pool: pool to allocate from
>>    * @size: number of bytes to allocate from the pool
>>    * @dma: dma-view physical address return value.  Use NULL if unneeded.
>> @@ -342,14 +566,15 @@ EXPORT_SYMBOL(gen_pool_alloc_algo);
>>    * Uses the pool allocation function (with first-fit algorithm by default).
>>    * Can not be used in NMI handler on architectures without
>>    * NMI-safe cmpxchg implementation.
>> + *
>> + * Return:
>> + * * address of the memory allocated	- success
>> + * * NULL				- error
>>    */
>>   void *gen_pool_dma_alloc(struct gen_pool *pool, size_t size, dma_addr_t *dma)
>>   {
>>   	unsigned long vaddr;
>>   
>> -	if (!pool)
>> -		return NULL;
>> -
> why is this being removed?  I don't believe this code was getting 
> removed from your v17 series patches.

Because, as Matthew Wilcox pointed out [1] (well, that's how I
understood it) de-referencing a NULL pointer will cause the kernel to
complain loudly.

Where is the NULL pointer coming from?

a) from a bug in the user of the API - in that case it will be noticed,
reported and fixed, that is how also other in-kernel APIs work

b) from an attacker - it will still trigger an error from the kernel,
but it cannot really do much else, besides crashing repeatedly and
causing a DOS. However, there are so many other places that could be
under similar attack, that it doesn't seem to make a difference having a
check here only.

If the value was coming from userspace, that would be a completely
different case and some sort of sanitation would be mandatory.

> Otherwise, looks good,
> 
> Reviewed-by: Jay Freyensee <why2jjj.linux@gmail.com>

thanks


[1] http://www.openwall.com/lists/kernel-hardening/2018/02/26/16


--
igor
