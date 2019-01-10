Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAA9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B5521841
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbfAJRhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:37:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:36697 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729905AbfAJRhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:37:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2019 09:37:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,462,1539673200"; 
   d="scan'208";a="266148086"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2019 09:37:32 -0800
Message-ID: <0a72b8db91f9151ecc7f215b465ec8e69adc239c.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v9 1/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dave.jiang@intel.com, bvanassche@acm.org
Date:   Thu, 10 Jan 2019 09:37:32 -0800
In-Reply-To: <20181220152844.GA27498@kroah.com>
References: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
         <154466189880.9126.10737761541647369077.stgit@ahduyck-desk1.jf.intel.com>
         <CAJZ5v0hSWOb4b7FWJmfi86mYY+T1kedtC=ydS8VMUvpH4ctzbw@mail.gmail.com>
         <20181220152844.GA27498@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-20 at 16:28 +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 19, 2018 at 03:27:48PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Dec 13, 2018 at 1:45 AM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> > > 
> > > Add an additional bit flag to the device struct named "dead".
> > > 
> > > This additional flag provides a guarantee that when a device_del is
> > > executed on a given interface an async worker will not attempt to attach
> > > the driver following the earlier device_del call. Previously this
> > > guarantee was not present and could result in the device_del call
> > > attempting to remove a driver from an interface only to have the async
> > > worker attempt to probe the driver later when it finally completes the
> > > asynchronous probe call.
> > > 
> > > One additional change added was that I pulled the check for dev->driver
> > > out of the __device_attach_driver call and instead placed it in the
> > > __device_attach_async_helper call. This was motivated by the fact that the
> > > only other caller of this, __device_attach, had already taken the
> > > device_lock() and checked for dev->driver. Instead of testing for this
> > > twice in this path it makes more sense to just consolidate the dev->dead
> > > and dev->driver checks together into one set of checks.
> > > 
> > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It's too late for 4.21-rc1 as my tree should be closed by now.
> 
> So I'll hold on to these in my queue until 4.21-rc1 is out and then
> queue them up and see what breaks in linux-next :)
> 
> thanks,
> 
> greg k-h

I just wanted to check on on this patch set in terms of workflow. Since
it looks like we now have 5.0-rc1 out I was wondering what the ETA for
this patch set being pulled was, or if I need to resubmit the set.

Thanks.

- Alex

