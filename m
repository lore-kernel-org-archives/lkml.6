Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE521C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8731F20870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 12:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cbpNXjKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfALMVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 07:21:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47480 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbfALMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 07:21:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Ay3EY0rSIoOGjPxxniknja2l2jepTyF7hYwlc9x/Bk=; b=cbpNXjKQYJgS7cylfkfy8ZEe6
        orr84Ondn8Gq/JvgBL7ErIG1jsxc1qZu+cqu93Arf3pMIQAz8hMah+sSFubavoeOGmU7S6+ehqwnu
        7zHdZ/HBI/xWBnRC+7zQOBqcvFYP/9nq8m7HlLbnzHTq6YEnACn+hOi2wa0Ap1qPq+02cQWwxlr4m
        58PbNkXMGEMUl7XpNJ5HVcFMo3Gr6SsbMcdx99ujeoTDzUfPhdsEOEGhYIM8P+OLD9SRDEG8g0S1g
        tx8CSnlpa2GJoEpQqvYv1yc+l16rkPVWxZtdomKIccywzQV3FF/MM1l7ChumC+Q8Uk/oMwGsRpUNL
        lySIHrEmA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giIHp-0008BR-G4; Sat, 12 Jan 2019 12:21:13 +0000
Date:   Sat, 12 Jan 2019 04:21:13 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     rostedt@goodmis.org, linux@armlinux.org.uk, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190112122113.GR6310@bombadil.infradead.org>
References: <20190112065701.30841-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112065701.30841-1-changbin.du@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2019 at 02:57:01PM +0800, Changbin Du wrote:
> This patch adds a new trace option 'funcgraph-retval' and is disabled by
> default. When this option is enabled, fgraph tracer will show the return
> value of each function. This is useful to find/analyze a original error
> source in a call graph.
> 
> One limitation is that kernel doesn't know the prototype of functions. So
> fgraph assumes all functions have a retvalue of type int. You must ignore
> the value of *void* function. And if the retvalue looks like an error code
> then both hexadecimal and decimal number are displayed.

I don't think we can do this.  You're leaking a _lot_ of kernel addresses
this way, and we've been trying very hard to avoid doing that because
it gives a lot of information to attackers.

Something more clever that prints out only errors (ie IS_ERR_VALUE())
might be acceptable.  I would think printing return values that are
between 0 and 4095 should also be OK since they can't be real pointers.
We'd leak whether a function called kmalloc(0, x) since that returns
16, but that seems like a not-very-useful information leak.

>  3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
>  3)               |    kvm_arch_vcpu_create() {
>  3)               |      vmx_create_vcpu() {
>  3) + 17.969 us   |        kmem_cache_alloc(); /* ret=0xffff88813a980040 */
>  3) + 15.948 us   |        kmem_cache_alloc(); /* ret=0xffff88813aa99200 */
>  3)   0.653 us    |        allocate_vpid.part.88(); /* ret=0x1 */
>  3)   6.964 us    |        kvm_vcpu_init(); /* ret=0xfffffffb */
>  3)   0.323 us    |        free_vpid.part.89(); /* ret=0x1 */
>  3)   9.985 us    |        kmem_cache_free(); /* ret=0x80000000 */
>  3)   9.491 us    |        kmem_cache_free(); /* ret=0x80000000 */
>  3) + 69.858 us   |      } /* ret=0xfffffffffffffffb/-5 */
>  3) + 70.631 us   |    } /* ret=0xfffffffffffffffb/-5 */
>  3)               |    mutex_lock() {
>  3)               |      _cond_resched() {
>  3)   0.199 us    |        rcu_all_qs(); /* ret=0x80000000 */
>  3)   0.594 us    |      } /* ret=0x0 */
>  3)   1.067 us    |    } /* ret=0x0 */
>  3)   0.337 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
>  3) + 92.730 us   |  } /* ret=0xfffffffffffffffb/-5 */
