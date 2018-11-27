Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EF7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A95208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12A95208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbeK1DsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:48:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:14150 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbeK1DsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:48:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 08:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="95741468"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga008.jf.intel.com with ESMTP; 27 Nov 2018 08:49:31 -0800
Message-ID: <b1ee672ccc2746ce57fb6a0def3d553faa462785.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v5 5/9] driver core: Establish clear order
 of operations for deferred probe and remove
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Date:   Tue, 27 Nov 2018 08:49:30 -0800
In-Reply-To: <CAPcyv4ieNzbx5iN74ZCAKDesgYt_67iM_DC-A35M=Z9jfR+YAQ@mail.gmail.com>
References: <154145223352.29224.8912797012647157172.stgit@ahduyck-desk1.jf.intel.com>
         <154145232484.29224.1635232599636954462.stgit@ahduyck-desk1.jf.intel.com>
         <CAPcyv4ieNzbx5iN74ZCAKDesgYt_67iM_DC-A35M=Z9jfR+YAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 18:35 -0800, Dan Williams wrote:
> On Mon, Nov 5, 2018 at 1:12 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> > 
> > This patch adds an additional bit to the device struct named async_probe.
> > This additional bit allows us to guarantee ordering between probe and
> > remove operations.
> > 
> > This allows us to guarantee that if we execute a remove operation or a
> > driver load attempt on a given interface it will not attempt to update the
> > driver member asynchronously following the earlier operation. Previously
> > this guarantee was not present and could result in us attempting to remove
> > a driver from an interface only to have it show up later when it is
> > asynchronously loaded.
> > 
> > One change I made in addition is I replaced the use of "bool X:1" to define
> > the bitfield to a "u8 X:1" setup in order to resolve some checkpatch
> > warnings.
> 
> The usage of "us" in the changelog through me off, please reword this
> to explicitly state the subject like: "The additional bit allows the
> driver core to guarantee ordering between probe and remove
> operations."

Okay, I will work on the wording here.

> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
> >  drivers/base/dd.c      |  104 +++++++++++++++++++++++++++---------------------
> >  include/linux/device.h |    9 ++--
> >  2 files changed, 64 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index e74cefeb5b69..ed19cf0d6f9a 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -472,6 +472,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
> >                  drv->bus->name, __func__, drv->name, dev_name(dev));
> >         WARN_ON(!list_empty(&dev->devres_head));
> > 
> > +       /* clear async_probe flag as we are no longer deferring driver load */
> > +       dev->async_probe = false;
> >  re_probe:
> >         dev->driver = drv;
> > 
> > @@ -771,6 +773,10 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
> > 
> >         device_lock(dev);
> > 
> > +       /* nothing to do if async_probe has been cleared */
> > +       if (!dev->async_probe)
> > +               goto out_unlock;
> > +
> >         if (dev->parent)
> >                 pm_runtime_get_sync(dev->parent);
> > 
> > @@ -781,7 +787,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
> > 
> >         if (dev->parent)
> >                 pm_runtime_put(dev->parent);
> > -
> > +out_unlock:
> >         device_unlock(dev);
> > 
> >         put_device(dev);
> > @@ -826,6 +832,7 @@ static int __device_attach(struct device *dev, bool allow_async)
> >                          */
> >                         dev_dbg(dev, "scheduling asynchronous probe\n");
> >                         get_device(dev);
> > +                       dev->async_probe = true;
> >                         async_schedule(__device_attach_async_helper, dev);
> >                 } else {
> >                         pm_request_idle(dev);
> > @@ -971,62 +978,69 @@ EXPORT_SYMBOL_GPL(driver_attach);
> >   */
> >  static void __device_release_driver(struct device *dev, struct device *parent)
> >  {
> > -       struct device_driver *drv;
> > +       struct device_driver *drv = dev->driver;
> > 
> > -       drv = dev->driver;
> > -       if (drv) {
> > -               while (device_links_busy(dev)) {
> > -                       __device_driver_unlock(dev, parent);
> > +       /*
> > +        * In the event that we are asked to release the driver on an
> > +        * interface that is still waiting on a probe we can just terminate
> > +        * the probe by setting async_probe to false. When the async call
> > +        * is finally completed it will see this state and just exit.
> > +        */
> > +       dev->async_probe = false;
> > +       if (!drv)
> > +               return;
> 
> Patch 4 deleted the async_synchronize_full() that would have flushed
> in-flight ->probe() relative to the current ->remove(). If remove runs
> before probe then would seem to be deadlock condition, but if
> ->remove() runs before probe then dev->driver is NULL and we abort. So
> I'm struggling to see what value dev->async_probe provides over
> dev->driver?

So the issue addressed by patch 4 is a deadlock on the device driver
lock. Also it didn't make much sense to flush per device when we really
only needed to flush things once and then clean up the devices.

What I am doing with the async_probe value is providing a way to
gracefully shutdown any deferred probe calls that may be outstanding
without having to resort to an explicit flush. The problem with the
flush is that you have to release the device lock and as soon as you
have done that the potential for something else to occur gets opended
up. The general issue I have with just trying to use dev->driver is
that it assumes the probe has already completed. That may not always be
the case. My main concern would be with a device that is popping in and
out of existence quickly so that something like a remove call is being
made before the driver has been loaded. I would prefer all possible
cases where probe and then remove is called in quick succession to
result in no driver being loaded instead of a driver loading on a
device that maybe shouldn't be there.

As far as the remove before probe case that should have no effect with
this code since it would just transition async_probe from false to
false so the extra write would have no effect.


