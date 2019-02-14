Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36466C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A472070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 11:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J91kQpug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393920AbfBNL3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 06:29:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55174 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfBNL3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 06:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8y4n+o9Hv/codggya8emxwNTjOMFoKmC5CMGzEsB5lo=; b=J91kQpug93gfsehaWqBdUaNX7
        zurTZUL4+JzzJoEFzinTvJLUcZjvtAzQUTAW6XGeEyeZYoRxJOdnXrn0XUqSbi8HIRM+3IZy8pve/
        4kk1Edp9RzAsItTLdw/hvdY5AwjqWP7RA9zA76VNIhGGFOPzHzvme8eEmjQia3qP3cNqAzFx/AfE2
        jwORxRGFCJSfSYkvbyGpUcJEvMsu5Ppy/zsm5R1ixltq5pbxTQ21Rkf4JKNFBDb7PHYcO8flecFDK
        896o1MiZPOaSslxF2HapiP0kq3xMZz+S9jbcKGCkhJ5SdRotn11e7eVeiITgcuWxWsGQ2GZKc17nL
        Mn0bIMNOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guFCG-000270-4h; Thu, 14 Feb 2019 11:28:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DADA20298BF7; Thu, 14 Feb 2019 12:28:49 +0100 (CET)
Date:   Thu, 14 Feb 2019 12:28:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Igor Stoppa <igor.stoppa@huawei.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 03/12] __wr_after_init: Core and default arch
Message-ID: <20190214112849.GM32494@hirez.programming.kicks-ass.net>
References: <cover.1550097697.git.igor.stoppa@huawei.com>
 <b99f0de701e299b9d25ce8cfffa3387b9687f5fc.1550097697.git.igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b99f0de701e299b9d25ce8cfffa3387b9687f5fc.1550097697.git.igor.stoppa@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:41:32AM +0200, Igor Stoppa wrote:
> +static inline void *wr_memset(void *p, int c, __kernel_size_t n)
> +{
> +	return memset(p, c, n);
> +}
> +
> +static inline void *wr_memcpy(void *p, const void *q, __kernel_size_t n)
> +{
> +	return memcpy(p, q, n);
> +}
> +
> +#define wr_assign(var, val)	((var) = (val))
> +#define wr_rcu_assign_pointer(p, v)	rcu_assign_pointer(p, v)
> +
> +#else
> +
> +void *wr_memset(void *p, int c, __kernel_size_t n);
> +void *wr_memcpy(void *p, const void *q, __kernel_size_t n);
> +
> +/**
> + * wr_assign() - sets a write-rare variable to a specified value
> + * @var: the variable to set
> + * @val: the new value
> + *
> + * Returns: the variable
> + */
> +
> +#define wr_assign(dst, val) ({			\
> +	typeof(dst) tmp = (typeof(dst))val;	\
> +						\
> +	wr_memcpy(&dst, &tmp, sizeof(dst));	\
> +	dst;					\
> +})
> +
> +/**
> + * wr_rcu_assign_pointer() - initialize a pointer in rcu mode
> + * @p: the rcu pointer - it MUST be aligned to a machine word
> + * @v: the new value
> + *
> + * Returns the value assigned to the rcu pointer.
> + *
> + * It is provided as macro, to match rcu_assign_pointer()
> + * The rcu_assign_pointer() is implemented as equivalent of:
> + *
> + * smp_mb();
> + * WRITE_ONCE();
> + */
> +#define wr_rcu_assign_pointer(p, v) ({	\
> +	smp_mb();			\
> +	wr_assign(p, v);		\
> +	p;				\
> +})

This requires that wr_memcpy() (through wr_assign) is single-copy-atomic
for native types. There is not a comment in sight that states this.

Also, is this true of x86/arm64 memcpy ?
