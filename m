Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B389EC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 11:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8280C21920
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 11:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545564588;
	bh=fQLex0in71gJp9HJxLT2/8SGVAhgpAfTxshtDC8kU+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MVTnpEswDoQ+sKU4RpMfw5YnFjyBk33jUu+Y3XFO/fgPz1CN/oiSTBWkkE8EaIaXs
	 liRfdbWoWV/jpm0SYd1ZAShCYNJeYFXTVQe+zcqzkaVHJFTiospD5y0JfwtbDdPbA3
	 rWJ8PJA51ErBUdS/WiQY/eXQwatDhTCi5lTStxys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeLWL3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 06:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeLWL3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 06:29:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD5E82186A;
        Sun, 23 Dec 2018 11:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545564586;
        bh=fQLex0in71gJp9HJxLT2/8SGVAhgpAfTxshtDC8kU+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ksd6RYPXrXB9/tvOdYyyLU36IOMdfjHucOXW68EZbdZL0uGhT7QyAZGpNKtoQ0zAk
         P/0a4SBMTynpUNuCsXJVtedeXxfiIwyimCX4re4HJX/sFZWjJgUjd69EyIGliER6R7
         kNjOHkjZgj7GeNLDNtfxCrfpWqae8GkuFaQ9fQts=
Date:   Sun, 23 Dec 2018 12:29:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        arve@android.com, maco@android.com, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binderfs: implement "max" mount option
Message-ID: <20181223112944.GC27818@kroah.com>
References: <20181222211806.1478-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222211806.1478-1-christian@brauner.io>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 10:18:06PM +0100, Christian Brauner wrote:
> Since binderfs can be mounted by userns root in non-initial user namespaces
> some precautions are in order. First, a way to set a maximum on the number
> of binder devices that can be allocated per binderfs instance and second, a
> way to reserve a reasonable chunk of binderfs devices for the initial ipc
> namespace.
> A first approach as seen in [1] used sysctls similiar to devpts but was
> shown to be flawed (cf. [2] and [3]) since some aspects were unneeded. This
> is an alternative approach which avoids sysctls completely and instead
> switches to a single mount option.
> 
> Starting with this commit binderfs instances can be mounted with a limit on
> the number of binder devices that can be allocated. The max=<count> mount
> option serves as a per-instance limit. If max=<count> is set then only
> <count> number of binder devices can be allocated in this binderfs
> instance.

Ok, this is fine, but why such a big default?  You only need 4 to run a
modern android system, and anyone using binder outside of android is
really too crazy to ever be using it in a container :)

> Additionally, the binderfs instance in the initial ipc namespace will
> always have a reserve of at least 1024 binder devices unless explicitly
> capped via max=<count>.

Again, why so many?  And why wouldn't that initial ipc namespace already
have their device nodes created _before_ anything else is mounted?

Some comments on the patch below:

> +/*
> + * Ensure that the initial ipc namespace always has a good chunk of devices
> + * available.
> + */
> +#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 1024)

Again that seems crazy big, how about splitting this into two different
patches, one for the max= stuff, and one for this "reserve some minors"
thing, so we can review them separately.

>  
>  static struct vfsmount *binderfs_mnt;
>  
> @@ -46,6 +52,24 @@ static dev_t binderfs_dev;
>  static DEFINE_MUTEX(binderfs_minors_mutex);
>  static DEFINE_IDA(binderfs_minors);
>  
> +/**
> + * binderfs_mount_opts - mount options for binderfs
> + * @max: maximum number of allocatable binderfs binder devices
> + */
> +struct binderfs_mount_opts {
> +	int max;
> +};
> +
> +enum {
> +	Opt_max,
> +	Opt_err
> +};
> +
> +static const match_table_t tokens = {
> +	{ Opt_max, "max=%d" },
> +	{ Opt_err, NULL     }
> +};
> +
>  /**
>   * binderfs_info - information about a binderfs mount
>   * @ipc_ns:         The ipc namespace the binderfs mount belongs to.
> @@ -55,13 +79,16 @@ static DEFINE_IDA(binderfs_minors);
>   *                  created.
>   * @root_gid:       gid that needs to be used when a new binder device is
>   *                  created.
> + * @mount_opts:     The mount options in use.
> + * @device_count:   The current number of allocated binder devices.
>   */
>  struct binderfs_info {
>  	struct ipc_namespace *ipc_ns;
>  	struct dentry *control_dentry;
>  	kuid_t root_uid;
>  	kgid_t root_gid;
> -
> +	struct binderfs_mount_opts mount_opts;
> +	atomic_t device_count;

Why atomic?

You should already have the lock held every time this is accessed,
so no need to use an atomic value, just use an int.

>  	/* Reserve new minor number for the new device. */
>  	mutex_lock(&binderfs_minors_mutex);
> -	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
> +	if (atomic_inc_return(&info->device_count) < info->mount_opts.max)

No need for atomic, see, your lock is held :)

thanks,

greg k-h
