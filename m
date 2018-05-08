Date: Tue, 8 May 2018 09:41:55 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>,
	Finn Thain <fthain@telegraphics.com.au>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
Message-ID: <20180508074155.GA8561@kroah.com>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com>
 <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com>
 <CAOmrzk+bY5wUxJhNAwO-pf+O--HiqJ63rB3BmxRsY8qq_PeLmw@mail.gmail.com>
 <20180508070037.GA4792@kroah.com>
 <CAMuHMdUAWfmiaZG7snEQRL1N-w69NuSYzeoQgQosQRf_JTZ5OQ@mail.gmail.com>
 <20180508072522.GA26568@kroah.com>
 <CAMuHMdX+utbGHOV1p_oFwaKigxGBMMgkC_v5hWCO4EoVXeqezg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX+utbGHOV1p_oFwaKigxGBMMgkC_v5hWCO4EoVXeqezg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 09:35:10AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Tue, May 8, 2018 at 9:25 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, May 08, 2018 at 09:07:27AM +0200, Geert Uytterhoeven wrote:
> >> On Tue, May 8, 2018 at 9:00 AM, Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >> > On Mon, May 07, 2018 at 09:51:12AM +1200, Michael Schmitz wrote:
> >> >> the BUG() was triggered by loading a Mac Nubus network card module on
> >> >> a multiplatform kernel running on an Amiga machine. Up to Finn's Nubus
> >> >> core rewrite (this February), we've seen no errors. Since then, Nubus
> >> >> drivers fail to register because the Nubus bus is only registered on
> >> >> Macs.
> >> >>
> >> >> Can't see link order involved here at all.
> >> >
> >> > The link order is totally involved here :)
> >> >
> >> > Link order determines the order in which init calls are run, so you need
> >> > to ensure that your bus code comes before any drivers that use that bus
> >> > code in link order.  That way, at init time, your bus is created first,
> >> > preventing this type of error to happen.
> >>
> >> The issue here is not due to link ordering, but due to the bus not being
> >> registered on a system that doesn't have that particular bus.
> >
> > But how can that happen if the bus code is not present in the system at
> > that point in time?  Hardware doesn't matter at all here.
> 
> The bus code is present in the system.
> The bus is just not registered by the NuBus bus driver if the hardware
> doesn't have a NuBus host.

Ah, that sounds like some "tight" coupling that other bus cores do not
have.  That's the confusion here that I have, sorry.

> >> Akin to booting a kernel on an old PC without PCI, and loading a driver
> >> module for a PCI network card. I guess that doesn't crash (because no one
> >> has a PC without PCI anymore? ;-)
> >
> > No, it should work just fine, try it!  :)
> >
> > The driver will not bind to anything, but the bus code should work
> > properly, as long as it is initialized before the driver tries to
> > register with that specific bus type.
> 
> Hence the NuBus bus code should register the bus irregardless of the
> presence of the NuBus host hardware.

Yes it should.  Shouldn't cause any problems as long as you don't have
any hardware specific code in your bus code.  Because of this, I don't
think the original patch would help at all here, as the error would
still be the same.

So add a "is bus registered" flag to your bus and all should be fine.

thanks,

greg k-h
