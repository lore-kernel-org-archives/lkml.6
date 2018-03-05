Date: Mon, 5 Mar 2018 14:08:59 +0100
From: Greg KH <greg@kroah.com>
To: Mark Brown <broonie@kernel.org>
Cc: Alex Shi <alex.shi@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
Message-ID: <20180305130859.GB17802@kroah.com>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
 <20180302165415.GB8704@kroah.com>
 <20180305124638.GG8588@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305124638.GG8588@sirena.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 12:46:38PM +0000, Mark Brown wrote:
> On Fri, Mar 02, 2018 at 05:54:15PM +0100, Greg KH wrote:
> > On Fri, Mar 02, 2018 at 05:14:50PM +0800, Alex Shi wrote:
> > > On 03/01/2018 11:24 PM, Greg KH wrote:
> 
> > > > And why are you making this patchset up?  What is wrong with the patches
> > > > in the android-common tree for this?
> 
> > > We believe the LTS is the base kernel for android/lsk, so the fixing
> > > patches should get it first and then merge to other tree.
> 
> > But you know that android-common is already fine here, the needed
> > patches are all integrated into there, so no additional work is needed
> > for android devices.  So what devices do you expect to use this 4.9
> > backport?
> 
> See below...
> 
> > What is "lsk"?
> 
> The Linaro Stable Kernel, it's LTS plus some feature backports.
> 
> > But really, I don't see this need as all ARM devices that I know of that
> > are stuck on 4.9.y are already using the android-common tree.  Same for
> > 4.4.y.  Do you know of any that are not, and that can not just use
> > 4.14.y instead?
> 
> There's way more to ARM than just Android systems, assuming that getting
> things into the Android kernel is enough is like assuming that x86 is
> covered since the distros have their own backports - it covers a lot of
> users but not everyone.  Off the top of my head there's things like
> routers, NASs, cameras, IoT, radio systems, industrial appliances, set
> top boxes and these days even servers.  Most of these segments are just
> as conservative about taking new kernel versions on shipping product as
> the phone vendors are, the practices that make people relucant to take
> bigger updates in production are general engineering practices common
> across industry.

I know there is lots more than Android to ARM, but the huge majority by
quantity is Android.

What I'm saying here is look at all of the backports that were required
to get this working in the android tree.  It was non-trivial by a long
shot, and based on that work, this series feels really "small" and I'm
really worried that it's not really working or solving the problem here.

There are major features that were backported to the android trees for
ARM that the upstream features for Spectre and Meltdown built on top of
to get their solution.  To not backport all of that is a huge risk,
right?

So that's why I keep pointing people at the android trees.  Look at what
they did there.  There's nothing stoping anyone who is really insistant
on staying on these old kernel versions from pulling from those branches
to get these bugfixes in a known stable, and tested, implementation.
That's why I point people there[1].  To do all of the backporting and
add the new features feels _way_ beyond what I should be taking into the
stable kernels.  We didn't do it for x86, why should we do it for ARM?

Yes, we did a horrid hack for the x86 backports (with the known issues
that it has, and people seem to keep ignoring, which is crazy), and I
would suggest NOT doing that same type of hack for ARM, but go grab a
tree that we all know to work correctly if you are suck with these old
kernels!

Or just move to 4.14.y.  Seriously, that's probably the safest thing in
the long run for anyone here.  And when you realize you can't do that,
go yell at your SoC for forcing you into the nightmare that they conned
you into by their 3+ million lines added to their kernel tree.  You were
always living on borowed time, and it looks like that time is finally
up...

thanks,

greg k-h

[1] It's also why I keep doing the LTS merges into the android-common
    trees within days of the upstream LTS release (today being an
    exception).  That way once you do a pull/merge, you can just keep
    always merging to keep a secure device that is always up to date
    with the latest LTS releases in a simple way.  How much easier can I
    make it for the ARM ecosystem here, really?

    Oh, I know, get the SoC vendors to merge from the android-common
    trees into their trees.  Look, that's already happening today for at
    least 3 major SoCs!  So just go pull the update from your SoC today,
    for your chip, and it automatically has all of these fixes in it
    already!  If you know a SoC that is not pulling these updates
    regularly, let me know and I'll work with them to resolve that[2].

[2] I have offered to do that merge myself, from the android-common
    trees into any "internal" tree, so that future merges happen cleanly
    and automatically, for any company that asks for it.  So far only
    one company has taken me up on it, and it only took me a week to get
    it all up and working properly.  It took a ton of "fun" quilt and
    git work, but in the end, it all worked, and has worked cleanly
    since then, showing it can be done.
