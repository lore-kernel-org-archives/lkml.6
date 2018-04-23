Return-Path: <rjw@rjwysocki.net>
X-Google-Smtp-Source: AB8JxZr2aCxhcNlYVHTIN/PBLGGuDD8NjxbdI/jPUGy642+lBQFA3/9cnjU5Rd+89z00UZXHxjKd
ARC-Seal: i=1; a=rsa-sha256; t=1524475105; cv=none;
        d=google.com; s=arc-20160816;
        b=zz/xM9ne7gy2adLpUr2wgfieFTOfOXV3DIObcB0l+63OS3f9I7aXRF44ROa2P1+VWI
         fE33f4Ml15aFiUoUsk9M9A8kOeKO7lM17TZk7wcJMNlGj6QB9ZRV8IIxNVBIIYowWzaI
         tryJAIfYq7xUgrjoy7ccuVJbR1B8rPzKYDUvHso2LgGN8MnRsQiONEWag/V2gNi1OLkG
         Bgl9Guwmf4o3kr2zVr7LyWK1+uZTn2mde7cjuIfjZU9Q4O93y8J2SyHjQhsfyhJ54qa4
         +a3ioq6oeGbZlbgGlxVto6jdNuY9iDvCuRWkMw9K7xc2BoQgNI14z1g59ikFEoIKgs5c
         vEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Wie9kD3kqGR2vgmWQ0h79wnUBH+RAkLjfeuXrfX6mkA=;
        b=UuIgZjRZZk34MXS0NSVgWHqGIMxpCYXPXUP3BrFdnqIsZdhQEMze9zy4do7qbzaH+c
         Sylsck/18qmocr+z1A800fc7Pu4TlW/Sgr6+AFT0TjSb+cidSYOfE6QdpCf8eefNaUtX
         wDKYyc9gDfE1TnB7MpOdTD+frEUaxsfhFsI5kUKDctqrzCWHUj7lpOjW1/v3Rk0BPD6b
         +xnhcrVDTPLH5PJKLcC7IpREYehsACOv7+TbE18U9AGMHnG/12ICIGw9B0B6UMl2pvM9
         2KNM7wcIb4VLsecaa56w69K0jhifim1vzoFLsk65K1ndf0BkLDnBNRayvh2blWsYWTOY
         lxGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rjw@rjwysocki.net designates 79.96.170.134 as permitted sender) smtp.mailfrom=rjw@rjwysocki.net
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Mon, 23 Apr 2018 11:18:17 +0200
Message-ID: <1792056.cK5O20Fh4U@aspire.rjw.lan>
In-Reply-To: <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be> <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594912192574352449?=
X-GMAIL-MSGID: =?utf-8?q?1598528007640207502?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

First, sorry for the huge delay.

On Wednesday, March 14, 2018 12:26:24 PM CEST Geert Uytterhoeven wrote:
> Add a callback to inform a device that his wake-up setting has been
> changed.  This allows a device to synchronize device configuration with
> an external user action.
> 
> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
> switch, the system suspend procedure is:
>   1. Configure PMIC for DDR backup mode, which changes the role of the
>      accessory power switch from a power to a wake-up switch,
>   2. Switch accessory power switch off, to prepare for system suspend,
>   3. Suspend system.
> 
> Hence step 1 cannot be done in the PMIC's suspend callback,

I don't quite understand this, so can you please explain?

What can't it be done from ->prepare() or even from a suspend notifier?

> but it can be done in the new callback, in response to the user writing "enabled"
> to the PMIC's wakeup virtual file in sysfs.
