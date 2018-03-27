Return-Path: <kernel-hardening-return-12752-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtuO+6ZN3fOkf9UR8hlhVdITX2ZNfdmd1HK0aRLplrQ33vQO6+rvF2s5Ss6yyThzKSk2XxZ
ARC-Seal: i=1; a=rsa-sha256; t=1522117899; cv=none;
        d=google.com; s=arc-20160816;
        b=OJZDacI4xx7FC1P5x0V02OaVVTWQlmRsuq2L0rtKFuuQnDu6x10NVtmJ6Ds2/Xipg4
         twjPwEAlu6xs2qX4AgPjtPxbPdHddU0vdkycOM5rzXXfBhJBIYinEHDIFDuZj808N7KP
         WuTaYL+w8BRxRFtENc/NLwRrjCtNP4Xm+QVY+8AwNB8LpCr+K2RglTvYqi8B0PN6vL4H
         xFMNLF4a7fxZQ/eY4po0aEErU4OmTnks52IsKtEPNxQAg7qKYdSFmK7UsYaocQdHH/LW
         APgzRozOppYsNdgjrjuSzhCKw8bcBKzBkC0GUc+02ES6hpyG5Fjy9mPi6dBPA/zI5iJr
         a8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=7WqbcKf8FKJ/scg3+a7Sbgdmx/BCtGikxql+C04k5Uc=;
        b=t0ZWL34BLM4sewMBZXK5x+zxf6lHkXOVz6MSqy3AuczN3D6jPXXcr9G0TicD4FNCtG
         Mkek6/VNxxclp7GyqHvPyEgoYJidbGtB9LwM1BQaqXb2kCAVR3VUIMItutjeef1WOcCd
         4lMi261XWjR32BVIQzymuWbuoCzSOjDbYpQQ1Fy5MSETatFcRf/oXkguTd+v3RjmDUs9
         DbqPPdcNfIVfAVCBxx56LxYBh+3TcRdw0cR0e2ISYH7hSVQzIX/xQSHpzS8SzNi82yLZ
         s4PC9dK4Zjk79KqthTcHrVusbGaBDjc3wotNEdulXbJgRIejx0zi5aPeWGtlsv1pxnpb
         2OTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=pzH8LKYR;
       spf=pass (google.com: domain of kernel-hardening-return-12752-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12752-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=pzH8LKYR;
       spf=pass (google.com: domain of kernel-hardening-return-12752-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12752-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 26 Mar 2018 19:31:10 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: keescook@chromium.org, mhocko@kernel.org, david@fromorbit.com,
	rppt@linux.vnet.ibm.com, labbott@redhat.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	igor.stoppa@gmail.com
Subject: Re: [PATCH 3/6] Protectable Memory
Message-ID: <20180327023110.GD10054@bombadil.infradead.org>
References: <20180327015524.14318-1-igor.stoppa@huawei.com>
 <20180327015524.14318-4-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327015524.14318-4-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596054126767530056?=
X-GMAIL-MSGID: =?utf-8?q?1596056298592386312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 04:55:21AM +0300, Igor Stoppa wrote:
> +static inline void *pmalloc_array_align(struct pmalloc_pool *pool,
> +					size_t n, size_t size,
> +					short int align_order)
> +{

You're missing:

        if (size != 0 && n > SIZE_MAX / size)
                return NULL;

> +	return pmalloc_align(pool, n * size, align_order);
> +}

> +static inline void *pcalloc_align(struct pmalloc_pool *pool, size_t n,
> +				  size_t size, short int align_order)
> +{
> +	return pzalloc_align(pool, n * size, align_order);
> +}

Ditto.

> +static inline void *pcalloc(struct pmalloc_pool *pool, size_t n,
> +			    size_t size)
> +{
> +	return pzalloc_align(pool, n * size, PMALLOC_ALIGN_DEFAULT);
> +}

If you make this one:

	return pcalloc_align(pool, n, size, PMALLOC_ALIGN_DEFAULT)

then you don't need the check in this function.

Also, do we really need 'align' as a parameter to the allocator functions
rather than to the pool?

I'd just reuse ARCH_KMALLOC_MINALIGN from slab.h as the alignment, and
then add the special alignment options when we have a real user for them.
