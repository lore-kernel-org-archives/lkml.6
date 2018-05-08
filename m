Date: Tue, 8 May 2018 09:00:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Finn Thain <fthain@telegraphics.com.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nubus: Unconditionally register bus type
Message-ID: <20180508070037.GA4792@kroah.com>
References: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
 <20180506045530.GA5328@kroah.com>
 <alpine.LNX.2.21.1805061544550.8@nippy.intranet>
 <20180506202018.GC8924@kroah.com>
 <CAOmrzk+bY5wUxJhNAwO-pf+O--HiqJ63rB3BmxRsY8qq_PeLmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOmrzk+bY5wUxJhNAwO-pf+O--HiqJ63rB3BmxRsY8qq_PeLmw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 09:51:12AM +1200, Michael Schmitz wrote:
> Hi Greg,
> 
> the BUG() was triggered by loading a Mac Nubus network card module on
> a multiplatform kernel running on an Amiga machine. Up to Finn's Nubus
> core rewrite (this February), we've seen no errors. Since then, Nubus
> drivers fail to register because the Nubus bus is only registered on
> Macs.
> 
> Can't see link order involved here at all.

The link order is totally involved here :)

Link order determines the order in which init calls are run, so you need
to ensure that your bus code comes before any drivers that use that bus
code in link order.  That way, at init time, your bus is created first,
preventing this type of error to happen.

> Safeguarding against this bug could be done by checking a
> bus-is-registered flag, or checking what machine model the kernel runs
> on. Simply registering the Nubus bus driver regardless of machine
> model seemed the easiest way.

If you really have this problem due to link ordering issues not being
able to be worked around (due to different directories and the like),
then put a "bus is registered" flag in your bus code.  That will solve
the initial BUG_ON() problem, and you should return an error that allows
the driver code to probe your driver later on after your bus is enabled.

Hope this helps,

greg k-h
