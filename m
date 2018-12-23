Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51947C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB4121849
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 13:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="GNJ6WuiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeLWNDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 08:03:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45951 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeLWNDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 08:03:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so9458469wrr.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Dec 2018 05:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P7u1qejgc2zqdoyNiMvAOMoq7pr8atJFhxSQaG9DqRA=;
        b=GNJ6WuiJnWFudy5TyisoNtE6CB9QxamXbh8D8fTDqtlepAWY8a4Sk5o7cu5q6J/eje
         5f+Q4DiITmrj9i6b8jL8+N8uFr7uI6wgxaZbxPblFmxq2rERhawCI+CXnRFy7xm1TPpP
         EuuuhMb3kHWFlJlflGvJTacY7lBgH54YCCHseRuH/skkdr4yIatbd8bBW6s7AiMFvJha
         FtQgH/+VeL0t7EUNCsiQGFxYuZgDuprPpaDPu+G9on/9llavtjmLNvrzJ34RMRl4RFGl
         +QA68xNB0i6sdmEPfIx9AoaZGsgG79BwyIpt9aeyMH4jHXB+zhjC//OWCXhP7N/HB+el
         Kvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P7u1qejgc2zqdoyNiMvAOMoq7pr8atJFhxSQaG9DqRA=;
        b=DE2oL4CE2H4jQMqH3VLRyp8/IaT1vxmvJob++PTH0GADdqeJOI/aEyTDvI0D1lq1pt
         aRQXB9Ykob9UAyhpd6URiwEb5eeJM2noNKpxH2mqmRMU2kY9BhB2F+jaxXbxWg6fUh7p
         9x/LBCBrhdq7isbI26QV2N6HmWQF/47+D3u4pJLh16zYzgJBB3j3yunAWiVeZwUn6WSV
         fhEWVV++yTeDgyfsY2IWKhl9iFMJmiMbJdUQn/gtwXl6yAdhzvikRQjj2FuFDxsxkpRl
         +SRFvYWlL1YM3QF7xkrIYJavCeguw2NOS8vnp7i46GprShnrWVOZ8UIQ4QW3IHETwkbz
         0p8g==
X-Gm-Message-State: AJcUukeUi/g43BH5fUje2SneHQryPJsbCS/PjgC/Qs7y344fqYKId2LM
        z5n6IGocJL6/wH1uUcD8cZgH/SmWLTz6tg==
X-Google-Smtp-Source: ALg8bN4iBEhcjb8+CKB3ifleYCFHwI1FLWwNl+aUFepxkoQoHyGUz8E6VNZti6y3TzeeA9McWgFCRA==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr9526883wrn.185.1545570222635;
        Sun, 23 Dec 2018 05:03:42 -0800 (PST)
Received: from brauner.io (p5B12DA88.dip0.t-ipconnect.de. [91.18.218.136])
        by smtp.gmail.com with ESMTPSA id h13sm17706191wrp.61.2018.12.23.05.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Dec 2018 05:03:41 -0800 (PST)
Date:   Sun, 23 Dec 2018 14:03:40 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        arve@android.com, maco@android.com, Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH] binderfs: implement "max" mount option
Message-ID: <20181223130339.iyadarp53jhu4byi@brauner.io>
References: <20181222211806.1478-1-christian@brauner.io>
 <20181223112944.GC27818@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181223112944.GC27818@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 12:29:44PM +0100, Greg KH wrote:
> On Sat, Dec 22, 2018 at 10:18:06PM +0100, Christian Brauner wrote:
> > Since binderfs can be mounted by userns root in non-initial user namespaces
> > some precautions are in order. First, a way to set a maximum on the number
> > of binder devices that can be allocated per binderfs instance and second, a
> > way to reserve a reasonable chunk of binderfs devices for the initial ipc
> > namespace.
> > A first approach as seen in [1] used sysctls similiar to devpts but was
> > shown to be flawed (cf. [2] and [3]) since some aspects were unneeded. This
> > is an alternative approach which avoids sysctls completely and instead
> > switches to a single mount option.
> > 
> > Starting with this commit binderfs instances can be mounted with a limit on
> > the number of binder devices that can be allocated. The max=<count> mount
> > option serves as a per-instance limit. If max=<count> is set then only
> > <count> number of binder devices can be allocated in this binderfs
> > instance.
> 
> Ok, this is fine, but why such a big default?  You only need 4 to run a
> modern android system, and anyone using binder outside of android is
> really too crazy to ever be using it in a container :)
> 
> > Additionally, the binderfs instance in the initial ipc namespace will
> > always have a reserve of at least 1024 binder devices unless explicitly
> > capped via max=<count>.
> 
> Again, why so many?  And why wouldn't that initial ipc namespace already
> have their device nodes created _before_ anything else is mounted?

Right, my issue is with re-creating devices, like if binderfs gets
unmounted or if devices get removed via rm. But we can lower the number
to 4 (see below).

> 
> Some comments on the patch below:

Thanks!

> 
> > +/*
> > + * Ensure that the initial ipc namespace always has a good chunk of devices
> > + * available.
> > + */
> > +#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 1024)
> 
> Again that seems crazy big, how about splitting this into two different
> patches, one for the max= stuff, and one for this "reserve some minors"
> thing, so we can review them separately.

Yes, let's do that. I will also lower this to 4 reserved devices.

> 
> >  
> >  static struct vfsmount *binderfs_mnt;
> >  
> > @@ -46,6 +52,24 @@ static dev_t binderfs_dev;
> >  static DEFINE_MUTEX(binderfs_minors_mutex);
> >  static DEFINE_IDA(binderfs_minors);
> >  
> > +/**
> > + * binderfs_mount_opts - mount options for binderfs
> > + * @max: maximum number of allocatable binderfs binder devices
> > + */
> > +struct binderfs_mount_opts {
> > +	int max;
> > +};
> > +
> > +enum {
> > +	Opt_max,
> > +	Opt_err
> > +};
> > +
> > +static const match_table_t tokens = {
> > +	{ Opt_max, "max=%d" },
> > +	{ Opt_err, NULL     }
> > +};
> > +
> >  /**
> >   * binderfs_info - information about a binderfs mount
> >   * @ipc_ns:         The ipc namespace the binderfs mount belongs to.
> > @@ -55,13 +79,16 @@ static DEFINE_IDA(binderfs_minors);
> >   *                  created.
> >   * @root_gid:       gid that needs to be used when a new binder device is
> >   *                  created.
> > + * @mount_opts:     The mount options in use.
> > + * @device_count:   The current number of allocated binder devices.
> >   */
> >  struct binderfs_info {
> >  	struct ipc_namespace *ipc_ns;
> >  	struct dentry *control_dentry;
> >  	kuid_t root_uid;
> >  	kgid_t root_gid;
> > -
> > +	struct binderfs_mount_opts mount_opts;
> > +	atomic_t device_count;
> 
> Why atomic?
> 
> You should already have the lock held every time this is accessed,
> so no need to use an atomic value, just use an int.
> 
> >  	/* Reserve new minor number for the new device. */
> >  	mutex_lock(&binderfs_minors_mutex);
> > -	minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR, GFP_KERNEL);
> > +	if (atomic_inc_return(&info->device_count) < info->mount_opts.max)
> 
> No need for atomic, see, your lock is held :)

Habit, to be honest.

Thanks, fixed version to follow in a bit.
Christian
