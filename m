Date: Mon, 7 May 2018 16:45:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
Message-ID: <20180507144511.GA22694@kroah.com>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com>
 <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com>
 <alpine.LNX.2.21.1805070930240.8@nippy.intranet>
 <CAMuHMdV_5p0Un3xMC1SMw71xpLAzVH0u4oJCTeGeo7jXS4KZSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdV_5p0Un3xMC1SMw71xpLAzVH0u4oJCTeGeo7jXS4KZSA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 02:53:13PM +0200, Geert Uytterhoeven wrote:
> Hi Finn,
> 
> (responding immediately to patches doing non-kosher things ;-)
> 
> On Mon, May 7, 2018 at 1:57 AM, Finn Thain <fthain@telegraphics.com.au> wrote:
> > On Sun, 6 May 2018, Greg Kroah-Hartman wrote:
> >> > > Why not just have an "bus is registered" flag in your driver
> >> > > register function that refuses to let drivers register with the
> >> > > driver core if it isn't set?
> >> >
> >> > Perhaps that should happen in the core driver_register() function.
> >> > BUG_ON is frowned upon, after all. Would that be acceptable?
> >>
> >> I don't understand what you mean here, perhaps make a patch to show it?
> >>
> >
> > As an alternative to your suggestion (add flag to avoid the BUG_ON):
> >
> > --- a/drivers/base/driver.c
> > +++ b/drivers/base/driver.c
> > @@ -148,7 +148,10 @@ int driver_register(struct device_driver *drv)
> >         int ret;
> >         struct device_driver *other;
> >
> > -       BUG_ON(!drv->bus->p);
> > +       if (!drv->bus->p) {
> > +               WARN_ONCE(1, "Cannot register driver with invalid bus\n");
> > +               return -EPROBE_DEFER;
> > +       }
> >
> >         if ((drv->bus->probe && drv->probe) ||
> >             (drv->bus->remove && drv->remove) ||
> >
> > I'm not actually proposing this change; just responding to your question.
> 
> The bus_type.p field may be unused by some bus drivers, hence this
> would prevent their drivers from being registered.

bus_type.p is an internal-to-the-driver-core structure, no bus driver
should ever be touching it.  This is a catch to see if someone is using
the driver core incorrectly.

thanks,

greg k-h
