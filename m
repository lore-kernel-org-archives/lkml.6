Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1524756574; cv=none;
        d=google.com; s=arc-20160816;
        b=TJMris3XtRDMyHqgzbljTorKIaGd7zZNiLhRC2EO+CVf4TTuVnj6ZsdYvmT5Z3SYFR
         yYTFMjbtu1uEphn4hf4QZL+T4912ib4q3eBlFbHAxHkWuani3ePizKVy1qdNRkA6uMyu
         lNA+8qQLh81cs9rVETkmTUkJ0EMXARnNlXf4xxS77e+T+UElKmiSYKyLbyluESSg5lj8
         58wM4IDnTjNk80rf4+9o+R2ewJvuFRVY0sSk1eZxudOd+SWVURRoDkZfvwBDFMWUS1QX
         7ATo8O38ht+rlAgXoLDTzaCBsztEXJ8bZejTanpqBrTo7J1a31lTJnalRsY+0yWH9G3V
         hfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=psxLmNITlMYHCRdygaR0WxL86seus5FiYSOervPjrTw=;
        b=JRARdL/k53YjpTyB5wl+XSXwFaPRoj0XTmI0v021hRLhvtL5+NhjyTUVq+Rs6X9/y5
         gPr4O/sgEwqj2nWPwcikHICulhDgHR3/Y9HFzeML4cVw8pwPwhBBeNaT41wD+hkuckS6
         orFuo7QJKREV7eE/d12dYf3Pm5Ym1Ltq6VsulVzFff7nYWs/K0TpJ9TNSCaJlJq4mrfi
         5gb2uh+s19RlXsg024aahlQZ/CTZlfzqVxBadWB9+8pjmonf1Wmo5yEBFaI15wwVRm7/
         dC5B5lHuVABFaUX/CR2t6sYzUTxhoyujf74J16xHP7gMJvOy3NXNk/NDJ6RvVjUEbZnM
         9QKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=fUAYMrEF;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=fUAYMrEF;
       spf=neutral (google.com: 209.85.220.65 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AB8JxZqvPqIeS95a2Vm+3+VO9jb9Wt9rm/8C1cvUxJzhbESzn7nfh+cQq5UU5kmvXRBOxxB9vIGNdw==
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
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Peter Rosin <peda@axentia.se>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH RFC PoC 0/2] platform: different approach to early platform drivers
Date: Thu, 26 Apr 2018 17:29:18 +0200
Message-Id: <20180426152920.21569-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598823149958129846?=
X-GMAIL-MSGID: =?utf-8?q?1598823149958129846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow to my series[1] the aim of which was to introduce device tree
support for early platform devices.

It was received rather negatively. Aside from using device tree to pass
implementation specific details to the system, two important concerns were
raised: no probe deferral support and the fact that currently the early devices
never get converted to actual platform drivers. This series is a
proof-of-concept that's trying to address those issues.

The only user of the current version of early platform drivers is the SuperH
architecture. If this series eventually gets merged, we could simply replace
the other solution.

The current implementation of early platform drivers is pretty much a hack
built on top of the early_param mechanism. The devices only look like platform
devices and use the same structures but never actually get registered with the
driver model.

The idea behind this series is to allow users to probe platform devices very
early in the boot sequence and then switch the early devices to actual platform
devices and the early drivers to platform drivers in during device_initcall.

If any of the early registration functions is called after device_initcall,
we'll just end up calling the normal platform_driver/device_register routines.

The user can specify if he wants the device to be probed the second time after
this conversion and the check if it's an early or a normal probe from the
driver code.

We also support a simple version of probe deferral: initially each new
registered device is added to the head of the early devices list. If it matches
an early driver, it will be probed. If probe return -EPROBE_DEFER, it will be
moved to the tail of the list and reprobed the next time we match a device
but after all other devices.

This implementation has certain shortcomings that will be addressed if the
feedback is at least somewhat positive. For instance: the driver registration
happens in early_initcall(). This may be too late for certain clocksource or
clk drivers. The solution for that would be defining a new section in which the
init callbacks of the drivers would reside and let the architecture call the
actual registration function whenever it's needed.

I also need to figure out if any locking is needed.

We don't support DT in this series either. The proposed approach would be to
walk over the devices nodes early in the boot sequence and allocate and probe
the matching early devices and then register them with the driver model later.

[1] https://lkml.org/lkml/2018/4/24/937

Bartosz Golaszewski (2):
  earlydev: implement a new way to probe platform devices early
  misc: implement a dummy early platform driver

 drivers/base/Kconfig            |   3 +
 drivers/base/Makefile           |   1 +
 drivers/base/earlydev.c         | 175 ++++++++++++++++++++++++++++++++
 drivers/base/platform.c         |  11 ++
 drivers/misc/Kconfig            |   8 ++
 drivers/misc/Makefile           |   1 +
 drivers/misc/dummy-early.c      |  46 +++++++++
 include/linux/earlydev.h        |  63 ++++++++++++
 include/linux/platform_device.h |   4 +
 9 files changed, 312 insertions(+)
 create mode 100644 drivers/base/earlydev.c
 create mode 100644 drivers/misc/dummy-early.c
 create mode 100644 include/linux/earlydev.h

-- 
2.17.0
