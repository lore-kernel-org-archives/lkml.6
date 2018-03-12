Return-Path: <kernel-hardening-return-12477-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt2is1ceUAlm/oMHw0Lzp4buoI0m6JxzMLLI48th2hPPpXv1HNTZgvHTVWGmV3xHKkMhcVc
ARC-Seal: i=1; a=rsa-sha256; t=1520882020; cv=none;
        d=google.com; s=arc-20160816;
        b=yM18owEfWgMX+Sx/yqQJGjIsstNtlNNdHwkWaWHJG3wHwCyQIZpAZIIxU1X4dVq/Uf
         JFlxWxhBvOs4TdLr4Z4jif0UI5CUfpA+fn3x8CqwMwRWmMY18s4NVASMWNuFy4gqnJvX
         hFwoJ3HZeXbz1lntYO9YvluMtiPlfhOQ1bUtC26SzxPoyVQPFEaKE5B5ql0JIdLHbEBI
         ffoRxePqjXWJfaMhIa5d6I2RmaDV51Yy9pceC16nKkCJpWTOG0y96pC8C67AvUif/DS1
         WKqfBrx3oDJxGsZFZXl6+mTB5Ki4t5W0y1NP6IfFKMK9SPpmXU7NCI1usel+Kw+ZflXv
         IOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=Xr774fbIR7F9Y4EsV8h1ay3LfhlXlQXhyMbsotGqH+0=;
        b=qxhuDhxkcNrTHWDxAzrEoq+SXqlIzpBi9TNWyUude9O7NhFsfs/spbvAmE9tt6ZrZf
         hUM1WL5FF1RMR+g2cMPbL3b7gg8tyBHznyYfU1uJ59DmAe97QIKVAqBlBDpIAKS+P0mE
         pFkqU5WcAVYt0CoHDcfXPL0oDTEwjcBAP8owDo2T2TBxd8/zyD869lGWAZ+HpGCaRuOI
         yOEWjM1RkDiGySSmRi78v3llxZ8prOC30Jh0ltgAfkk9Y5RSYTznNCDpauM119U/ttvf
         /lzfGquMNdaqhgD/Y1HqEeb7xrRKZ+6yvXHApMrPTeuqMkr7Yh+mPq3aRZ0S0LuSq4zv
         ymVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=LkoPlj3l;
       spf=pass (google.com: domain of kernel-hardening-return-12477-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12477-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=LkoPlj3l;
       spf=pass (google.com: domain of kernel-hardening-return-12477-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12477-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 12 Mar 2018 12:13:15 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: david@fromorbit.com, keescook@chromium.org, mhocko@kernel.org,
	labbott@redhat.com, linux-security-module@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 4/7] Protectable Memory
Message-ID: <20180312191314.GA29191@bombadil.infradead.org>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-5-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228200620.30026-5-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676771806146287?=
X-GMAIL-MSGID: =?utf-8?q?1594760385642555807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:06:17PM +0200, Igor Stoppa wrote:
> struct gen_pool *pmalloc_create_pool(const char *name,
> 					 int min_alloc_order);
> int is_pmalloc_object(const void *ptr, const unsigned long n);
> bool pmalloc_prealloc(struct gen_pool *pool, size_t size);
> void *pmalloc(struct gen_pool *pool, size_t size, gfp_t gfp);
> static inline void *pzalloc(struct gen_pool *pool, size_t size, gfp_t gfp)
> static inline void *pmalloc_array(struct gen_pool *pool, size_t n,
> 				  size_t size, gfp_t flags)
> static inline void *pcalloc(struct gen_pool *pool, size_t n,
> 			    size_t size, gfp_t flags)
> static inline char *pstrdup(struct gen_pool *pool, const char *s, gfp_t gfp)
> int pmalloc_protect_pool(struct gen_pool *pool);
> static inline void pfree(struct gen_pool *pool, const void *addr)
> int pmalloc_destroy_pool(struct gen_pool *pool);

Do you have users for all these functions?  I'm particularly sceptical of
pfree().  To my mind, a user wants to:

pmalloc_create();
pmalloc(); * N
pmalloc_protect();
...
pmalloc_destroy();

I don't mind the pstrdup, pcalloc, pmalloc_array, pzalloc variations, but
I don't know why you need is_pmalloc_object().
