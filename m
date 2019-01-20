Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E87BC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7648C20883
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 00:01:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfATABq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 19:01:46 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46944 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729803AbfATABq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 19:01:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0327CA78;
        Sat, 19 Jan 2019 16:01:46 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A9743F6A8;
        Sat, 19 Jan 2019 16:01:43 -0800 (PST)
Date:   Sun, 20 Jan 2019 00:01:40 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Florian La Roche <florian.laroche@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, Crt Mori <cmo@melexis.com>,
        Joe Perches <joe@perches.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fix int_sqrt() for very large numbers
Message-ID: <20190120000138.GI26876@brain-police>
References: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119151450.26879-1-Florian.LaRoche@googlemail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 04:14:50PM +0100, Florian La Roche wrote:
> If an input number x for int_sqrt() has the highest bit set, then
> __ffs(x) is 64. (1UL << 64) is an overflow and breaks the algorithm.

This is confusing, because the patch doesn't go near an __ffs().

> Just subtracting 1 is an even better guess for the initial
> value of m and that's what also used to be done in earlier
> versions of this code.
> 
> best regards,
> 
> Florian La Roche
> 
> Signed-off-by: Florian La Roche <Florian.LaRoche@googlemail.com>
> ---
>  lib/int_sqrt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
> index 14436f4ca6bd..ea00e84dc272 100644
> --- a/lib/int_sqrt.c
> +++ b/lib/int_sqrt.c
> @@ -23,7 +23,7 @@ unsigned long int_sqrt(unsigned long x)
>  	if (x <= 1)
>  		return x;
>  
> -	m = 1UL << (__fls(x) & ~1UL);
> +	m = 1UL << ((__fls(x) - 1) & ~1UL);

I think this one is fine, because __fls() gives you back 0-63 (or
undefined, but the previous <= 1 check handles that case).

>  	while (m != 0) {
>  		b = y + m;
>  		y >>= 1;
> @@ -52,7 +52,7 @@ u32 int_sqrt64(u64 x)
>  	if (x <= ULONG_MAX)
>  		return int_sqrt((unsigned long) x);
>  
> -	m = 1ULL << (fls64(x) & ~1ULL);
> +	m = 1ULL << ((fls64(x) - 1) & ~1ULL);

This just looks like a copy-paste error because there isn't an __fls64().
But I think your suggestion here is ok, given the previous check against
ULONG_MAX.

Will
