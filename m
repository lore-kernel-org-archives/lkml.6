Return-Path: <kernel-hardening-return-12591-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtR7x/0VTUObutPLdOZNvkKN3msW+72Og+ULCa7vNAhZNjBPijd+LZhRAvFIKfc0Afmw+RJ
ARC-Seal: i=1; a=rsa-sha256; t=1521032592; cv=none;
        d=google.com; s=arc-20160816;
        b=ZInkd76PT6oIRguCNCdEQnPJKWXaGfzCr/osCJ3B8l1BbGEzrp0YrVnkhcDwWlM/L2
         clXQKQyiEyCM6PFvp7wn/Xu0V+GBKnFqJi9u+bHOQnW036ppXwIFccPEyQq7nYqX4TzC
         Q7rbNyQPesssnlcb5X+KQ0x6vqAVz8dZDyDEdTTVFl9xZyhzD1MJXIqyGuLX9BxElsrd
         cIKBy7gV9FLoyVL98xbAJYj+DPVGZbjw2YieSMGsNRQ/9MKtSDL5SK4vflmzmsxxNdWY
         OpHhDEqyPrcNF7mXIfqms1f/bSJggpCd4piqKUH8pL0w/dnxUCEcIbm1Vu/nIZISrNb3
         mPeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=DvpnaiKAkZ5u4o0hy/Vw4uU9MPGyeESEcQ3LEDJ47/w=;
        b=0oMYgOTVI+9OdFqbZrWLsCOYL3X8TRbtV3leaogUszzlOdp/K6D2DyegOaS0KnpEXN
         L2JFX6HJ++P2TGS1ojehMk8+h839OYlSFzRloDkyc+5+h1UkfZwhOxzov/vBh2tEHCj3
         dzg8YBABqp8rK08baVnq6kxU3mY2GeJxLCaNfoOGLjRq5u8DSUkhsvaKI+ajrdPznljh
         DYe+dTklW/LUJmsyJ3bgb5EeoiCfO94W3kRp/Nw5elaLzrUffsEIZrCQ993uCzMhcIX4
         V2Tm72Nc2Dgua2yMj4uHh0KsCx+pEkkDXLrOVc4Y87d5KZZdqMmeiLnm6bXyZTCVvVL6
         Mj7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12591-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12591-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12591-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12591-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH 5/8] Protectable Memory
To: Matthew Wilcox <willy@infradead.org>
CC: <david@fromorbit.com>, <rppt@linux.vnet.ibm.com>, <keescook@chromium.org>,
	<mhocko@kernel.org>, <labbott@redhat.com>,
	<linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <kernel-hardening@lists.openwall.com>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <20180313214554.28521-6-igor.stoppa@huawei.com>
 <20180314121547.GE29631@bombadil.infradead.org>
From: Igor Stoppa <igor.stoppa@huawei.com>
Message-ID: <eb9bc944-b1de-48d9-652f-9f898ec4fcec@huawei.com>
Date: Wed, 14 Mar 2018 15:02:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314121547.GE29631@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.225.51]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860899667726963?=
X-GMAIL-MSGID: =?utf-8?q?1594918271840478288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 14/03/18 14:15, Matthew Wilcox wrote:
> On Tue, Mar 13, 2018 at 11:45:51PM +0200, Igor Stoppa wrote:
>> +static inline void *pmalloc_array(struct gen_pool *pool, size_t n,
>> +				  size_t size, gfp_t flags)
>> +{
>> +	if (unlikely(!(pool && n && size)))
>> +		return NULL;
> 
> Why not use the same formula as kvmalloc_array here?  You've failed to
> protect against integer overflow, which is the whole point of pmalloc_array.
> 
> 	if (size != 0 && n > SIZE_MAX / size)
> 		return NULL;


oops :-(

>> +static inline char *pstrdup(struct gen_pool *pool, const char *s, gfp_t gfp)
>> +{
>> +	size_t len;
>> +	char *buf;
>> +
>> +	if (unlikely(pool == NULL || s == NULL))
>> +		return NULL;
> 
> No, delete these checks.  They'll mask real bugs.

I thought I got rid of all of them, but some have escaped me

>> +static inline void pfree(struct gen_pool *pool, const void *addr)
>> +{
>> +	gen_pool_free(pool, (unsigned long)addr, 0);
>> +}
> 
> It's poor form to use a different subsystem's type here.  It ties you
> to genpool, so if somebody wants to replace it, you have to go through
> all the users and change them.  If you use your own type, it's a much
> easier task.

I thought about it, but typedef came to my mind and knowing it's usually
frowned upon, I restrained myself.

> struct pmalloc_pool {
> 	struct gen_pool g;
> }

I didn't think this could be acceptable either. But if it is, then ok.

> then:
> 
> static inline void pfree(struct pmalloc_pool *pool, const void *addr)
> {
> 	gen_pool_free(&pool->g, (unsigned long)addr, 0);
> }
> 
> Looking further down, you could (should) move the contents of pmalloc_data
> into pmalloc_pool; that's one fewer object to keep track of.
> 
>> +struct pmalloc_data {
>> +	struct gen_pool *pool;  /* Link back to the associated pool. */
>> +	bool protected;     /* Status of the pool: RO or RW. */
>> +	struct kobj_attribute attr_protected; /* Sysfs attribute. */
>> +	struct kobj_attribute attr_avail;     /* Sysfs attribute. */
>> +	struct kobj_attribute attr_size;      /* Sysfs attribute. */
>> +	struct kobj_attribute attr_chunks;    /* Sysfs attribute. */
>> +	struct kobject *pool_kobject;
>> +	struct list_head node; /* list of pools */
>> +};
> 
> sysfs attributes aren't free, you know.  I appreciate you want something
> to help debug / analyse, but having one file for the whole subsystem or
> at least one per pool would be a better idea.

Which means that it should not be normal sysfs, but rather debugfs, if I
understand correctly, since in sysfs 1 value -> 1 file.

--
igor
