Date: Thu, 15 Mar 2018 14:19:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Or Idgar <idgar@virtualoco.com>, linux-kernel@vger.kernel.org,
	arnd@arndb.de, oidgar@redhat.com, ghammer@redhat.com,
	Or Idgar <oridgar@gmail.com>
Subject: Re: [PATCH v5] drivers/misc: vm_gen_counter: initial driver
 implementation
Message-ID: <20180315131959.GA28568@kroah.com>
References: <20180301142215.11812-1-idgar@virtualoco.com>
 <20180313190617-mutt-send-email-mst@kernel.org>
 <20180314182536.GA14504@kroah.com>
 <20180314211704-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314211704-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 09:25:17PM +0200, Michael S. Tsirkin wrote:
> On Wed, Mar 14, 2018 at 07:25:36PM +0100, Greg KH wrote:
> > On Tue, Mar 13, 2018 at 07:40:51PM +0200, Michael S. Tsirkin wrote:
> > > I think it's a good idea to use sysfs for this. However,
> > > there are a couple of missing interfaces here:
> > > 
> > > 1. Userspace needs a way to know when this value changes.
> > >    I see no change notifications here and that does not seem right.
> > 
> > How can these change?
> 
> It's a hardware register. It changes when hardware feels like it :)

Does the hardware notify the kernel that it changes?  Or does the kernel
have to "poll" for it?

> In particular, it changes whenever VM is migrated or snapshotted.

So very rarely.  And userspace always knows about those events already,
right?

> > > 2. Userspace needs to be able to read these without
> > >    system calls.
> > 
> > Ick, what?  Why not?
> >
> > > Pls add mmap support to the raw format.
> > 
> > For a single integer?  Why do you need mmap for this?  What is so
> > "performant" that needs to touch a sysfs file?
> > >    (Phys address is not guaranteed to be page-aligned so you will
> > >     probably want an offset attribute for that as well).
> > 
> > Ick ick ick, that's why it's good to just stick with a sysfs file.
> > 
> > Have you tested just how long this takes to see if the open/read/close
> > is really the bottleneck, or if the io on reading the value is the
> > bottleneck?
> > 
> > thanks,
> > 
> > greg k-h
> 
> Well an application needs to check this value basically after
> every database transaction.

"every"?  That's horrid, why would you write a database that has to do
an ACPI i/o call for every transaction?  That's a sure way to write a
very slow database :(

> So I'm pretty sure it's a performance sensitive path.

Given that this api is not present today, why is this even needed?  Who
wants/needs it so badly that it has to be tuned in ways like this?

If it is _really_ performant critical, just make it a new syscall :)

> But yes, I
> didn't profile any apps since they
> are yet to be written to use this interface.

Then what database are you talking about?  What apps need/want this
thing?

thanks,

greg k-h
