Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524591071; cv=none;
        d=google.com; s=arc-20160816;
        b=CWzYGZULZeSsJiHwIr8kS03fVAgWSZTbNalW7IEk2ieuEAhaa5kGPX+7LIeSnCN0Qk
         b/jqvj/7wN1L8WempQPpgv1EYbMArgUgVD+z1wwDguQkPmVEH8d0ZaweAl8XlgSRozSS
         dWdDcAqVs3FsmURzoV8sjigkIsh1Myp7BxgC6H5xTc0JyGS25OIqWb4Hun4DihENJ19C
         ghrzlA2teTWI1Mm11DTE0FZ5ZxiSW84q/Y+ENq2SY8YERo5f35S8kxWgh9TlTxB/JTzQ
         5epHaWd1Rm5DA7hYrYYD8Ppd0WqPxGWL6Efsjgi9RHcSmXsZRRpsaLSe+QtVR5v/R//H
         YQVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=IFrQEk4nDjzvgcrPTH5iMFpItGQmQCsWREhwNBnKrRs=;
        b=aiV3rvf8LAQVKUqiaiObq0CWvTi9IaD6HR35oPS9o7IeyeDc+SBNgXU7prdmSrKXne
         DqejIZRTA2NWAIz1moI722aL9KVaR4wOZREvlHxxJIcw6PaM/lGp2Z4GGTPwblkHn4R1
         OZTwbkdXwCmE9OL8/oKHl8sIbk8G3zv4wUhEMDFyYRA0Je0RBCHii2KDxGM8lABiMa1o
         7gM4dx1NAP1g+QMqwR1fRi5iFmXy+BgNvOq6MHkA3QTOOUc4moX4QmnLhgb+tXci+NWQ
         vX1K/nNIKPox7apM9BoxHc7xmNkZa/K+OBoHutt84Iu4kwP6e+prcfnR2mkP3BoG7GkL
         YYew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=XIEUzhx1;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=XIEUzhx1;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AIpwx48R1ziX2RoDGJPprGB+3jngQ3qltyGqgUve4dqV9z6fofpW9gkrYs0T7HBdbvzumya76DV3ng==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>,
	Kevin Hilman <khilman@kernel.org>,
	David Lechner <david@lechnology.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/11] platform: device tree support for early platform drivers
Date: Tue, 24 Apr 2018 19:30:40 +0200
Message-Id: <20180424173051.15099-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598649607100825317?=
X-GMAIL-MSGID: =?utf-8?q?1598649607100825317?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Device tree based systems often use OF_DECLARE() macros for devices
that need to be initialized early in the boot process such as clocks,
timers etc. However platform devices are more desirable.

This series aims at introducing support for early platform drivers for
OF-based systems.

The idea is to have a special compatible fallback string: "earlydev"
that similarily to "syscon" would be added to device nodes that need
early probing. We then need to call of_early_platform_populate() early
in the boot process to actually probe the registered devices.

I am aware that this new compatible does not strictly correspond with
the "hardware description only" rule of DT, but we already have many
functionalities that break this rule: syscon, gpio hogs etc.

The first user of this new functionality will be the DaVinci platform
for which we want to probe the pll, psc and timer drivers early in the
boot sequence but keep them implemented as platform drivers.

In the future, if this series gets accepted, this could become and
alternative to TIMER_OF_DECLARE, CLK_OF_DECLARE etc. and could lead
to deprecating of those macros in favor of early platform drivers.

Bartosz Golaszewski (11):
  platform: early: provide early_platform_add_device()
  platform: provide early_platform_driver_register_probe_all()
  platform: make support for early platform devices conditional
  of: platform: use pdev as name for vars of type struct platform_device
  platform: use a dedicated list_head for early devices
  of: provide for_each_compatible_child_node()
  dt-bindings: add bindings for early devices
  of: platform: provide of_early_platform_populate()
  platform: provide early_platform_driver()
  of: platform: provide of_early_platform_probe()
  misc: implement a dummy early platform driver

 Documentation/devicetree/bindings/early.txt |   7 +
 arch/sh/Kconfig                             |   1 +
 drivers/base/Kconfig                        |   4 +
 drivers/base/platform.c                     |  26 ++--
 drivers/misc/Kconfig                        |   8 ++
 drivers/misc/Makefile                       |   1 +
 drivers/misc/dummy-early.c                  |  40 ++++++
 drivers/of/device.c                         |  14 +-
 drivers/of/platform.c                       | 143 +++++++++++++++-----
 include/linux/device.h                      |   4 +
 include/linux/of.h                          |   3 +
 include/linux/of_device.h                   |   5 +
 include/linux/of_platform.h                 |  19 +++
 include/linux/platform_device.h             |  52 +++++++
 14 files changed, 279 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/early.txt
 create mode 100644 drivers/misc/dummy-early.c

-- 
2.17.0
