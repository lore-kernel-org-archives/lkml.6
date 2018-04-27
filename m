Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AB8JxZo2++J7l0UZJEZzpCwFQwHwwhyfgQaCC7xkPklvE8XsbgGCnekDc51OTtN78xPl1KvaeWEg
ARC-Seal: i=1; a=rsa-sha256; t=1524797720; cv=none;
        d=google.com; s=arc-20160816;
        b=Xy5pWZrX5Ko2b/JW/ON6XJEOk7vCwEt/dkJDlZst0cXrPk6LYPfjv6abr3t07XwRHX
         xPchQnUZfc7GevE/YEtJaaM+kjXIyo8PbmQE0Oy+OLWjp/F6od21GY5kwWTs0bNQq6Sr
         ASUtAANjWiL2KUnVPN+5zzXGONulLlVm3fNFQmFRHdP+0tD+YPbad4n1j5uL8FIiVUAd
         +hBvCGK8jyjiFSgKqhfF9DKgIZCjYndJhoYdJ4DNr8gfW9Bjy6m7ubjl6HjhDmdXt+Ef
         Jmxk90Xw4hiyqgWkeU+tMRGmXW8Fl47XcnjmmfZDOwsLlxFvKeP7yLtEBU5GSah8wcF3
         6QdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=ytvHSxg0+ns0SvxR5QxP/XWcf+ZmMPnA7NpX1oaUeZk=;
        b=IAeSqFFDwWSzViw+S2A0R+uPHOS4UxM5+oHSc/gQRxbJHfo58FrYqKMx8UlcOhG67M
         yqYe+2eOGoUq+uEyPP/tL8YIYhgtUDaVeAyS8+bBJAetjnLTeakjQg8xKuHYBjojYHyQ
         cSEuZnW+Kn9/9y8AP/pvx/zMfYW4/M5iNBUSqCqKQYJ5k1oVZPYON6MEl8Y2/fdK3QzQ
         f93Y7YqV3XynMAER5VvfyHCSrBecykgtn9ARjObLvXiOtyHuBLM62S9ZI3dQ/D+bvJVZ
         KqNABuh8glJIbC9A4ZtUCv9WyBGM0d8Ads2WYTqq0WR7WFotGiUewlicd2ESG61AzyOI
         CpVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Thu, 26 Apr 2018 22:54:21 -0400
From: Rich Felker <dalias@libc.org>
To: David Lechner <david@lechnology.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Peter Rosin <peda@axentia.se>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH RFC PoC 0/2] platform: different approach to early
 platform drivers
Message-ID: <20180427025421.GN3094@brightrain.aerifal.cx>
References: <20180426152920.21569-1-brgl@bgdev.pl>
 <20180426173151.GJ3094@brightrain.aerifal.cx>
 <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d1f9114-f1d1-961f-4f36-74adff059dc3@lechnology.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598866294874275938?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 09:28:39PM -0500, David Lechner wrote:
> On 04/26/2018 12:31 PM, Rich Felker wrote:
> >On Thu, Apr 26, 2018 at 05:29:18PM +0200, Bartosz Golaszewski wrote:
> >>From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >>This is a follow to my series[1] the aim of which was to introduce device tree
> >>support for early platform devices.
> >>
> >>It was received rather negatively. Aside from using device tree to pass
> >>implementation specific details to the system, two important concerns were
> >>raised: no probe deferral support and the fact that currently the early devices
> >>never get converted to actual platform drivers. This series is a
> >>proof-of-concept that's trying to address those issues.
> >>
> >>The only user of the current version of early platform drivers is the SuperH
> >>architecture. If this series eventually gets merged, we could simply replace
> >>the other solution.
> >
> >Looking at a quick output of:
> >
> >	grep -r -A10 early_devices[[] arch/sh/kernel/
> >
> >it looks like all of the existing early platform devices are serial
> >ports, clocks, and clocksources. The switch to device tree should pick
> >them all up from CLK_OF_DECLARE, TIMER_OF_DECLARE, and
> >EARLYCON_DECLARE. Until that's complete, the existing code works
> >as-is. I don't see what problem you're trying to solve.
> 
> The problem for us is that clk maintainers don't want new drivers to use
> CLK_OF_DECLARE and instead use platform devices. I have just written such
> a new driver that is shared by 6 different SoCs. For some combinations of
> SoCs and clocks, using a platform device is fine but on others we need to
> register early, so the drivers now have to handle both cases, which is
> kind of messy and fragile. If there is a generic way to register platform
> devices early, then the code is simplified because we only have to handle
> one method of registering the clocks instead of two.

Can you get them to explain why? This sounds wrong.

Rich
