Return-Path: <kernel-hardening-return-12143-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtvaJswZUfNT7NLoNxsHye+HiQ7v6L0pF5KK0aATWaA1HZ5RNX+mzdW/lQNlTC23JhRkA2C
ARC-Seal: i=1; a=rsa-sha256; t=1520345623; cv=none;
        d=google.com; s=arc-20160816;
        b=GoWyRnIaw2F4p8LCuo+a4vUROrgDFMFcxof6c8x39RIVo/z2P5fr7V7vsRfoSscH+e
         j6LMS8EGoCYOoNIe5z0GlF+YE1ABLU8b2zBczgv0zhaSVgrTrfHbGEil/LhYtT8TwcQn
         QxwDQ5MRpoI7DOKBBdjQV0uXCgV5bmhA7HKoLisdCt7vvZZhLFCFUUGBmQ9xQJGsjSki
         PtfFZcbRE29gFhMpUcIJZOmymiPAbXKRwra2qP/+DdzVCaXXu3JDJXroj4N+47zyJtKq
         TNy2KPlxejx5MMdpCf7XWGt72mvgn6McA4rFMYCGAK4cruJm25kpxkppgvLNjAFnACiS
         fl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=2amBYKcAx8K9nWSqnBcHWVsmu2cPISa7Ft3/2GRdJpU=;
        b=BJqBcZefrOmGfKCwA3UAuv8bI0yzZEqwrpBg+r3przNCkTTBiFx4uxoZlixeOGvPyF
         DWvGDGlbyzuYMsPRT4/pTr3b5dnt7JTck55nGApbuhn1byqxAC5HoSPIJbLUclqtzKoy
         Iy2bPi/IfvwOv1a1xVWjS8xYIhFgOyQn2z4o20IGuh5tn3Ced9E65Fh9vD/oXjCWU2Lo
         CgU4Qkgv01cKka2g0x2rwnk7TwmpTnMyYfU34LchexNYwXDwt8rnUQbZqXO2JswHnyTQ
         cRt0DMk81q1wLOhim6vABJ91SiW2ZuGBgmB9imVrtruTetRF4CHGi41psjTn1hj1RDdU
         Z0kw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=JMAtVyCa;
       spf=pass (google.com: domain of kernel-hardening-return-12143-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12143-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=JMAtVyCa;
       spf=pass (google.com: domain of kernel-hardening-return-12143-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12143-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 6 Mar 2018 06:13:17 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, david@fromorbit.com,
	keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 1/7] genalloc: track beginning of allocations
Message-ID: <20180306141317.GC13722@bombadil.infradead.org>
References: <20180228200620.30026-1-igor.stoppa@huawei.com>
 <20180228200620.30026-2-igor.stoppa@huawei.com>
 <20180306131856.GD19349@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306131856.GD19349@rapoport-lnx>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676614912638441?=
X-GMAIL-MSGID: =?utf-8?q?1594197932117026165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 02:19:03PM +0100, Mike Rapoport wrote:
> > +/**
> > + * gen_pool_create() - create a new special memory pool
> > + * @min_alloc_order: log base 2 of number of bytes each bitmap entry
> > + *		     represents
> > + * @nid: node id of the node the pool structure should be allocated on,
> > + *	 or -1
> > + *
> > + * Create a new special memory pool that can be used to manage special
> > + * purpose memory not managed by the regular kmalloc/kfree interface.
> > + *
> > + * Return:
> > + * * pointer to the pool	- success
> > + * * NULL			- otherwise
> > + */
> 
> If I'm not mistaken, several kernel-doc descriptions are duplicated now.
> Can you please keep a single copy? ;-)

I think the problem is that Igor has chosen to put the kernel-doc with
the function declaration.  I think we usually recommend putting it with
the definition so it's more likely to be updated.
