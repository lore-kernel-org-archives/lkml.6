Return-Path: <cohuck@redhat.com>
X-Google-Smtp-Source: AH8x224mppW9D7WCvrQDTYF1Tl7RtpJdwbqH2tnjbWtP8STZXqQHKTMH+jKhJ/cb2mOyvKhG4qNq
ARC-Seal: i=1; a=rsa-sha256; t=1518628842; cv=none;
        d=google.com; s=arc-20160816;
        b=t6zkVhZxeYt6cbUTy/44prUBLKJCmLso4Lco0WRp8goGI9t9qtIQLDyKZkE1chrRHM
         n7BDnLSKSiJgo3QSmT2chHZbwVovf5R7r/Vm+jVSco/fink5Z1Z7our6N9op2QKn8B4T
         GRvfKMFi4rXRC+yHQ9cw46Cm77VcI+JLxUUQ8WPX34b0ZnXcyTevuOpG9owgfBndRGR8
         yvkvtwVaiiKGTXDc6K9Wv3IrPaEKSjr8XZ/rgZ2MvCZcJsgZrAw/C8XzzD+37mrvZ+yD
         o3t6QD5fp536ZyY+FbJ9/s9d+NyNH79mCn2r00GE1nX6tc7Uv0xDf2bJagtRxRhf3zPK
         TS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=KrJVZm63H9b0L8JmDEkIXrGuRZPn/zzVclsFiJ7E5X4=;
        b=Ka381TCLdrZQwv5hJlZHSY/B8JGnnGwD1lmnQTTz5HtvcCpn/EXlFwSFxJhpFR/sP+
         mPI8tdlKxWlxR8toYewuongj45i2uWe9pt3Dr4nr7bAfW/iGhW0KJgAp6gYNCNiq4Igz
         LH/L0lkBsrgvx/as9DjNTpyjsKsvtBk5agslqLSnF0W/0Zo/Br+TjCpV5LN2wfL+f4ID
         UDuO2BAa0Z/CQbbt1PqgtJA4yKhN3IHrMvRSCYp1GxqaIWTZ8ZcE3XcmnncuargExG6y
         aDpZMxi/3ZoiD/RUQP1FUqwcIhIcIOjPsDos4eolm/8Wj0WwMcJClnZyAdL6dIjRhF9+
         dyzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of cohuck@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=cohuck@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of cohuck@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=cohuck@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 14 Feb 2018 18:20:35 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kwankhede@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 cordius.wu@huawei.com, eskultet@redhat.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC] vfio/mdev: delay uevent after initialization
 complete
Message-ID: <20180214182035.69f69c49.cohuck@redhat.com>
In-Reply-To: <20180213171502.167da0e9@w520.home>
References: <20180209102716.32253-1-cohuck@redhat.com>
	<20180212142057.66e2b15c@w520.home>
	<20180213140901.44d55aa4.cohuck@redhat.com>
	<20180213171502.167da0e9@w520.home>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592397756759604308?=
X-GMAIL-MSGID: =?utf-8?q?1592397756759604308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[cc:ing Greg for his opinion on this; retaining quoting for context]

On Tue, 13 Feb 2018 17:15:02 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 13 Feb 2018 14:09:01 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Mon, 12 Feb 2018 14:20:57 -0700
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > On Fri,  9 Feb 2018 11:27:16 +0100
> > > Cornelia Huck <cohuck@redhat.com> wrote:
> > >     
> > > > The registration code first registers the mdev device, and then
> > > > proceeds to populate sysfs. An userspace application that listens
> > > > for the ADD uevent is therefore likely to look for sysfs entries
> > > > that have not yet been created.
> > > > 
> > > > The canonical way to fix this is to use attribute groups that are
> > > > registered by the driver core before it sends the ADD uevent; I
> > > > unfortunately did not find a way to make this work in this case,
> > > > though.
> > > > 
> > > > An alternative approach is to suppress uevents before we register
> > > > with the core and generate the ADD uevent ourselves after the
> > > > sysfs infrastructure is in place.
> > > > 
> > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > > ---
> > > > 
> > > > This feels like a band-aid, but I can't figure out how to handle creating
> > > > attribute groups when there's a callback in the parent involved.
> > > > 
> > > > This should address the issue with libvirt's processing of mdevs raised in
> > > > https://www.redhat.com/archives/libvir-list/2018-February/msg00023.html
> > > > - although libvirt will still need to deal with older kernels, of course.
> > > > 
> > > > Best to consider this an untested patch :)      
> > > 
> > > I agree, this feels like a band-aide.  If every device in the kernel
> > > needs to suppress udev events until until some key component is added,
> > > that suggests that either udev is broken in general or not being used
> > > as intended.      
> > 
> > I think udev is working exactly as designed - it's more a problem of
> > when the kernel is sending what kind of notification to userspace, and
> > the particular issue here is how the code sending the event (driver
> > core) and the code assembling part of the user interface (mdev)
> > interact.
> >   
> > > Zongyong submitted a different proposal to fix this
> > > here[1].  That proposal seems a bit more sound and has precedence
> > > elsewhere in the kernel.  What do you think of that approach?  We
> > > don't need both afaict.  Thanks,
> > > 
> > > Alex
> > > 
> > > [1]https://patchwork.kernel.org/patch/10196197/    
> > 
> > Zongyong's patch is sending an additional CHANGE uevent, and I agree
> > that doing both does not make sense. However, I think the CHANGE uevent
> > is not quite suitable in this case, and delaying the ADD uevent is
> > better.
> > 
> > [Warning, the following may be a bit rambling.]
> > 
> > The Linux driver model works under the assumption that any device is
> > represented as an in-kernel object that exposes information and knobs
> > through sysfs. As long as the device exists, userspace can poke at the
> > sysfs entries and retrieve information or configure things.
> > 
> > The idea of the 'ADD' uevent is basically to let userspace know that
> > there is now a new device with its related sysfs entries, and it may
> > look at it and configure it. IOW, if I (as a userspace application) get
> > the ADD uevent, I expect to be able to look at the device's sysfs
> > entries and find all the files/directories that are usually there,
> > without having to wait.
> > 
> > This expectation is broken if a device is first registered with the
> > driver core (generating the ADD uevent) and the driver adds sysfs
> > attributes later. To fix this, the driver core added a way to specify
> > default attribute groups for the device, which are registered by the
> > driver core itself before it generates the ADD uevent. Unfortunately, I
> > did not see a way to do this here (which does not mean there isn't).
> > The alternative was to prevent the driver core from sending the ADD
> > uevent and do it from the mdev code when it was ready.
> > 
> > The 'CHANGE' uevent, on the other hand, tells userspace that something
> > has changed for the device (that already existed). I (as a userspace
> > application) would expect to see it if, for example, the information
> > exposed via sysfs has changed, or maybe even if new, optional, entries
> > have appeared and I might want to rescan. With Zongyong's patch,
> > userspace gets the CHANGE uevent for something that was already
> > expected to be there, and is now _really_ there. It does give userspace
> > an indication that it can now work with the device (which certainly
> > improves things), but I would prefer to get rid of the too-early uevent
> > completely so that userspace does not get notified at all before the
> > device is completely present in sysfs.
> > 
> > So, in short, my patch does 'don't tell userspace until we're really
> > done', and Zongyong's patch does 'tell userspace again when we're
> > really done'.  
> 
> This all sounds reasonable, but don't we have this synchronization
> problem _everywhere_?  I apologize for referencing this bug because it's
> not public (https://bugzilla.redhat.com/show_bug.cgi?id=1376907) but
> the gist of it is that soft-unplugging PCI devices using the remove
> entry in sysfs and re-adding with rescan sysfs entry results in libvirt
> seeing the ADD uevent before the PCI config attribute is created and it
> balks on the device. 

Yikes. So it seems that _any_ PCI device is incomplete when the ADD
uevent is sent? Or does this just apply to an unfortunately large
number of drivers?

> So at the PCI core we have this same issue and
> developers are saying that there's no guarantee that sysfs entries
> won't be added and removed at any time in the lifecycle of the device
> and it's not the kernel's responsibility to provide that
> synchronization. 

I think this is mixing up two things:
- sysfs entries that are there by default. These not being in place
  when the ADD uevent is sent sounds broken.
- Optional sysfs entries that might change. There may be a case for
  those to be added/removed later on (probably paired with a CHANGE
  uevent.)

> So what are we to do?  If this issue exists in a far
> more predominant device subsystem than mdev, do we need to reset
> developer expectations about what sort of synchronization, if any, the
> kernel is intending to provide?  Should we agree and document some best
> practices around ordering of (or suppressing of) uevents so that we can
> consistently cleanup subsystems, or define that such ordering is
> officially not guaranteed?  Thanks,
> 
> Alex

I'd like to clarify expectations here as well. My understanding has
been what I outlined above, and what I think allows userspace to rely
on asynchronous notifications without having to resort to polling,
waiting, etc.
