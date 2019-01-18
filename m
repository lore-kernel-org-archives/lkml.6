Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F908C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B472086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547826651;
	bh=TQFy+vRH6KfWVlckG3F5pPytrOgcZBEmzbR5Jcl32/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hqX/1asuXI0RZMoKu+Hox4ZDFDLtDKGWx2qhbj91ty0HYmWaCfWZ9zODJ+p2s4eub
	 a63Qr6/oMOjBx71Zj7dvJlDw7BPAkgR9GVfkMcXA+Gr3kwS7ybVfwo4uab7kFvcH1F
	 2XvNpueCUKVCxIlf0FwCSvSLcbKLhPwuiikrI/7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfARPut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:50:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbfARPup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:50:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040A72087E;
        Fri, 18 Jan 2019 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547826644;
        bh=TQFy+vRH6KfWVlckG3F5pPytrOgcZBEmzbR5Jcl32/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w+C4aKk2iFK2eOl0tXnfpgiFl2Kl54xLW7z1tDnNaVgFVcID5R/24yDkTPbmKk6Kd
         RFDjK9Ut6VzgP7jNskx1USYrFKg0rroCh7exz2UAj9vVnjHuxwPonXnp7Kq8ItPXb/
         V17p36qJRsxuo8ec0oEt2FCILMHOTYlL94Yhdnds=
Date:   Fri, 18 Jan 2019 16:50:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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
Message-ID: <20190118155042.GA5009@kroah.com>
References: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
 <154466189880.9126.10737761541647369077.stgit@ahduyck-desk1.jf.intel.com>
 <CAJZ5v0hSWOb4b7FWJmfi86mYY+T1kedtC=ydS8VMUvpH4ctzbw@mail.gmail.com>
 <20181220152844.GA27498@kroah.com>
 <0a72b8db91f9151ecc7f215b465ec8e69adc239c.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a72b8db91f9151ecc7f215b465ec8e69adc239c.camel@linux.intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:37:32AM -0800, Alexander Duyck wrote:
> On Thu, 2018-12-20 at 16:28 +0100, Greg Kroah-Hartman wrote:
> > On Wed, Dec 19, 2018 at 03:27:48PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Dec 13, 2018 at 1:45 AM Alexander Duyck
> > > <alexander.h.duyck@linux.intel.com> wrote:
> > > > 
> > > > Add an additional bit flag to the device struct named "dead".
> > > > 
> > > > This additional flag provides a guarantee that when a device_del is
> > > > executed on a given interface an async worker will not attempt to attach
> > > > the driver following the earlier device_del call. Previously this
> > > > guarantee was not present and could result in the device_del call
> > > > attempting to remove a driver from an interface only to have the async
> > > > worker attempt to probe the driver later when it finally completes the
> > > > asynchronous probe call.
> > > > 
> > > > One additional change added was that I pulled the check for dev->driver
> > > > out of the __device_attach_driver call and instead placed it in the
> > > > __device_attach_async_helper call. This was motivated by the fact that the
> > > > only other caller of this, __device_attach, had already taken the
> > > > device_lock() and checked for dev->driver. Instead of testing for this
> > > > twice in this path it makes more sense to just consolidate the dev->dead
> > > > and dev->driver checks together into one set of checks.
> > > > 
> > > > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > > > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > > 
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > It's too late for 4.21-rc1 as my tree should be closed by now.
> > 
> > So I'll hold on to these in my queue until 4.21-rc1 is out and then
> > queue them up and see what breaks in linux-next :)
> > 
> > thanks,
> > 
> > greg k-h
> 
> I just wanted to check on on this patch set in terms of workflow. Since
> it looks like we now have 5.0-rc1 out I was wondering what the ETA for
> this patch set being pulled was, or if I need to resubmit the set.

I'm reviewing it now, no need to resend...

thanks,

greg k-h
