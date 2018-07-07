Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC241C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C41222BC1
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C41222BC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbeGGAaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:30:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbeGGAav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:30:51 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97839CE9;
        Sat,  7 Jul 2018 00:30:50 +0000 (UTC)
Date:   Fri, 6 Jul 2018 17:30:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, linux-arm-kernel@lists.infradead.org,
        yamada.masahiro@socionext.com
Subject: Re: [RESEND PATCH v2 3/9] asm-generic: Move some macros from
 linux/bitops.h to a new bits.h file
Message-Id: <20180706173049.e28171504c745934a280dee8@linux-foundation.org>
In-Reply-To: <1529412794-17720-4-git-send-email-will.deacon@arm.com>
References: <1529412794-17720-1-git-send-email-will.deacon@arm.com>
        <1529412794-17720-4-git-send-email-will.deacon@arm.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018 13:53:08 +0100 Will Deacon <will.deacon@arm.com> wrote:

> In preparation for implementing the asm-generic atomic bitops in terms
> of atomic_long_*, we need to prevent asm/atomic.h implementations from
> pulling in linux/bitops.h. A common reason for this include is for the
> BITS_PER_BYTE definition, so move this and some other BIT() and masking
> macros into a new header file, linux/bits.h
> 
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -2,29 +2,9 @@
>  #ifndef _LINUX_BITOPS_H
>  #define _LINUX_BITOPS_H
>  #include <asm/types.h>
> +#include <linux/bits.h>
>  
> -#ifdef	__KERNEL__
> -#define BIT(nr)			(1UL << (nr))
> -#define BIT_ULL(nr)		(1ULL << (nr))
> -#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
> -#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
> -#define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
> -#define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
> -#define BITS_PER_BYTE		8
>  #define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
> -#endif

Why does it leave BITS_TO_LONGS() in place?

That becomes unfortunate with Chris's patch, so I'm moving
BITS_TO_LONGS() into bits.h.


From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: include/linux/bitops.h: introduce BITS_PER_TYPE

net_dim.h has a rather useful extension to BITS_PER_BYTE to compute the
number of bits in a type (BITS_PER_BYTE * sizeof(T)), so promote the macro
to bitops.h, alongside BITS_PER_BYTE, for wider usage.

Link: http://lkml.kernel.org/r/20180706094458.14116-1-chris@chris-wilson.co.uk
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Gospodarek <gospo@broadcom.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/bitops.h  |    3 ++-
 include/linux/net_dim.h |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/linux/bitops.h~bitops-introduce-bits_per_type include/linux/bitops.h
--- a/include/linux/bitops.h~bitops-introduce-bits_per_type
+++ a/include/linux/bitops.h
@@ -11,7 +11,8 @@
 #define BIT_ULL_MASK(nr)	(1ULL << ((nr) % BITS_PER_LONG_LONG))
 #define BIT_ULL_WORD(nr)	((nr) / BITS_PER_LONG_LONG)
 #define BITS_PER_BYTE		8
-#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
+#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
+#define BITS_TO_LONGS(nr)	DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #endif
 
 /*
diff -puN include/linux/net_dim.h~bitops-introduce-bits_per_type include/linux/net_dim.h
--- a/include/linux/net_dim.h~bitops-introduce-bits_per_type
+++ a/include/linux/net_dim.h
@@ -363,7 +363,6 @@ static inline void net_dim_sample(u16 ev
 }
 
 #define NET_DIM_NEVENTS 64
-#define BITS_PER_TYPE(type) (sizeof(type) * BITS_PER_BYTE)
 #define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
 
 static inline void net_dim_calc_stats(struct net_dim_sample *start,
_

