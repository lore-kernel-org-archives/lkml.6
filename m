Return-Path: <cohuck@redhat.com>
X-Google-Smtp-Source: AG47ELvKt8Rjf1AGWITYzmp+0D57D4OzXKsmfhe5HRib2eWAJ9qaxRsFQjFNACutcpGfU31KZlbg
ARC-Seal: i=1; a=rsa-sha256; t=1519671097; cv=none;
        d=google.com; s=arc-20160816;
        b=l304ZxfjimfoUBURDNsW0ReO+pKp4sfwYO0WxLuAnaFh4jHHj6HNYqLz2eROkO2KCg
         W3nfGY6HMBTviAe9z6RnlgQsslJS2xKcJ0Tc7s5xSJj4lGY6FiANDfSv+Hot6D1x5I8w
         a278J5C3RasklNEBPnaoCSkiIavGh6j746W9fBCmGesM256c2aW1vNU+AOnkGRSZtOqW
         5bX99JtrQblJDfO+kwpZXUMTzADDsfRNUmLDiTXs+9X4E3sUiGz7wpSTLvfj46pZ7GAn
         v3uyU2DXyWuZrZRPGqBV/eNj56n27hOpdwP7nFkRZCzZh5W2Dujw5TlwQOyZjqV/SoXi
         6hiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=RLcvRi20D0k0uakJvFyf1PZL5LESQZIVUB3THmuakjY=;
        b=HgG0qY8/RQzzbSGP4UdzQdwrzp2ysU+DWiDqFXseniU+zBHjiUnpmDVdaXv1SZeLSx
         xCX7txpilrLrJXvKfi5hNHpxn1X0Uva9m/DUAltYiTc2W8NdpLPV+8hae8XygV/10m21
         YmEQRs8kvse3xoAqgyfdoJ2QrPhSYPK5gV1OsR9TNSkKzltLn009zXNz9YqK9IbmE9wt
         kLQWuOTXrbY3e/P266U9TvkkUJoxdcJ74Twqa68LJoKPWgCSyEYRNJ6lHuuWPaSHmZEK
         FRtBb7JHYinKAngfRtt2d+L/FzI6k75V/njZ2UxrQVbrOpdd2qK5qADzI75cXi0hh0F2
         DbbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of cohuck@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=cohuck@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of cohuck@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=cohuck@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Mon, 26 Feb 2018 19:51:31 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kwankhede@nvidia.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 cordius.wu@huawei.com, eskultet@redhat.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC] vfio/mdev: delay uevent after initialization
 complete
Message-ID: <20180226195131.71690e9a.cohuck@redhat.com>
In-Reply-To: <20180214182035.69f69c49.cohuck@redhat.com>
References: <20180209102716.32253-1-cohuck@redhat.com>
	<20180212142057.66e2b15c@w520.home>
	<20180213140901.44d55aa4.cohuck@redhat.com>
	<20180213171502.167da0e9@w520.home>
	<20180214182035.69f69c49.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1592397756759604308?=
X-GMAIL-MSGID: =?utf-8?q?1593490640792158848?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 14 Feb 2018 18:20:35 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

Ping. Does anyone have an opinion on how to proceed?

> [cc:ing Greg for his opinion on this; retaining quoting for context]
> 
> On Tue, 13 Feb 2018 17:15:02 -0700
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Tue, 13 Feb 2018 14:09:01 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > On Mon, 12 Feb 2018 14:20:57 -0700
> > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > >     
> > > > On Fri,  9 Feb 2018 11:27:16 +0100
> > > > Cornelia Huck <cohuck@redhat.com> wrote:
> > > >       
> > > > > The registration code first registers the mdev device, and then
> > > > > proceeds to populate sysfs. An userspace application that listens
> > > > > for the ADD uevent is therefore likely to look for sysfs entries
> > > > > that have not yet been created.
> > > > > 
> > > > > The canonical way to fix this is to use attribute groups that are
> > > > > registered by the driver core before it sends the ADD uevent; I
> > > > > unfortunately did not find a way to make this work in this case,
> > > > > though.
> > > > > 
> > > > > An alternative approach is to suppress uevents before we register
> > > > > with the core and generate the ADD uevent ourselves after the
> > > > > sysfs infrastructure is in place.
> > > > > 
> > > > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > > > ---
> > > > > 
> > > > > This feels like a band-aid, but I can't figure out how to handle creating
> > > > > attribute groups when there's a callback in the parent involved.
> > > > > 
> > > > > This should address the issue with libvirt's processing of mdevs raised in
> > > > > https://www.redhat.com/archives/libvir-list/2018-February/msg00023.html
> > > > > - although libvirt will still need to deal with older kernels, of course.
> > > > > 
> > > > > Best to consider this an untested patch :)        
> > > > 
> > > > I agree, this feels like a band-aide.  If every device in the kernel
> > > > needs to suppress udev events until until some key component is added,
> > > > that suggests that either udev is broken in general or not being used
> > > > as intended.        
> > > 
> > > I think udev is working exactly as designed - it's more a problem of
> > > when the kernel is sending what kind of notification to userspace, and
> > > the particular issue here is how the code sending the event (driver
> > > core) and the code assembling part of the user interface (mdev)
> > > interact.
> > >     
> > > > Zongyong submitted a different proposal to fix this
> > > > here[1].  That proposal seems a bit more sound and has precedence
> > > > elsewhere in the kernel.  What do you think of that approach?  We
> > > > don't need both afaict.  Thanks,
> > > > 
> > > > Alex
> > > > 
> > > > [1]https://patchwork.kernel.org/patch/10196197/      
> > > 
> > > Zongyong's patch is sending an additional CHANGE uevent, and I agree
> > > that doing both does not make sense. However, I think the CHANGE uevent
> > > is not quite suitable in this case, and delaying the ADD uevent is
> > > better.
> > > 
> > > [Warning, the following may be a bit rambling.]
> > > 
> > > The Linux driver model works under the assumption that any device is
> > > represented as an in-kernel object that exposes information and knobs
> > > through sysfs. As long as the device exists, userspace can poke at the
> > > sysfs entries and retrieve information or configure things.
> > > 
> > > The idea of the 'ADD' uevent is basically to let userspace know that
> > > there is now a new device with its related sysfs entries, and it may
> > > look at it and configure it. IOW, if I (as a userspace application) get
> > > the ADD uevent, I expect to be able to look at the device's sysfs
> > > entries and find all the files/directories that are usually there,
> > > without having to wait.
> > > 
> > > This expectation is broken if a device is first registered with the
> > > driver core (generating the ADD uevent) and the driver adds sysfs
> > > attributes later. To fix this, the driver core added a way to specify
> > > default attribute groups for the device, which are registered by the
> > > driver core itself before it generates the ADD uevent. Unfortunately, I
> > > did not see a way to do this here (which does not mean there isn't).
> > > The alternative was to prevent the driver core from sending the ADD
> > > uevent and do it from the mdev code when it was ready.
> > > 
> > > The 'CHANGE' uevent, on the other hand, tells userspace that something
> > > has changed for the device (that already existed). I (as a userspace
> > > application) would expect to see it if, for example, the information
> > > exposed via sysfs has changed, or maybe even if new, optional, entries
> > > have appeared and I might want to rescan. With Zongyong's patch,
> > > userspace gets the CHANGE uevent for something that was already
> > > expected to be there, and is now _really_ there. It does give userspace
> > > an indication that it can now work with the device (which certainly
> > > improves things), but I would prefer to get rid of the too-early uevent
> > > completely so that userspace does not get notified at all before the
> > > device is completely present in sysfs.
> > > 
> > > So, in short, my patch does 'don't tell userspace until we're really
> > > done', and Zongyong's patch does 'tell userspace again when we're
> > > really done'.    
> > 
> > This all sounds reasonable, but don't we have this synchronization
> > problem _everywhere_?  I apologize for referencing this bug because it's
> > not public (https://bugzilla.redhat.com/show_bug.cgi?id=1376907) but
> > the gist of it is that soft-unplugging PCI devices using the remove
> > entry in sysfs and re-adding with rescan sysfs entry results in libvirt
> > seeing the ADD uevent before the PCI config attribute is created and it
> > balks on the device.   
> 
> Yikes. So it seems that _any_ PCI device is incomplete when the ADD
> uevent is sent? Or does this just apply to an unfortunately large
> number of drivers?
> 
> > So at the PCI core we have this same issue and
> > developers are saying that there's no guarantee that sysfs entries
> > won't be added and removed at any time in the lifecycle of the device
> > and it's not the kernel's responsibility to provide that
> > synchronization.   
> 
> I think this is mixing up two things:
> - sysfs entries that are there by default. These not being in place
>   when the ADD uevent is sent sounds broken.
> - Optional sysfs entries that might change. There may be a case for
>   those to be added/removed later on (probably paired with a CHANGE
>   uevent.)
> 
> > So what are we to do?  If this issue exists in a far
> > more predominant device subsystem than mdev, do we need to reset
> > developer expectations about what sort of synchronization, if any, the
> > kernel is intending to provide?  Should we agree and document some best
> > practices around ordering of (or suppressing of) uevents so that we can
> > consistently cleanup subsystems, or define that such ordering is
> > officially not guaranteed?  Thanks,
> > 
> > Alex  
> 
> I'd like to clarify expectations here as well. My understanding has
> been what I outlined above, and what I think allows userspace to rely
> on asynchronous notifications without having to resort to polling,
> waiting, etc.
