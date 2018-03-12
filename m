Return-Path: <kernel-hardening-return-12479-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvGCKp+XWGOSza7LyI3Zt88/1MscF/W0Uy06tZHnUzIOiLUYMviifkHumgspuytD1wH6eGi
ARC-Seal: i=1; a=rsa-sha256; t=1520890021; cv=none;
        d=google.com; s=arc-20160816;
        b=ZLEt9C4q6djtUDBq3pNUoMznHWeX4ixji8nlRJgwm0HeOnoMLacgb1TfpstTIv6pB7
         yUtFJw7D6or1MYCDQH8CcrzuJZldxDjj7t4tIc6crIBnEvq2iymXzFy1vSKjx6tv/eNb
         Xy8OmuMr1DJMKw2/tPyiP265yrVsi1Q6a/rgRZmLUk0d2gs2OhqoxJqxj8ZFfwJFn9VA
         2aJA+7GZkKUVr5qE06OZgJseBPCQzDSUDrN9hgP72/Gkbkmam/YGs4tsaofBQ26Xt1zd
         wvz81nHuHQsnlQaW7SWlGae/yqC/3tfWmD2nNVTJxSmPBFW8SSmhYVtDwCkxhNK2wKKg
         PM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=VldzJ6XKeGN+boQ7Rqy6+K/6bYTC2XPq27tA7HsH+5w=;
        b=we8U1rVMLOLfsdQ36TGLG3cygj9AtIUKuJ4mQUDSlNzJIHzH/9Iix90oYJcET+pP2W
         WRxj93ZQ+1+3rPCgK6k/rmoFVEzalRLPlUB7H/zcu7Yoxj7HeiKLaMx9qapguDrV1ov4
         2Qwq5Guzi3yrYdT39ZgdhVu+UPTKX9bBlffrNQXjVotWIQDj+tKhR7twh/nLKd17+X/n
         jDJ2qDFUAZvxWKKKw4btbnNZBh/DjhefeXHDtzNZNar9DsMBL+6kias81m37I11cEaPP
         3elZ0l+0Sxi+PQBMKEStIgVoEEZx/4ot3Kd8FvbE0Jac46XNPzUkv7M7uYwDE63k4ap/
         iqLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12479-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12479-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12479-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12479-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 4/7] Protectable Memory
To: Matthew Wilcox <willy@infradead.org>
CC: <david@fromorbit.com>, <keescook@chromium.org>, <mhocko@kernel.org>,
	<labbott@redhat.com>, <linux-security-module@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kernel-hardening@lists.openwall.com>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-5-igor.stoppa@huawei.com>
 <20180312191314.GA29191@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <b481f817-dad4-6bed-15bb-1bda4396b6b6@huawei.com>
Date: Mon, 12 Mar 2018 23:25:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180312191314.GA29191@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676771806146287?=
X-GMAIL-MSGID: =?utf-8?q?1594768775562155373?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 12/03/18 21:13, Matthew Wilcox wrote:
> On Wed, Feb 28, 2018 at 10:06:17PM +0200, Igor Stoppa wrote:
>> struct gen_pool *pmalloc_create_pool(const char *name,
>> 					 int min_alloc_order);
>> int is_pmalloc_object(const void *ptr, const unsigned long n);
>> bool pmalloc_prealloc(struct gen_pool *pool, size_t size);
>> void *pmalloc(struct gen_pool *pool, size_t size, gfp_t gfp);
>> static inline void *pzalloc(struct gen_pool *pool, size_t size, gfp_t gfp)
>> static inline void *pmalloc_array(struct gen_pool *pool, size_t n,
>> 				  size_t size, gfp_t flags)
>> static inline void *pcalloc(struct gen_pool *pool, size_t n,
>> 			    size_t size, gfp_t flags)
>> static inline char *pstrdup(struct gen_pool *pool, const char *s, gfp_t gfp)
>> int pmalloc_protect_pool(struct gen_pool *pool);
>> static inline void pfree(struct gen_pool *pool, const void *addr)
>> int pmalloc_destroy_pool(struct gen_pool *pool);
> 
> Do you have users for all these functions?  I'm particularly sceptical of
> pfree().

The typical case is when rolling back allocations, on an error path.
For example, with SELinux, the userspace provides the policy, which gets
processed and converted into a policyDB, where every policy maps to
several structures allocated dynamically.

The allocation is not transactional. In case a policy turns out to be
bad/broken, while being interpreted, those structures that were
initially allocated for that policy, must be freed.

Since pmalloc is meant to be a drop in replacement for k/vmalloc, it
needs to provide also pfree.

>  To my mind, a user wants to:
> 
> pmalloc_create();
> pmalloc(); * N
> pmalloc_protect();
> ...
> pmalloc_destroy();

This is the simplest case, but also the error path must be supported.

> I don't mind the pstrdup, pcalloc, pmalloc_array, pzalloc variations, but

All those functions turned out to be necessary when converting SELinux
to pmalloc.
Yes, I haven't published this code yet, but I was hoping to first be
done with pmalloc and then move on to SELinux, which I suspect will be
harder to chew :-/

> I don't know why you need is_pmalloc_object().

Because of hardened usercopy [1]:


On 23/05/17 00:38, Kees Cook wrote:

[...]

> I'd like hardened usercopy to grow knowledge of these
> allocations so we can bounds-check objects. Right now, mm/usercopy.c
> just looks at PageSlab(page) to decide if it should do slab checks. I
> think adding a check for this type of object would be very important
> there.



[1] http://www.openwall.com/lists/kernel-hardening/2017/05/23/17


--
igor
