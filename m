Return-Path: <mst@redhat.com>
X-Google-Smtp-Source: AG47ELsv0rIRYGx8cevYJvunXsEEVm8urWscduVXbdzLLOQYt5od3eRMAbRgi4jLsNte23DOpqiN
ARC-Seal: i=1; a=rsa-sha256; t=1521121571; cv=none;
        d=google.com; s=arc-20160816;
        b=v7V7bJ1ATMt86/L5IkZQ+NbiZjgwGeb+IjP1B3b5TRJ45J67LXZm8Ia0xAqa93EfmE
         NCxubUswIH0DeLwWRz4J4QgRrI7AjAn/ijyUw2AlB1EWxYoxHUwoOm/e0eGZVyFFjYOg
         CuMGkN3PBPpmPBAoP/q+7ElbYSqgjnxlZP8Lyhz54qppMJJXix/DrwK/vBCVw5vOfyFy
         mr3bCP6Hid14jva2+48ah4Q6mN7zqHvf9Ri/o37ogIYTad+XEiQtTkUeJL/RVepvK3yu
         simMeMlBWSQaIZBbK5Pa3yPxJAo9UlBOSQstL53N3YyeqZoiLFgAaMRU2IijPYCz82cI
         rLKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:arc-authentication-results;
        bh=5W6sqdFk14AayYhkxzLTXIslM2el/1XYpc4TNJVNPlQ=;
        b=CZftlPaYzcf9mB+bkbxpCr9z7ZuovQtjuA0mq6xxVGguNqooe4u+t3kbjYjHkVxI9y
         HlxZjrveo/S2pDvifYqrn2Rpe+PIQvzn9LSyHYcjYbLD2ivxdzbaVA0zA2ONJ/EHkvbD
         fwi8e5ZxSltIJI71eusggl4gJCEQ4p8NeG+ik5YIgatJl4PmlOwecm7FPj4r1GSXGiFX
         TlNU0pNyVOkQIxpMVnmj3rjx4WK9XmOoWpooPqSKIN4OmY7CrliC3rsQa4aJzXrbYqtF
         FZC6255vQCaQ3lPWzE0kbIEwz/ysCVWHr05dFlPF3VwCoE0MTOjGw8Uh6jdM5omujvpp
         BYLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mst@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=mst@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Thu, 15 Mar 2018 15:46:06 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Or Idgar <idgar@virtualoco.com>, linux-kernel@vger.kernel.org,
	arnd@arndb.de, oidgar@redhat.com, ghammer@redhat.com,
	Or Idgar <oridgar@gmail.com>
Subject: Re: [PATCH v5] drivers/misc: vm_gen_counter: initial driver
 implementation
Message-ID: <20180315153311-mutt-send-email-mst@kernel.org>
References: <20180301142215.11812-1-idgar@virtualoco.com>
 <20180313190617-mutt-send-email-mst@kernel.org>
 <20180314182536.GA14504@kroah.com>
 <20180314211704-mutt-send-email-mst@kernel.org>
 <20180315131959.GA28568@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315131959.GA28568@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593745507285614890?=
X-GMAIL-MSGID: =?utf-8?q?1595011572692332791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 02:19:59PM +0100, Greg KH wrote:
> On Wed, Mar 14, 2018 at 09:25:17PM +0200, Michael S. Tsirkin wrote:
> > On Wed, Mar 14, 2018 at 07:25:36PM +0100, Greg KH wrote:
> > > On Tue, Mar 13, 2018 at 07:40:51PM +0200, Michael S. Tsirkin wrote:
> > > > I think it's a good idea to use sysfs for this. However,
> > > > there are a couple of missing interfaces here:
> > > > 
> > > > 1. Userspace needs a way to know when this value changes.
> > > >    I see no change notifications here and that does not seem right.
> > > 
> > > How can these change?
> > 
> > It's a hardware register. It changes when hardware feels like it :)
> 
> Does the hardware notify the kernel that it changes?  Or does the kernel
> have to "poll" for it?

Yes - it sends an ACPI interrupt notification.

> > In particular, it changes whenever VM is migrated or snapshotted.
> 
> So very rarely.  And userspace always knows about those events already,
> right?

Not at all.

> > > > 2. Userspace needs to be able to read these without
> > > >    system calls.
> > > 
> > > Ick, what?  Why not?
> > >
> > > > Pls add mmap support to the raw format.
> > > 
> > > For a single integer?  Why do you need mmap for this?  What is so
> > > "performant" that needs to touch a sysfs file?
> > > >    (Phys address is not guaranteed to be page-aligned so you will
> > > >     probably want an offset attribute for that as well).
> > > 
> > > Ick ick ick, that's why it's good to just stick with a sysfs file.
> > > 
> > > Have you tested just how long this takes to see if the open/read/close
> > > is really the bottleneck, or if the io on reading the value is the
> > > bottleneck?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Well an application needs to check this value basically after
> > every database transaction.
> 
> "every"?  That's horrid, why would you write a database that has to do
> an ACPI i/o call for every transaction?  That's a sure way to write a
> very slow database :(

Absolutely. That's why we might want to do an mmap and then get the ID
from memory. An alternative is poll support so userspace can get
notified about changes. Opens a bigger window during which you
are doing duplicate work, but maybe that's not such a big issue.

> > So I'm pretty sure it's a performance sensitive path.
> 
> Given that this api is not present today, why is this even needed?  Who
> wants/needs it so badly that it has to be tuned in ways like this?
> 
> If it is _really_ performant critical, just make it a new syscall :)

Maybe you are right and it is a premature optimization. Let's put it out
there without mmap support and see what happens - but then we definitely
need poll support.

> > But yes, I
> > didn't profile any apps since they
> > are yet to be written to use this interface.
> 
> Then what database are you talking about?  What apps need/want this
> thing?
> 
> thanks,
> 
> greg k-h

Anything that runs within a VM that is snapshoted is at risk
of sending duplicate transactions when it's restored and
time rolls back to a random point in the past.

If you want the application to have ability to detect these, then VM gen
ID offers a way to do it:
	id=read_id()
	do_work()
	new_id=read_id()
	if (new_id != id)
		find_and_handle_duplicate_work()


-- 
MST
