Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF87FC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB5520882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NAQrqkJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfA3Mbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:31:41 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44245 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfA3Mbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:31:41 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so18822002edd.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 04:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wLZ9V0y1gFpiVhD8QM6erFo39WOqs/oblGB3Yw2JF0k=;
        b=NAQrqkJfP5vE7BtY6ytcv2PJ6mqfd/pazoQx6KqJjJ38vmeozkziUf7Mp5kX3YIsLD
         BGUzd9eoZAv3WCSCcEw2OaH+H3uGaMcSkkHXRc4U60a0vnWlH2Q3bjjH8Rg/e7vZug11
         rUZFjlNBH3+UFEHBXoNnUMs3KsunHHqM3eY5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wLZ9V0y1gFpiVhD8QM6erFo39WOqs/oblGB3Yw2JF0k=;
        b=JGvfyUGROsRDrDgm79AaGZcue59lHDdf79dDaDiUCKgnmMDlG8VIcLgM33Ma3VaAz5
         vjSAN151XTsqgN3DNp3LQdgzw1afJcOIp39xkdsOb8L1aVkicQeVCTkayVaVX/DffnJM
         WIbYIuz27Ypv0wOvcNo3m985fbi6i59WBnjzR4FnLTVp0SKzgiy9MOwa4fYCndY6GaWU
         /TepfJ7OYSEHAWlQoapxAymNEbtYSsDsg5o6oQsET+8+fVQ0XGiJXFpOTH5h8EfRZUVk
         li7bjqWBgO6vUDZi7dHHKlJ/wC/jl3AdNQu7MGMbUb3dRJ1FCyrUarN2fAZnyHQp6170
         F/uQ==
X-Gm-Message-State: AJcUukfDNu6sZX+Bg+dpWQ+bmIfGVCy/on9Ll7p/xlwlLKPieslrxUzJ
        Ixk4mlTb9Y02rBkg7tFrvKNnWw==
X-Google-Smtp-Source: ALg8bN4ubPSmPLOBbcmo+WobNdv1Ham3PEsR52xWPUAdtvwvyhDcgDXICqCoGY9qRgRkMfm0jOdmfA==
X-Received: by 2002:a17:906:7b15:: with SMTP id e21mr25439381ejo.8.1548851498763;
        Wed, 30 Jan 2019 04:31:38 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id z2sm487185edd.4.2019.01.30.04.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 04:31:37 -0800 (PST)
Date:   Wed, 30 Jan 2019 13:31:31 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dvyukov@google.com, stern@rowland.harvard.edu,
        keescook@chromium.org
Subject: Re: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Message-ID: <20190130123131.GA20517@andrea>
References: <1548847131-27854-1-git-send-email-elena.reshetova@intel.com>
 <1548847131-27854-2-git-send-email-elena.reshetova@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548847131-27854-2-git-send-email-elena.reshetova@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:18:51PM +0200, Elena Reshetova wrote:
> This adds an smp_acquire__after_ctrl_dep() barrier on successful
> decrease of refcounter value from 1 to 0 for refcount_dec(sub)_and_test
> variants and therefore gives stronger memory ordering guarantees than
> prior versions of these functions.
> 
> Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>

Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>

  Andrea


> ---
>  Documentation/core-api/refcount-vs-atomic.rst | 24 +++++++++++++++++++++---
>  arch/x86/include/asm/refcount.h               | 22 ++++++++++++++++++----
>  lib/refcount.c                                | 18 +++++++++++++-----
>  3 files changed, 52 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/core-api/refcount-vs-atomic.rst b/Documentation/core-api/refcount-vs-atomic.rst
> index 322851b..976e85a 100644
> --- a/Documentation/core-api/refcount-vs-atomic.rst
> +++ b/Documentation/core-api/refcount-vs-atomic.rst
> @@ -54,6 +54,13 @@ must propagate to all other CPUs before the release operation
>  (A-cumulative property). This is implemented using
>  :c:func:`smp_store_release`.
>  
> +An ACQUIRE memory ordering guarantees that all post loads and
> +stores (all po-later instructions) on the same CPU are
> +completed after the acquire operation. It also guarantees that all
> +po-later stores on the same CPU must propagate to all other CPUs
> +after the acquire operation executes. This is implemented using
> +:c:func:`smp_acquire__after_ctrl_dep`.
> +
>  A control dependency (on success) for refcounters guarantees that
>  if a reference for an object was successfully obtained (reference
>  counter increment or addition happened, function returned true),
> @@ -119,13 +126,24 @@ Memory ordering guarantees changes:
>     result of obtaining pointer to the object!
>  
>  
> -case 5) - decrement-based RMW ops that return a value
> ------------------------------------------------------
> +case 5) - generic dec/sub decrement-based RMW ops that return a value
> +---------------------------------------------------------------------
>  
>  Function changes:
>  
>   * :c:func:`atomic_dec_and_test` --> :c:func:`refcount_dec_and_test`
>   * :c:func:`atomic_sub_and_test` --> :c:func:`refcount_sub_and_test`
> +
> +Memory ordering guarantees changes:
> +
> + * fully ordered --> RELEASE ordering + ACQUIRE ordering on success
> +
> +
> +case 6) other decrement-based RMW ops that return a value
> +---------------------------------------------------------
> +
> +Function changes:
> +
>   * no atomic counterpart --> :c:func:`refcount_dec_if_one`
>   * ``atomic_add_unless(&var, -1, 1)`` --> ``refcount_dec_not_one(&var)``
>  
> @@ -136,7 +154,7 @@ Memory ordering guarantees changes:
>  .. note:: :c:func:`atomic_add_unless` only provides full order on success.
>  
>  
> -case 6) - lock-based RMW
> +case 7) - lock-based RMW
>  ------------------------
>  
>  Function changes:
> diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> index dbaed55..232f856 100644
> --- a/arch/x86/include/asm/refcount.h
> +++ b/arch/x86/include/asm/refcount.h
> @@ -67,16 +67,30 @@ static __always_inline void refcount_dec(refcount_t *r)
>  static __always_inline __must_check
>  bool refcount_sub_and_test(unsigned int i, refcount_t *r)
>  {
> -	return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
> +	bool ret = GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
>  					 REFCOUNT_CHECK_LT_ZERO,
>  					 r->refs.counter, e, "er", i, "cx");
> +
> +	if (ret) {
> +		smp_acquire__after_ctrl_dep();
> +		return true;
> +	}
> +
> +	return false;
>  }
>  
>  static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
>  {
> -	return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> -					REFCOUNT_CHECK_LT_ZERO,
> -					r->refs.counter, e, "cx");
> +	bool ret = GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
> +					 REFCOUNT_CHECK_LT_ZERO,
> +					 r->refs.counter, e, "cx");
> +
> +	if (ret) {
> +		smp_acquire__after_ctrl_dep();
> +		return true;
> +	}
> +
> +	return false;
>  }
>  
>  static __always_inline __must_check
> diff --git a/lib/refcount.c b/lib/refcount.c
> index ebcf8cd..6e904af 100644
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
> @@ -164,8 +167,8 @@ EXPORT_SYMBOL(refcount_inc_checked);
>   * at UINT_MAX.
>   *
>   * Provides release memory ordering, such that prior loads and stores are done
> - * before, and provides a control dependency such that free() must come after.
> - * See the comment on top.
> + * before, and provides an acquire ordering on success such that free()
> + * must come after.
>   *
>   * Use of this function is not recommended for the normal reference counting
>   * use case in which references are taken and released one at a time.  In these
> @@ -190,7 +193,12 @@ bool refcount_sub_and_test_checked(unsigned int i, refcount_t *r)
>  
>  	} while (!atomic_try_cmpxchg_release(&r->refs, &val, new));
>  
> -	return !new;
> +	if (!new) {
> +		smp_acquire__after_ctrl_dep();
> +		return true;
> +	}
> +	return false;
> +
>  }
>  EXPORT_SYMBOL(refcount_sub_and_test_checked);
>  
> @@ -202,8 +210,8 @@ EXPORT_SYMBOL(refcount_sub_and_test_checked);
>   * decrement when saturated at UINT_MAX.
>   *
>   * Provides release memory ordering, such that prior loads and stores are done
> - * before, and provides a control dependency such that free() must come after.
> - * See the comment on top.
> + * before, and provides an acquire ordering on success such that free()
> + * must come after.
>   *
>   * Return: true if the resulting refcount is 0, false otherwise
>   */
> -- 
> 2.7.4
> 
