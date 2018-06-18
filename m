Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8659FC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4339020693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 18:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4339020693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935996AbeFRSwa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 14:52:30 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:42507 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935677AbeFRSw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 14:52:28 -0400
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1414.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Mon, 18 Jun 2018 18:51:49 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Mon, 18
 Jun 2018 11:51:54 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Mon, 18 Jun
 2018 11:51:54 -0700
Date:   Mon, 18 Jun 2018 11:51:41 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>, <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180618185141.yvkrsbdi2gbxjxj7@pburton-laptop>
References: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1529042858-9483-1-git-send-email-chenhc@lemote.com>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1529347894-531716-5145-161145-2
X-BESS-VER: 2018.7-r1806151722
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.194166
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: chenhc@lemote.com,paulmck@linux.vnet.ibm.com,luc.maranget@inria.fr,j.alglave@ucl.ac.uk,dhowells@redhat.com,npiggin@gmail.com,boqun.feng@gmail.com,peterz@infradead.org,will.deacon@arm.com,andrea.parri@amarulasolutions.com,stern@rowland.harvard.edu,stable@vger.kernel.org,chenhuacai@gmail.com,wuzhangjin@gmail.com,zhangfx@lemote.com,linux-mips@linux-mips.org,ralf@linux-mips.org,akiyks@gmail.com,linux-kernel@vger.kernel.org
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

On Fri, Jun 15, 2018 at 02:07:38PM +0800, Huacai Chen wrote:
> After commit 7f56b58a92aaf2c ("locking/mcs: Use smp_cond_load_acquire()
> in MCS spin loop") Loongson-3 fails to boot. This is because Loongson-3
> has SFB (Store Fill Buffer) and READ_ONCE() may get an old value in a
> tight loop. So in smp_cond_load_acquire() we need a __smp_mb() after
> every READ_ONCE().

Thanks - modifying smp_cond_load_acquire() is a step better than
modifying arch_mcs_spin_lock_contended() to avoid it, but I'm still not
sure we've reached the root of the problem. If tight loops using
READ_ONCE() are at fault then what's special about
smp_cond_load_acquire()? Could other such loops not hit the same
problem?

Is the scenario you encounter the same as that outlined in the "DATA
DEPENDENCY BARRIERS (HISTORICAL)" section of
Documentation/memory-barriers.txt by any chance? If so then perhaps it
would be better to implement smp_read_barrier_depends(), or just raw
read_barrier_depends() depending upon how your SFB functions.

Is there any public documentation describing the behaviour of the store
fill buffer in Loongson-3?

Part of the problem is that I'm still not sure what's actually happening
in your system - it would be helpful to have further information in the
commit message about what actually happens. For example if you could
walk us through an example of the problem step by step in the style of
the diagrams you'll see in Documentation/memory-barriers.txt then I
think that would help us to see what the best solution here is.

I've copied the LKMM maintainers in case they have further input.

Thanks,
    Paul

> This patch introduce a Loongson-specific smp_cond_load_acquire(). And
> it should be backported to as early as linux-4.5, in which release the
> smp_cond_acquire() is introduced.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/barrier.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
> index a5eb1bb..4ea384d 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -222,6 +222,23 @@
>  #define __smp_mb__before_atomic()	__smp_mb__before_llsc()
>  #define __smp_mb__after_atomic()	smp_llsc_mb()
>  
> +#ifdef CONFIG_CPU_LOONGSON3
> +/* Loongson-3 need a __smp_mb() after READ_ONCE() here */
> +#define smp_cond_load_acquire(ptr, cond_expr)			\
> +({								\
> +	typeof(ptr) __PTR = (ptr);				\
> +	typeof(*ptr) VAL;					\
> +	for (;;) {						\
> +		VAL = READ_ONCE(*__PTR);			\
> +		__smp_mb();					\
> +		if (cond_expr)					\
> +			break;					\
> +		cpu_relax();					\
> +	}							\
> +	VAL;							\
> +})
> +#endif	/* CONFIG_CPU_LOONGSON3 */
> +
>  #include <asm-generic/barrier.h>
>  
>  #endif /* __ASM_BARRIER_H */
> -- 
> 2.7.0
> 
