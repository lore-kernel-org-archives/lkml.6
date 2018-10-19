Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCF6ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFD120843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 22:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFD120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeJTGnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 02:43:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:31509 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeJTGnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 02:43:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 15:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,401,1534834800"; 
   d="scan'208";a="242754322"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga004.jf.intel.com with ESMTP; 19 Oct 2018 15:35:06 -0700
Message-ID: <b07027cb4b9d51ec8f27d9e6c0b73b3032610ebd.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, len.brown@intel.com,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 19 Oct 2018 15:35:06 -0700
In-Reply-To: <1e061fe5-9be4-77be-5350-4cb7175afdf8@acm.org>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
         <20181015150926.29520.45280.stgit@localhost.localdomain>
         <1539886275.81977.17.camel@acm.org>
         <e870da1d-48fa-7f2e-6909-b168a06633f2@linux.intel.com>
         <1539893636.81977.29.camel@acm.org>
         <CAKgT0Ucf-v3FNTA0z=3nPR-xS=0NYeqDjRfDW-KjDE5Ed-n1_g@mail.gmail.com>
         <1e061fe5-9be4-77be-5350-4cb7175afdf8@acm.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-18 at 19:31 -0700, Bart Van Assche wrote:
> On 10/18/18 7:20 PM, Alexander Duyck wrote:
> > I see what you are talking about now. Actually I think this was an
> > existing issue before my patch even came into play. Basically the
> > code
> > as it currently stands is device specific in terms of the attach
> > and
> > release code.
> > 
> > I wonder if we shouldn't have the async_synchronize_full call in
> > __device_release_driver moved down and into driver_detach before we
> > even start the for loop. Assuming the driver is no longer
> > associated
> > with the bus that should flush out all devices so that we can then
> > pull them out of the devices list at least. I may look at adding an
> > additional bitflag to the device struct to indicate that it has a
> > driver attach pending. Then for things like races between any
> > attach
> > and detach calls the logic becomes pretty straight forward. Attach
> > will set the bit and provide driver data, detach will clear the bit
> > and the driver data. If a driver loads in between it should clear
> > the
> > bit as well.
> > 
> > I'll work on it over the next couple days and hopefully have
> > something
> > ready for testing/review early next week.
> 
> Hi Alex,
> 
> How about checking in __driver_attach_async_helper() whether the
> driver 
> pointer is still valid by checking whether bus_for_each_drv(dev-
> >bus, 
> ...) can still find the driver pointer? That approach requires 
> protection with a mutex to avoid races with the driver detach code
> but 
> shouldn't require any new flags in struct device.
> 
> Thanks,
> 
> Bart.

That doesn't solve the problem I was pointing out though.

So the issue you are addressing by rechecking the bus should already be
handled by just calling async_synchronize_full in driver_detach. After
all we can't have a driver that is being added to the bus while it is
also being removed. So if we are detaching the driver calling
async_synchronize_full will flush out any deferred attach calls and
there will be no further calls since the driver has already been
removed from the bus.

The issue I was thinking of is how do we deal with races between
device_attach and device_release_driver. In that case we know the
device we want to remove a driver from, but we may not have information
about the driver. The easiest solution is to basically just disable the
pending enable. I could use the approach I am doing now and just NULL
out the driver_data if dev->driver is NULL. The only thing I am
thinking about is if just dev->driver being NULL is enough to signal
that we are using driver_data to carry a pointer to a pending driver,
or if we should add an extra bit to carry that meaning. It would be
pretty easy to just add a bit and then use that to prevent any false
reads of the deferred driver as driver data, or driver data as a
deferred driver as it would essentially act as a type bit.

Thanks.

- Alex

