Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A803C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1742186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545319729;
	bh=+E4yyKDeZJn3Kxkx2iyRDuqOmqPRzY6Oo/MlxHoRdtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FbnaASU8D/ix6XHoC5mL/9pGLdwms5Aam4YPKFGJkyw3Sy3u8hC0Zwuuxbla3cDB9
	 FC6EiCgei/nrwJpukQ4mYx5+z8NYOaDyzFGRj2kF+JBWAsngJKIIRBRaNi1JCVUeB8
	 WWJJBYQzvp2mMRWmA3E3PUJqAIBYUJ/nPVjIFtmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbeLTP2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:28:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:52722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729927AbeLTP2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:28:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E13E217D8;
        Thu, 20 Dec 2018 15:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545319727;
        bh=+E4yyKDeZJn3Kxkx2iyRDuqOmqPRzY6Oo/MlxHoRdtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FrVRwTjjBUsHJrZQTNGoO0VLu6kO+WN5yEQpa2wabUayTUgZzXJcVsYUeofDaJeFC
         Ny+pdUiCKVWXPekeQy9ru3yBLHa4vpZ9bskH3Rly3pYWU7fL6Ulcqw1egFPnZQBiZF
         c0nfGyWCtzg/aUvCEnRiY7FXquhahAPYN+4Pw3Nw=
Date:   Thu, 20 Dec 2018 16:28:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     alexander.h.duyck@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dave.jiang@intel.com, bvanassche@acm.org
Subject: Re: [driver-core PATCH v9 1/9] driver core: Establish order of
 operations for device_add and device_del via bitflag
Message-ID: <20181220152844.GA27498@kroah.com>
References: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
 <154466189880.9126.10737761541647369077.stgit@ahduyck-desk1.jf.intel.com>
 <CAJZ5v0hSWOb4b7FWJmfi86mYY+T1kedtC=ydS8VMUvpH4ctzbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hSWOb4b7FWJmfi86mYY+T1kedtC=ydS8VMUvpH4ctzbw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 03:27:48PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 13, 2018 at 1:45 AM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
> >
> > Add an additional bit flag to the device struct named "dead".
> >
> > This additional flag provides a guarantee that when a device_del is
> > executed on a given interface an async worker will not attempt to attach
> > the driver following the earlier device_del call. Previously this
> > guarantee was not present and could result in the device_del call
> > attempting to remove a driver from an interface only to have the async
> > worker attempt to probe the driver later when it finally completes the
> > asynchronous probe call.
> >
> > One additional change added was that I pulled the check for dev->driver
> > out of the __device_attach_driver call and instead placed it in the
> > __device_attach_async_helper call. This was motivated by the fact that the
> > only other caller of this, __device_attach, had already taken the
> > device_lock() and checked for dev->driver. Instead of testing for this
> > twice in this path it makes more sense to just consolidate the dev->dead
> > and dev->driver checks together into one set of checks.
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It's too late for 4.21-rc1 as my tree should be closed by now.

So I'll hold on to these in my queue until 4.21-rc1 is out and then
queue them up and see what breaks in linux-next :)

thanks,

greg k-h
