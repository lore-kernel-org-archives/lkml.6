Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F8C2173D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 04:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F8C2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbeH0HtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 03:49:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44358 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeH0HtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 03:49:18 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fu8lL-0002mA-Pu; Mon, 27 Aug 2018 04:04:23 +0000
Date:   Mon, 27 Aug 2018 05:04:23 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
Message-ID: <20180827040423.GB6515@ZenIV.linux.org.uk>
References: <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <20180826173236.GU6515@ZenIV.linux.org.uk>
 <d31fe59160e0b7d40e09536a3c74619ebb1f3b13.camel@perches.com>
 <20180826212421.GW6515@ZenIV.linux.org.uk>
 <eca48539a3dede3bfaed9ab9a6c06794cf8160e0.camel@perches.com>
 <20180826224322.GX6515@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1808262159430.2528@hadrien>
 <20180827023526.GA6515@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1808262319000.2295@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1808262319000.2295@hadrien>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 26, 2018 at 11:35:17PM -0400, Julia Lawall wrote:

> * x = \(kmalloc\|kzalloc\|devm_kmalloc\|devm_kzalloc\)(...)

I can name several you've missed right off the top of my head -
vmalloc, kvmalloc, kmem_cache_alloc, kmem_cache_zalloc, variants
with _trace slapped on, and that is not to mention the things like
get_free_page or

void *my_k3wl_alloc(u64 n) // 'cause all artificial limits suck, that's why
{
	lots and lots of home-grown stats collection
	some tracepoints thrown in just for fun
	return kmalloc(n);
}

(and no, I'm not implying that net/sched folks had done anything of that
sort; I have seen that and worse in drivers, though)

> The * at the beginning of the line means to highlight what you are looking
> for, which is done by making a diff in which the highlighted line
> appears to be removed.

Umm...  Does that cover return, BTW?  Or something like
	T *barf;
	extern void foo(T *p);
	foo(kmalloc(sizeof(*barf)));


> The limitation is the ability to figure out the type of x.  If it is a
> local variable, Coccinelle should have no problem.  If it is a structure
> field, it may be necessary to provide command line arguments like
> 
> --all-includes --include-headers-for-types
> 
> --all-includes means to try to find all include files that are mentioned
> in the .c file.  The next stronger option is --recursive includes, which
> means include what all of the mentioned files include as well,
> recursively.  This tends to cause a major performance hit, because a lot
> of code is being parsed.  --include-headers-for-types heals a bit with
> that, as it only considers the header files when computing type
> information, and now when applying the rules.
> 
> With respect to ifdefs around variable declarations and structure field
> declaration, in these cases Coccinelle considers that it cannot make the
> ifdef have an if-like control flow, and so if considers the #ifdef, #else
> and #endif to be comments.  Thus it takes into account only the last type
> provided for a given variable.

[snip]

What about several variants of structure definition?  Because ifdefs around
includes do occur in the wild...
