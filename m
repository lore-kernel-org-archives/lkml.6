Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AG47ELtTt/DB9rIt6LNcyDJ1+7ccFFgfwtgcRP8i6kxd/2ZqR6wfq11jKwFwcgzkpfQLRH/omyeD
ARC-Seal: i=1; a=rsa-sha256; t=1519636169; cv=none;
        d=google.com; s=arc-20160816;
        b=bmWagiOU8VTzKnNU//m7kU0cykTM24ffh8Ws0jhvpZ8Iwx1lEEtLtf0rZ6mHB9mdVV
         6w9MATy4ShnLYhMzgLAYz/OoNkxigdTuadBL2RdbG2Vt9M99h98CAeBV8IKxjCfpzzwF
         ppuwXsedrtI1rl/ipiu1U+cMK2tVrhvJcktCGxtRnQANNxP5t1XypPMa8iF/LR3UdeQN
         iGhxb4qR1LQZogLk7HHaViWIhWQCw+mmB26csR0WOR0IHRE1s/FDYYpAYYuLC63/0not
         zHwVNO44/BOzmoTBfD1HANtTlApIXrREqWm40hxwhsVOb1cde/zjTuaUN5psaykiCrnG
         ENrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=Yrg+IgrYbkl2G6UVNMs587uL50uS4tj1POItKXgiyRE=;
        b=bajO00OsEHCRZ7wP8vGvn0ES3PrLiaMpufWNBjV7ZsprgSwD4jzuULpkZxJkDdVhuO
         HiBjVkCtwVC4q4++3snMH0+sGhbCIJ+Rl6mxqfYiT2JXqR2ql6ybLPFwKDcPRC5hdymZ
         8xjmofPhimOlcayg6zgFe64RHtX5oAvN8XUfonkEmzIV8+1CbuFX/ePAP4ZMrEHhrEfc
         3akb9Hn8oDiJWijg+SDFNNWH1FdWk1o8H3LDOZdm7tnLkmDU4ULoEHSyPqGS5UxnglBi
         bk3DJT8sPeGigV+661HfgiHj8xlyFKM+yYli1YBfCumdpjT6MdfOCpQbfIV5TvJqMyVO
         eoVg==
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
Subject: [PATCH v3 00/12] USB Type-C device-connection, mux and switch support
Date: Mon, 26 Feb 2018 10:09:13 +0100
Message-Id: <20180226090925.29436-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454016298840899?=
X-GMAIL-MSGID: =?utf-8?q?1593454016298840899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Here is version 3 of Heikki's and my USB Type-C device-connection, mux and
switch support series. Version 2 and 3 bring various small code and style
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
