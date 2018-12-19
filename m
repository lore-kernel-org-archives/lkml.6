Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCEF217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K796sxSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeLSJYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:24:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:46962 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeLSJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:24:35 -0500
Received: by mail-io1-f68.google.com with SMTP id v10so15033685ios.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dk+U8RddQVY6IQsyamvv0BPxZvG5be3iotUVh2ckxyU=;
        b=K796sxSz18gkQda0THvBIyXBgkUSQhFrWyvlzEO6ZcanyUWU+xIZEe5xmDI5xQQWAn
         sAF+5Q6Wx4j1O1GEoEW77deYKT6Kk32IxMFG9ibpA7laVGATyifjg/4nmgfpvkKFylRG
         z8wOZRbyEwYF9RnZcESp0Gb0cYnA8G5pw2XTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dk+U8RddQVY6IQsyamvv0BPxZvG5be3iotUVh2ckxyU=;
        b=SjlK8E/RBoZKFEDYlmBXM5LygdwQ15SpxPQVwLbD21vaso48i1/mgOfXPK4xr/yn5H
         GBwbHmWlEtemK8a7xsq2uOLDv5SnqwIB3wlTL1bD2fD3H5VISx686+m2lDGtzUrhf3Yt
         UNG2NR/PkxlHwg4ePIbrn7t7ErwUpB+0s8LRBOO0IKFJadre7dQbOrOwh5uv3TJQrvDx
         2yD8MGcudzFNI+KZ/cjoRX7SDNmYWZwnFM/GNXXMH2MxIPN4/lkyu5rjqERgf5a0TW3u
         Y9yDEug50QtpwFDPs/T0HhDoApfLsP/D8tzF+6Sce+skPlvxcBGVRSAX3aw4GivCF2cC
         m/nA==
X-Gm-Message-State: AA+aEWb+q37mKrM7op703yKs5RoV5Asdb5GFY3RFwq4axv80l3QNZAYi
        hVqNy7XlDxvJnq8mq2m9vryfZ/fR+T+q5G1OV5KQYA==
X-Google-Smtp-Source: AFSGD/WBIto+2lpOBqCVS9ZPmrfkO9bLol/CC8o4kgVs5XPz5sDycp4CM5h8YmvGMitY3OIM4/g+rakdQqBReyQGDCY=
X-Received: by 2002:a6b:4001:: with SMTP id k1mr18666801ioa.34.1545211474323;
 Wed, 19 Dec 2018 01:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20181218201443.4950-1-daniel.vetter@ffwll.ch> <20181219070110.GB21256@kroah.com>
In-Reply-To: <20181219070110.GB21256@kroah.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 19 Dec 2018 10:24:23 +0100
Message-ID: <CAKMK7uF0dDeomEyDkeZGSqCE66f76ME2EkuExVPJv6Bu=tKQSg@mail.gmail.com>
Subject: Re: [PATCH] sysfs: Disable lockdep for driver bind/unbind files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 8:01 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 18, 2018 at 09:14:43PM +0100, Daniel Vetter wrote:
> > This is the much more correct fix for my earlier attempt at:
> >
> > https://lkml.org/lkml/2018/12/10/118
> >
> > Short recap:
> >
> > - There's not actually a locking issue, it's just lockdep being a bit
> >   too eager to complain about a possible deadlock.
> >
> > - Contrary to what I claimed the real problem is recursion on
> >   kn->count. Greg pointed me at sysfs_break_active_protection(), used
> >   by the scsi subsystem to allow a sysfs file to unbind itself. That
> >   would be a real deadlock, which isn't what's happening here. Also,
> >   breaking the active protection means we'd need to manually handle
> >   all the lifetime fun.
> >
> > - With Rafael we discussed the task_work approach, which kinda works,
> >   but has two downsides: It's a functional change for a lockdep
> >   annotation issue, and it won't work for the bind file (which needs
> >   to get the errno from the driver load function back to userspace).
> >
> > - Greg also asked why this never showed up: To hit this you need to
> >   unregister a 2nd driver from the unload code of your first driver. I
> >   guess only gpus do that. The bug has always been there, but only
> >   with a recent patch series did we add more locks so that lockdep
> >   built a chain from unbinding the snd-hda driver to the
> >   acpi_video_unregister call.
> >
> > Full lockdep splat:
> >
> > [12301.898799] ============================================
> > [12301.898805] WARNING: possible recursive locking detected
> > [12301.898811] 4.20.0-rc7+ #84 Not tainted
> > [12301.898815] --------------------------------------------
> > [12301.898821] bash/5297 is trying to acquire lock:
> > [12301.898826] 00000000f61c6093 (kn->count#39){++++}, at: kernfs_remove_by_name_ns+0x3b/0x80
> > [12301.898841] but task is already holding lock:
> > [12301.898847] 000000005f634021 (kn->count#39){++++}, at: kernfs_fop_write+0xdc/0x190
> > [12301.898856] other info that might help us debug this:
> > [12301.898862]  Possible unsafe locking scenario:
> > [12301.898867]        CPU0
> > [12301.898870]        ----
> > [12301.898874]   lock(kn->count#39);
> > [12301.898879]   lock(kn->count#39);
> > [12301.898883] *** DEADLOCK ***
> > [12301.898891]  May be due to missing lock nesting notation
> > [12301.898899] 5 locks held by bash/5297:
> > [12301.898903]  #0: 00000000cd800e54 (sb_writers#4){.+.+}, at: vfs_write+0x17f/0x1b0
> > [12301.898915]  #1: 000000000465e7c2 (&of->mutex){+.+.}, at: kernfs_fop_write+0xd3/0x190
> > [12301.898925]  #2: 000000005f634021 (kn->count#39){++++}, at: kernfs_fop_write+0xdc/0x190
> > [12301.898936]  #3: 00000000414ef7ac (&dev->mutex){....}, at: device_release_driver_internal+0x34/0x240
> > [12301.898950]  #4: 000000003218fbdf (register_count_mutex){+.+.}, at: acpi_video_unregister+0xe/0x40
> > [12301.898960] stack backtrace:
> > [12301.898968] CPU: 1 PID: 5297 Comm: bash Not tainted 4.20.0-rc7+ #84
> > [12301.898974] Hardware name: Hewlett-Packard HP EliteBook 8460p/161C, BIOS 68SCF Ver. F.01 03/11/2011
> > [12301.898982] Call Trace:
> > [12301.898989]  dump_stack+0x67/0x9b
> > [12301.898997]  __lock_acquire+0x6ad/0x1410
> > [12301.899003]  ? kernfs_remove_by_name_ns+0x3b/0x80
> > [12301.899010]  ? find_held_lock+0x2d/0x90
> > [12301.899017]  ? mutex_spin_on_owner+0xe4/0x150
> > [12301.899023]  ? find_held_lock+0x2d/0x90
> > [12301.899030]  ? lock_acquire+0x90/0x180
> > [12301.899036]  lock_acquire+0x90/0x180
> > [12301.899042]  ? kernfs_remove_by_name_ns+0x3b/0x80
> > [12301.899049]  __kernfs_remove+0x296/0x310
> > [12301.899055]  ? kernfs_remove_by_name_ns+0x3b/0x80
> > [12301.899060]  ? kernfs_name_hash+0xd/0x80
> > [12301.899066]  ? kernfs_find_ns+0x6c/0x100
> > [12301.899073]  kernfs_remove_by_name_ns+0x3b/0x80
> > [12301.899080]  bus_remove_driver+0x92/0xa0
> > [12301.899085]  acpi_video_unregister+0x24/0x40
> > [12301.899127]  i915_driver_unload+0x42/0x130 [i915]
> > [12301.899160]  i915_pci_remove+0x19/0x30 [i915]
> > [12301.899169]  pci_device_remove+0x36/0xb0
> > [12301.899176]  device_release_driver_internal+0x185/0x240
> > [12301.899183]  unbind_store+0xaf/0x180
> > [12301.899189]  kernfs_fop_write+0x104/0x190
> > [12301.899195]  __vfs_write+0x31/0x180
> > [12301.899203]  ? rcu_read_lock_sched_held+0x6f/0x80
> > [12301.899209]  ? rcu_sync_lockdep_assert+0x29/0x50
> > [12301.899216]  ? __sb_start_write+0x13c/0x1a0
> > [12301.899221]  ? vfs_write+0x17f/0x1b0
> > [12301.899227]  vfs_write+0xb9/0x1b0
> > [12301.899233]  ksys_write+0x50/0xc0
> > [12301.899239]  do_syscall_64+0x4b/0x180
> > [12301.899247]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [12301.899253] RIP: 0033:0x7f452ac7f7a4
> > [12301.899259] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 80 00 00 00 00 8b 05 aa f0 2c 00 48 63 ff 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 55 53 48 89 d5 48 89 f3 48 83
> > [12301.899273] RSP: 002b:00007ffceafa6918 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> > [12301.899282] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f452ac7f7a4
> > [12301.899288] RDX: 000000000000000d RSI: 00005612a1abf7c0 RDI: 0000000000000001
> > [12301.899295] RBP: 00005612a1abf7c0 R08: 000000000000000a R09: 00005612a1c46730
> > [12301.899301] R10: 000000000000000a R11: 0000000000000246 R12: 000000000000000d
> > [12301.899308] R13: 0000000000000001 R14: 00007f452af4a740 R15: 000000000000000d
> >
> > Locking around I've noticed that usb and i2c already handle similar
> > recursion problems, where a sysfs file can unbind the same type of
> > sysfs somewhere else in the hierarchy. Relevant commits are:
> >
> > commit 356c05d58af05d582e634b54b40050c73609617b
> > Author: Alan Stern <stern@rowland.harvard.edu>
> > Date:   Mon May 14 13:30:03 2012 -0400
> >
> >     sysfs: get rid of some lockdep false positives
> >
> > commit e9b526fe704812364bca07edd15eadeba163ebfb
> > Author: Alexander Sverdlin <alexander.sverdlin@nsn.com>
> > Date:   Fri May 17 14:56:35 2013 +0200
> >
> >     i2c: suppress lockdep warning on delete_device
> >
> > Implement the same trick for driver bind/unbind.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Ramalingam C <ramalingam.c@intel.com>
> > Cc: Arend van Spriel <aspriel@gmail.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Cc: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Cc: Joe Perches <joe@perches.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > ---
> >  drivers/base/bus.c     | 4 ++--
> >  include/linux/device.h | 4 ++++
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> > index 8bfd27ec73d6..5d2411b848cd 100644
> > --- a/drivers/base/bus.c
> > +++ b/drivers/base/bus.c
> > @@ -195,7 +195,7 @@ static ssize_t unbind_store(struct device_driver *drv, const char *buf,
> >       bus_put(bus);
> >       return err;
> >  }
> > -static DRIVER_ATTR_WO(unbind);
> > +static DRIVER_ATTR_IGNORE_LOCKDEP(unbind, S_IWUSR, NULL, unbind_store);
> >
> >  /*
> >   * Manually attach a device to a driver.
> > @@ -231,7 +231,7 @@ static ssize_t bind_store(struct device_driver *drv, const char *buf,
> >       bus_put(bus);
> >       return err;
> >  }
> > -static DRIVER_ATTR_WO(bind);
> > +static DRIVER_ATTR_IGNORE_LOCKDEP(bind, S_IWUSR, NULL, bind_store);
> >
> >  static ssize_t show_drivers_autoprobe(struct bus_type *bus, char *buf)
> >  {
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 1b25c7a43f4c..d2cb1a6c5d95 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -326,6 +326,10 @@ struct driver_attribute {
> >       struct driver_attribute driver_attr_##_name = __ATTR_RO(_name)
> >  #define DRIVER_ATTR_WO(_name) \
> >       struct driver_attribute driver_attr_##_name = __ATTR_WO(_name)
> > +#define DRIVER_ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store) \
> > +     struct driver_attribute driver_attr_##_name =           \
> > +             __ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store)
> > +
>
> I don't want to give driver writers the ability to shoot themselves in
> the foot, can you just put this in the bus.c file itself so that no one
> else will abuse this and "open code" the unbind/bind attributes instead
> of using a #define for it?

So part of the reasons I've put these here is that I think we can do a
lot better. Instead of ignoring lockdep I think we can implement
nested lockdep annotations. It's going to be a bit a pain to wire that
through from sysfs->kernfs, but for all the (now 3) uses of
_IGNORE_LOCKDEP it should work if the add/remove_files functions use
mutex_lock_nested. I think then there's not really a problem with
exposing this. Aside from it's already exposed, but only for devices,
as DEVICE_ATTR_IGNORE_LOCKDEP.

> Also I've been trying to get rid of the "specify the mode" macros, so
> that everyone uses the RO, WO, and RW versions, so adding a generic one
> here is not going to help with that effort :)

Didn't know that, I went with consistency with
DEVICE_ATTR_IGNORE_LOCKDEP. Since I haven't really started typing the
follow-up series yet, I can use that one to convert over to
_ATTR_NESTED_RO/RW/WO.

Anyway, just wanted to explain why I picked these, happy to bikeshed
to taste if you insist.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
