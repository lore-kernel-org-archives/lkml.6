Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C39BC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0724220850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GlOxq9IU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0724220850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeLFLN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:13:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39077 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbeLFLN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:13:27 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so423597edt.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 03:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a1s83AK4TLnZTcRKSLvfFSH6O7s+l2s09s9ys7iYbHg=;
        b=GlOxq9IUHOfR0uMwxRcRUkCdEhlHuL4KOD9TdXzRnJY5ppcJt5Wvbdozkn488iNFaS
         4WJ0/q6CsOUabTf8lgTGbYt7uBs/yKVXzh+FsKVp4t2GrUaGt3ks43GOMGLra+9g5HWj
         woCf0MOIYuAfww0jfTGSqfz374GtJDdMg7ZwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1s83AK4TLnZTcRKSLvfFSH6O7s+l2s09s9ys7iYbHg=;
        b=j9Ocm4EnVQxoDPoJyOAe86z88kHf17jfM9ArsYVIc7/TLx8kqTvwlKc07n276f+VX0
         WNVQM9JSp9uTy1yr/lAuqesCH4s2qybaJ0ChEM12c7CO4X1+z9WB35TdLHwRPOK744XD
         vo8Ww+DDRkXctdZRj1CH/9cQeU0/OjCejvlKeM0P88SlNV8ZMROlwtIMh7YZ/jYRbysX
         XLv7L8Rx2TQRFaTGuh4lEjI1dM/Nx28qGfDldJRzQhEISP9BSIKrYMtSXEAbFIqhk1bj
         B5/QY+bFvDzm6PlsLjqQ1NMYdLUU/TH47xW1DBwsDyUX0EP/gcLzQuk7ss0bMqssMegH
         gtGg==
X-Gm-Message-State: AA+aEWa7G60WREnLjqHhM5ta+ixXOzNPXavh4pPjqTPe6B+VMcDCMKrb
        mDP8Q6HefFbndZeJ4yhkkOoXZQ==
X-Google-Smtp-Source: AFSGD/VhEYEs9sffHDxdtU9Ck02Ul1jNbaUoAIx74TR252YBwrhSx8JcA1LCWXgsQxcQ5Vwt2gjN9Q==
X-Received: by 2002:a50:8799:: with SMTP id a25mr24564573eda.96.1544094804989;
        Thu, 06 Dec 2018 03:13:24 -0800 (PST)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id c53sm107539ede.26.2018.12.06.03.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 03:13:24 -0800 (PST)
Date:   Thu, 6 Dec 2018 12:13:17 +0100
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Jessica Yu <jeyu@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v7 13/14] module: Do not set nx for module memory before
 freeing
Message-ID: <20181206111317.GA5685@andrea>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-14-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205013408.47725-14-namit@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:34:07PM -0800, Nadav Amit wrote:
> When module memory is about to be freed, there is no apparent reason to
> make it (and its data) executable, but that's exactly what is done
> today. This is not efficient and not secure.

Looks to me like you forgot to Cc the maintainer of this file: doing it
now.  The same consideration would hold for 14/14.

  Andrea


> 
> There are various theories why it was done, but none of them seem as
> something that really require it today. nios2 uses kmalloc for module
> memory, but anyhow it does not change the PTEs of the module memory.  In
> x86, changing vmalloc'd memory mappings also modifies the direct mapping
> alias, but the NX-bit is not modified in such way.
> 
> So let's remove it. Andy suggested that the changes of the PTEs can be
> avoided (excluding the direct-mapping alias), which is true. However,
> in x86 it requires some cleanup of the contiguous page allocator, which
> is outside of the scope of this patch-set.
> 
> Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  kernel/module.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 7cb207249437..57c5b23746e7 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2027,20 +2027,29 @@ void set_all_modules_text_ro(void)
>  	mutex_unlock(&module_mutex);
>  }
>  
> -static void disable_ro_nx(const struct module_layout *layout)
> +static void module_restore_mappings(const struct module_layout *layout)
>  {
> -	if (rodata_enabled) {
> -		frob_text(layout, set_memory_rw);
> -		frob_rodata(layout, set_memory_rw);
> -		frob_ro_after_init(layout, set_memory_rw);
> -	}
> -	frob_rodata(layout, set_memory_x);
> -	frob_ro_after_init(layout, set_memory_x);
> -	frob_writable_data(layout, set_memory_x);
> +	/*
> +	 * First, make the mappings of the code non-executable to prevent
> +	 * transient W+X mappings from being set when the text is set as RW.
> +	 */
> +	frob_text(layout, set_memory_nx);
> +
> +	if (!rodata_enabled)
> +		return;
> +
> +	/*
> +	 * Second, set the memory as writable. Although the module memory is
> +	 * about to be freed, these calls are required (at least on x86) to
> +	 * restore the direct map to its "correct" state.
> +	 */
> +	frob_text(layout, set_memory_rw);
> +	frob_rodata(layout, set_memory_rw);
> +	frob_ro_after_init(layout, set_memory_rw);
>  }
>  
>  #else
> -static void disable_ro_nx(const struct module_layout *layout) { }
> +static void module_restore_mappings(const struct module_layout *layout) { }
>  static void module_enable_nx(const struct module *mod) { }
>  static void module_disable_nx(const struct module *mod) { }
>  #endif
> @@ -2173,7 +2182,7 @@ static void free_module(struct module *mod)
>  	mutex_unlock(&module_mutex);
>  
>  	/* This may be empty, but that's OK */
> -	disable_ro_nx(&mod->init_layout);
> +	module_restore_mappings(&mod->init_layout);
>  	module_arch_freeing_init(mod);
>  	module_memfree(mod->init_layout.base);
>  	kfree(mod->args);
> @@ -2183,7 +2192,7 @@ static void free_module(struct module *mod)
>  	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
>  
>  	/* Finally, free the core (containing the module structure) */
> -	disable_ro_nx(&mod->core_layout);
> +	module_restore_mappings(&mod->core_layout);
>  	module_memfree(mod->core_layout.base);
>  }
>  
> @@ -3507,7 +3516,7 @@ static noinline int do_init_module(struct module *mod)
>  #endif
>  	module_enable_ro(mod, true);
>  	mod_tree_remove_init(mod);
> -	disable_ro_nx(&mod->init_layout);
> +	module_restore_mappings(&mod->init_layout);
>  	module_arch_freeing_init(mod);
>  	mod->init_layout.base = NULL;
>  	mod->init_layout.size = 0;
> -- 
> 2.17.1
> 
