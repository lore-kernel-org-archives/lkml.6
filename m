Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E4AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C092173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C092173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeI1MnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:43:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53451 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1MnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:43:11 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g5m8z-0001LT-A8; Fri, 28 Sep 2018 08:20:54 +0200
Date:   Fri, 28 Sep 2018 08:20:52 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] futex: Set USER_DS for the futex_detect_cmpxchg() test
In-Reply-To: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
Message-ID: <alpine.DEB.2.21.1809280819040.8118@nanos.tec.linutronix.de>
References: <74fb6ce22f62e0fb48b91ca9918b74cedbcecaf1.1538096323.git.luto@kernel.org>
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

On Thu, 27 Sep 2018, Andy Lutomirski wrote:
> I have a couple questions here:
> 
>  - Is this actually okay on all architectures?  That is, are there
>    cases where we'll screw up if we fail a USER_DS access this early?
>    s390 stands out as the obvious special case (where USER_DS is not
>    than just a subset of KERNEL_DS), but s390 opts out.
>
>  - Why doesn't x86 set HAVE_FUTEX_CMPXCHG?  Or do we still support
>    some 32-bit configurations that don't have cmpxchg and don't know
>    about it at compile time?

I'm not entirely sure. Have to dig into the details. I assume S390 just can
set it though.

Thanks,

	tglx

>  kernel/futex.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 11fc3bb456d6..16bd3e72602a 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3593,6 +3593,7 @@ static void __init futex_detect_cmpxchg(void)
>  {
>  #ifndef CONFIG_HAVE_FUTEX_CMPXCHG
>  	u32 curval;
> +	mm_segment_t old_seg;
>  
>  	/*
>  	 * This will fail and we want it. Some arch implementations do
> @@ -3604,8 +3605,11 @@ static void __init futex_detect_cmpxchg(void)
>  	 * implementation, the non-functional ones will return
>  	 * -ENOSYS.
>  	 */
> +	old_seg = get_fs();
> +	set_fs(USER_DS);
>  	if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
>  		futex_cmpxchg_enabled = 1;
> +	set_fs(old_seg);
>  #endif
>  }
>  
> -- 
> 2.17.1
> 
> 
