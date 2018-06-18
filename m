Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4312C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C5520864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C5520864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755184AbeFRPyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:54:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754974AbeFRPyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:54:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 172181529;
        Mon, 18 Jun 2018 08:54:05 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DBBCD3F557;
        Mon, 18 Jun 2018 08:54:04 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 456611AE10A0; Mon, 18 Jun 2018 16:54:40 +0100 (BST)
Date:   Mon, 18 Jun 2018 16:54:40 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, mingo@kernel.org,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCHv3 09/18] atomics/alpha: define atomic64_fetch_add_unless()
Message-ID: <20180618155439.GD11612@arm.com>
References: <20180618101919.51973-1-mark.rutland@arm.com>
 <20180618101919.51973-10-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618101919.51973-10-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:19:10AM +0100, Mark Rutland wrote:
> As a step towards unifying the atomic/atomic64/atomic_long APIs, this
> patch converts the arch/alpha implementation of atomic64_add_unless() into
> an implementation of atomic64_fetch_add_unless().
> 
> A wrapper in <linux/atomic.h> will build atomic_add_unless() atop of
> this, provided it is given a preprocessor definition.
> 
> No functional change is intended as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/include/asm/atomic.h | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
> index 4a800a3424a3..dcb7bbeeae02 100644
> --- a/arch/alpha/include/asm/atomic.h
> +++ b/arch/alpha/include/asm/atomic.h
> @@ -238,35 +238,36 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  #define atomic_fetch_add_unless atomic_fetch_add_unless
>  
>  /**
> - * atomic64_add_unless - add unless the number is a given value
> + * atomic64_fetch_add_unless - add unless the number is a given value
>   * @v: pointer of type atomic64_t
>   * @a: the amount to add to v...
>   * @u: ...unless v is equal to u.
>   *
>   * Atomically adds @a to @v, so long as it was not @u.
> - * Returns true iff @v was not @u.
> + * Returns the old value of @v.
>   */
> -static __inline__ int atomic64_add_unless(atomic64_t *v, long a, long u)
> +static __inline__ int atomic64_fetch_add_unless(atomic64_t *v, long a, long u)

Don't you want a 64-bit return type (e.g. long) here?

Will
