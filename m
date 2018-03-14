Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELt5oDsthC+hs6kz6FFHL7rov3wsTnueIdnsdQo6sIYtRPH9c1WuheRCVpqHbrWFmK2rSScW
ARC-Seal: i=1; a=rsa-sha256; t=1521033140; cv=none;
        d=google.com; s=arc-20160816;
        b=YW05KHqkzXcYujDRRA4F4TkEM0CVsNaWzPR0hG47nAjNMznqF78kF1EwOuFnNW7ZUt
         xd1LFIaBpHdo/Q9RevWGxuJZHeGaMTCnMLewCltLZLsT5o8FMm1gRo/59LN6kPTunrp3
         cDid7jJ15mZOgVp1VpEuMsuA+H2ZWQyZDNQgobWOv0nPDutkACr1CGsslQB9GbNHlw9K
         CD41Rb/BOgHM0eNYVvWo9KpgM4BQ/nRaTbmxLGbvX9tnyS+U43u8MML6hwt5eoFIWUau
         j9QfmyF4kjEcAuwJ/q3tGpqQ8andfwVu86HlSjQAhg+GElWEA8p1+1rZNrAZ6JF8C7jy
         jkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=2eDskVtOl5gn4vYU0LXEgBm9gwcsexBnsi77+X/sr8A=;
        b=QPdJAwLsHr59DeSpYYHDEyqwE48YggLUXAUTiEnVDE3TpOEYvqdWcLSQg8tjLqhnk2
         UNJTDNZLTPNP8ZTboU/+E2mjLCYZ0cqCqChX16hasfM6CSFF1b0muJO7ryBg9/c4BbGJ
         osQBy+rdNW77mad3nehU3bhmG1OlbITHNy32AcP/dCxAbDZEHBCc5lZL1VH5lzT3bnqs
         ibl9ouX/97Doi9FfEeGCTYPXODRRG6g01ua7J9FteXbWMTgbRzxO5YP0G7BJF3DfHxEz
         8g1UAYZfQhfKvbqqRAGw/ZomSSp2yHNl4LXhUFUWPx6Ny//0K0jS3GMy6iRjCx4p6NJo
         IrzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37991590"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
	Andy Shevchenko <andy@infradead.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jun Li <jun.li@nxp.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH v8 00/12] USB Type-C device-connection, mux and switch support
Date: Wed, 14 Mar 2018 16:12:03 +0300
Message-Id: <20180314131215.70833-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.16.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594918846021835736?=
X-GMAIL-MSGID: =?utf-8?q?1594918846021835736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This is version 8 of series we prepare with Hans where we are introducing
support for USB muxes and generic device connections. The only change in this
version is to patch 1/12 (the device connections), where we are no longer using
rcu. Greg pointed out that we are not doing anything heavy enough to justify use
of rcu.


Cover-letter of v7:

This is version 7 of Hans' and my series introducing support for USB muxes and
generic device-connections. The api naming for device-connections is now made
according to proposal from Greg, connection.h is dropped and the prototypes are
now in device.h. kbuild test robot <fengguang.wu@intel.com> also found stylistic
problems from patches 9/12 and 10/12 which were fixed. The patch 4/12 ("usb:
typec: Separate the definitions for data and power roles") was added to the
series.

Check the v6 from here:
https://lkml.org/lkml/2018/3/2/340


Here is the cover-letter of v6:

Hi All,

Here is version 6 of Heikki's and my USB Type-C device-connection, mux and
switch support series. Versions 2 - 5 bring various small code and style
fixes based on review (no major changes). Version 6 is rebased on top of
the latest usb-next and brings one small but important code fix in
the devcon code.

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



Hans de Goede (7):
  usb: typec: tcpm: Set USB role switch to device mode when configured
    as such
  usb: typec: tcpm: Use new Type-C switch/mux and usb-role-switch
    functions
  xhci: Add Intel extended cap / otg phy mux handling
  usb: roles: Add Intel xHCI USB role switch driver
  usb: typec: driver for Pericom PI3USB30532 Type-C cross switch
  platform/x86: intel_cht_int33fe: Add device connections for the Type-C
    port
  extcon: axp288: Set USB role where necessary

Heikki Krogerus (4):
  drivers: base: Unified device connection lookup
  usb: typec: API for controlling USB Type-C Multiplexers
  usb: common: Small class for USB role switches
  usb: typec: Separate the definitions for data and power roles

Mathias Nyman (1):
  xhci: Add option to get next extended capability in list by passing id
    = 0

 Documentation/ABI/testing/sysfs-class-usb_role |  21 ++
 Documentation/driver-api/device_connection.rst |  43 ++++
 Documentation/driver-api/usb/typec.rst         |  73 +++++-
 MAINTAINERS                                    |  12 +
 drivers/base/Makefile                          |   3 +-
 drivers/base/devcon.c                          | 136 +++++++++++
 drivers/extcon/Kconfig                         |   3 +-
 drivers/extcon/extcon-axp288.c                 | 176 +++++++++++++-
 drivers/platform/x86/intel_cht_int33fe.c       |  24 ++
 drivers/usb/Kconfig                            |   5 +
 drivers/usb/Makefile                           |   2 +
 drivers/usb/common/Makefile                    |   1 +
 drivers/usb/common/roles.c                     | 305 +++++++++++++++++++++++++
 drivers/usb/host/Makefile                      |   2 +-
 drivers/usb/host/xhci-ext-caps.c               |  90 ++++++++
 drivers/usb/host/xhci-ext-caps.h               |   7 +-
 drivers/usb/host/xhci-pci.c                    |   5 +
 drivers/usb/host/xhci.h                        |   2 +
 drivers/usb/roles/Kconfig                      |  14 ++
 drivers/usb/roles/Makefile                     |   1 +
 drivers/usb/roles/intel-xhci-usb-role-switch.c | 192 ++++++++++++++++
 drivers/usb/typec/Kconfig                      |   3 +
 drivers/usb/typec/Makefile                     |   2 +
 drivers/usb/typec/{typec.c => class.c}         | 124 ++++++++--
 drivers/usb/typec/fusb302/fusb302.c            |   2 +-
 drivers/usb/typec/mux.c                        | 191 ++++++++++++++++
 drivers/usb/typec/mux/Kconfig                  |  10 +
 drivers/usb/typec/mux/Makefile                 |   3 +
 drivers/usb/typec/mux/pi3usb30532.c            | 178 +++++++++++++++
 drivers/usb/typec/tcpm.c                       |  63 +++--
 drivers/usb/typec/tps6598x.c                   |  26 ++-
 drivers/usb/typec/typec_wcove.c                |   1 +
 drivers/usb/typec/ucsi/ucsi.c                  |  13 +-
 include/linux/device.h                         |  22 ++
 include/linux/usb/role.h                       |  53 +++++
 include/linux/usb/tcpm.h                       |  15 +-
 include/linux/usb/typec.h                      |  28 ++-
 include/linux/usb/typec_mux.h                  |  55 +++++
 38 files changed, 1812 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-usb_role
 create mode 100644 Documentation/driver-api/device_connection.rst
 create mode 100644 drivers/base/devcon.c
 create mode 100644 drivers/usb/common/roles.c
 create mode 100644 drivers/usb/host/xhci-ext-caps.c
 create mode 100644 drivers/usb/roles/Kconfig
 create mode 100644 drivers/usb/roles/Makefile
 create mode 100644 drivers/usb/roles/intel-xhci-usb-role-switch.c
 rename drivers/usb/typec/{typec.c => class.c} (93%)
 create mode 100644 drivers/usb/typec/mux.c
 create mode 100644 drivers/usb/typec/mux/Kconfig
 create mode 100644 drivers/usb/typec/mux/Makefile
 create mode 100644 drivers/usb/typec/mux/pi3usb30532.c
 create mode 100644 include/linux/usb/role.h
 create mode 100644 include/linux/usb/typec_mux.h

-- 
2.16.1
