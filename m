Return-Path: <linux+gregkh=linuxfoundation.org@armlinux.org.uk>
X-Google-Smtp-Source: AB8JxZouPiXFuRLQGiWH2/sP46F0bivdQmMrwRTEdePo9ryG53VJhWD8s7QMD5w2WyF/uA/+yfZD
ARC-Seal: i=1; a=rsa-sha256; t=1525862408; cv=none;
        d=google.com; s=arc-20160816;
        b=UHgvke/pedfFSmfmADOSRLDRjHJiFMYKz5HCbTm0pT9AmLPj0IDhrIQ4TteaQg9mFe
         MFdtNh4wqMvcK1ErQ/8fdy3Z3mfBC05me+EceOzgWxaUtcKtagVmUOwj8BZXxGD6dbpI
         2hBvadr1fkzWjDUmg3Viw4wjS/WDl2qCzGaR9xDzA+ciuSwdGyuOM0/dO5QNYPWx8BBh
         330egI20mCOlgTXhzqY8PaEUROqZCNaLZVpAp7wJJuchz2+34pcyPMjYGJuGQmHSZaEv
         LGFPNYjUZznJI4usPsk+ECkMl0yGgG3U3jLu9yxHyYSTRXZRcRdebU2Z6UC6I76P2KLT
         DNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=kPHHFKvBzk4l/Bmgofs7DhvyZ+zUOY/f2IGD2sCNkWs=;
        b=bx5CMxWgit4yx4pgr1HZdEbC2J3UQSpX8No61lUUewtxD/6Pgla6rMitQfgbr6t5bN
         j2N7FVfjA7uMhgFSZnMAmobQKz+bPKUOVA69RV1ZZKlBJxMkokEYrfer4m476erklroH
         mWH+vGcZkeijX7JPHy1qPq3Za/+ZQP9lyWgi3+HgCSWWnECJabUTz/ZRPyMnCMI3Rcwv
         NcbfrOVvZa9HkeAYWNY5HfjBmWEkL23zYSIyDXc9ExhoseBdDdGGjrYZ8jWeMm2q/g0r
         bE4YA0oQY+/8nSaFNIKblbjbBJuPOTsiarxWZ3qMYNROHlSgTHCZnLtBp+mJQQdXgIBu
         +s0A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=LU5SowOr;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@armlinux.org.uk header.s=pandora-2014 header.b=LU5SowOr;
       spf=pass (google.com: best guess record for domain of linux+gregkh=linuxfoundation.org@armlinux.org.uk designates 2001:4d48:ad52:3201:214:fdff:fe10:1be6 as permitted sender) smtp.mailfrom=linux+gregkh=linuxfoundation.org@armlinux.org.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=armlinux.org.uk
Date: Wed, 9 May 2018 11:39:54 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Adrian Salido <salidoa@google.com>,
	Nicolai Stange <nstange@suse.de>,
	Sasha Levin <Alexander.Levin@microsoft.com>,
	Todd Kjos <tkjos@android.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] ARM: amba: Fix race condition with driver_override
Message-ID: <20180509103954.GR16141@n2100.armlinux.org.uk>
References: <1523366506-19832-1-git-send-email-geert+renesas@glider.be>
 <1523366506-19832-3-git-send-email-geert+renesas@glider.be>
 <20180425160645.GA16732@kroah.com>
 <CAMuHMdUVowxjG0Q=DGie_JjPqfz3UBDikvLnZ6_86jbcJMKqyQ@mail.gmail.com>
 <20180426070410.GM14025@kroah.com>
 <CAMuHMdWLCQoHzuW1UZNP9gdRV3EE6_yPcdyX1NDy65q7Nt4tZw@mail.gmail.com>
 <20180426083542.GA31073@kroah.com>
 <CAMuHMdWO+C3g4T_rPbcyPFgVpqubjj4HZ++O+P7d0VYYFP0xWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWO+C3g4T_rPbcyPFgVpqubjj4HZ++O+P7d0VYYFP0xWA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597365566189003865?=
X-GMAIL-MSGID: =?utf-8?q?1599982700600689062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:45:49AM +0200, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Thu, Apr 26, 2018 at 10:35 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Thu, Apr 26, 2018 at 09:40:08AM +0200, Geert Uytterhoeven wrote:
> >> On Thu, Apr 26, 2018 at 9:04 AM, Greg Kroah-Hartman
> >> <gregkh@linuxfoundation.org> wrote:
> >> > On Wed, Apr 25, 2018 at 07:53:06PM +0200, Geert Uytterhoeven wrote:
> >> >> On Wed, Apr 25, 2018 at 6:06 PM, Greg Kroah-Hartman
> >> >> <gregkh@linuxfoundation.org> wrote:
> >> >> > On Tue, Apr 10, 2018 at 03:21:44PM +0200, Geert Uytterhoeven wrote:
> >> >> >> The driver_override implementation is susceptible to a race condition
> >> >> >> when different threads are reading vs storing a different driver
> >> >> >> override.  Add locking to avoid this race condition.
> >> >> >>
> >> >> >> Cfr. commits 6265539776a0810b ("driver core: platform: fix race
> >> >> >> condition with driver_override") and 9561475db680f714 ("PCI: Fix race
> >> >> >> condition with driver_override").
> >> >> >>
> >> >> >> Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
> >> >> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> >> >> Reviewed-by: Todd Kjos <tkjos@google.com>
> >> >> >> Cc: stable <stable@vger.kernel.org>
> >> >>
> >> >> > As this should go to stable kernels, I've fixed it up to apply without
> >> >> > patch 1 as that's not a real "fix" that anyone needs...
> >> >> >
> >> >> > Please try to remember to put fixes first, and then "trivial" things
> >> >> > later on in a series.
> >> >>
> >> >> I did it on purpose, as the fix is much more ugly without patch 1 applied.
> >> >> Can't you just take patch 1, too? More consistency is always nice, even for
> >> >> stable ;-)
> >> >
> >> > Consistency is nice, but when you have bug fixes that rely on "trivial"
> >> > patches, it's usually not nice :(
> >> >
> >> > I already committed patch 2 to my tree without 1, so let's leave it
> >> > as-is for now.
> >>
> >> Unfortunately the version you committed is buggy: the race condition
> >> also covers the NULL check removed by the trivial patch you skipped,
> >> so now you can get inconsistent behavior (no output or "(null)") on the
> >> same running kernel version...
> >>
> >> Please revert and apply both. Thanks!
> >
> > Ugh, you are right, sorry about that.
> >
> > I've reverted the offending patch, and added them in the correct order
> > now, I should have listened to you :)
> 
> Np, issue detected and fixed.
> Thanks!

So what about the patches you submitted to the patch system - should
I pick those up or not?

Please don't ask other maintainers to take patches that have been
submitted to the patch system without first changing their status,
they're liable to get applied anyway.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
