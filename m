Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4D3C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9445220693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:46:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9445220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754423AbeFTJqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:46:10 -0400
Received: from foss.arm.com ([217.140.101.70]:32844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751337AbeFTI0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:26:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA7615BF;
        Wed, 20 Jun 2018 01:16:40 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE0BB3F246;
        Wed, 20 Jun 2018 01:16:40 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 883C71AE35A5; Wed, 20 Jun 2018 09:17:16 +0100 (BST)
Date:   Wed, 20 Jun 2018 09:17:16 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20180620081715.GA27776@arm.com>
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
 <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
 <tencent_59DC823168EC2F5D42AE44F0@qq.com>
 <20180619072242.GC2494@hirez.programming.kicks-ass.net>
 <tencent_2BF857EC332473814C12A753@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_2BF857EC332473814C12A753@qq.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 11:31:55AM +0800, 陈华才 wrote:
> Loongson-3's Store Fill Buffer is nearly the same as your "Store Buffer",
> and it increases the memory ordering weakness. So, smp_cond_load_acquire()
> only need a __smp_mb() before the loop, not after every READ_ONCE(). In
> other word, the following code is just OK:
> 
> #define smp_cond_load_acquire(ptr, cond_expr)                   \
> ({                                                              \
>         typeof(ptr) __PTR = (ptr);                              \
>         typeof(*ptr) VAL;                                       \
>         __smp_mb();                                     \
>         for (;;) {                                              \
>                 VAL = READ_ONCE(*__PTR);                        \
>                 if (cond_expr)                                  \
>                         break;                                  \
>                 cpu_relax();                                    \
>         }                                                       \
>         __smp_mb();                                     \
>         VAL;                                                    \
> })
> 
> the __smp_mb() before loop is used to avoid "reads prioritised over
> writes", which is caused by SFB's weak ordering and similar to ARM11MPCore
> (mentioned by Will Deacon).

Sure, but smp_cond_load_acquire() isn't the only place you'll see this sort
of pattern in the kernel. In other places, the only existing arch hook is
cpu_relax(), so unless you want to audit all loops and add a special
MIPs-specific smp_mb() to those that are affected, I think your only option
is to stick it in cpu_relax().

I assume you don't have a control register that can disable this
prioritisation in the SFB?

Will
