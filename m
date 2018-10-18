Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E750ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AC821470
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 01:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NRvWGHWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AC821470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeJRJ2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 05:28:32 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36844 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbeJRJ2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 05:28:32 -0400
Received: by mail-it1-f195.google.com with SMTP id c85-v6so5077189itd.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 18:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kdPFN0LEbEMZ9IMvAsEl2i67D21nSEKfGsWKIMlnxVE=;
        b=NRvWGHWSjNhgnFi9IqgfnRht+S61AFEv5AXNZuiwT2BYC3TlMHd57sY4S6rTHPJB6e
         uW2Z4uEbSKQo0f8TvkeRvpyzwBK3UKoNkR9oOEREmm6soMwkNH7MgRIvHKqFa/tn4a2y
         Cc3dWfTOF7fp/m2R19CdERgh/y8qL1VXEnyPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kdPFN0LEbEMZ9IMvAsEl2i67D21nSEKfGsWKIMlnxVE=;
        b=WcMAUWYZUKsmwRQcoPS0fekomJ4fV5fQxjioI3xMaYg/sh6g+AygjUnSb4KCvtVhDC
         68kC/lBBbXY4AjBIhLPUvZ1UsMt45upmhi2Ya5uHSs8Wv+YgTQKvB6w4nliBeJvXiUY9
         WaJBMRaKasc+mF0znd8BTe/SRQ2+Fj2UX+fV78psUI0O87zVeSw2SkMDgcPtL8zz5Twf
         t9QtHV2KtyJ2bENXgN6uLUEGO14FYBl+V197pGlVn+ZT2CrEMysNeT0US64kFMOMSl81
         P1s/lTdtoCVu86lMSxK2/WypW5zcrd3+Xkiwf2XwoP5XzzsLJHEHsVLoI/G+a3A80kzb
         RK7g==
X-Gm-Message-State: ABuFfojiY/G0ckrN3HdLAueETOdYqJwdSahWjHdwiN7eB5YV5Lm18+oP
        HoifKQ3MyK9Ept7kbIJXc/PxlA==
X-Google-Smtp-Source: AJdET5clccV7tdFdaQ589yrDoMGEJILZ8Shmyu5kuVgUiFE5SW5VQd6Ac0Segt//j5DcZ9TPPiwJ/w==
X-Received: by 2002:a24:74d4:: with SMTP id o203-v6mr3394136itc.81.1539826204254;
        Wed, 17 Oct 2018 18:30:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id u1-v6sm2886199itu.42.2018.10.17.18.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 18:30:02 -0700 (PDT)
Date:   Wed, 17 Oct 2018 18:30:01 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: Refactor compression initialization
Message-ID: <20181018013001.GA99677@joelaf.mtv.corp.google.com>
References: <20181017214124.GA8239@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017214124.GA8239@beast>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 02:41:24PM -0700, Kees Cook wrote:
> With compression initialization now separated from pstore_register(),
> there is no longer a good reason to do compression method selection
> during fs init. Instead, merge everything together into the late init.
> Additionally cleans up the reporting to be more clear.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This patch goes on top of Joel's. I'll have both in linux-next shortly...
> ---
>  fs/pstore/inode.c    |  2 --
>  fs/pstore/internal.h |  3 --
>  fs/pstore/platform.c | 65 ++++++++++++++++++++++++++++----------------
>  3 files changed, 41 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 5fcb845b9fec..d814723fb27d 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -486,8 +486,6 @@ static int __init init_pstore_fs(void)
>  {
>  	int err;
>  
> -	pstore_choose_compression();
> -
>  	/* Create a convenient mount point for people to access pstore */
>  	err = sysfs_create_mount_point(fs_kobj, "pstore");
>  	if (err)
> diff --git a/fs/pstore/internal.h b/fs/pstore/internal.h
> index fb767e28aeb2..c029314478fa 100644
> --- a/fs/pstore/internal.h
> +++ b/fs/pstore/internal.h
> @@ -37,7 +37,4 @@ extern bool	pstore_is_mounted(void);
>  extern void	pstore_record_init(struct pstore_record *record,
>  				   struct pstore_info *psi);
>  
> -/* Called during module_init() */
> -extern void __init pstore_choose_compression(void);
> -
>  #endif
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index f09066db2d4d..e4737a5fa68c 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -274,36 +274,56 @@ static int pstore_decompress(void *in, void *out,
>  
>  static void allocate_buf_for_compression(void)
>  {
> +	struct crypto_comp *ctx;
> +	int size;
> +	char *buf;
> +
> +	/* Skip if not built-in or compression backend not selected yet. */
>  	if (!IS_ENABLED(CONFIG_PSTORE_COMPRESS) || !zbackend)
>  		return;
>  
> +	/* Skip if no pstore backend yet or compression init already done. */
> +	if (!psinfo || tfm)
> +		return;
> +
>  	if (!crypto_has_comp(zbackend->name, 0, 0)) {
> -		pr_err("No %s compression\n", zbackend->name);
> +		pr_err("Unknown compression: %s\n", zbackend->name);
>  		return;
>  	}
>  
> -	big_oops_buf_sz = zbackend->zbufsize(psinfo->bufsize);
> -	if (big_oops_buf_sz <= 0)
> +	size = zbackend->zbufsize(psinfo->bufsize);
> +	if (size <= 0) {
> +		pr_err("Invalid compression size for %s: %d\n",
> +		       zbackend->name, size);
>  		return;
> +	}
>  
> -	big_oops_buf = kmalloc(big_oops_buf_sz, GFP_KERNEL);
> -	if (!big_oops_buf) {
> -		pr_err("allocate compression buffer error!\n");
> +	buf = kmalloc(size, GFP_KERNEL);
> +	if (!buf) {
> +		pr_err("Failed %d byte compression buffer allocation for: %s\n",
> +		       size, zbackend->name);
>  		return;
>  	}
>  
> -	tfm = crypto_alloc_comp(zbackend->name, 0, 0);
> -	if (IS_ERR_OR_NULL(tfm)) {
> -		kfree(big_oops_buf);
> -		big_oops_buf = NULL;
> -		pr_err("crypto_alloc_comp() failed!\n");
> +	ctx = crypto_alloc_comp(zbackend->name, 0, 0);
> +	if (IS_ERR_OR_NULL(ctx)) {
> +		kfree(buf);
> +		pr_err("crypto_alloc_comp('%s') failed: %ld\n", zbackend->name,
> +		       PTR_ERR(ctx));
>  		return;
>  	}
> +
> +	/* A non-NULL big_oops_buf indicates compression is available. */
> +	tfm = ctx;
> +	big_oops_buf_sz = size;
> +	big_oops_buf = buf;
> +
> +	pr_info("Using compression: %s\n", zbackend->name);
>  }
>  
>  static void free_buf_for_compression(void)
>  {
> -	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && !IS_ERR_OR_NULL(tfm))
> +	if (IS_ENABLED(CONFIG_PSTORE_COMPRESS) && tfm)
>  		crypto_free_comp(tfm);
>  	kfree(big_oops_buf);
>  	big_oops_buf = NULL;
> @@ -764,31 +784,28 @@ static void pstore_timefunc(struct timer_list *unused)
>  			  jiffies + msecs_to_jiffies(pstore_update_ms));
>  }
>  
> -void __init pstore_choose_compression(void)
> +static int __init pstore_compression_late_init(void)
>  {
>  	const struct pstore_zbackend *step;
>  
>  	if (!compress)
> -		return;
> +		return 0;
>  
> +	/* Locate desired compression method. */
>  	for (step = zbackends; step->name; step++) {
>  		if (!strcmp(compress, step->name)) {
>  			zbackend = step;
> -			pr_info("using %s compression\n", zbackend->name);
> -			return;
> +			break;
>  		}
>  	}
> -}
>  
> -static int __init pstore_compression_late_init(void)
> -{
>  	/*
> -	 * Check if any pstore backends registered earlier but did not allocate
> -	 * for compression because crypto was not ready, if so then initialize
> -	 * compression.
> +	 * Check if any pstore backends registered earlier but did not
> +	 * initialize compression because crypto was not ready. If so,
> +	 * then initialize compression now.
>  	 */
> -	if (psinfo && !tfm)
> -		allocate_buf_for_compression();
> +	allocate_buf_for_compression();

We can also get rid of the 'zbackend' global variable since choosing the
compression backend and allocating the buffers are done at the same time?

Otherwise looks good to me,

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

