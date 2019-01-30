Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F98EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5491E218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548858258;
	bh=EBlhtCOnVEDHCNiftlVobfn3fixPaM1NOWwF2xiJ6Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MEHXLfubZIZ+JTO4aHmBtL/g5IK7G4t/ZDxFUEfcwmcpzTKJjOvyKS1B6G/cf/y6U
	 fpHUe/8Uj7+RA0hMOCjoqoYUDZNF4GfZQAW7VYceu54UOyfxlL77Ck2zgAk4uAqUeC
	 3Qj4ux+j5g9iGvFYXREhDdgdW0hY3V6uu+Z/rApQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfA3OYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:24:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbfA3OYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:24:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE43820855;
        Wed, 30 Jan 2019 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548858255;
        bh=EBlhtCOnVEDHCNiftlVobfn3fixPaM1NOWwF2xiJ6Bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nLroZ8tWOqOytm26HhUfyI5+csCmpt2kHCQi8AwRe8yoEwotngNUcfNDqMohguytZ
         dLEGH3oX+4IafXSWtFhAaznOeKCv7KEBbDXfZ/FlgzaF/Wz3FpzyO4wUz//MB8jhiR
         55M90e6vQX5GGMK9Sl0CsKYGfif2PENR70WQyRlA=
Date:   Wed, 30 Jan 2019 15:24:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, arve@android.com, maco@android.com,
        joel@joelfernandes.org, tkjos@google.com
Subject: Re: [PATCH 2/2] binderfs: remove separate device_initcall()
Message-ID: <20190130142412.GA13798@kroah.com>
References: <20190123114116.5251-1-christian@brauner.io>
 <20190123114116.5251-2-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123114116.5251-2-christian@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 12:41:16PM +0100, Christian Brauner wrote:
> binderfs should not have a separate device_initcall(). When a kernel is
> compiled with CONFIG_ANDROID_BINDERFS register the filesystem alongside
> CONFIG_ANDROID_IPC. This use-case is especially sensible when users specify
> CONFIG_ANDROID_IPC=y, CONFIG_ANDROID_BINDERFS=y and
> ANDROID_BINDER_DEVICES="".
> When CONFIG_ANDROID_BINDERFS=n then this always succeeds so there's no
> regression potential for legacy workloads.
> 
> Signed-off-by: Christian Brauner <christian@brauner.io>
> ---
>  drivers/android/binder.c          | 4 ++++
>  drivers/android/binder_internal.h | 9 +++++++++
>  drivers/android/binderfs.c        | 4 +---
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index cdfc87629efb..751d76173f81 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5915,6 +5915,10 @@ static int __init binder_init(void)
>  			goto err_init_binder_device_failed;
>  	}
>  
> +	ret = init_binderfs();
> +	if (ret)
> +		goto err_init_binder_device_failed;
> +
>  	return ret;
>  
>  err_init_binder_device_failed:
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 7fb97f503ef2..045b3e42d98b 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -46,4 +46,13 @@ static inline bool is_binderfs_device(const struct inode *inode)
>  }
>  #endif
>  
> +#ifdef CONFIG_ANDROID_BINDERFS
> +extern int __init init_binderfs(void);
> +#else
> +static inline int __init init_binderfs(void)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_BINDER_INTERNAL_H */
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 7a550104a722..e773f45d19d9 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -550,7 +550,7 @@ static struct file_system_type binder_fs_type = {
>  	.fs_flags	= FS_USERNS_MOUNT,
>  };
>  
> -static int __init init_binderfs(void)
> +int __init init_binderfs(void)
>  {
>  	int ret;
>  
> @@ -568,5 +568,3 @@ static int __init init_binderfs(void)
>  
>  	return ret;
>  }
> -
> -device_initcall(init_binderfs);

I get a build warning when applying this patch :(

Please fix up and resend.

thanks,

greg k-h
