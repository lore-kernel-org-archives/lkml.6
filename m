Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A836CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7575A218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548401870;
	bh=UOALMbGG5EUTvdlXSbg1y4umlv5djU9VR0sxjhU8ScU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lAzNzAw4VZyYbMI8IpaKVqEB1L2Q8TGzTHv1fwTaV0U9EoaYc6Txp7WowseznIClU
	 xGc+Y8Xemg0dvKjZr6ggodBDjceP0gPVC8zSgTt9PtAc51HJ8V0VtPgvUG0Zpzrn4I
	 r4wIEboItOFohai9GweFHx+KTu1qiQvN2QmVOReo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfAYHhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:37:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbfAYHhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:37:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48012218D0;
        Fri, 25 Jan 2019 07:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548401867;
        bh=UOALMbGG5EUTvdlXSbg1y4umlv5djU9VR0sxjhU8ScU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umZZvCc7v2StZzKS5aAogMgSqldxpQB+kpXg53YfR6e6KKdoXQUB9zLXEPiyABmc3
         b0u0ZA+sQs3OgpBqVzwgi+DXDzSlA9MDMZzhkRj1BvFPbm5+eIpRMX1DhZ8GgqKm6w
         vz9KZYGphqKGWA89sdGNoNgAT1D1q5TNFIfNa8+s=
Date:   Fri, 25 Jan 2019 08:37:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, ogabbay@habana.ai
Subject: Re: [PATCH 00/15] Habana Labs kernel driver
Message-ID: <20190125073745.GD11891@kroah.com>
References: <20190123000057.31477-1-oded.gabbay@gmail.com>
 <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tznaiw+a7rWqfdMMO6Aj3GtsO9vetd=3n9d+bGLW0U8Cg@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 07:57:11AM +1000, Dave Airlie wrote:
> On Wed, 23 Jan 2019 at 10:01, Oded Gabbay <oded.gabbay@gmail.com> wrote:
> >
> > Hello,
> >
> > For those who don't know me, my name is Oded Gabbay (Kernel Maintainer
> > for AMD's amdkfd driver, worked at RedHat's Desktop group) and I work at
> > Habana Labs since its inception two and a half years ago.
> 
> Hey Oded,
> 
> So this creates a driver with a userspace facing API via ioctls.
> Although this isn't a "GPU" driver we have a rule in the graphics
> drivers are for accelerators that we don't merge userspace API with an
> appropriate userspace user.
> 
> https://dri.freedesktop.org/docs/drm/gpu/drm-uapi.html#open-source-userspace-requirements
> 
> I see nothing in these accelerator drivers that make me think we
> should be treating them different.

I understand that this is your position on when you accept drivers into
the DRM layer, as you need to interact with common interfaces and a
massive userspace stack at the same time.  And that's wonderful, it
allows you to be able to move both sides of that stack forward without
removing support for devices that worked on older kernels.

But, that's not really the case with this new driver at all.  We add new
driver subsystems, and individual drivers, with loads of new ioctls, in
every new kernel release.  We don't impose on all of them the "your
userspace code must be open" rule, so why is this new driver somehow
different from them?

Yes, there is the fun legal issue of "derivative works" when talking
about a userspace program that is written to only interact with a
specific kernel driver using a custom api like this one has, and how the
license of the kernel side (GPLv2) affects the userspace side
(whatever), but that is something that I leave up to the lawyers who
like discussing and enforcing such things.

When evaluating this driver (note, I saw it for a few revisions before
Oded posted it here), all I did was try to make sure that it fit in
properly with the kernel apis and methods of operations.  Given that
there are no in-kernel drivers for this type of device, and that it
really is a pretty small shim layer around the hardware, which means
that userspace does a lot of the heavy lifting, it is going to be a
very hardware-specific user/kernel api, and that shows.

Sidenote, this could have almost just been a UIO driver, which would
have put _ALL_ of the logic in userspace.  At least this way we have a
chance for the kernel code to be sane and not try to inflict problems on
the rest of the system.

Going forward, it would be wonderful if we could come up with a unified
api for how to interact with these types of hardware accelerators, but
given the newness of this industry, and the vastly different ways people
are trying to solve the problem, that is going to take a few attempts,
and many years before we can get there.  Until then, taking drivers like
this into the kernel tree makes sense as that way all of our users will
be able to use that hardware, and better yet, the rest of us can learn
more about how this stuff works so that we can help out with that api
generation when it happens.

So for now, I have no objection to taking this type of driver into the
tree.  Yes, it would be wonderful if we had an open userspace program to
drive it so that we could actually test and make changes to the api over
time, but I think that is something that the submitting company needs to
realize will be better for them to do, as for right now, all of that
testing and changes are their responsibility.

As for what directory the code should live in, I suggested "misc" as
there was no other universal location, and I hate to see new subsystems
be created with only one driver, as that's pretty sad.  But it's just a
name/location, I have no dog in the fight, so I really don't care where
it ends up in the tree, just as long as it gets merged somewhere :)

thanks,

greg k-h
