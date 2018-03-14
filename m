Return-Path: <kernel-hardening-return-12585-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvej45hD/nUWVQeNmN2kDbhofgACLjoi/Ycn1Y3ZLjQWv3OTInpNqiSBxaN4BZz6MVQ8IBp
ARC-Seal: i=1; a=rsa-sha256; t=1521029770; cv=none;
        d=google.com; s=arc-20160816;
        b=kVVHHfokHlROfLcufrOJ2ZyaFmX7Gdnjz7kS5QTDk+Ik3gAHkBMYfim0bKdHYk6S4b
         xw2IMtPRRNU0cA4yDCtxsTG7szb1CWUCv2iLtU4Oo+aSy7i9H7e7VfOo5LKBNLpiFGHz
         mtmh72WDKejvjRu5bplQflWq8z4XjvHDqKJI0fjC6v2+bnH06VrI085fkLLpjg9Dsycy
         BR5m0UvaaWz5DuGl7GXwtKAIJr9h7eaKRkbRqwd9CDxS6UDI3ZZ+xhO5HAtMDPzzsUr/
         97zXViANPPUrS/eC5bKv50+SOrvsZaMZ993QJ9DcnUT2jtw3xV8GyyI8xl7ChCNGQ01t
         Sd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=4RcB5opToOTjBfpwRtWY0BVmjWMZTf51PaMJtYONIJY=;
        b=qTCraIwn3PNZ5f9R6irzyyxdqxIbvYYzmNHLWQuveM43IMH4JmGYZYRvf0oLACBUgs
         y3E7+D/D8fplkpHmaQ4fXxiOa/5iuWGJ7IzVNy+c0PuiBtue/iQP036mHNHUmADF8Yat
         1u58TBwXUYCr8eKtUW3AcFllar6tR3W/JbwJIvGyJSbS/ShHxI0S8zOAN05UKpGH+H2d
         F6Dy7VQxFZbi+fsnUOm28sXCvc5npKICNUHbXCAeyfF0DNyQDD8Xv3JQnioCtpkZONBK
         j9z4RbBBE/SJ/yNhmbIYO4MmRQb3wh0XE+Hin0d2G6folhUZAwFE7AEk5oDZyc7gKJia
         6z9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=mQfec3Dj;
       spf=pass (google.com: domain of kernel-hardening-return-12585-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12585-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=mQfec3Dj;
       spf=pass (google.com: domain of kernel-hardening-return-12585-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12585-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Mar 2018 05:15:47 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: david@fromorbit.com, rppt@linux.vnet.ibm.com, keescook@chromium.org,
	mhocko@kernel.org, labbott@redhat.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 5/8] Protectable Memory
Message-ID: <20180314121547.GE29631@bombadil.infradead.org>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <20180313214554.28521-6-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313214554.28521-6-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860899667726963?=
X-GMAIL-MSGID: =?utf-8?q?1594915312200706422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 11:45:51PM +0200, Igor Stoppa wrote:
> +static inline void *pmalloc_array(struct gen_pool *pool, size_t n,
> +				  size_t size, gfp_t flags)
> +{
> +	if (unlikely(!(pool && n && size)))
> +		return NULL;

Why not use the same formula as kvmalloc_array here?  You've failed to
protect against integer overflow, which is the whole point of pmalloc_array.

	if (size != 0 && n > SIZE_MAX / size)
		return NULL;

> +static inline char *pstrdup(struct gen_pool *pool, const char *s, gfp_t gfp)
> +{
> +	size_t len;
> +	char *buf;
> +
> +	if (unlikely(pool == NULL || s == NULL))
> +		return NULL;

No, delete these checks.  They'll mask real bugs.

> +static inline void pfree(struct gen_pool *pool, const void *addr)
> +{
> +	gen_pool_free(pool, (unsigned long)addr, 0);
> +}

It's poor form to use a different subsystem's type here.  It ties you
to genpool, so if somebody wants to replace it, you have to go through
all the users and change them.  If you use your own type, it's a much
easier task.

struct pmalloc_pool {
	struct gen_pool g;
}

then:

static inline void pfree(struct pmalloc_pool *pool, const void *addr)
{
	gen_pool_free(&pool->g, (unsigned long)addr, 0);
}

Looking further down, you could (should) move the contents of pmalloc_data
into pmalloc_pool; that's one fewer object to keep track of.

> +struct pmalloc_data {
> +	struct gen_pool *pool;  /* Link back to the associated pool. */
> +	bool protected;     /* Status of the pool: RO or RW. */
> +	struct kobj_attribute attr_protected; /* Sysfs attribute. */
> +	struct kobj_attribute attr_avail;     /* Sysfs attribute. */
> +	struct kobj_attribute attr_size;      /* Sysfs attribute. */
> +	struct kobj_attribute attr_chunks;    /* Sysfs attribute. */
> +	struct kobject *pool_kobject;
> +	struct list_head node; /* list of pools */
> +};

sysfs attributes aren't free, you know.  I appreciate you want something
to help debug / analyse, but having one file for the whole subsystem or
at least one per pool would be a better idea.
