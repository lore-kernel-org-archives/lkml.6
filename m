Return-Path: <kernel-hardening-return-12762-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt6mUccptmbXIUC7X0rK+WQPQvNiAKdcJWIVnY2P7KkySvV/E6r8BJRJE2xsHuQ7aFgcnV4
ARC-Seal: i=1; a=rsa-sha256; t=1522151026; cv=none;
        d=google.com; s=arc-20160816;
        b=nP5xHlmsBjr9MNc7D1fASW7pkraM/Maxn53o7ijNntTA2J5I8Y6HNZkXn644dSi79k
         EpHi3Rjjh3mw3dlBT/f4cschAIUjK1kohUWkEqRapfZ1OUbo45mJH+FH8OsWFPK1rGLS
         9xJDus9EpuIxPHK3e0cZRrehyk+VQ/RFwPKH7kodGE1gwDvUtKY2ge8tAf9fpWjY1ivQ
         aAHHmwkSQuygPZxqo9jjsH+Xiv9DmdYwvP02gKRpsNWxSr3aZxxYmng3sel4yo3bvnby
         uYxeccISC+Xe3XxcBb2NzHn2BEpAFrh+YwoNS2DIi34e0rLIC7rLG5vdSAQc0SysTdta
         nfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=zVEF546kkfdysQpGmIQ2USGsHK8+Ee3iHyHRxJ16V6k=;
        b=xvRKsuRhjRAUK09w+blDMv2KrI/hXyFakVFf9d6JeFkKcCvPbZYmV9B3f033J5pF93
         ZiBbKZ2g7JtpOwSw2aJc42dzT651jDWM0OWYQgQtJAxSwg17bW6KTKd/Qf1vF+U8UT4k
         D+1+iVxEPyhRc8+YhdMjQQbL697umjtb6dU31B+1phY9wfG6QFb05NZ2lPVVVDj6rrra
         peY2GdLiUPgpvfwW3vKvYEMsWbMciR+eyKbua+kHcK4BvvuYPo+IYGC35ThAHE4y4ixj
         NqvCak5hOWmMQnui+LCdaTAL60JilIbQtYLB+MEzBXs2ZbDBLI37KlGbjb/WecMyKcUY
         dLlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12762-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12762-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12762-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12762-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 3/6] Protectable Memory
To: Matthew Wilcox <willy@infradead.org>
CC: <keescook@chromium.org>, <mhocko@kernel.org>, <david@fromorbit.com>,
	<rppt@linux.vnet.ibm.com>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>,
	<igor.stoppa@gmail.com>
References: <20180327015524.14318-1-igor.stoppa@huawei.com>
 <20180327015524.14318-4-igor.stoppa@huawei.com>
 <20180327023110.GD10054@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <4bafdb91-307b-ff4c-5432-cf5a39dfbb8b@huawei.com>
Date: Tue, 27 Mar 2018 14:43:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327023110.GD10054@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596054126767530056?=
X-GMAIL-MSGID: =?utf-8?q?1596091035359607306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 27/03/18 05:31, Matthew Wilcox wrote:
> On Tue, Mar 27, 2018 at 04:55:21AM +0300, Igor Stoppa wrote:
>> +static inline void *pmalloc_array_align(struct pmalloc_pool *pool,
>> +					size_t n, size_t size,
>> +					short int align_order)
>> +{
> 
> You're missing:
> 
>         if (size != 0 && n > SIZE_MAX / size)
>                 return NULL;


ACK

>> +	return pmalloc_align(pool, n * size, align_order);
>> +}
> 
>> +static inline void *pcalloc_align(struct pmalloc_pool *pool, size_t n,
>> +				  size_t size, short int align_order)
>> +{
>> +	return pzalloc_align(pool, n * size, align_order);
>> +}
> 
> Ditto.

ok

>> +static inline void *pcalloc(struct pmalloc_pool *pool, size_t n,
>> +			    size_t size)
>> +{
>> +	return pzalloc_align(pool, n * size, PMALLOC_ALIGN_DEFAULT);
>> +}
> 
> If you make this one:
> 
> 	return pcalloc_align(pool, n, size, PMALLOC_ALIGN_DEFAULT)

ok

> then you don't need the check in this function.
> 
> Also, do we really need 'align' as a parameter to the allocator functions
> rather than to the pool?

I actually wrote it first without, but then I wondered how to deal if
one needs to allocate both small fry structures and then something
larger that is page aligned.

However it's just speculation, I do not have any real example.

> I'd just reuse ARCH_KMALLOC_MINALIGN from slab.h as the alignment, and
> then add the special alignment options when we have a real user for them.

ok

--
thanks, igor
