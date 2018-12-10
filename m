Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3564C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEC52082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEC52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbeLJU5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:57:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:37648 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727538AbeLJU5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:57:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 12:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="97688351"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga007.jf.intel.com with ESMTP; 10 Dec 2018 12:57:44 -0800
Message-ID: <bd92d0a3ff60097bf4424ff4c556a5369e66da6d.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v8 2/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Date:   Mon, 10 Dec 2018 12:57:44 -0800
In-Reply-To: <CAPcyv4i1RTrKYX0YpyCRE=pqt3pHBRiCGQq1wYUriLjKKTVA7A@mail.gmail.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
         <154403072403.11544.10419282512791659652.stgit@ahduyck-desk1.jf.intel.com>
         <CAPcyv4jH_Op-xHTd2FwQizPaWFx_2FE-pVsOLLmZAEK8EVPrYg@mail.gmail.com>
         <15b6817fd945a1622afe673b46b028bacefad72b.camel@linux.intel.com>
         <CAPcyv4i1RTrKYX0YpyCRE=pqt3pHBRiCGQq1wYUriLjKKTVA7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 11:43 -0800, Dan Williams wrote:
> On Mon, Dec 10, 2018 at 11:35 AM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> > 
> > On Mon, 2018-12-10 at 10:58 -0800, Dan Williams wrote:
> > > On Wed, Dec 5, 2018 at 9:25 AM Alexander Duyck
> > > <alexander.h.duyck@linux.intel.com> wrote:
> > > > 
> > > > Add an additional bit flag to the device struct named "dead".
> > > > 
> > > > This additional flag provides a guarantee that when a device_del is
> > > > executed on a given interface an async worker will not attempt to attach
> > > > the driver following the earlier device_del call. Previously this
> > > > guarantee was not present and could result in the device_del call
> > > > attempting to remove a driver from an interface only to have the async
> > > > worker attempt to probe the driver later when it finally completes the
> > > > asynchronous probe call.
> > > > 
> > > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > > ---
> > > >  drivers/base/core.c    |   11 +++++++++++
> > > >  drivers/base/dd.c      |    8 ++++++--
> > > >  include/linux/device.h |    5 +++++
> > > >  3 files changed, 22 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index f3e6ca4170b4..70358327303b 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -2075,6 +2075,17 @@ void device_del(struct device *dev)
> > > >         struct kobject *glue_dir = NULL;
> > > >         struct class_interface *class_intf;
> > > > 
> > > > +       /*
> > > > +        * Hold the device lock and set the "dead" flag to guarantee that
> > > > +        * the update behavior is consistent with the other bitfields near
> > > > +        * it and that we cannot have an asynchronous probe routine trying
> > > > +        * to run while we are tearing out the bus/class/sysfs from
> > > > +        * underneath the device.
> > > > +        */
> > > > +       device_lock(dev);
> > > > +       dev->dead = true;
> > > > +       device_unlock(dev);
> > > > +
> > > >         /* Notify clients of device removal.  This call must come
> > > >          * before dpm_sysfs_remove().
> > > >          */
> > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > index 88713f182086..3bb8c3e0f3da 100644
> > > > --- a/drivers/base/dd.c
> > > > +++ b/drivers/base/dd.c
> > > > @@ -774,6 +774,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
> > > > 
> > > >         device_lock(dev);
> > > > 
> > > > +       /* device is or has been removed from the bus, just bail out */
> > > > +       if (dev->dead)
> > > > +               goto out_unlock;
> > > > +
> > > 
> > > What do you think about moving this check into
> > > __device_attach_driver() alongside all the other checks? That way we
> > > also get ->dead checking through the __device_attach() path.
> > 
> > I'm not really sure that is the best spot to do that. Part of the
> > reason being that by placing it where I did we avoid messing with the
> > runtime power management for the parent if it was already powered off.
> 
> ...but this already a rare event and the parent shouldn't otherwise be
> bothered by a spurious pm_runtime wakeup event.
> 
> > If anything I would say we could probably look at pulling the check out
> > and placing the driver check in __device_attach_async_helper since from
> > what I can tell the check is actually redundant in the non-async path
> > anyway since __device_attach already had taken the device lock and
> > checked dev->driver prior to calling __device_attach_driver.
> > 
> > > ...and after that maybe it could be made a common helper
> > > (dev_driver_checks()?) shared between __device_attach_driver() and
> > > __driver_attach() to reduce some duplication.
> > 
> > I'm not sure consolidating it into a function would really be worth the
> > extra effort. It would essentially just obfuscate the checks and I am
> > not sure you really save much with:
> >         if (dev_driver_checks(dev))
> > vs:
> >         if (!dev->dead && !dev->driver)
> > 
> > By the time you create the function and replace the few spots that are
> > making these checks you would end up most likely adding more complexity
> > to the kernel rather than reducing it any.
> 
> No, I was talking about removing this duplication in
> __device_attach_driver() and __driver_attach():
> 
>         if (ret == 0) {
>                 /* no match */
>                 return 0;
>         } else if (ret == -EPROBE_DEFER) {
>                 dev_dbg(dev, "Device match requests probe deferral\n");
>                 driver_deferred_probe_add(dev);

Is this bit of code correct? Seems like there should be a return here
doesn't it?

I just double checked and this is what is in the kernel too.

>         } else if (ret < 0) {
>                 dev_dbg(dev, "Bus failed to match device: %d", ret);
>                 return ret;
>         } /* ret > 0 means positive match */
> 
> ...and lead in with a dev->dead check.

I would think that we would want to check for dev->dead before we even
call driver_match_device. That way we don't have the match function
crawling around a device that is being disassembled. Is that what you
were referring to?

Also the context for the two functions seems to be a bit different. In
the case of __device_attach_driver the device_lock is already held. In
__driver_attach the lock on the device isn't taken until after a match
has been found.



