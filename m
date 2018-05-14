Return-Path: <foo00@h08.hostsharing.net>
X-Google-Smtp-Source: AB8JxZoedt13gqFA798Okhg8y8BruqmdE1bzfwsN6qEr0BNEYI+7JNNhjyCBk1cDHspb20MkkIMz
ARC-Seal: i=1; a=rsa-sha256; t=1526315181; cv=none;
        d=google.com; s=arc-20160816;
        b=JxfL9boSjsDq0te0G/3JTB3osv3ToWdr4XolaqnNRM6Kt7NFc8WV6Mvwj6XyP7Xnyt
         dFfv/CC3iluSL66ZRdV04PoZkFrjDwQOT9uCfjotuuxFhUpYdXaFEJ4wHOUTsgzPBm+2
         kRnE4IqWKXfAksABIgXvLv5Azc3y9De1i7Jhg+pzTCG8lpD/6ZVIQJSWkpyMudqwg2kp
         CSfgcJaXQg6QQDeAuLxXG5FW5cI079/x6qFFUkIb+A7u5tgy9hCsnXGkTP7xwwpglo85
         s6EB1+XOfrDDL3oBN+jpq125hexmcDp1+xfzfshFjO/ZgRTq/AEcLATEDqqKgWKviuiz
         5puQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+foyy/rOZ2kCoEyy18HK4FOE6DdDhrZunk3JubF8Orw=;
        b=qXc3zysidgdmrIevXowDcoA0v6dRzz+lnVvnV1Wz9H4LB+Zs99P8/bTNffc7N8WVTr
         7iQBGvyLhbY6y9O3X9niZjtjDfKegTGPG+c98XZkDNd3pCUGJ3it4wStp0bBov+eCcHy
         MexvOZsjML2krQHZeFGpngjH+waUW4xnJKzpVdYIf0Y6K9pHl9s9aAkYFKHa1I+nmEAw
         OfF5UkvdJeIZbx6ortP1LdF3y0at2ipFP10hvevzMJVIHWTWdG817EGHPsWs+8sKjGoR
         qk/2CWmtEd5a6C1Kh88iEtA5tZE5aa3vCFeW23J7LkGEufbpICyddp6ule1zHaHBYKkD
         TFdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of foo00@h08.hostsharing.net designates 83.223.95.100 as permitted sender) smtp.mailfrom=foo00@h08.hostsharing.net
Date: Mon, 14 May 2018 18:26:20 +0200
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
Message-ID: <20180514162620.GA12132@wunner.de>
References: <20180508131547.44366-1-andriy.shevchenko@linux.intel.com>
 <20180514121817.GA27869@wunner.de>
 <f2109d06a0755dd2d9dc807c1e13dd2c19903905.camel@linux.intel.com>
 <20180514154017.GA6734@wunner.de>
 <ddd9eae5cf848df9c25a49001845a3d80e429a6f.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd9eae5cf848df9c25a49001845a3d80e429a6f.camel@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599901902158233534?=
X-GMAIL-MSGID: =?utf-8?q?1600457467568019900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 07:13:24PM +0300, Andy Shevchenko wrote:
> On Mon, 2018-05-14 at 17:40 +0200, Lukas Wunner wrote:
> > On Mon, May 14, 2018 at 03:48:09PM +0300, Andy Shevchenko wrote:
> > > On Mon, 2018-05-14 at 14:18 +0200, Lukas Wunner wrote:
> > > > On Tue, May 08, 2018 at 04:15:47PM +0300, Andy Shevchenko wrote:
> > > > > --- a/drivers/firmware/efi/apple-properties.c
> > > > > +++ b/drivers/firmware/efi/apple-properties.c
> > > > > @@ -13,6 +13,9 @@
> > > > > + * FIXME: The approach is still based on union aliasing and
> > > > > should be
> > > > > + * replaced by a proper resource provider.
> > > > 
> > > > Why?  All Apple EFI properties are either boolean or u8 arrays.
> > > > You've correctly changed this file to always supply u8 arrays,
> > > > so I don't see where union aliasing is happening here?
> > > 
> > > the implementation is quite fragile in this sense, because it
> > > doesn't discourage people to use device_property_read_string() in
> > > case when it's indeed a string (I saw these kind of properties in
> > > the very dump you posted on your GH page).
> > 
> > Well if that is your concern then you need to prevent functions which
> > retrieve properties to use the wrong type.
> > 
> > E.g. to prevent retrieval of the u8 array as string, you'd have to
> > amend drivers/base/property.c:pset_prop_read_string_array() to
> > check the type of the property found and return -EINVAL if it's not
> > string.
> 
> I think it's doable. I will hack a new version later this week.

Ok, thanks for doing this.


> But it still not a (best) solution for Apple properties. B/c as I told
> already I saw in _your_ dump the _string_ properties. Someone might have
> got an idea to use them as _strings_.

That's kind of their problem then. ;-)  The Apple EFI properties are
untyped, so making them available as u8 arrays is the best we can do.
If people need them as strings, they should retrieve as u8 array and
convert that to string themselves.

Kind regards,

Lukas
