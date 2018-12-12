Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D117C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005512084E
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 11:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544613592;
	bh=QKa5zYsHxYI1aGgEq7tsjj3bty4Nm9iYE05hv42O6e4=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=tUS/ykvUwcrFeabgpsbZJw2T7uYKBY8LZH6pcCu9YMls9ZOMUS5MzqxCRfFfN5JQr
	 sTTi0uEC9ZyWi70U2kcRU4gQgIIyET+Szw0Q5k0ksA9k9tucXF426z6+wAvCRshwao
	 QssDnWJCDUWfsON6EDlRterKbPjjmhTUE2xgFEJs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005512084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeLLLTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 06:19:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbeLLLTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 06:19:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 413B42084E;
        Wed, 12 Dec 2018 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544613589;
        bh=QKa5zYsHxYI1aGgEq7tsjj3bty4Nm9iYE05hv42O6e4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Cl2Q80dXbOcBc+Df03jR+jtq9eWnLR1q5QYzbJ2n+3zl3onRFKOMHDEgye5GJSKDU
         YMjJQ7PShVMnAbp2wvPUoK+yO8fdkdVFbw/4k4WzlJIWwS/Dwo6x4fSxHMhKTkYK4j
         d9xsJwUZFo5ZU1cAwqrPdfluDOrTlb43iOBHRQtY=
Date:   Wed, 12 Dec 2018 12:19:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Ramalingam C <ramalingam.c@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH] drivers/base: use a worker for sysfs unbind
Message-ID: <20181212111947.GA12685@kroah.com>
References: <20181210084653.7268-1-daniel.vetter@ffwll.ch>
 <20181210100634.GA8836@kroah.com>
 <20181210101832.GN21184@phenom.ffwll.local>
 <20181210102058.GO21184@phenom.ffwll.local>
 <20181212110840.GA21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212110840.GA21184@phenom.ffwll.local>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 12:08:40PM +0100, Daniel Vetter wrote:
> On Mon, Dec 10, 2018 at 11:20:58AM +0100, Daniel Vetter wrote:
> > On Mon, Dec 10, 2018 at 11:18:32AM +0100, Daniel Vetter wrote:
> > > On Mon, Dec 10, 2018 at 11:06:34AM +0100, Greg Kroah-Hartman wrote:
> > > > On Mon, Dec 10, 2018 at 09:46:53AM +0100, Daniel Vetter wrote:
> > > > > Drivers might want to remove some sysfs files, which needs the same
> > > > > locks and ends up angering lockdep. Relevant snippet of the stack
> > > > > trace:
> > > > > 
> > > > >   kernfs_remove_by_name_ns+0x3b/0x80
> > > > >   bus_remove_driver+0x92/0xa0
> > > > >   acpi_video_unregister+0x24/0x40
> > > > >   i915_driver_unload+0x42/0x130 [i915]
> > > > >   i915_pci_remove+0x19/0x30 [i915]
> > > > >   pci_device_remove+0x36/0xb0
> > > > >   device_release_driver_internal+0x185/0x250
> > > > >   unbind_store+0xaf/0x180
> > > > >   kernfs_fop_write+0x104/0x190
> > > > > 
> > > > > I've stumbled over this because some new patches by Ram connect the
> > > > > snd-hda-intel unload (where we do use sysfs unbind) with the locking
> > > > > chains in the i915 unload code (but without creating a new loop),
> > > > > which upset our CI. But the bug is already there and can be easily
> > > > > reproduced by unbind i915 directly.
> > > > 
> > > > This is odd, why wouldn't any driver hit this issue?  And why now since
> > > > you say this is triggerable today?
> > > 
> > > The above backtrace is triggered by unbinding i915 on current upstream
> > > kernels. Note: Will crash later on rather badly in the
> > > fbdev/fbcon/vtconsole hell, but that's separate issue (which can be worked
> > > around by first unbinding fbcon manually through sysfs).
> > > 
> > > > I know scsi was doing some strange things like trying to remove the
> > > > device itself from a sysfs callback on the device, which requires it to
> > > > just call a different kobject function created just for that type of
> > > > thing.  Would that also make sense to do here instead of your workqueue?
> > > 
> > > Note how we blow up on unregistering sw device instances supported by i915
> > > in entirely different subsystems. I guess most drivers just have sysfs
> > > files for their own stuff, where this is done as you describe. The problem
> > > is that there's an awful lot of unrelated stuff hanging off i915.
> > > 
> > > Or maybe acpi_video is busted, and should be using a different function.
> > > You haven't said which one, and I have no idea which one it is ...
> > > 
> > > And in case the context wasn't clear: This is unbinding the i915 pci
> > > driver which triggers the above lockdep splat recursion.
> > 
> > btw another option for "fixing" this would be to annotate the mutex_lock
> > in kernfs_remove_by_name_ns as recursive. Which just shuts up lockdep (and
> > might hide some real bugs), but would get the job done since there's not
> > actually a deadlock here. Just lockdep being annoyed.
> 
> So what's the pick? I can do the typing, but I don't understand all the
> driver core interactions to know what we should be doing here best.

Sorry for the delay.

Look at sdev_store_delete() in drivers/scsi/scsi_sysfs.c and see if the
logic there makes sense to do here instead.

It still seems odd that removing a sysfs file by writing to a sysfs file
at the same level really invokes lockdep as I would have thought that
this path is well-tested by now.

thanks,

greg k-h
