Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415A0C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E92A21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E92A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeK3JAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:00:50 -0500
Received: from mga12.intel.com ([192.55.52.136]:56530 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeK3JAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:00:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 13:53:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,296,1539673200"; 
   d="scan'208";a="94227712"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2018 13:53:57 -0800
Message-ID: <53173cf971f5fbd33d744a1734dda87cb66c4206.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v7 2/9] driver core: Establish clear order
 of operations for deferred probe and remove
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
Date:   Thu, 29 Nov 2018 13:53:57 -0800
In-Reply-To: <CAPcyv4j2w6ygzuP-vEKPk6NGLCEB6FcKTVFQkUqr3HC471xJsg@mail.gmail.com>
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
         <154345153672.18040.3771035148218843351.stgit@ahduyck-desk1.amr.corp.intel.com>
         <CAPcyv4gMswOJ3VTaY6P7f=iG_jNBKZyynn22CLrEBB13Fq-8vQ@mail.gmail.com>
         <a5b33ae899fc4131abf0f26af33a6c6b7f462431.camel@linux.intel.com>
         <CAPcyv4j2w6ygzuP-vEKPk6NGLCEB6FcKTVFQkUqr3HC471xJsg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-11-29 at 10:55 -0800, Dan Williams wrote:
> On Thu, Nov 29, 2018 at 10:07 AM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> > 
> > On Wed, 2018-11-28 at 17:57 -0800, Dan Williams wrote:
> 
> [..]
> > > I think the flag should be named "cancel" and set it in the
> > > device_del() path. Otherwise this is encoding code flow state in the
> > > struct rather than device-state that the code needs to comprehend.
> > 
> > Instead of "cancel" what would you think of "dead"? In my mind once we
> > call device_del we are essentially working with a dead device object so
> > that might make more sense in terms of a state rather than "cancel"
> > which doesn't really tell us what should be canceled.
> 
> That sounds good to me.
> 
> > Looking over the code I could probably set it before we start calling
> > the notifiers for BUS_NOTIFY_DEL_DEVICE. The only thing I am not sure
> > about is if we would need to add any sort of synchronization primitives
> > around it.
> > 
> 
> I think it needs to be something like a barrier:
> 
>     dev->dead;
>     device_lock();
>     device_unlock();
> 
> ...where you can be sure that anyone after that device_unlock() has
> acted on dev->dead, or will see dev->dead.

Actually what I think I will do is set dev->dead to true with the
device lock held at the start of device_del. So something like:
	device_lock();
	dev->dead = true;
	device_unlock();

It seems like that would probably make the most sense and be consistent
with the handling of other bits such as dev->offline. It means adding
one more call to device_lock/unlock but it guarantees that the update
behavior is consistent with the other bitfields near it and that we
cannot have an asynchronous probe routine trying to run while we are
tearing out the bus/class/sysfs from underneath the device.

