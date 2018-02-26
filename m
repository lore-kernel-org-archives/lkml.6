Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELudQ8RekOzDnkk9c26tkt3SDpJcHJAKtHm2t0MtELwiYjr7/ihtl9g1zi56af4hnBjeMVHy
ARC-Seal: i=1; a=rsa-sha256; t=1519670364; cv=none;
        d=google.com; s=arc-20160816;
        b=HkE4cpO9aPmgcmRjhsBbbavXdj45yx1WPqN2ne30Y9dUG3lPgt5UwytKng37AjVuMv
         t5f5HVuqgS8nkHWC3b1NOZeQqnlsglop0XxA6E68eRZOuGCyAyu0oLmuEUoHp5/fIESv
         wd7xz/P5RvyCQ04u+3QMrDZAhjJ5h3fgCVwLW8K+muP1ittvxhH29x+SPnDPQkrR2CrE
         n7D8RoL4MXE3FXrLFMahVuN9Xml6Mw8Jd1uLRAhaX6c85IhT+B/EFMbV1AcfBA/X1bmZ
         LoZ/84/b9aAy9gB8Sfot8YVnDP87mhApb39fl5h+VAQfCJ3+KeMlKI8CjpwrooljHNYp
         h5Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=w8AYb1WHeFRWKZ+1i+83mfXPC5ojnEAEMLwZ832BWWs=;
        b=zXAD71sn/8+64EfMaHeqc1X0Asx8vltZMJOeuIoMFssN/44WEBl75TYmPM1W8KlEEj
         HYfadN6ScxaNuNYjb9VbpLaVXIX/pfx0EZvMpif5nsAALNN3CieOBe7MZstqgbENhJrX
         AfoPIOqsVJp/NgdMYtdKrSE4sVBRmHQ4ypdKClmWud9+hY1EqhdQO0Ja8p2udVLN7gdW
         Msxk9Ff777DFHD+eIsaiJmc2YUGp69KyZSztgJCWyNznNt3878H+qQuydlsJ6dZlXBfu
         KTbtlh2z9ssxylH6I6LbpHTN51UohFFd7mVVelHQpvkZCL24596BFwJyFN8R4x1te/vA
         Kf4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of hdegoede@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=hdegoede@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v4 00/12] USB Type-C device-connection, mux and switch support
Date: Mon, 26 Feb 2018 19:39:07 +0100
Message-Id: <20180226183919.24353-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593489872208876952?=
X-GMAIL-MSGID: =?utf-8?q?1593489872208876952?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Here is version 4 of Heikki's and my USB Type-C device-connection, mux and
switch support series. Version 2, 3 and 4 bring various small code and style
fixes based on review (no major changes).

Here is the original cover-letter of v1:

Some devices with an USB Type-C connector have a bunch of muxes
behind that connector which need to be controlled by the kernel (rather
then having them controlled by firmware as on most devices).

Quite a while back I submitted a patch-series to tie together these muxes
and the Type-C Port Manager (tcpm) code, using the then new drivers/mux
framework. But the way I used the mux framework went against what it was
designed for, so in the end that series got nowhere.

Heikki Krogerus from Intel, who maintains the USB TYPEC subsystem, has
recently been working on solving the same problem for some boards he is
doing hardware-enablement for.

Heikki has come up with a number of infrastructure patches for this.
The first one is a new device-connection framework. This solves the
problem of describing non bus device-links on x86 in what in my experience
with this problematic area is a really nice simple, clean and *generic*
way. This could for example in the near future also replace the custom
lookup code in the pwm subsys and the custom pwm_add_table() /
pwm_remove_table() functions.

The other 3 patches add a framework for the different type of Type-C /
USB "muxes".

Heikki and I have gone through a number of iterations of these patches
together and we believe these are now ready for merging. Since merging
infrastructure patches without users is not done and Heikki's own use-case
for these is not yet ready for merging, the rest of this series consists
of patches by me to make the Type-C connector found on some Cherry Trail
devices (finally) be able to actually work as an USB port and not just
a charge port.

The last patch uses the new usb-role-switch framework to also do proper
devcie / host switching on CHT devices with a USB micro AB connector.
This is also a big feature for CHT users, because before this they had
to do a reboot to get an OTG-host cable recognized (on some devices).

Part of this series is an usb-role-switch driver for the role-switch
found inside the xhci controller on e.g. CHT devices, this is currently
implemented as the generic xhci controller instantiating a platform
child-device for this, since this really is a separate chunk of HW
which happens to sit in the XHCI mmio space. This approach may not be
universally liked, given that in this new series the role-switch driver
is much smaller and does not have any external deps anymore we could
just integrate it into the xhci code if that is preferred.

About merging this series (once everything is reviewed, etc.), there are
quite some interdependencies in it esp. a lot of the patches depend on
the first patch. Luckily patches 1-10 all apply to subsystems which are
maintained by Greg (most to the USB subsys). Which just leaves patches
11 and 12 once 1-10 are merged. Greg, can you create an immutable branch
for the platform/x86 and extcon maintainers to merge once this is done?

Regards,

Hans
