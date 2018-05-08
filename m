Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525783699; cv=none;
        d=google.com; s=arc-20160816;
        b=NLkqt0BymLIMSnfTbztFZ2VQh4YlW+MS1stB1VYmlpSlEDMX9GNNNMXEPbHOD+cxdE
         2S/2pUUqKPBtyzI//N9L+VV2kOb9nGC2u4SlVhpqLQakog9lb1dpxO0UsPj/WuxYS6ea
         u5P1dHLr6KHb6qK6kIuk9BQUqqJQVWpOen701OIm+vx8u6MolrK1PEUdflmTmlD1qv6S
         OkZyr/7SiSCt1xuGPCr/WHFH87g1n9sBXgU7qgJ1TUeKRa/iBaZ1SBe9EUNYb+3z5MNR
         KosevdiCzBVG3pA5/vz4mK0IBzl2CEmjbYcYbVQInMBxxVYnF8G/3PPHs497y/vm2N/p
         YC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=lOUdg38FdZpP/EvBnayExlUjPHkqeEW+gKj6rCm26WE=;
        b=AhM7jg5v11us6UrNUNfDzbqWZXGoS793Vl1XVKjOgUe0xjI7JLTKxdaw1mTNwy2I7j
         njxVg2qaJLLnM5jKAs8hI2zX7ocPZsrdXPb+j2oIGOp1xkzI0dKVZrzwKJSe1nv7cnR4
         FDZ4bUmAn4Uld3KvhkmOandEM6BmL8w+iTxAVeE3gsvcAVocW/f1QRA8ly9+4wzWTMRZ
         uM1frjgc8htzPM6YKwQmCEiOZl+WNpYpwkH+btfDkZbcc0LmoPLZWLWOyIVxiG5fsXD5
         ZCFz1SeIxSLfbAKD6aTCWVoCMaAyJNDbNnVm4LeYgSxDu/MeAClwN2wCmt9NCwtiQat2
         RVoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uqYPoNRm;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=uqYPoNRm;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZrRbt4q+3cPvivgHi0+Z0ME9WAS3W7r2D168O7nlB2lrHzlYKw4u5ds6uGLc53SOMN4En/F7w==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Tue, 8 May 2018 14:48:17 +0200
From: Johan Hovold <johan@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hovold <johan@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] gnss: add new GNSS subsystem
Message-ID: <20180508124817.GZ2285@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180504132741.brn5jqv5ufjhp7ky@earth.universe>
 <20180507102056.GU2285@localhost>
 <FA27606D-AB12-4D62-8EBD-3CC6F0900AF7@holtmann.org>
 <20180508070153.GX2285@localhost>
 <C8F35484-132F-466C-B87F-B209B2BC8B37@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8F35484-132F-466C-B87F-B209B2BC8B37@holtmann.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1599900168617041450?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 09:49:36AM +0200, Marcel Holtmann wrote:
> Hi Johan,
> 
> >>>> I have one concern, though. While providing raw data by
> >>>> default is fine generally, it is a problem with device
> >>>> auto-discovery. I think there should be some IOCTL from
> >>>> the start, that can be used to inform userspace about
> >>>> the raw protocol being used (i.e. "NMEA"). I fear, that
> >>>> userspace may start to just assume raw = NMEA without
> >>>> having this (especially since all initial drivers provide
> >>>> NMEA).
> >>> 
> >>> One problem I see here would be that the driver does not necessarily
> >>> know either what protocol is currently being used. Some devices have
> >>> boot-pins which can be used to configure the initial protocol used (and
> >>> this could perhaps be reflected in DT), but this can often later be
> >>> changed (by user space) and even be made persistent using battery-backed
> >>> ram or eeproms.
> >>> 
> >>> Also note that at least u-blox devices supports having more than one
> >>> protocol active on the same port...
> >> 
> >> as long as userspace can determine that it is GNSS hardware and what
> >> hardware it is, then you deal with the rest in userspace.
> > 
> > Yeah, I think that will do for now.
> 
> I forgot to mention that this part should be simple. So providing a
> DEVTYPE attribute that can be easily associated to the /dev/gnssX
> nodes is a must have here. Doing complex mapping of USB or DT layouts
> to figure out this is NMEA vs some vendor vs I need extra code to
> change the mode etc.

Yes, as I mentioned in the cover letter some kind of generic interface
for identifying the device type (and its features) should be defined
eventually.

Note that this is not necessarily something that is needed from the
start however as, for example, gpsd implements protocol detection.

> So a proper GNSS daemon will require some hardware abstraction anyway.
> There will be still a few GNSS devices that are part of the cellular
> modem, where you have to go via the telephony daemon to get access to
> it. We have done this within oFono since there would be otherwise no
> access to it. So only extra pieces that could be done here is to
> provide a /dev/ugnss (like /dev/uinput, /dev/uhid) so that you can
> emulate GNSS hardware from userspace as well. In oFono, we could then
> just hook this up with /dev/ugnss and the GNSS daemon would not have
> to have to know how to talk to oFono.

Interesting idea, could be useful for testing purposes as well. But just
so I understand your use case better, why do you need to go through
oFono rather than implement, say, a serdev driver for the GNSS port of
the modem? To enable the receiver using AT commands on a different port?
Or what kind of interface did you have in mind here?

Thanks,
Johan
