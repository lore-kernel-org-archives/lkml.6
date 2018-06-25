Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A94C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1449625832
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 11:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mA4UzhTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1449625832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755321AbeFYLiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 07:38:12 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36035 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbeFYLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 07:38:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id f16-v6so13336451wrm.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kCcG3Dqos2mpy6qUtjdShG8rFXpZI6LDCJMpYRbNxoU=;
        b=mA4UzhTOZKiNuhrFEcIMxRR6tMRcBJKeTTGVXh++NcyNhfoYdUC8Y66UYquHQmIZzn
         Se/EgraY5ophWd/epuQjgWR2HaLGtdVPPIDa6wtC2P8RapCVfziQOUwEilf/l27ZHEsa
         +nvNEFefu0Ou1slXGIVeQyvt8RjvP2vcPlS5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCcG3Dqos2mpy6qUtjdShG8rFXpZI6LDCJMpYRbNxoU=;
        b=i0HPNiufkKXP8wOY2njmg45/33+pR60xf3tC/fN2+PeIZWUb3vP0uWFXF6Zp3ICrYb
         rkYYFvJfCqaTuxzB+/mfHI1tK5aVi2GIWWN8oy6YazMcE/X1BP/izKBqYusEcqioWjYV
         1dF78tvOUwxmLR/8CCtY45mTbFdt0KMsImvFjym5h2rQ+iztY60pFHJuOzAAb4Yre1bu
         GchJeeTDX5GIUEqmbSlkuDujWqb8scn7coRoW+6Qf3BkmyYcs+9gbn4CQWisn2BZ6ioJ
         qEUCUuYU8o2PZHavtvuLYtR5U83fpMQ2idtjgsVT/fYaLVP4Qae042sCBf9tgujDn1DU
         cZhg==
X-Gm-Message-State: APt69E0j8gyexgnELT0aYxQpbeECWjaskKs5GY2mva9FwEYslQdDuTsh
        e5rOeNgKSMG3gAqGIhZNbzTpbbZz
X-Google-Smtp-Source: AAOMgpfUFaveMKkzDGWIimm1e6ALFAJb6ANeOuS+pHCJeDGhCVl7pl3zzx7a8fE1/07zsySNfcBYyw==
X-Received: by 2002:adf:a285:: with SMTP id s5-v6mr9520144wra.114.1529926689703;
        Mon, 25 Jun 2018 04:38:09 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id f133-v6sm8539333wme.42.2018.06.25.04.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 04:38:09 -0700 (PDT)
Date:   Mon, 25 Jun 2018 13:38:03 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCHv2 03/11] atomics: simplify cmpxchg() instrumentation
Message-ID: <20180625113803.GA13628@andrea>
References: <20180625105952.3756-1-mark.rutland@arm.com>
 <20180625105952.3756-4-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625105952.3756-4-mark.rutland@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:59:44AM +0100, Mark Rutland wrote:
> Currently we define some fairly verbose wrappers for the cmpxchg()
> family so that we can pass a pointer and size into kasan_check_write().
> 
> The wrapper duplicate the size-switching logic necessary in arch code,
> and only work for scalar types. On some architectures, (cmp)xchg are
> used on non-scalar types, and thus the instrumented wrappers need to be
> able to handle this.
> 
> We could take the type-punning logic form {READ,WRITE}_ONCE(), but this
> makes the wrappers even more verbose, and requires several local
> variables in the macros.
> 
> Instead, let's simplify the wrappers into simple macros which:
> 
>  * snapshot the pointer into a single local variable, called __ai_ptr to
>    avoid conflicts with variables in the scope of the caller.
> 
>  * call kasan_check_read() on __ai_ptr.

Maybe I'm misreading the diff: aren't you calling kasan_check_write()?
(not sure if it makes a difference in this case/for KTSan, but CMPXCHG
does not necessarily perform a write...)

  Andrea


> 
>  * invoke the arch_ function, passing the original arguments, bar
>    __ai_ptr being substituted for ptr.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  include/asm-generic/atomic-instrumented.h | 100 +++++-------------------------
>  1 file changed, 15 insertions(+), 85 deletions(-)
> 
> diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
> index 3c64e95d5ed0..c7c3e4cdd942 100644
> --- a/include/asm-generic/atomic-instrumented.h
> +++ b/include/asm-generic/atomic-instrumented.h
> @@ -408,109 +408,39 @@ static __always_inline bool atomic64_add_negative(s64 i, atomic64_t *v)
>  }
>  #endif
>  
> -static __always_inline unsigned long
> -cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
> -{
> -	kasan_check_write(ptr, size);
> -	switch (size) {
> -	case 1:
> -		return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
> -	case 2:
> -		return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
> -	case 4:
> -		return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
> -	case 8:
> -		BUILD_BUG_ON(sizeof(unsigned long) != 8);
> -		return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
> -	}
> -	BUILD_BUG();
> -	return 0;
> -}
> -
>  #define cmpxchg(ptr, old, new)						\
>  ({									\
> -	((__typeof__(*(ptr)))cmpxchg_size((ptr), (unsigned long)(old),	\
> -		(unsigned long)(new), sizeof(*(ptr))));			\
> +	typeof(ptr) __ai_ptr = (ptr);					\
> +	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
> +	arch_cmpxchg(__ai_ptr, (old), (new));				\
>  })
>  
> -static __always_inline unsigned long
> -sync_cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new,
> -		  int size)
> -{
> -	kasan_check_write(ptr, size);
> -	switch (size) {
> -	case 1:
> -		return arch_sync_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
> -	case 2:
> -		return arch_sync_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
> -	case 4:
> -		return arch_sync_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
> -	case 8:
> -		BUILD_BUG_ON(sizeof(unsigned long) != 8);
> -		return arch_sync_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
> -	}
> -	BUILD_BUG();
> -	return 0;
> -}
> -
>  #define sync_cmpxchg(ptr, old, new)					\
>  ({									\
> -	((__typeof__(*(ptr)))sync_cmpxchg_size((ptr),			\
> -		(unsigned long)(old), (unsigned long)(new),		\
> -		sizeof(*(ptr))));					\
> +	typeof(ptr) __ai_ptr = (ptr);					\
> +	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
> +	arch_sync_cmpxchg(__ai_ptr, (old), (new));			\
>  })
>  
> -static __always_inline unsigned long
> -cmpxchg_local_size(volatile void *ptr, unsigned long old, unsigned long new,
> -		   int size)
> -{
> -	kasan_check_write(ptr, size);
> -	switch (size) {
> -	case 1:
> -		return arch_cmpxchg_local((u8 *)ptr, (u8)old, (u8)new);
> -	case 2:
> -		return arch_cmpxchg_local((u16 *)ptr, (u16)old, (u16)new);
> -	case 4:
> -		return arch_cmpxchg_local((u32 *)ptr, (u32)old, (u32)new);
> -	case 8:
> -		BUILD_BUG_ON(sizeof(unsigned long) != 8);
> -		return arch_cmpxchg_local((u64 *)ptr, (u64)old, (u64)new);
> -	}
> -	BUILD_BUG();
> -	return 0;
> -}
> -
>  #define cmpxchg_local(ptr, old, new)					\
>  ({									\
> -	((__typeof__(*(ptr)))cmpxchg_local_size((ptr),			\
> -		(unsigned long)(old), (unsigned long)(new),		\
> -		sizeof(*(ptr))));					\
> +	typeof(ptr) __ai_ptr = (ptr);					\
> +	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
> +	arch_cmpxchg_local(__ai_ptr, (old), (new));			\
>  })
>  
> -static __always_inline u64
> -cmpxchg64_size(volatile u64 *ptr, u64 old, u64 new)
> -{
> -	kasan_check_write(ptr, sizeof(*ptr));
> -	return arch_cmpxchg64(ptr, old, new);
> -}
> -
>  #define cmpxchg64(ptr, old, new)					\
>  ({									\
> -	((__typeof__(*(ptr)))cmpxchg64_size((ptr), (u64)(old),		\
> -		(u64)(new)));						\
> +	typeof(ptr) __ai_ptr = (ptr);					\
> +	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
> +	arch_cmpxchg64(__ai_ptr, (old), (new));				\
>  })
>  
> -static __always_inline u64
> -cmpxchg64_local_size(volatile u64 *ptr, u64 old, u64 new)
> -{
> -	kasan_check_write(ptr, sizeof(*ptr));
> -	return arch_cmpxchg64_local(ptr, old, new);
> -}
> -
>  #define cmpxchg64_local(ptr, old, new)					\
>  ({									\
> -	((__typeof__(*(ptr)))cmpxchg64_local_size((ptr), (u64)(old),	\
> -		(u64)(new)));						\
> +	typeof(ptr) __ai_ptr = (ptr);					\
> +	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));			\
> +	arch_cmpxchg64_local(__ai_ptr, (old), (new));			\
>  })
>  
>  /*
> -- 
> 2.11.0
> 
