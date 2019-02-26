Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6BFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938F821848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 03:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551150126;
	bh=QUGnFHsjQAYPEf/fWHg1f2Aj3+j0RMlKMEM5z0dakWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nRbAUEWZZLd8J1Vp1FM5gqRXOSRoUrW22s9QKeenpEwfEL6VPbyGMbLnvYckUssdH
	 hvGJ9GnxtYPSDiOf4QVXu8QAhatQE5n++a4a1CX4k0GoPYEn/Rsh27MG3ZVk3nWi6y
	 kAsxfzxitAQi1fAcmLHuEaO04kkC1KBS/erAUiPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfBZDCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:02:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbfBZDCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 22:02:05 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB67A21841;
        Tue, 26 Feb 2019 03:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551150123;
        bh=QUGnFHsjQAYPEf/fWHg1f2Aj3+j0RMlKMEM5z0dakWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AKIKGvdb3r1iPXlVlpcCDVHPlNxSkWYKGQiCcP9s65MXozW1XCbbDyCmo4B9Vu6PQ
         KYnFJgllpDUcVFsEBtH3x/4Scr1iTExsqoU3x0WOA+Lb2+5huurcEaCblUFoYenolJ
         gjiwNkOVR5mVWOAJd4MtZ/wL+W3LM8aAxWSt++C4=
Date:   Tue, 26 Feb 2019 12:01:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [RFC PATCH 2/4] uaccess: Add non-pagefault user-space read
 functions
Message-Id: <20190226120159.c346704961ff22d344f45e96@kernel.org>
In-Reply-To: <20190225150603.GE32494@hirez.programming.kicks-ass.net>
References: <155110348217.21156.3874419272673328527.stgit@devbox>
        <155110354092.21156.13871336589042178985.stgit@devbox>
        <20190225150603.GE32494@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, 25 Feb 2019 16:06:03 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 25, 2019 at 11:05:41PM +0900, Masami Hiramatsu wrote:
> 
> > +static __always_inline long __strncpy_from_unsafe_user(char *dst,
> > +			 const char __user *unsafe_addr, long count)
> > +{
> > +	if (!access_ok(unsafe_addr, count))
> > +		return -EFAULT;
> > +
> > +	return strncpy_from_unsafe_common(dst, unsafe_addr, count);
> > +}
> 
> Would something like so work for people?
> 
> ---
>  arch/x86/include/asm/uaccess.h |  8 +++++++-
>  include/linux/uaccess.h        | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 780f2b42c8ef..3125d129d3b6 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -92,12 +92,18 @@ static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, un
>   * checks that the pointer is in the user space range - after calling
>   * this function, memory access functions may still return -EFAULT.
>   */
> -#define access_ok(addr, size)					\
> +#define access_ok(addr, size)						\
>  ({									\
>  	WARN_ON_IN_IRQ();						\
>  	likely(!__range_not_ok(addr, size, user_addr_max()));		\
>  })
>  
> +#define user_access_ok(addr, size)					\
> +({									\
> +	WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));			\
> +	likely(!__range_not_ok(addr, size, user_addr_max()));		\
> +})
> +
>  /*
>   * These are the main single-value transfer routines.  They automatically
>   * use the right size if we just have the right pointer type.
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 37b226e8df13..088f2ae09e14 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -10,6 +10,24 @@
>  
>  #include <asm/uaccess.h>
>  
> +/**
> + * user_access_ok: Checks if a user space pointer is valid
> + * @addr: User space pointer to start of block to check
> + * @size: Size of block to check
> + *
> + * Context: User context or explicit set_fs(USER_DS).
> + *
> + * This function is very much like access_ok(), except it (may) have different
> + * context validation. In general we must be very careful when using this.
> + */
> +#ifndef user_access_ok
> +#define user_access_ok(addr, size)					\
> +({									\
> +	WARN_ON_ONCE(!segment_eq(get_fs(), USER_DS));			\
> +	access_ok(addr, size);						\
> +})
> +#endif
> +
>  /*
>   * Architectures should provide two primitives (raw_copy_{to,from}_user())
>   * and get rid of their private instances of copy_{to,from}_user() and

Yeah, looks good to me. 

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
