Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524641572; cv=none;
        d=google.com; s=arc-20160816;
        b=1FilW6SsKCb2CIhCw048W0VmsTOvFJ4n6PISpM3Tm3/eVaj02snWWLlEA0CrkF1lpn
         oW/g0Xg0eS2RELeur6RCCYdyt0XeEJVBGHucujgy7sxbj7lZxWLEH6GpjTRn16ein/UW
         vxMAIKWgZQwmn4/sNmqK6BOxogkg3eu5n+LyeJfJ5bvpzYOetyxmRvdnO05QLlqAc6tk
         /AdnPF+7EQ21HSdxVr52z+7VtXC1lfCWyryi5i4Nd7/eAjHwrBCj9PAHMXfMruGpAz00
         A8u24xBrfGhaShvIVoY/tZgbI2RtWPL7nRvN4iHas+npbNrTWyscSpGJAjS3SMlDkpwv
         sKLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=Cf6++sqcM2FwEf4/0/GCMDjS21r6CJ+V2Qu31XqThWE=;
        b=rv9cExQdu9TWyMiIR+1p+FA7a1Nc9pv22fD0EMU/Yr1LgjAyNDNYsrPV10cMN0EACL
         zvxu17Ix36S66543Eb/DrSSInXKhfG8cF7FcShCF5MLW7br6FvxGWraZX6RvlPBXF+ux
         5C9b8PgjMMh2M1MJHsqLAjDXleyPDPPT+cuoZvqV6y3G/kCE1N7G3IqTJmJYrc2Ymuts
         S79gmdrNEJ1gOi3iUU4vA20Mb1CYdzJMdCj1Zq7mg2K3W2NDoQmAbZgWWdDIMbeAKhLQ
         /oxPetI3UcojTBxpYjJr3El78EHSYgmnUaEIFEWHiZ5eLVEwPxaH3xFREWdgXfroERQv
         Ij2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ppecLrYk;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ppecLrYk;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx4+60HN3gv/9mewMebGJKcjl85J3RhnipVv4+lq7WiE+K/5/rKv8DFffr6f3HwJXYHbZwRaULw==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 09:32:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Pavel Machek <pavel@ucw.cz>, Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180425073243.GJ4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424201318.GA14390@amd>
 <20180424225948.4d6a121c@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424225948.4d6a121c@aktux>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598702560947483503?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:59:48PM +0200, Andreas Kemnade wrote:
> On Tue, 24 Apr 2018 22:13:19 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Hi!
> > 
> > > This series adds a new subsystem for GNSS receivers (e.g. GPS
> > > receivers).  
> > 
> > Actually... I'd just call it GPS subsystem. Yes, GPS is a bit
> > misleading, but so is GNSS. We'd like Loran to use similar interface,
> > right? We'd like to QZSS to use similar interface, too...
> > 
> > https://www.pcworld.com/article/205325/japan_launches_its_first_gps_satellite.html
> > . QZSS is not _global_ positioning system. Still they call it GPS. I'd
> > call it GPS too.
> > 
> > (Alternatively, we could have drivers/position and /dev/pos0...)
> > 
> > Looking closer... I'm not sure if it makes sense to push different
> > protocols (SiRF, NMEA, ...) through one device. Userland should know
> > what protocol to expect... Yes, there will be common code between
> > /dev/nmea0 and /dev/sirf0...
> > 
> > I don't know. I'd really like to see '/dev/input/event0'-like layer,
> > so that userland would not need to know about different protocols. But
> > your work solves some problems we have now...
> > 
> I am not really sure what to do here. The question is if we can remove
> nmea parsing from userspace if the kernel does it? There is the
> use-case of having external loggers storing nmea data and userspace
> will access the logger data and needs to have nmea parsing for that
> anyway.
> 
> But for other more exotic stuff, it would be helpful that the user
> space does not need to handle the differences.
> 
> Hmm, maybe userspace could register something like uinput devices for
> having more complex calculation. Maybe triangulating using gsm cell
> reception data. And the uinput-like device would have properties
> attached like accuracy, costs.

There's also seems to be trend towards exposing raw measurements and
experimenting with different Position-Velocity-Time algorithms in user
space.

But in any case, moving gpsd into the kernel is not my aim here.

With a GNSS subsystem in place which would give us device detection and
power management from the start, people can start experimenting with
more features (e.g. device identification, feature flags, or possibly
higher-level protocol interfaces).

Thanks,
Johan
