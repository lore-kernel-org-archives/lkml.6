Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FE2C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C571020866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZhKs/0Wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfAVVx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:53:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33580 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbfAVVx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:53:29 -0500
Received: from zn.tnic (p200300EC2BCBD90048119EF4C35B6C28.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:d900:4811:9ef4:c35b:6c28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF0891EC06FB;
        Tue, 22 Jan 2019 22:53:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548194007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4e+Ea5IRFH+/ga0tTL4h2CD+dObJHkLC4yNrwwRN04I=;
        b=ZhKs/0Wh0sIRHz+dUb7S7px9/WX5BgxfoUZRFEROt+zRTIvjZbkTAuNKHPOdWwYnxCQcVn
        XVAwNn00/rxgOIwIZkej0TZGzxfTA3DJHQj5rzk76sjCqmvqEgfUVCzHjeCCWe8kE/IcBD
        lF8Jp++Ul2LO01xEoDQR5MnU7KB9j2o=
Date:   Tue, 22 Jan 2019 22:53:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH 1/6] x86: mce: no need to check return value of
 debugfs_create functions
Message-ID: <20190122215326.GM26587@zn.tnic>
References: <20190122143542.8816-1-gregkh@linuxfoundation.org>
 <20190122143542.8816-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122143542.8816-2-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 03:35:37PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/x86/kernel/cpu/mce/core.c     | 15 ++++---------
>  arch/x86/kernel/cpu/mce/inject.c   | 34 +++++-------------------------
>  arch/x86/kernel/cpu/mce/severity.c | 14 +++---------
>  3 files changed, 12 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 672c7225cb1b..1f13f9032a8a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -2457,22 +2457,15 @@ static int fake_panic_set(void *data, u64 val)
>  DEFINE_SIMPLE_ATTRIBUTE(fake_panic_fops, fake_panic_get,
>  			fake_panic_set, "%llu\n");
>  
> -static int __init mcheck_debugfs_init(void)
> +static void __init mcheck_debugfs_init(void)
>  {
> -	struct dentry *dmce, *ffake_panic;
> +	struct dentry *dmce;
>  
>  	dmce = mce_get_debugfs_dir();
> -	if (!dmce)
> -		return -ENOMEM;
> -	ffake_panic = debugfs_create_file("fake_panic", 0444, dmce, NULL,
> -					  &fake_panic_fops);
> -	if (!ffake_panic)
> -		return -ENOMEM;
> -
> -	return 0;
> +	debugfs_create_file("fake_panic", 0444, dmce, NULL, &fake_panic_fops);

Right, for that I don't care if it fails or not...

>  #else
> -static int __init mcheck_debugfs_init(void) { return -EINVAL; }
> +static void __init mcheck_debugfs_init(void) { }
>  #endif
>  
>  DEFINE_STATIC_KEY_FALSE(mcsafe_key);
> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
> index 8492ef7d9015..0f5b6c57ffde 100644
> --- a/arch/x86/kernel/cpu/mce/inject.c
> +++ b/arch/x86/kernel/cpu/mce/inject.c
> @@ -648,7 +648,6 @@ static const struct file_operations readme_fops = {
>  
>  static struct dfs_node {
>  	char *name;
> -	struct dentry *d;
>  	const struct file_operations *fops;
>  	umode_t perm;
>  } dfs_fls[] = {
> @@ -662,7 +661,7 @@ static struct dfs_node {
>  	{ .name = "README",	.fops = &readme_fops, .perm = S_IRUSR | S_IRGRP | S_IROTH },
>  };
>  
> -static int __init debugfs_init(void)
> +static void __init debugfs_init(void)
>  {
>  	unsigned int i;
>  	u64 cap;
> @@ -671,30 +670,11 @@ static int __init debugfs_init(void)
>  	n_banks = cap & MCG_BANKCNT_MASK;
>  
>  	dfs_inj = debugfs_create_dir("mce-inject", NULL);
> -	if (!dfs_inj)
> -		return -EINVAL;
> -
> -	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++) {
> -		dfs_fls[i].d = debugfs_create_file(dfs_fls[i].name,
> -						    dfs_fls[i].perm,
> -						    dfs_inj,
> -						    &i_mce,
> -						    dfs_fls[i].fops);
> -
> -		if (!dfs_fls[i].d)
> -			goto err_dfs_add;
> -	}
> -
> -	return 0;
>  
> -err_dfs_add:
> -	while (i-- > 0)
> -		debugfs_remove(dfs_fls[i].d);
> +	for (i = 0; i < ARRAY_SIZE(dfs_fls); i++)
> +		debugfs_create_file(dfs_fls[i].name, dfs_fls[i].perm, dfs_inj,
> +				    &i_mce, dfs_fls[i].fops);

... but that matters: if any of those debugfs files cannot be created
for whatever reason, that injector module is useless because I can't
inject MCEs properly.

I mean, I like the simplification but ...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
