Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935248AbeBMNJI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:09:08 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935116AbeBMNJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:09:06 -0500
Date: Tue, 13 Feb 2018 14:09:01 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kwankhede@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cordius.wu@huawei.com,
        eskultet@redhat.com
Subject: Re: [PATCH RFC] vfio/mdev: delay uevent after initialization
 complete
Message-ID: <20180213140901.44d55aa4.cohuck@redhat.com>
In-Reply-To: <20180212142057.66e2b15c@w520.home>
References: <20180209102716.32253-1-cohuck@redhat.com>
        <20180212142057.66e2b15c@w520.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2018 14:20:57 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Fri,  9 Feb 2018 11:27:16 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > The registration code first registers the mdev device, and then
> > proceeds to populate sysfs. An userspace application that listens
> > for the ADD uevent is therefore likely to look for sysfs entries
> > that have not yet been created.
> > 
> > The canonical way to fix this is to use attribute groups that are
> > registered by the driver core before it sends the ADD uevent; I
> > unfortunately did not find a way to make this work in this case,
> > though.
> > 
> > An alternative approach is to suppress uevents before we register
> > with the core and generate the ADD uevent ourselves after the
> > sysfs infrastructure is in place.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> > 
> > This feels like a band-aid, but I can't figure out how to handle creating
> > attribute groups when there's a callback in the parent involved.
> > 
> > This should address the issue with libvirt's processing of mdevs raised in
> > https://www.redhat.com/archives/libvir-list/2018-February/msg00023.html
> > - although libvirt will still need to deal with older kernels, of course.
> > 
> > Best to consider this an untested patch :)  
> 
> I agree, this feels like a band-aide.  If every device in the kernel
> needs to suppress udev events until until some key component is added,
> that suggests that either udev is broken in general or not being used
> as intended.  

I think udev is working exactly as designed - it's more a problem of
when the kernel is sending what kind of notification to userspace, and
the particular issue here is how the code sending the event (driver
core) and the code assembling part of the user interface (mdev)
interact.

> Zongyong submitted a different proposal to fix this
> here[1].  That proposal seems a bit more sound and has precedence
> elsewhere in the kernel.  What do you think of that approach?  We
> don't need both afaict.  Thanks,
> 
> Alex
> 
> [1]https://patchwork.kernel.org/patch/10196197/

Zongyong's patch is sending an additional CHANGE uevent, and I agree
that doing both does not make sense. However, I think the CHANGE uevent
is not quite suitable in this case, and delaying the ADD uevent is
better.

[Warning, the following may be a bit rambling.]

The Linux driver model works under the assumption that any device is
represented as an in-kernel object that exposes information and knobs
through sysfs. As long as the device exists, userspace can poke at the
sysfs entries and retrieve information or configure things.

The idea of the 'ADD' uevent is basically to let userspace know that
there is now a new device with its related sysfs entries, and it may
look at it and configure it. IOW, if I (as a userspace application) get
the ADD uevent, I expect to be able to look at the device's sysfs
entries and find all the files/directories that are usually there,
without having to wait.

This expectation is broken if a device is first registered with the
driver core (generating the ADD uevent) and the driver adds sysfs
attributes later. To fix this, the driver core added a way to specify
default attribute groups for the device, which are registered by the
driver core itself before it generates the ADD uevent. Unfortunately, I
did not see a way to do this here (which does not mean there isn't).
The alternative was to prevent the driver core from sending the ADD
uevent and do it from the mdev code when it was ready.

The 'CHANGE' uevent, on the other hand, tells userspace that something
has changed for the device (that already existed). I (as a userspace
application) would expect to see it if, for example, the information
exposed via sysfs has changed, or maybe even if new, optional, entries
have appeared and I might want to rescan. With Zongyong's patch,
userspace gets the CHANGE uevent for something that was already
expected to be there, and is now _really_ there. It does give userspace
an indication that it can now work with the device (which certainly
improves things), but I would prefer to get rid of the too-early uevent
completely so that userspace does not get notified at all before the
device is completely present in sysfs.

So, in short, my patch does 'don't tell userspace until we're really
done', and Zongyong's patch does 'tell userspace again when we're
really done'.
