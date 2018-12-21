Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22837C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BDD21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ix99TSbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391486AbeLUSlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:41:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbeLUSlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vmDgozvoxxSIRUOGhKq2UuDLDvfMVTzCj+7pKkEDXbg=; b=Ix99TSbHuikVh0WQblpZ9xHxd
        oqLcaIZku25DYd0mtjwTedOjN7PF7jJEm9AQmPSJgaLyndQJ9p4CNwwiuOgzvCCfnlyywuFMQBkjo
        CZ+TvmYrbwVbXlEZt8b5O+niZHyhw70SY6e0gzab/Gcomygebf4MQlDWEcF6bF725K7h4g1ne8UG1
        0QT2dmTVPOJ4ZrS6s7i5F55X9CMuY1NCFtqbcdqhickpak+XVBRPbUYjzKQsEZiExMZZTc59sKMRm
        BowES9uI/G5tiGlZjpSMC3ZruXTxCnLu82CsuXEX6m3dQ/1FsTcvJq39eoAYD8g/Zdv2X4bL3f6PP
        u4zNONAPQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaPjc-00022l-F7; Fri, 21 Dec 2018 18:41:20 +0000
Date:   Fri, 21 Dec 2018 10:41:20 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        igor.stoppa@huawei.com, Nadav Amit <nadav.amit@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Ahmed Soliman <ahmedsoliman@mena.vt.edu>,
        linux-integrity@vger.kernel.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/12] __wr_after_init: generic functionality
Message-ID: <20181221184120.GG10600@bombadil.infradead.org>
References: <20181221181423.20455-1-igor.stoppa@huawei.com>
 <20181221181423.20455-4-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221181423.20455-4-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 08:14:14PM +0200, Igor Stoppa wrote:
> +static inline int memtst(void *p, int c, __kernel_size_t len)

I don't understand why you're verifying that writes actually happen
in production code.  Sure, write lib/test_wrmem.c or something, but
verifying every single rare write seems like a mistake to me.

> +#ifndef CONFIG_PRMEM

So is this PRMEM or wr_mem?  It's not obvious that CONFIG_PRMEM controls
wrmem.

> +#define wr_assign(var, val)	((var) = (val))

The hamming distance between 'var' and 'val' is too small.  The convention
in the line immediately below (p and v) is much more readable.

> +#define wr_rcu_assign_pointer(p, v)	rcu_assign_pointer(p, v)
> +#define wr_assign(var, val) ({			\
> +	typeof(var) tmp = (typeof(var))val;	\
> +						\
> +	wr_memcpy(&var, &tmp, sizeof(var));	\
> +	var;					\
> +})

Doesn't wr_memcpy return 'var' anyway?

> +/**
> + * wr_memcpy() - copyes size bytes from q to p

typo

> + * @p: beginning of the memory to write to
> + * @q: beginning of the memory to read from
> + * @size: amount of bytes to copy
> + *
> + * Returns pointer to the destination

> + * The architecture code must provide:
> + *   void __wr_enable(wr_state_t *state)
> + *   void *__wr_addr(void *addr)
> + *   void *__wr_memcpy(void *p, const void *q, __kernel_size_t size)
> + *   void __wr_disable(wr_state_t *state)

This section shouldn't be in the user documentation of wr_memcpy().

> + */
> +void *wr_memcpy(void *p, const void *q, __kernel_size_t size)
> +{
> +	wr_state_t wr_state;
> +	void *wr_poking_addr = __wr_addr(p);
> +
> +	if (WARN_ONCE(!wr_ready, "No writable mapping available") ||

Surely not.  If somebody's called wr_memcpy() before wr_ready is set,
that means we can just call memcpy().

