Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE88BC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F8720882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544696635;
	bh=BGYHbh+cikv0ZP3MUAbajaR6UsxVCZDUpUMT3e+nwrY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pvdcgd0QJho7opudgXxQIznN+RjHQOUlvyTTzFa8HYfeEiBz6elECAu2jIvF0vnix
	 HxcL6OtVCK9nHcASWMmT3pDtKS/dnUmHRjOQsUhzuSxweBd4uHOnCG/GYXc4e22C7c
	 OyijYlGOmUn7g5A2dPywHiWzeYzm7XLXEQ1tULkQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F8720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeLMKXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:23:54 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35135 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLMKXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:23:54 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so1428229otj.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjhXbieLnqpmo8PT47Ixix69zcjNtLTv/M0MF3sqTCs=;
        b=GNyBJ1UmY7IUTl/FfeXffx7YP8TaIV+cO44MvzDPjaxPa0dLIcE7LR/2JD6qdWxkHN
         yJVuDVcoTP7GJq8jb0w2Oxd4IRygrCQhssI6+DGXxqTkKagv5lJYilxdUXzfR+n7XSUr
         LDa+YHKNEay05F8Tab8Kqo2du6ghsjgzeZUS05wI3TyLkkENLGGlZf71nDk57JOaOpJj
         gvXXzuyZQjAAf8uOENjj/l34EY9bJ5iVOjoUou/BmPZ7YuE3juFtmCfyqVsPB7mkqFz+
         MttjBFJP5Hd+eIjaouPZ/b9PRx78ZzDRTvk3+u9kr6I3oZ0vJNMM9cwg6Bv0zHAWKYYE
         F3gw==
X-Gm-Message-State: AA+aEWbWdMosnBnKsMbqDUrwuDsniZfg1Uqvsi0Rq6Ri9b7z/mz01V39
        Eb6GVaHNANNImzOku9osijREiWgjY2BqdNb/jYk=
X-Google-Smtp-Source: AFSGD/X4+HF2PuvBEhBxGwZlNFibBUjbCmZibOcWoq3N72OKztwSGcZW1xNY865w8hiM+vpe1o07GdW60F96Yf9H6A4=
X-Received: by 2002:a9d:2062:: with SMTP id n89mr15627725ota.244.1544696632885;
 Thu, 13 Dec 2018 02:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch> <CAJZ5v0jkE=Rt2ozwcTxRdUN++Sr4HXULksDeMx4jEWj1jVDcyA@mail.gmail.com>
 <20181213095814.GC21184@phenom.ffwll.local>
In-Reply-To: <20181213095814.GC21184@phenom.ffwll.local>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Dec 2018 11:23:41 +0100
Message-ID: <CAJZ5v0iWshem3kuurF53gutVJ8jFm_caAbetK2CiSCpyc6ReeQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ramalingam.c@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 10:58 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Dec 13, 2018 at 10:38:14AM +0100, Rafael J. Wysocki wrote:
> > On Mon, Dec 10, 2018 at 9:47 AM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > >
> > > Drivers might want to remove some sysfs files, which needs the same
> > > locks and ends up angering lockdep. Relevant snippet of the stack
> > > trace:
> > >
> > >   kernfs_remove_by_name_ns+0x3b/0x80
> > >   bus_remove_driver+0x92/0xa0
> > >   acpi_video_unregister+0x24/0x40
> > >   i915_driver_unload+0x42/0x130 [i915]
> > >   i915_pci_remove+0x19/0x30 [i915]
> > >   pci_device_remove+0x36/0xb0
> > >   device_release_driver_internal+0x185/0x250
> > >   unbind_store+0xaf/0x180
> > >   kernfs_fop_write+0x104/0x190
> >
> > Is the acpi_bus_unregister_driver() in acpi_video_unregister() the
> > source of the lockdep unhappiness?
>
> Yeah I guess I cut out too much of the lockdep splat. It complains about
> kernfs_fop_write and kernfs_remove_by_name_ns acquiring the same lock
> class. It's ofc not the same lock, so no real deadlock. Getting the
> device_release_driver outside of the callchain under kernfs_fop_write,
> which this patch does, "fixes" it. For "fixes" = shut up lockdep.

OK, so the problem really is that the operation is started via sysfs
which means that this code is running under a lock already.

Which lock does lockdep complain about, exactly?

> Other options:
> - Anotate the recursion with the usual lockdep annotations. Potentially
>   results in lockdep not catching real deadlocks (you can still have other
>   loops closing the deadlock, maybe through some subsystem/bus lock).
>
> - Rewrite kernfs_fop_write to drop the lock (optionally, for callbacks
>   that know what they're doing), which should be fine if we refcount
>   everything properly (bus, driver & device).
>
> - Also note that probably the same bug exists on the bind sysfs interface,
>   but we don't use that, so I don't care :-)
>
> - Most of these issues are never visible in normal usage, since normally
>   driver bind/unbind is done from a kthread or model_load/unload, neither
>   of which is running in the context of that kernfs mutex kernfs_fop_write
>   holds. That's why I think the task work is the best solution, since it
>   changes the locking context of the unbind sysfs to match the locking
>   context of module unload and hotunplug.

I think that using a task work here makes sense.  There is a drawback,
which is that the original sysfs write will not wait for the driver to
actually be released before returning to user space AFAICS, but that
probably isn't a big deal.

Also please note that the patch changes the code flow slightly,
because passing a non-NULL parent pointer to
device_release_driver_internal() potentially has side effects, but
that should not be a big deal either.

> Unfortunately that trick doesn't work for the bind sysfs file, since that way we can't thread the errno value back to userspace.

Right.  That is unless we wait for the operation to complete and check
the error left behind by it.  That should be doable, but somewhat
complicated.
