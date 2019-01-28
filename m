Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B73EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C00720880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HSpMMOS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfA1O3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:29:24 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39674 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1O3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:29:23 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so13159614edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WV7Ko4eRGy4W/1j5DfqMD9bFBj+1do/9QKpVhfOFvnE=;
        b=HSpMMOS1u8/IoLkwFCWrmmpuryQUmJVIBaCxFF7yS1IrEFcv1D3Xp9LCgGBSmPlHWk
         0LrOWzF9ctJP84OSye2oNqh8EKIdcOtWQ3m7BlM3Ifju1h2FygwUISQhm8qGq3+DBiy2
         WKqfkGE7sg4fsLSZgBSQ/3bAKB69rivXeiUKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WV7Ko4eRGy4W/1j5DfqMD9bFBj+1do/9QKpVhfOFvnE=;
        b=i0sPYModiyNmZx7cVMceCg7sKhp0tT3hILFiGAF/AQCcRpc9T1qF/sNK6gZtrHrXlK
         Olv102/dFgRTRGJyDBm936Md+Vbjs2naZ1pYfRmis+TiSGhBY4aYbselkDpVzyFproxy
         /T6f8/S2BX6QU7iyeQuyqyJLzvwKipNQuj5PgxK/C7mao9Zqoe645s+2+oPSOD/1pkd1
         ubxoLGOQpSu0U7vaHG8IHz2oc95J4H/bJeUPFj+4xyOYfRlKe3rvCcJGy5ZbmLo+5b3R
         Fm91A1qecNLGsjN4Fqbe2t1dxcM5kL7wkZJawLM5AVrmbLpbS/0l+hCvpV/ZikZMVu7I
         aNCg==
X-Gm-Message-State: AJcUukctoTbeaNjqxYiLH93zD8R5plgiyiF1g4kCRcarmdnGeGZeKGEz
        wz8yzgUR4+1DuyJODs5QOg5EAw==
X-Google-Smtp-Source: ALg8bN7RPJQ1yTDPez4j+UJDKyBNaPC7LDh0CZKIpFbj00EePbys+mCPBAdTUMF/NNagzTb15/Gw7A==
X-Received: by 2002:a05:6402:121a:: with SMTP id c26mr21397846edw.104.1548685760979;
        Mon, 28 Jan 2019 06:29:20 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id g16sm2570054ejb.65.2019.01.28.06.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 06:29:19 -0800 (PST)
Date:   Mon, 28 Jan 2019 15:29:10 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Message-ID: <20190128142910.GA7232@andrea>
References: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 02:09:37PM +0200, Elena Reshetova wrote:
> This adds an smp_acquire__after_ctrl_dep() barrier on successful
> decrease of refcounter value from 1 to 0 for refcount_dec(sub)_and_test
> variants and therefore gives stronger memory ordering guarantees than
> prior versions of these functions.
> 
> Co-Developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>

+ Alan, Dmitry; they might also deserve a Suggested-by:  ;-)

[...]


> +An ACQUIRE memory ordering guarantees that all post loads and
> +stores (all po-later instructions) on the same CPU are
> +completed after the acquire operation. It also guarantees that all
> +po-later stores on the same CPU and all propagated stores from other CPUs
> +must propagate to all other CPUs after the acquire operation
> +(A-cumulative property).

Mmh, this property (A-cumulativity) isn't really associated to ACQUIREs
in the LKMM; I'd suggest to simply remove the last sentence.

[...]


> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> index dbaed55..ab8f584 100644
> --- a/arch/x86/include/asm/refcount.h
> +++ b/arch/x86/include/asm/refcount.h
> @@ -67,16 +67,29 @@ static __always_inline void refcount_dec(refcount_t *r)
>  static __always_inline __must_check
>  bool refcount_sub_and_test(unsigned int i, refcount_t *r)
>  {
> -	return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
> +	bool ret = GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
>  					 REFCOUNT_CHECK_LT_ZERO,
>  					 r->refs.counter, e, "er", i, "cx");
> +
> +    if (ret) {
> +               smp_acquire__after_ctrl_dep();
> +               return true;
> +    }
> +
> +    return false;

There appears to be some white-space damage (here and in other places);
checkpatch.pl should point these and other style problems out.

  Andrea


>  }
>  
>  static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
>  {
> -	return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> -					REFCOUNT_CHECK_LT_ZERO,
> -					r->refs.counter, e, "cx");
> +	bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> +                   REFCOUNT_CHECK_LT_ZERO,
> +                   r->refs.counter, e, "cx");
> +    if (ret) {
> +               smp_acquire__after_ctrl_dep();
> +               return true;
> +    }
> +
> +    return false;
>  }
>  
>  static __always_inline __must_check
> diff --git a/lib/refcount.c b/lib/refcount.c
> index ebcf8cd..732feac 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -33,6 +33,9 @@
>   * Note that the allocator is responsible for ordering things between free()
>   * and alloc().
>   *
> + * The decrements dec_and_test() and sub_and_test() also provide acquire
> + * ordering on success. 
> + *
>   */
>  
>  #include <linux/mutex.h>
> @@ -164,8 +167,7 @@ EXPORT_SYMBOL(refcount_inc_checked);
>   * at UINT_MAX.
>   *
>   * Provides release memory ordering, such that prior loads and stores are done
> - * before, and provides a control dependency such that free() must come after.
> - * See the comment on top.
> + * before, and provides an acquire ordering on success such that free() must come after.
>   *
>   * Use of this function is not recommended for the normal reference counting
>   * use case in which references are taken and released one at a time.  In these
> @@ -190,7 +192,12 @@ bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
>  
>  	} while (!atomic_try_cmpxchg_release(&r->refs, &val, new));
>  
> -	return !new;
> +    if (!new) {
> +               smp_acquire__after_ctrl_dep();
> +               return true;
> +    }
> +    return false;
> +
>  }
>  EXPORT_SYMBOL(refcount_sub_and_test_checked);
>  
> @@ -202,8 +209,7 @@ EXPORT_SYMBOL(refcount_sub_and_test_checked);
>   * decrement when saturated at UINT_MAX.
>   *
>   * Provides release memory ordering, such that prior loads and stores are done
> - * before, and provides a control dependency such that free() must come after.
> - * See the comment on top.
> + * before, and provides an acquire ordering on success such that free() must come after.
>   *
>   * Return: true if the resulting refcount is 0, false otherwise
>   */
> -- 
> 2.7.4
> 
