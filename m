Return-Path: <dmitry.torokhov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520705523; cv=none;
        d=google.com; s=arc-20160816;
        b=HpU8KCIImVT31zgDd24R+BQf8lSDAVPYU3lJmProj/Og6aLEexALGDO0UVRn9ZViEG
         +HMfNDDkmfs+CTDNLrZ4rmP95ze8I8nQne5TQ9A1cNuJ37pG/zYAbarjLc/T9Evt6+br
         ZxA+PLR7thvQYeLYDiZiBGOS7oyImYr+5VqIQq51gZX9RDHRc45LPPSYzS3pKfUNQqKh
         58rfmlVccBasYcdhYo//2bHWZyQfdadG4YT7nFlxkUXTiaqGEj4U5tU6VuFuCEV2KHXl
         AgyF32zoRk6IptequD4axVpWTfWQk/QkkBsVENx51TKjQFWuQEGpAK4Fuj4fJz3G4GY6
         v0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=tsEEyTDmjRTN2SolVFKWc9du0GoeXSFJYs2aCGlW/+s=;
        b=juDzHqBRmZtDbpbrhiVSYwaThQXmCSoEoMjDQ5uhbYZ9ZACbc8htQ345amcmFaf7yH
         HqhWPm7uKmaRr4HLaa2tMGOUbfMhFDVy91vQQtUpfzrr77+fQGwdeEPlM3/c0z4b8ViJ
         p5SJ/I3GcrpvDRxxz9G8TLRZYy4iF54WCM07oxEOEZB9fyyz883tkgfCiBNwNt6CVBNG
         h+vJFrvb8y/5oGiXCZrE/TpUF9AHRcD0pZ3PRJm5tR6IMjgnq+I4ynFFKgLwXKgXCsy2
         1iGyxn/QomeD/3jt4CoGOI/y935F1NGVv9LRO0+qvwARsE5Y9Itwn0svtmmikvMDdOak
         HUcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QKkgf7x7;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QKkgf7x7;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu5X1M/aqRAlJ4/UduO2guj7jy0RYTjdGlw9/tKsUjdJaieKyYwQEFvxxaV33n8HlsXrI/efw==
Date: Sat, 10 Mar 2018 10:11:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org,
	briannorris@google.com, heiko@sntech.de, dtor@google.com,
	dianders@google.com, devicetree@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v5 1/3] Input: gpio-keys - add support for wakeup event
 action
Message-ID: <20180310181159.GA260013@dtor-ws>
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com>
 <20180308073213.8419-2-jeffy.chen@rock-chips.com>
 <20180309232720.pmqaulifiqa5czul@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309232720.pmqaulifiqa5czul@rob-hp-laptop>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1594575314277062505?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 05:27:21PM -0600, Rob Herring wrote:
> On Thu, Mar 08, 2018 at 03:32:11PM +0800, Jeffy Chen wrote:
> > Add support for specifying event actions to trigger wakeup when using
> > the gpio-keys input device as a wakeup source.
> > 
> > This would allow the device to configure when to wakeup the system. For
> > example a gpio-keys input device for pen insert, may only want to wakeup
> > the system when ejecting the pen.
> > 
> > Suggested-by: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > ---
> > 
> > Changes in v5:
> > Remove unneeded irq_wake flag as Andy suggested.
> > 
> > Changes in v4:
> > Add dt-binding gpio-keys.h, stop saving irq trigger type, add enable/disable wakeup helpers as Dmitry suggested.
> > 
> > Changes in v3:
> > Adding more comments as Brian suggested.
> > 
> > Changes in v2:
> > Specify wakeup event action instead of irq trigger type as Brian
> > suggested.
> > 
> >  drivers/input/keyboard/gpio_keys.c    | 63 +++++++++++++++++++++++++++++++++--
> >  include/dt-bindings/input/gpio-keys.h | 13 ++++++++
> 
> This file should be in the binding patch.

No, this is a folly. Both the header, along with the documentation (i.e.
binding doc) should be together with the patch that introduces the
changes. The patches are supposed to be self contained and sufficient to
stand on their own. Neither this header, not the binding doc make
sense without the change to the driver itself.

Next we'll start adding #defines in a separate patch before using
them...

Thanks.

-- 
Dmitry
