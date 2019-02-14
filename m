Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6532C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7697921928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 17:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550167111;
	bh=66b0ltTdjXzPnPc+X3pGDo0Z4VxDVcmhUVI44uPdQeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LU+Z3eZ2eTP/PXuD8TnU7BQ+O4wjLgEFwxTaLC6dYn3EfluokJGwatSe7ZEI8fGv6
	 5Ok7AirUIWlx+YMIJhPT3uRit7tpasfhZHeRh97ho7mAH+QJ0cpV41q+yWDGUjhgPL
	 cpILuE7dEuJ6+gPt1h8UAE9BA3yZZtJDWN7SBii4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437971AbfBNR6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 12:58:30 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40195 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfBNR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 12:58:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so3429519pgp.7;
        Thu, 14 Feb 2019 09:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gz0mDdAFP0iHqS6mE6/JnB6Z9tei8hlMgres71bhWmM=;
        b=nvHEyWj2vkleNgBkYxQI0Mw3S3tjSNd/p7oX2xboKo1oyzGDSQ+bAd691di8Hh1p94
         OCdMAxxrioxClkXpWtc3oybxSiLsFKIqlM/i40mmnuFBWfHHHit558kdh9219G7zZGSN
         zOKoxTvuGa4SKyoPFOsZbX80/FDKECXlJH1W9YSVCQHgSvgX1SyrsNGcjzqnCKEK+IMp
         QZpCkr554lUqnbaWQZANwvhkRcHJmR94KMDgIMnIGxNffoQP5T0Hhce/r2MI9rRSPKOF
         V3uIdwiLaNPoQsX77sDPBzXbQB6g3n1HWbtKywIA3F9CuYDlfsYN2FaEyTVq60Y37WoW
         k80Q==
X-Gm-Message-State: AHQUAub0aAOWEAcxXePsER30h04LYhA5w5vYxH2Bkl9qgyPFVHFx+7fy
        GD//NGU4pVcE/oDsmUy+U4I=
X-Google-Smtp-Source: AHgI3IY02ZV1wDrTuc6VvWKs+BqBN7uj5ByaABhoSsPQgzyZtk0eVGgWWGx8hlAeEJ6IErGFT4usUg==
X-Received: by 2002:a63:ce4f:: with SMTP id r15mr1066495pgi.303.1550167107834;
        Thu, 14 Feb 2019 09:58:27 -0800 (PST)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id h10sm3892986pgn.11.2019.02.14.09.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 09:58:26 -0800 (PST)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 14 Feb 2019 09:58:23 -0800
Date:   Thu, 14 Feb 2019 09:58:23 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: Re: [PATCH v2] x86/ima: require signed kernel modules
Message-ID: <20190214175823.GG11489@garbanzo.do-not-panic.com>
References: <1550060279-8624-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550060279-8624-1-git-send-email-zohar@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 07:17:59AM -0500, Mimi Zohar wrote:
> Require signed kernel modules on systems with secure boot mode enabled.
> 
> Requiring appended kernel module signatures may be configured, enabled
> on the boot command line, or with this patch enabled in secure boot
> mode. 

But only if IMA is enabled? If so, should this statement be true if
IMA is disabled?

Either way, this is not clear from the commit log and code, can the
commit log be clear if set_module_sig_enforced() will be set if
IMA is disabled but secure boot mode enabled?

> This patch defines set_module_sig_enforced().
> 
> To coordinate between appended kernel module signatures and IMA
> signatures, only define an IMA MODULE_CHECK policy rule if
> CONFIG_MODULE_SIG is not enabled.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> 
> Changelog:
> - Removed new "sig_required" flag and associated functions, directly set
>   sig_enforce.
> 
>  arch/x86/kernel/ima_arch.c | 9 ++++++++-
>  include/linux/module.h     | 1 +
>  kernel/module.c            | 5 +++++
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
> index e47cd9390ab4..3fb9847f1cad 100644
> --- a/arch/x86/kernel/ima_arch.c
> +++ b/arch/x86/kernel/ima_arch.c
> @@ -64,12 +64,19 @@ static const char * const sb_arch_rules[] = {
>  	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
>  #endif /* CONFIG_KEXEC_VERIFY_SIG */
>  	"measure func=KEXEC_KERNEL_CHECK",
> +#if !IS_ENABLED(CONFIG_MODULE_SIG)
> +	"appraise func=MODULE_CHECK appraise_type=imasig",
> +#endif
> +	"measure func=MODULE_CHECK",
>  	NULL
>  };
>  
>  const char * const *arch_get_ima_policy(void)
>  {
> -	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
> +	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> +		if (IS_ENABLED(CONFIG_MODULE_SIG))
> +			set_module_sig_enforced();
>  		return sb_arch_rules;
> +	}
>  	return NULL;
>  }
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8fa38d3e7538..75e2a5c24a2b 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -660,6 +660,7 @@ static inline bool is_livepatch_module(struct module *mod)
>  #endif /* CONFIG_LIVEPATCH */
>  
>  bool is_module_sig_enforced(void);
> +void set_module_sig_enforced(void);
>  
>  #else /* !CONFIG_MODULES... */

I think you need the !CONFIG_MODULES definition of set_module_sig_enforced()
then...

> diff --git a/kernel/module.c b/kernel/module.c
> index 2ad1b5239910..4cb5b733fb18 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -286,6 +286,11 @@ bool is_module_sig_enforced(void)
>  }
>  EXPORT_SYMBOL(is_module_sig_enforced);
>  
> +void set_module_sig_enforced(void)
> +{
> +       sig_enforce = true;
> +}

The export is not needed as it is bool eh?

  Luis
