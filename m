Return-Path: <dalias@aerifal.cx>
X-Google-Smtp-Source: AB8JxZqevHZYClR8ZUU8+sW0fAMEs26DCXwx2+dSy5vX9HGAQuOqDE5wQSfhAhfIazigfMWmkzPk
ARC-Seal: i=1; a=rsa-sha256; t=1524763980; cv=none;
        d=google.com; s=arc-20160816;
        b=X2pGApdIg1LrghVE6zldqJsFclwZ4cpKdh05Ac0cgpYNWvr87fbKX676NsR9+RjF7g
         jMh4zm2UhPwGb+AKuV8oUWD/WJ2HEIIkpmgWjDvTrF/vQeiqwcMaTV0dIJGHkIM+Vnnp
         6Kjn78Ao53SmGfBLGbabpmkVAxaUPBp7gNc7ogOsaZsEwoWyHs4dn7F8S8v/B1EES/GA
         rlCjJClndh0kX8uLScF3F+cMdTlTWDzspehr3EZtEXIJTVUAfWWYCNnpovoTmsZcow7X
         FV23JIlzu/ASxyr1f1G0K2dsaQH+6Cw722d4+0dvBvmmWjnbm0Cy5JDMcurGoQhWuG4h
         qAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=sender:user-agent:in-reply-to:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=nYRXoxFnTP3Ddq9xwv57b17GlNzkpeKNrdV/bxRqTj0=;
        b=SwTbCLmPyuMlQP5ofLnvvMSMXK+Bl1m1NzOY9vA2dI4Gop03cBgffCw+rjr3iYysgl
         gBA3RdyNNj1wvJiS2Ts6QqiGuWAvLCOhw4dqIFnb15F3t31xamzEFsglVEN+fG12z/50
         E2aIT7+QYU+FFxn9Sbh4gcpJooLTBHaepPWCus9NL+3nWxnyWxNUQ6Xs+mJ+MzVLCq8k
         XR6QtBK+QXlQPllSZn93ErP9PrqtkGrAUK9gqgZOO3MBQHZvEIdUcLTMZnRG/JIcCTyN
         M92BT3XBZ1f2QkhMLLJXCltCA9qTO16Vl9tPaEURiXS0mO/FD88du1HZMRAmXUrnJO+u
         2xYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.12.86.13 is neither permitted nor denied by best guess record for domain of dalias@aerifal.cx) smtp.mailfrom=dalias@aerifal.cx
Date: Thu, 26 Apr 2018 13:31:51 -0400
From: Rich Felker <dalias@libc.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
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
Message-ID: <20180426173151.GJ3094@brightrain.aerifal.cx>
References: <20180426152920.21569-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426152920.21569-1-brgl@bgdev.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: Rich Felker <dalias@aerifal.cx>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598830914959905493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 05:29:18PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This is a follow to my series[1] the aim of which was to introduce device tree
> support for early platform devices.
> 
> It was received rather negatively. Aside from using device tree to pass
> implementation specific details to the system, two important concerns were
> raised: no probe deferral support and the fact that currently the early devices
> never get converted to actual platform drivers. This series is a
> proof-of-concept that's trying to address those issues.
> 
> The only user of the current version of early platform drivers is the SuperH
> architecture. If this series eventually gets merged, we could simply replace
> the other solution.

Looking at a quick output of:

	grep -r -A10 early_devices[[] arch/sh/kernel/

it looks like all of the existing early platform devices are serial
ports, clocks, and clocksources. The switch to device tree should pick
them all up from CLK_OF_DECLARE, TIMER_OF_DECLARE, and
EARLYCON_DECLARE. Until that's complete, the existing code works
as-is. I don't see what problem you're trying to solve.

FYI I'm (sometimes-somewhat-absent) arch/sh co-maintainer.

Rich
