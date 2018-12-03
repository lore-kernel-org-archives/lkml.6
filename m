Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B328FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6FB2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 16:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6FB2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeLCQot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 11:44:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:56867 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeLCQot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 11:44:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 08:44:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,311,1539673200"; 
   d="scan'208";a="97664638"
Received: from ahduyck-desk1.amr.corp.intel.com ([10.7.198.76])
  by orsmga006.jf.intel.com with ESMTP; 03 Dec 2018 08:44:43 -0800
Message-ID: <c60069cf68cd0c674f31f7690406bb97dd39c8da.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v7 4/9] driver core: Probe devices
 asynchronously instead of the driver
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        brendanhiggins@google.com
Date:   Mon, 03 Dec 2018 08:44:43 -0800
In-Reply-To: <20181201024847.GH28501@garbanzo.do-not-panic.com>
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
         <154345154692.18040.8161459765233879389.stgit@ahduyck-desk1.amr.corp.intel.com>
         <20181201024847.GH28501@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 18:48 -0800, Luis Chamberlain wrote:
> On Wed, Nov 28, 2018 at 04:32:26PM -0800, Alexander Duyck wrote:
> > Probe devices asynchronously instead of the driver.
> > +static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
> > +{
> > +	struct device *dev = _dev;
> > +	struct device_driver *drv;
> > +
> > +	__device_driver_lock(dev, dev->parent);
> > +
> > +	/*
> > +	 * If someone attempted to bind a driver either successfully or
> > +	 * unsuccessfully before we got here we should just skip the driver
> > +	 * probe call.
> > +	 */
> > +	drv = dev_get_drv_async(dev);
> > +	if (drv && !dev->driver)
> > +		driver_probe_device(drv, dev);
> 
> I believe this should mean drivers which have async work on probe can
> deadlock. For instance, if a driver does call async_schedule() or a
> derivative call does this for it, the kernel will call
> async_synchronize_full() and I believe we deadlock.
> 
> Are we sure most subsystems which would use async probe will not have
> an async_schedule() call?
> 
>   Luis

So the async_schedule call isn't a problem. I would only be an issue if
they are calling async_sychronize_full while we are holding a lock
and/or mutex. To mitigate that I believe many drivers are just using
the domain version of things instead of using the global async calls.

An issue like what you have described would already exist if there is
code like that floating around out there. As is this patch isn't
changing the fact that a driver can load asynchronously. All it is
doing is allowing each device to be handled asynchronously instead of
having just one thread work its way though all the devices one at a
time.

The earlier bug we were addressing in patch 1/9 was something like what
you were describing where we were performing an async_synchronize_full
while holding the device lock. I would think the requirement if you are
going to are going to use async within a driver is to use the domain
specific version instead of just synchronizing entire domains, or if
you must synchronize the entire domain you should not be doing so while
holding any locks and/or mutexs.

One of the reasons why I am using a flag to perform the synchronization
between the device_add and device_del in patch 2 is because technically
any driver can be turned into an asynchronous probing driver by just
adding the kernel parameter <driver>.async_probe. That flag is somewhat
hidden here as dev_get_drv_async was checking for the async_probe flag
in this version of the patch. In the future I plan to replace the
"async_probe" flag with a "dead" flag to indicate that the device is in
the process of doing through a device_del which should accomplish the
same thing.

- Alex

