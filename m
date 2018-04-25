Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524641062; cv=none;
        d=google.com; s=arc-20160816;
        b=uYYgApI8R3fUyae0gecOe9hViwF+b5ohvpu3v7DV/BI7ZMQNBmG7Vb6UVmgnoMO+Rm
         /oNeySUYTVtmOXiUH9uVa/om9W//mLw+N57rdOooia9eZtbYe4n3hALq1vfwT7Piknrl
         3DcmyaVvxccVkTNMpv79FWpN7uux5lzmi8ef6MqBaBLCkqnsMIpI2/0AaMvQUIX3oAxc
         rsAcnP+Dz5YBZSaPNWnCLwmtQLeE4gnQ4r/MSM/5DDNA6Sgge7ESAZfhEYmHfOIrJkaU
         U8K1mfqAfSrxaluEwh9eBzMgsF0vBaUInOrMPzzZ9k7sf883bPAi+w2fAjrxhnrMu88i
         EuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=XeB/K69ni+Wg6WINJE2/hH3ox1uZaKHIpggrolP3nxE=;
        b=xwUJilOEZRdrzGkuJMNF0/K0QqSdf4eHsLe1s9qXLGyfOILJTP9Ehr6Pfj0+NbY+1u
         eaev22TNR9CLKSJTNf7inEb+DcGb4TJoY64GoTRmaQzadyXlUKfqtHr2EomqswLm5tv7
         Q+96M9/XcsdHvzEP5pDXppCCrEB4L0dnSgKq+GwwhQB7pj+9enrraZeq0qhI+F0UwAh9
         cIlheg1kWGLc+stmHm9byTi5T0+/L5gatIVeBvthZbfqzbJoOsnYZ83dF16Dns8o71Eq
         g2BhqoF4sN24G5GdsiTMCH/PsbZYgqlnCpF6y0LCretzM5SDlMDU9yF8IDJjcQjcTBkU
         vTjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MgxRV8Qg;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MgxRV8Qg;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AIpwx48TRaLgtzsM1xqpmGmMMbypOpIFAku+ETpPqQ54utqmYPqlWVAmhvOWRfJ8Wadtk1g5vhhjlA==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 09:24:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180425072413.GI4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180424201318.GA14390@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424201318.GA14390@amd>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598702026744157418?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 10:13:19PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This series adds a new subsystem for GNSS receivers (e.g. GPS
> > receivers).
> 
> Actually... I'd just call it GPS subsystem. Yes, GPS is a bit
> misleading, but so is GNSS. We'd like Loran to use similar interface,
> right? We'd like to QZSS to use similar interface, too...
> 
> https://www.pcworld.com/article/205325/japan_launches_its_first_gps_satellite.html
> . QZSS is not _global_ positioning system. Still they call it GPS. I'd
> call it GPS too.

What Marcel said. Never heard of Loran, but apparently it's no longer in
use:

	https://en.wikipedia.org/wiki/Radio_navigation#Satellite_navigation

> (Alternatively, we could have drivers/position and /dev/pos0...)

If you find such a system in use and implement a driver for it, we'll
just let it be the odd bird.

> Looking closer... I'm not sure if it makes sense to push different
> protocols (SiRF, NMEA, ...) through one device. Userland should know
> what protocol to expect... Yes, there will be common code between
> /dev/nmea0 and /dev/sirf0...

That's not how GNSS devices work. It does not seem to be uncommon to
switch to a vendor protocol with a richer feature set and back to NMEA
(e.g. for configuration). Raw GNSS data may also be available over the
vendor protocol, etc. And some devices even support using to protocols
concurrently on one port.

I was going to call the device node /dev/gnssraw0 (cf. hidraw), but
since "raw" GNSS measurement already has a meaning in this space I
decided to drop that suffix. It can all be accessed over /dev/gnss0.

> I don't know. I'd really like to see '/dev/input/event0'-like layer,
> so that userland would not need to know about different protocols. But
> your work solves some problems we have now...

Yeah, and moving gpsd into the kernel is probably never going to happen.
But if it were, we probably wouldn't be using a character device to
access it anyway.

Johan
