Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB38CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D1B2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D1B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbeK1FCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:02:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:26247 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732136AbeK1FCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:02:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 10:04:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="112406987"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga001.jf.intel.com with ESMTP; 27 Nov 2018 10:04:09 -0800
Message-ID: <2031cf4705d76dd4d0f722a600a6a106cce2ba41.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v6 9/9] libnvdimm: Schedule device
 registration on node local to the device
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
Date:   Tue, 27 Nov 2018 10:04:09 -0800
In-Reply-To: <CAPcyv4jmTbHZbs2KHhH2_S6=mxxkwdiJCDL6widexMzePhNFBg@mail.gmail.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
         <154170044652.12967.17419321472770956712.stgit@ahduyck-desk1.jf.intel.com>
         <CAPcyv4jmTbHZbs2KHhH2_S6=mxxkwdiJCDL6widexMzePhNFBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-26 at 18:21 -0800, Dan Williams wrote:
> On Thu, Nov 8, 2018 at 10:07 AM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> > 
> > Force the device registration for nvdimm devices to be closer to the actual
> > device. This is achieved by using either the NUMA node ID of the region, or
> > of the parent. By doing this we can have everything above the region based
> > on the region, and everything below the region based on the nvdimm bus.
> > 
> > By guaranteeing NUMA locality I see an improvement of as high as 25% for
> > per-node init of a system with 12TB of persistent memory.
> > 
> 
> It seems the speed-up is achieved with just patches 1, 2, and 9 from
> this series, correct? I wouldn't want to hold up that benefit while
> the driver-core bits are debated.

Actually patch 6 ends up impacting things for persistent memory as
well. The problem is that all the async calls to add interfaces only do
anything if the driver is already loaded. So there are cases such as
the X86_PMEM_LEGACY_DEVICE case where the memory regions end up still
being serialized because the devices are added before the driver.

> You can add:
> 
>     Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...if the series needs to be kept together, but as far as I can see
> the workqueue changes enable 2 sub-topics of development and it might
> make sense for Tejun to take those first 2 and then Greg and I can
> base any follow-up topics on that stable baseline.

I had originally put this out there for Tejun to apply, but him and
Greg had talked and Greg agreed to apply the set. If it works for you I
would prefer to just keep it together for now as I don't believe there
will be too many more revisions of this needed.

