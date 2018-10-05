Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70326C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB6320834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB6320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbeJEM5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 08:57:36 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37345 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeJEM5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 08:57:36 -0400
Received: from tmo-101-17.customers.d1-online.com ([80.187.101.17] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g8JA0-0003YZ-Hm; Fri, 05 Oct 2018 08:00:24 +0200
Date:   Fri, 5 Oct 2018 08:00:23 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] x86/vdso: Rearrange do_hres() to improve code
 generation
In-Reply-To: <99e93a6be59916959ad259482f4cf347e8af9bac.1538689401.git.luto@kernel.org>
Message-ID: <alpine.DEB.2.21.1810050758370.2876@nanos.tec.linutronix.de>
References: <cover.1538689401.git.luto@kernel.org> <99e93a6be59916959ad259482f4cf347e8af9bac.1538689401.git.luto@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2018, Andy Lutomirski wrote:
> index 18c8a78d1ec9..419de7552c2f 100644
> --- a/arch/x86/entry/vdso/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vclock_gettime.c
> @@ -147,10 +147,9 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
>  
>  	do {
>  		seq = gtod_read_begin(gtod);
> -		ts->tv_sec = base->sec;
> +		cycles = vgetcyc(gtod->vclock_mode);
>  		ns = base->nsec;
>  		last = gtod->cycle_last;
> -		cycles = vgetcyc(gtod->vclock_mode);
>  		if (unlikely((s64)cycles < 0))
>  			return vdso_fallback_gettime(clk, ts);
>  		if (cycles > last)
> @@ -158,7 +157,7 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
>  		ns >>= gtod->shift;
>  	} while (unlikely(gtod_read_retry(gtod, seq)));
>  
> -	ts->tv_sec += __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
> +	ts->tv_sec = base->sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);

You cannot access base->sec outside of the seqcount protected region. It
might have been incremented by now and you'll get a time jump by a full
second.

Thanks,

	tglx


