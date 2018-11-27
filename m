Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8ECC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3BA20659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3BA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbeK1Egk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:36:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:20527 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbeK1Egk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:36:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 09:38:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="94801867"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga006.jf.intel.com with ESMTP; 27 Nov 2018 09:38:02 -0800
Message-ID: <ec672fcf5924ef267f35b11c13ddc50c815b1a9f.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v6 4/9] driver core: Move
 async_synchronize_full call
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
Date:   Tue, 27 Nov 2018 09:38:01 -0800
In-Reply-To: <CAPcyv4ibARHP1Gji2cZQ704BeiKL26Bh13G58eyB+PjQJSD58w@mail.gmail.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170042103.12967.5841784115552956171.stgit@ahduyck-desk1.jf.intel.com>
         <CAPcyv4ibARHP1Gji2cZQ704BeiKL26Bh13G58eyB+PjQJSD58w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 18:11 -0800, Dan Williams wrote:
> On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> > 
> > Move the async_synchronize_full call out of __device_release_driver and
> > into driver_detach.
> > 
> > The idea behind this is that the async_synchronize_full call will only
> > guarantee that any existing async operations are flushed. This doesn't do
> > anything to guarantee that a hotplug event that may occur while we are
> > doing the release of the driver will not be asynchronously scheduled.
> > 
> > By moving this into the driver_detach path we can avoid potential deadlocks
> > as we aren't holding the device lock at this point and we should not have
> > the driver we want to flush loaded so the flush will take care of any
> > asynchronous events the driver we are detaching might have scheduled.
> > 
> 
> What problem is this patch solving in practice, because if there were
> drivers issuing async work from probe they would need to be
> responsible for flushing it themselves. That said it seems broken that
> the async probing infrastructure takes the device_lock inside
> async_schedule and then holds the lock when calling
> async_syncrhonize_full. Is it just luck that this hasn't caused
> deadlocks in practice?

My understanding is that it has caused some deadlocks. There was
another patch set that Bart Van Assche had submitted that was
addressing this. I just tweaked my patch set to address both the issues
he had seen as well as the performance improvements included in my
original patch set.

> Given that the device_lock is hidden from lockdep I think it would be
> helpful to have a custom lock_map_acquire() setup, similar to the
> workqueue core, to try to keep the locking rules enforced /
> documented.
> 
> The only documentation I can find for async-probe deadlock avoidance
> is the comment block in do_init_module() for async_probe_requested.

Would it make sense to just add any lockdep or deadlock documentation
as a seperate patch? I can work on it but I am not sure it makes sense
to add to this patch since there is a chance this one will need to be
backported to stable at some point.

> Stepping back a bit, does this patch have anything to do with the
> performance improvement, or is it a separate "by the way I also found
> this" kind of patch?

This is more of a seperate "by the way" type of patch based on the
discussion Bart and I had about how to best address the issue. There
may be some improvement since we only call async_synchronize_full once
and only when we are removing the driver, but I don't think it would be
very noticable.

