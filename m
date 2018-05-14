Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AB8JxZq0P5WU3ZaJ/kYI2JsdBXMWbVHmhwRhvDH0wdj5K0xfitp9biVFvil+RvWXGz1CQecmfzCQ
ARC-Seal: i=1; a=rsa-sha256; t=1526312418; cv=none;
        d=google.com; s=arc-20160816;
        b=uvxy4DywXiJvXSJEuWa+MkzGipToFxE6sQ71B6C9apNO/NhjLs0MSIaVkhHYVW7VtE
         QyoC27Vuu7XyLKGLUZYul/wYCoyh6xo4gG8ndNHjGHElmRgv5kEwDbv31P/DwVNEf+bv
         LQ+IF545ADO9zpzmLpRTxCEphrNQLOqArxT6hep/vbKNoSRGd0LNOjTE+Zms25+kf35y
         CXZP8DCAfEypjViRTAAa9txF/str5hCZ7cdB5OM2/O0uUrNl0//AtAlU7kqn1MorvcMr
         MgU7Q7HaRgv1ITeRyDZT1uFnOv7+I9CT980/vV1bmOPuSE2X8FOZgN+JhfbfHve/fF/x
         3Klw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=e54tljYzgdV6XLsBfc9I8f9+0AYukEcFkDUIMmfwF2w=;
        b=ItsKbcpksNdM2q0gXkHZlEqiaA1I9DD+U5isaqE5kopfF74PVZdK9d5E7/haTsRtcU
         cY9YMW3vJM2IoRAKMB1DEVgOWntzrTf4/IKiUAwd9iOi2FduMxygnQ6Mr5aZ5L4ZzKae
         8v3q4wuFmqo5HJShqNYQlAOQpzbIqhaAoI0XFvcJgrLXZClGB5jDBiAp8OCfy4NxzHNH
         txxU7VEUBBu8DI5Q2w3mY46hg9CQj+iQroCGdU5qxGHvr2g6xxTNqHbg4+/veH1FczTk
         A8WUFi6xIYd4loDZvABfGq0iFw3mJ7rXWle2pBTYWN9DM5ULmD8QFfspKaI9X+8NUBk+
         CfTw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 176.9.242.62 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 176.9.242.62 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Mon, 14 May 2018 17:40:17 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-efi@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2] device property: Get rid of union aliasing
Message-ID: <20180514154017.GA6734@wunner.de>
References: <20180508131547.44366-1-andriy.shevchenko@linux.intel.com>
 <20180514121817.GA27869@wunner.de>
 <f2109d06a0755dd2d9dc807c1e13dd2c19903905.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2109d06a0755dd2d9dc807c1e13dd2c19903905.camel@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599901902158233534?=
X-GMAIL-MSGID: =?utf-8?q?1600454570260664854?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 03:48:09PM +0300, Andy Shevchenko wrote:
> On Mon, 2018-05-14 at 14:18 +0200, Lukas Wunner wrote:
> > On Tue, May 08, 2018 at 04:15:47PM +0300, Andy Shevchenko wrote:
> > > --- a/drivers/firmware/efi/apple-properties.c
> > > +++ b/drivers/firmware/efi/apple-properties.c
> > > @@ -13,6 +13,9 @@
> > > + * FIXME: The approach is still based on union aliasing and should be
> > > + * replaced by a proper resource provider.
> > 
> > Why?  All Apple EFI properties are either boolean or u8 arrays.
> > You've correctly changed this file to always supply u8 arrays,
> > so I don't see where union aliasing is happening here?
> 
> Okay, for now I can see only Thunderbolt user of these properties (is it
> correct?) in upstream which uses u8 arrays indeed.

That is correct, thunderbolt.ko is so far the only user.


> Though the implementation is quite fragile in this sense, because it
> doesn't discourage people to use device_property_read_string() in case
> when it's indeed a string (I saw these kind of properties in the very
> dump you posted on your GH page).

Well if that is your concern then you need to prevent functions which
retrieve properties to use the wrong type.

E.g. to prevent retrieval of the u8 array as string, you'd have to
amend drivers/base/property.c:pset_prop_read_string_array() to
check the type of the property found and return -EINVAL if it's not
string.

Thanks,

Lukas
