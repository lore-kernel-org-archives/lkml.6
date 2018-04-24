Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AB8JxZrvFKcnTKo/w+6/xpXwUegHSS/qdebycguIa3vfMpj3NyftULcdPgWvYpdBRZrad7hvgY2z
ARC-Seal: i=1; a=rsa-sha256; t=1524592555; cv=none;
        d=google.com; s=arc-20160816;
        b=yVEK/D7VFH52Wq2s4lKJm8Dz+InfpUKo6T+Vbq5Esc2QvpmNUtNF3Wd1gPQbHmOOz5
         Fqv9fJZg6F/vIxuojBqKyS/bje3j/6zHybQS6wgHU3wkeQEtUy4d4M2uGhb3PJxe9/8S
         Enxt3IW/daXDkrbJN42XsX+65+8HtSqT/rzA4JlabP2r82Rokt271oEjkdYv1BVu5GyM
         h3JGAhetU4xJC4BksNYj8t7IAYGQBnhbz8g0EovemeyWzRI+pIbTs7Z5SdvcEkil625O
         PbrrPuubdm15baZDpRe5SKHR6sz5ZXjWwPheMKXL8FhU8zyQUOs0n/gmvTCLSUy4DYvx
         CAOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=eCj7NXJ/iNLOXO8QPsKD9OYAZS7SagSPuC6U2bDOuf4=;
        b=hSrbr7OxrVhrl/hTNiwefiWh9JA5GnBwrAj9O87v+OMuzxJ/Z/NsLhesb/H5J4wHW2
         xKoVs34UagYchS2f51UXpC/xYK/6z7bVBR4f/YYhL690haMz7azyfu0WLFXyiPIHkyTc
         +tBsXO+cyDkNuJQQ2iqmDNKKFBJlYu2L2UEBnWpXBPeZeXqUxq5Adb4I90YN+sdWuaoF
         FK95MoF9QvYMcy+K4E2z5kwCFT3VEFCGvTN0IJBfPut5LN1wZE/KUBRtD9+obM6npP3r
         IkKqNSl0Z4Zw1ZQJUNL68fC2C5BHpD2Bl8WyPpCIFrdnUVziFQ7uFT9K4agM91EWjvx/
         rKsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Tue, 24 Apr 2018 18:55:45 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	Frank Rowand <frowand.list@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arend van Spriel <aspriel@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Michal Suchanek <msuchanek@suse.de>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 00/11] platform: device tree support for early platform
 drivers
Message-ID: <20180424175544.uq7f5x63a5il36sh@lakrids.cambridge.arm.com>
References: <20180424173051.15099-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424173051.15099-1-brgl@bgdev.pl>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649607100825317?=
X-GMAIL-MSGID: =?utf-8?q?1598651164024108912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi bartosz,

On Tue, Apr 24, 2018 at 07:30:40PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Device tree based systems often use OF_DECLARE() macros for devices
> that need to be initialized early in the boot process such as clocks,
> timers etc. However platform devices are more desirable.
> 
> This series aims at introducing support for early platform drivers for
> OF-based systems.
> 
> The idea is to have a special compatible fallback string: "earlydev"
> that similarily to "syscon" would be added to device nodes that need
> early probing. We then need to call of_early_platform_populate() early
> in the boot process to actually probe the registered devices.
> 
> I am aware that this new compatible does not strictly correspond with
> the "hardware description only" rule of DT, but we already have many
> functionalities that break this rule: syscon, gpio hogs etc.

I don't think we need the "earlydev" string at all, and can still keep
the rest of this infrastrcuture if it is helpful.

So while I'm certainly oppposed to the "earlydev" string, I think that
the infrastrcuture could be useful.

> The first user of this new functionality will be the DaVinci platform
> for which we want to probe the pll, psc and timer drivers early in the
> boot sequence but keep them implemented as platform drivers.

Can we have early_paltform_driver() take a reference to the driver's
of_match_table, and put that in a special section?

Then instead of looking for "earlydev", we look for any compatible
string in that section. No magic string required in the DT, and we can
always mess around with probe ordering in future.

> In the future, if this series gets accepted, this could become and
> alternative to TIMER_OF_DECLARE, CLK_OF_DECLARE etc. and could lead
> to deprecating of those macros in favor of early platform drivers.

IIRC we typically want to probe clocks before clocksources. Does using
early platform drivers ensure the necessary ordering?

Thanks,
Mark.

> Bartosz Golaszewski (11):
>   platform: early: provide early_platform_add_device()
>   platform: provide early_platform_driver_register_probe_all()
>   platform: make support for early platform devices conditional
>   of: platform: use pdev as name for vars of type struct platform_device
>   platform: use a dedicated list_head for early devices
>   of: provide for_each_compatible_child_node()
>   dt-bindings: add bindings for early devices
>   of: platform: provide of_early_platform_populate()
>   platform: provide early_platform_driver()
>   of: platform: provide of_early_platform_probe()
>   misc: implement a dummy early platform driver
> 
>  Documentation/devicetree/bindings/early.txt |   7 +
>  arch/sh/Kconfig                             |   1 +
>  drivers/base/Kconfig                        |   4 +
>  drivers/base/platform.c                     |  26 ++--
>  drivers/misc/Kconfig                        |   8 ++
>  drivers/misc/Makefile                       |   1 +
>  drivers/misc/dummy-early.c                  |  40 ++++++
>  drivers/of/device.c                         |  14 +-
>  drivers/of/platform.c                       | 143 +++++++++++++++-----
>  include/linux/device.h                      |   4 +
>  include/linux/of.h                          |   3 +
>  include/linux/of_device.h                   |   5 +
>  include/linux/of_platform.h                 |  19 +++
>  include/linux/platform_device.h             |  52 +++++++
>  14 files changed, 279 insertions(+), 48 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/early.txt
>  create mode 100644 drivers/misc/dummy-early.c
> 
> -- 
> 2.17.0
> 
