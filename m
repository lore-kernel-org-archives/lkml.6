Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358B9C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 015C52082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015C52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbeLJWYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:24:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:45578 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbeLJWYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:24:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 14:24:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,339,1539673200"; 
   d="scan'208";a="282518796"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga005.jf.intel.com with ESMTP; 10 Dec 2018 14:24:10 -0800
Message-ID: <00810f93b199c524378b5c963d49bd798c5d9843.camel@linux.intel.com>
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
Date:   Mon, 10 Dec 2018 14:24:10 -0800
In-Reply-To: <CAPcyv4hrML3SKnFP9UANC-hdTrpnOx4nWX=b-yhLsLuujL5oAA@mail.gmail.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
         <154403072403.11544.10419282512791659652.stgit@ahduyck-desk1.jf.intel.com>
         <CAPcyv4jH_Op-xHTd2FwQizPaWFx_2FE-pVsOLLmZAEK8EVPrYg@mail.gmail.com>
         <15b6817fd945a1622afe673b46b028bacefad72b.camel@linux.intel.com>
         <CAPcyv4i1RTrKYX0YpyCRE=pqt3pHBRiCGQq1wYUriLjKKTVA7A@mail.gmail.com>
         <bd92d0a3ff60097bf4424ff4c556a5369e66da6d.camel@linux.intel.com>
         <CAPcyv4jDG_2VwFr4oDGCURFrA=B0Bs2HGN9exLE47vDj0P3_8A@mail.gmail.com>
         <CAPcyv4hrML3SKnFP9UANC-hdTrpnOx4nWX=b-yhLsLuujL5oAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 13:23 -0800, Dan Williams wrote:
> On Mon, Dec 10, 2018 at 1:15 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > 
> > On Mon, Dec 10, 2018 at 12:58 PM Alexander Duyck
> > <alexander.h.duyck@linux.intel.com> wrote:
> 
> [..]
> > > Also the context for the two functions seems to be a bit different. In
> > > the case of __device_attach_driver the device_lock is already held. In
> > > __driver_attach the lock on the device isn't taken until after a match
> > > has been found.
> > 
> > Yes, I was only pattern matching when looking at the context of where
> > dev->dead is checked in __driver_attach() and wondering why it was
> > checked outside of __device_attach_driver()
> 
> ...and now I realize the bigger point of your concern, we need to
> check dev->dead after acquiring the device_lock otherwise the race is
> back. We can defer that consolidation, but the larger concern of
> making it internal to __device_attach_driver() still stands.

I'm still not a fan of moving it into __device_attach_driver. I would
much rather pull out the dev->driver check and instead place that in
__device_attach_async_helper.

The __device_attach function as I said took the device_lock and had
already checked dev->driver. So in the non-async path it shouldn't be
possible for dev->driver to ever be set anyway. In addition
__device_attach_driver is called once for each driver on a given bus,
so dropping the test should reduce driver load time since it is one
less test that has to be performed per driver.

