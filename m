Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749ACC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C9B20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C9B20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeLJXZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:25:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:27921 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728025AbeLJXZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:25:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 15:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,340,1539673200"; 
   d="scan'208";a="258396684"
Received: from ahduyck-desk1.jf.intel.com ([10.7.198.76])
  by orsmga004.jf.intel.com with ESMTP; 10 Dec 2018 15:25:04 -0800
Message-ID: <dd0b44d5dd9d19ac6735f80ae66bb437ec55b2cf.camel@linux.intel.com>
Subject: Re: [driver-core PATCH v8 0/9] Add NUMA aware async_schedule calls
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-nvdimm@lists.01.org, tj@kernel.org,
        akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        pavel@ucw.cz, zwisler@kernel.org, dan.j.williams@intel.com,
        dave.jiang@intel.com, bvanassche@acm.org
Date:   Mon, 10 Dec 2018 15:25:04 -0800
In-Reply-To: <20181210192216.GJ28501@garbanzo.do-not-panic.com>
References: <154403054034.11544.3978949383914046587.stgit@ahduyck-desk1.jf.intel.com>
         <20181210192216.GJ28501@garbanzo.do-not-panic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-10 at 11:22 -0800, Luis Chamberlain wrote:
> On Wed, Dec 05, 2018 at 09:25:13AM -0800, Alexander Duyck wrote:
> > This patch set provides functionality that will help to improve the
> > locality of the async_schedule calls used to provide deferred
> > initialization.
> > 
> > This patch set originally started out focused on just the one call to
> > async_schedule_domain in the nvdimm tree that was being used to defer the
> > device_add call however after doing some digging I realized the scope of
> > this was much broader than I had originally planned. As such I went
> > through and reworked the underlying infrastructure down to replacing the
> > queue_work call itself with a function of my own and opted to try and
> > provide a NUMA aware solution that would work for a broader audience.
> > 
> > In addition I have added several tweaks and/or clean-ups to the front of the
> > patch set. Patches 1 through 4 address a number of issues that actually were
> > causing the existing async_schedule calls to not show the performance that
> > they could due to either not scaling on a per device basis, or due to issues
> > that could result in a potential deadlock. For example, patch 4 addresses the
> > fact that we were calling async_schedule once per driver instead of once
> > per device, and as a result we would have still ended up with devices
> > being probed on a non-local node without addressing this first.
> 
> No tests were added. Again, I think it would be good to add test
> cases to showcase the old mechanisms, illustrate the new, and ensure
> we don't regress both now and also help us ensure we don't regress
> moving forward.
> 
> This is all too critical of a path for the kernel, and these changes
> are rather instrusive. I'd readlly like to see test code for it now
> rather than later.
> 
>   Luis

Sorry about that. I was more focused on the rewrite of patch 2 and
overlooked the comment about lib/test_kmod.c.

I'll look into it and see if I can squeeze it in for v9.

Thanks.

- Alex

