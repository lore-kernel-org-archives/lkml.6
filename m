Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303CEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B7320871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J5tf/UZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B7320871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754646AbeFTJWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:22:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFTJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 05:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mm8B6hvvw2/VNm8h40poQZG0dsa92W6ce82K+9oLdF0=; b=J5tf/UZpExB0n+CuRHIZDz8J5G
        QZjxc7TWh34GfhSehQQxNesnKNoTISy7S7BwVzeevnAswNQC03mivf1jc5Ozyx23heikOh2pxv2Em
        ztP45cjmrggMlFdGdrQvhWvglUjssvgVHPYenZjicpEnwhvm2WPFDf2vLZx/LHzw4VKJZD+jHHCH4
        6BhfjTCvn3KHjE8SKnlySfwtiQxHkZJNDu3N0bbRKbLv/eQSm3FpORmWqUtQ2We5MvvU/cxYw915D
        BGFJI+5906LbwYDIa9K7de/Xtqd8iCZeedwQO0+9IImnd/1fRfW58zG2NeKzHmaZuqBWm9th4VBci
        OllyLKZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fVZJr-00039z-LP; Wed, 20 Jun 2018 09:22:27 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 197BC2029F1DD; Wed, 20 Jun 2018 11:22:26 +0200 (CEST)
Date:   Wed, 20 Jun 2018 11:22:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        AndreaParri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180620092226.GM2476@hirez.programming.kicks-ass.net>
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
 <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
 <tencent_59DC823168EC2F5D42AE44F0@qq.com>
 <20180619072242.GC2494@hirez.programming.kicks-ass.net>
 <tencent_2BF857EC332473814C12A753@qq.com>
 <20180620081715.GA27776@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180620081715.GA27776@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 09:17:16AM +0100, Will Deacon wrote:
> On Wed, Jun 20, 2018 at 11:31:55AM +0800, 陈华才 wrote:
> > Loongson-3's Store Fill Buffer is nearly the same as your "Store Buffer",
> > and it increases the memory ordering weakness. So, smp_cond_load_acquire()
> > only need a __smp_mb() before the loop, not after every READ_ONCE(). In
> > other word, the following code is just OK:
> > 
> > #define smp_cond_load_acquire(ptr, cond_expr)                   \
> > ({                                                              \
> >         typeof(ptr) __PTR = (ptr);                              \
> >         typeof(*ptr) VAL;                                       \
> >         __smp_mb();                                     \
> >         for (;;) {                                              \
> >                 VAL = READ_ONCE(*__PTR);                        \
> >                 if (cond_expr)                                  \
> >                         break;                                  \
> >                 cpu_relax();                                    \
> >         }                                                       \
> >         __smp_mb();                                     \
> >         VAL;                                                    \
> > })
> > 
> > the __smp_mb() before loop is used to avoid "reads prioritised over
> > writes", which is caused by SFB's weak ordering and similar to ARM11MPCore
> > (mentioned by Will Deacon).
> 
> Sure, but smp_cond_load_acquire() isn't the only place you'll see this sort
> of pattern in the kernel. In other places, the only existing arch hook is
> cpu_relax(), so unless you want to audit all loops and add a special
> MIPs-specific smp_mb() to those that are affected, I think your only option
> is to stick it in cpu_relax().
> 
> I assume you don't have a control register that can disable this
> prioritisation in the SFB?

Right, I think we also want to clarify that this 'feature' is not
supported by the Linux kernel in general and LKMM in specific.

It really is a CPU bug. And the cpu_relax() change is a best effort
work-around.
