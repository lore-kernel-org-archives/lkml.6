Date: Wed, 9 May 2018 16:50:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
Message-ID: <20180509145035.GF18586@kroah.com>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
 <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
 <20180425160645.GA16732@kroah.com>
 <CAMuHMdUVowxjG0Q=DGie_JjPqfz3UBDikvLnZ6_86jbcJMKqyQ@mail.gmail.com>
 <20180426070410.GM14025@kroah.com>
 <CAMuHMdWLCQoHzuW1UZNP9gdRV3EE6_yPcdyX1NDy65q7Nt4tZw@mail.gmail.com>
 <20180426083542.GA31073@kroah.com>
 <CAMuHMdWO+C3g4T_rPbcyPFgVpqubjj4HZ++O+P7d0VYYFP0xWA@mail.gmail.com>
 <20180509103954.GR16141@n2100.armlinux.org.uk>
 <CAMuHMdVD59kA1BRrce+jHEMr7Sq7AqEzQEXJWL7SPDUY32Fgmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVD59kA1BRrce+jHEMr7Sq7AqEzQEXJWL7SPDUY32Fgmw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 03:32:16PM +0200, Geert Uytterhoeven wrote:
> Hi Russell,
> 
> On Wed, May 9, 2018 at 12:39 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Thu, Apr 26, 2018 at 10:45:49AM +0200, Geert Uytterhoeven wrote:
> >> On Thu, Apr 26, 2018 at 10:35 AM, Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >> > On Thu, Apr 26, 2018 at 09:40:08AM +0200, Geert Uytterhoeven wrote:
> >> >> On Thu, Apr 26, 2018 at 9:04 AM, Greg Kroah-Hartman
> >> >> <gregkh@linuxfoundation.org> wrote:
> >> >> > On Wed, Apr 25, 2018 at 07:53:06PM +0200, Geert Uytterhoeven wrote:
> >> >> >> On Wed, Apr 25, 2018 at 6:06 PM, Greg Kroah-Hartman
> >> >> >> <gregkh@linuxfoundation.org> wrote:
> >> >> >> > On Tue, Apr 10, 2018 at 03:21:44PM +0200, Geert Uytterhoeven wrote:
> >> >> >> >> The driver_override implementation is susceptible to a race condition
> >> >> >> >> when different threads are reading vs storing a different driver
> >> >> >> >> override.  Add locking to avoid this race condition.
> >> >> >> >>
> >> >> >> >> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
> >> >> >> >> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
> >> >> >> >> condition with driver_override").
> >> >> >> >>
> >> >> >> >> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
> >> >> >> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> >> >> >> Reviewed-by: Todd Kjos <tkjos@google.com>
> >> >> >> >> Cc: stable <stable@vger.kernel.org>
> >> >> >>
> >> >> >> > As this should go to stable kernels, I've fixed it up to apply without
> >> >> >> > patch 1 as that's not a real "fix" that anyone needs...
> >> >> >> >
> >> >> >> > Please try to remember to put fixes first, and then "trivial" things
> >> >> >> > later on in a series.
> >> >> >>
> >> >> >> I did it on purpose, as the fix is much more ugly without patch 1 applied.
> >> >> >> Can't you just take patch 1, too? More consistency is always nice, even for
> >> >> >> stable ;-)
> >> >> >
> >> >> > Consistency is nice, but when you have bug fixes that rely on "trivial"
> >> >> > patches, it's usually not nice :(
> >> >> >
> >> >> > I already committed patch 2 to my tree without 1, so let's leave it
> >> >> > as-is for now.
> >> >>
> >> >> Unfortunately the version you committed is buggy: the race condition
> >> >> also covers the NULL check removed by the trivial patch you skipped,
> >> >> so now you can get inconsistent behavior (no output or "(null)") on the
> >> >> same running kernel version...
> >> >>
> >> >> Please revert and apply both. Thanks!
> >> >
> >> > Ugh, you are right, sorry about that.
> >> >
> >> > I've reverted the offending patch, and added them in the correct order
> >> > now, I should have listened to you :)
> >>
> >> Np, issue detected and fixed.
> >> Thanks!
> >
> > So what about the patches you submitted to the patch system - should
> > I pick those up or not?
> 
> I think only the 4th patch (#8759) in the series is still applicable.
> 
> > Please don't ask other maintainers to take patches that have been
> > submitted to the patch system without first changing their status,
> > they're liable to get applied anyway.
> 
> They got picked up by Greg, on request of a third party who wanted them in
> -stable ASAP. Not much I can do to prevent that.
> Especially with an "Odd Fixes" maintainership status.

I was going to pick up the last one if needed and put it through my
tree, as it's still in my queue.

thanks,

greg k-h
