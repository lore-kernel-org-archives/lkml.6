Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D254C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D89218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 21:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548883064;
	bh=oPoILWShpfn77gdRfGWj0tKg56a84A9h4mTrQkvodHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TfZApdwGVfLAD40pcW4yHnavtHwaDXVKzx0uTEuegI4uGtI4SEIFZvvQqHIuAmFsq
	 WyqqUU9egmiuyEbNGmeHzczHVcTQ5sDql8Nvx+tWuYSdgnZCzZbuBN3dpv0l1Hb5IT
	 cfR0JdTgfhJ9QWSDhynyEhXh7Zglo7js7/zUFBLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732989AbfA3VRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 16:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:43632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbfA3VRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 16:17:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D9C218AF;
        Wed, 30 Jan 2019 21:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548883061;
        bh=oPoILWShpfn77gdRfGWj0tKg56a84A9h4mTrQkvodHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThOVkQRO6iWuXF30iZe0NmstSXZiyI2l8of9yvLUJadc0EUllkCRrF2/o2Cn+iazD
         dGRRuCppNwHc4i43qyfozEVawR4bXxUzDpppofoKziH97cQkv9CXQBGztVqiPxarYc
         m38u7fzwp9/TXNk5GghmKADOpwrftwstmOETzExQ=
Date:   Wed, 30 Jan 2019 22:17:39 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com, tkjos@google.com
Subject: Re: [PATCH 2/2] binderfs: remove separate device_initcall()
Message-ID: <20190130211739.GC25919@kroah.com>
References: <20190123114116.5251-1-christian@brauner.io>
 <20190123114116.5251-2-christian@brauner.io>
 <20190130142412.GA13798@kroah.com>
 <20190130170101.wfdrqc3374az75yo@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130170101.wfdrqc3374az75yo@brauner.io>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:01:02PM +0100, Christian Brauner wrote:
> On Wed, Jan 30, 2019 at 03:24:12PM +0100, Greg KH wrote:
> > On Wed, Jan 23, 2019 at 12:41:16PM +0100, Christian Brauner wrote:
> > > binderfs should not have a separate device_initcall(). When a kernel is
> > > compiled with CONFIG_ANDROID_BINDERFS register the filesystem alongside
> > > CONFIG_ANDROID_IPC. This use-case is especially sensible when users specify
> > > CONFIG_ANDROID_IPC=y, CONFIG_ANDROID_BINDERFS=y and
> > > ANDROID_BINDER_DEVICES="".
> > > When CONFIG_ANDROID_BINDERFS=n then this always succeeds so there's no
> > > regression potential for legacy workloads.
> > > 
> > > Signed-off-by: Christian Brauner <christian@brauner.io>
> > > ---
> > >  drivers/android/binder.c          | 4 ++++
> > >  drivers/android/binder_internal.h | 9 +++++++++
> > >  drivers/android/binderfs.c        | 4 +---
> > >  3 files changed, 14 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > index cdfc87629efb..751d76173f81 100644
> > > --- a/drivers/android/binder.c
> > > +++ b/drivers/android/binder.c
> > > @@ -5915,6 +5915,10 @@ static int __init binder_init(void)
> > >  			goto err_init_binder_device_failed;
> > >  	}
> > >  
> > > +	ret = init_binderfs();
> > > +	if (ret)
> > > +		goto err_init_binder_device_failed;
> > > +
> > >  	return ret;
> > >  
> > >  err_init_binder_device_failed:
> > > diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> > > index 7fb97f503ef2..045b3e42d98b 100644
> > > --- a/drivers/android/binder_internal.h
> > > +++ b/drivers/android/binder_internal.h
> > > @@ -46,4 +46,13 @@ static inline bool is_binderfs_device(const struct inode *inode)
> > >  }
> > >  #endif
> > >  
> > > +#ifdef CONFIG_ANDROID_BINDERFS
> > > +extern int __init init_binderfs(void);
> > > +#else
> > > +static inline int __init init_binderfs(void)
> > > +{
> > > +	return 0;
> > > +}
> > > +#endif
> > > +
> > >  #endif /* _LINUX_BINDER_INTERNAL_H */
> > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > index 7a550104a722..e773f45d19d9 100644
> > > --- a/drivers/android/binderfs.c
> > > +++ b/drivers/android/binderfs.c
> > > @@ -550,7 +550,7 @@ static struct file_system_type binder_fs_type = {
> > >  	.fs_flags	= FS_USERNS_MOUNT,
> > >  };
> > >  
> > > -static int __init init_binderfs(void)
> > > +int __init init_binderfs(void)
> > >  {
> > >  	int ret;
> > >  
> > > @@ -568,5 +568,3 @@ static int __init init_binderfs(void)
> > >  
> > >  	return ret;
> > >  }
> > > -
> > > -device_initcall(init_binderfs);
> > 
> > I get a build warning when applying this patch :(
> 
> Hm, I can't reproduce that build error with this patch applied to what
> you currently have in char-misc-linus. :(
> Any chance you can give me the config that produced this warning?
> I tried with CONFIG_BINDERFS=y and CONFIG_BINDERFS=n.

$ make M=drivers/android
  CC      drivers/android/binderfs.o
  CC      drivers/android/binder.o
drivers/android/binder.c: In function ‘binder_init’:
drivers/android/binder.c:5933:2: warning: ‘device_names’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  kfree(device_names);
  ^~~~~~~~~~~~~~~~~~~

$ gcc --version
gcc (GCC) 8.2.1 20181127

And gcc is right about this warning, that could happen with your change :(

thanks,

greg k-h
