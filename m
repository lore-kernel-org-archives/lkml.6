Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ACAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FA120659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FA120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIFBkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 21:40:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38754 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIFBkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 21:40:18 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AD908D84;
        Wed,  5 Sep 2018 21:08:19 +0000 (UTC)
Date:   Wed, 5 Sep 2018 14:08:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 3/3] mm: don't miss the last page because of
 round-off error
Message-Id: <20180905140818.c2120d25eba0baef90a84ed2@linux-foundation.org>
In-Reply-To: <20180829213311.GA13501@castle>
References: <20180827162621.30187-1-guro@fb.com>
        <20180827162621.30187-3-guro@fb.com>
        <20180827140432.b3c792f60235a13739038808@linux-foundation.org>
        <20180829213311.GA13501@castle>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 14:33:19 -0700 Roman Gushchin <guro@fb.com> wrote:

> >From d8237d3df222e6c5a98a74baa04bc52edf8a3677 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 29 Aug 2018 14:14:48 -0700
> Subject: [PATCH] math64: prevent double calculation of DIV64_U64_ROUND_UP()
>  arguments
> 
> Cause the DIV64_U64_ROUND_UP(ll, d) macro to cache
> the result of (d) expression in a local variable to
> avoid double calculation, which might bring unexpected
> side effects.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/math64.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/math64.h b/include/linux/math64.h
> index 94af3d9c73e7..bb2c84afb80c 100644
> --- a/include/linux/math64.h
> +++ b/include/linux/math64.h
> @@ -281,6 +281,7 @@ static inline u64 mul_u64_u32_div(u64 a, u32 mul, u32 divisor)
>  }
>  #endif /* mul_u64_u32_div */
>  
> -#define DIV64_U64_ROUND_UP(ll, d)	div64_u64((ll) + (d) - 1, (d))
> +#define DIV64_U64_ROUND_UP(ll, d)	\
> +	({ u64 _tmp = (d); div64_u64((ll) + _tmp - 1, _tmp); })
>  
>  #endif /* _LINUX_MATH64_H */

Does it have to be done as a macro?  A lot of these things are
implemented as nice inline C functions.

Also, most of these functions and macros return a value whereas
DIV64_U64_ROUND_UP() does not.  Desirable?

(And we're quite pathetic about documenting what those return values
_are_, which gets frustrating for the poor schmucks who sit here
reviewing code all day).

