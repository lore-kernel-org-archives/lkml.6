Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCBBC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF1D20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x92pq6NR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF1D20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbeKLGWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:22:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:52468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729720AbeKLGWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:22:36 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADFA820818;
        Sun, 11 Nov 2018 20:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541968384;
        bh=1jE6dl4WsJm2+RvstR+8zf0uNPOTbvPcrVL4TsYg/Qs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x92pq6NRqHX67UikavHCnaffJUmRQ0wvzQywViedKWN1NPK8YBd7tpSxTQPn+2vIs
         WfmxC1SA/fVqEeFqiY02vCdnad62UXhpvkTgGEijtHKtzJohl79WkRKfd7auGiO/7I
         Oc0BjPAY0cSo82RMtDIXRxRVRkrk1SwA8/Bi0hr8=
Date:   Sun, 11 Nov 2018 12:33:04 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        tj@kernel.org, akpm@linux-foundation.org, linux-pm@vger.kernel.org,
        jiangshanlai@gmail.com, rafael@kernel.org, len.brown@intel.com,
        zwisler@kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com,
        bvanassche@acm.org
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
Message-ID: <20181111203304.GA16871@kroah.com>
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com>
 <20181111193208.GB8332@kroah.com>
 <20181111195903.GA9726@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181111195903.GA9726@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 08:59:03PM +0100, Pavel Machek wrote:
> On Sun 2018-11-11 11:32:08, Greg KH wrote:
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
> We always said to companies we want to see code as soon as
> possible. You don't have to review their code, but discouraging the
> posting seems wrong.

I have a long history of Intel using me for their basic "find the
obvious bugs" review process for new driver subsystems and core changes.
When I see new major patches show up from an Intel developer without
_any_ other review from anyone else, directed at me, I get suspicious it
is happening again.

If you note, Intel is the _only_ company I say this to their developers
because of this problem combined with the fact that they have a whole
load of developers that they should be running things by first.

And yes, to answer Dan's point, we do want to do review in public.  But
this is v6 of a core patchset and there has been NO review from anyone
else at Intel on this.  So if that review was going to happen, one would
have thought it would have by now, instead of relying on me to do it.

And yes, I am grumpy, but I am grumpy because of the history here.  I am
not trying to discourage anything, only to take ADVANTAGE of resources
that almost no other company provides.

Hope this helps explain my statement here.

thanks,

greg k-h
