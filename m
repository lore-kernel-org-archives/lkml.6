Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524639115; cv=none;
        d=google.com; s=arc-20160816;
        b=Ny+42O6Q5MAQO50ErxTXyVohNIOc2nUI+enVDAVd0Ok0byP82BCAhpQRBj3M7tLgQn
         74TIo5sG3n3l27HwG05mKjPw3Efn7CzjEYG0hSzy6xh7FF4ViU4YDAwPYZKXfoknNS4A
         KfWixlpOilLGEUW2ZJ8QZ1wnZ7EdC6ETwaPKDmYvNlp3V7RSwKfqvLbNcGIYUFv96k8f
         YcmTwTmszU3yZlOV3QYycTgRqj1rshO1NxA51+tlF7GOwHzrJ6QZbjyWqmRRAsEXC5/c
         51yH26BSmAbSBELizHA29za56TIyZ+kH0skdkL8CBs+4QRifmXINw0ziS2oB/7wZWlm1
         gZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=deTgewHoF+xkeUfMySaQ895CDn3NVIxOtBJVr60y4NI=;
        b=yBSFIBgm52PO/mEKkazIRL0WRK3ng5l1TI25jgbpC5WJZjxsvmflkQqH1tVvJc68Zx
         leQgi8updtT4u2eQ7vB+zLGVXvxTWFw5B/upZQ0+sXI2opmYVqxwDm2DjJ/AsJDp24k6
         1aXfUhKIRfMFRdL++6gr6A4MuzwmldDrb7zPyCVmzyUMukOFY8OMeSkAWyMVr54WKVN1
         1XhyB4uo7+HRZ1CYvKoOgH6cxEzvGJZ/1GzXfo6K5Aeuam6tt8vwUGSXGJLLGoRXnRHB
         bWT9bILLHzgN/njuuImavIm2qRzA912fW9jVw6DBdjbuhnnsb+4diwFEb1Br8PsV3pwN
         UlvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UkZcBXAu;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=UkZcBXAu;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZrlgZPPcj66Oc8n3rzNCfOrgo91wHgu0SqLXJjQyVK0ytfKQKtpr5eSoXtjay3visd8PDpr5Q==
Sender: Johan Hovold <jhovold@gmail.com>
Date: Wed, 25 Apr 2018 08:51:46 +0200
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
Message-ID: <20180425065146.GH4615@localhost>
References: <20180424163458.11947-1-johan@kernel.org>
 <20180425062659.GA5352@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425062659.GA5352@amd>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598699985224888428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 08:26:59AM +0200, Pavel Machek wrote:
> Hi!
> 
> > This series adds a new subsystem for GNSS receivers (e.g. GPS
> > receivers).
> > 
> > While GNSS receivers are typically accessed using a UART interface they
> > often also support other I/O interfaces such as I2C, SPI and USB, while
> > yet other devices use iomem or even some form of remote-processor
> > messaging (rpmsg).
> >     
> > The new GNSS subsystem abstracts the underlying interface and provides a
> > new "gnss" class type, which exposes a character-device interface (e.g.
> > /dev/gnss0) to user space. This allows GNSS receivers to have a
> > representation in the Linux device model, something which is important
> > not least for power management purposes and which also allows for easy
> > detection and (eventually) identification of GNSS devices.
> 
> Actually... no, what you done is not GNSS subsystem. It is generic
> subsystem for a link + some controls, typically for power.
> 
> Yes, that setup is common for GPS receivers, but it is there also for
> modems (droid 4: usb + gpios) and bluetooth dongles (n900: serial +
> gpios).

Those would be handled by other subsystems.

The idea here is that eventually there may be more GNSS specific bits
added, such as 1PPS support that I already mentioned. If someone is
crazy enough to put a location service in the kernel with a more
high-level interface (an in-kernel gpsd) they can try, but I'm more and
more convinced that needs to remain in user space.

I did also already mentioned however, that some hybrid approach may be
doable, such as handling port setup over NMEA/UBX/SiRF from within the
kernel.

Johan
