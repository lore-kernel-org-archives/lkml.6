Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D2CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF5120818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkNdfGVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF5120818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbeKLGZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730246AbeKLGZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:25:14 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7205B20871;
        Sun, 11 Nov 2018 20:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541968541;
        bh=TCqN9dCzqMfYFN47gTO5cbWJGxI7NQGUx3QsE0/xM8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkNdfGVzIgtm9XjwoKo3DhepDf+Ga5YPYi0CKxmrjX58Ku1orfXoIIYHpQuqFeQzU
         9c73fdkjl4AwFwslvterJlZH80Q04Hk9Ku7/aD1Xu4Z+Vla0XLdUq2eQSATEKCAI+Q
         mWQ297HQAf4kNalcf/x1lTBaeXcWJDs8Mfa6oBW8=
Date:   Sun, 11 Nov 2018 12:35:41 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     alexander.h.duyck@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
Message-ID: <20181111203541.GB16871@kroah.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
 <20181111193208.GB8332@kroah.com>
 <CAPcyv4hofCTYMNN=Ow=o4RRuUPM=GLWajNAT9q6WWkuV47te_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hofCTYMNN=Ow=o4RRuUPM=GLWajNAT9q6WWkuV47te_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 11:53:20AM -0800, Dan Williams wrote:
> On Sun, Nov 11, 2018 at 11:32 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Nov 08, 2018 at 10:06:50AM -0800, Alexander Duyck wrote:
> > > Introduce four new variants of the async_schedule_ functions that allow
> > > scheduling on a specific NUMA node.
> > >
> > > The first two functions are async_schedule_near and
> > > async_schedule_near_domain end up mapping to async_schedule and
> > > async_schedule_domain, but provide NUMA node specific functionality. They
> > > replace the original functions which were moved to inline function
> > > definitions that call the new functions while passing NUMA_NO_NODE.
> > >
> > > The second two functions are async_schedule_dev and
> > > async_schedule_dev_domain which provide NUMA specific functionality when
> > > passing a device as the data member and that device has a NUMA node other
> > > than NUMA_NO_NODE.
> > >
> > > The main motivation behind this is to address the need to be able to
> > > schedule device specific init work on specific NUMA nodes in order to
> > > improve performance of memory initialization.
> > >
> > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > ---
> >
> > No one else from Intel has reviewed/verified this code at all?
> >
> > Please take advantages of the resources you have that most people do
> > not, get reviewes from your coworkers please before you send this out
> > again, as they can give you valuable help before the community has to
> > review the code...
> 
> I tend to be suspicious of code that arrives on the mailing list
> day-one with a series of company-internal reviewed-by tags. Sometimes
> there is preliminary work that can be done internally, but I think we
> should prefer to do review in the open as much as possible where it
> does not waste community time. Alex and I did reach a general internal
> consensus to send this out and get community feedback, but I assumed
> to do the bulk of the review in parallel with everyone else. That said
> I think it's fine to ask for some other acks before you take a look,
> but let's do that in the open.

Doing it in the open is great, see my response to Pavel for the history
of why I am normally suspicious of this, and why I wrote the above.

Also this patchset has had a long history of me asking for things, and
not seeing the changes happen (hint, where are the benchmark numbers I
asked for a long time ago?)  Touching the driver core like this is
tricky, and without others helping in review and test, it makes me
suspicious that it is not happening.

This would be a great time for some other people to do that review :)

thanks,

greg k-h
