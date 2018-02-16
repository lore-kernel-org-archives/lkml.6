Return-Path: <hdegoede@redhat.com>
X-Google-Smtp-Source: AH8x224nFLzFwsK/AEoFDgLgqBuSMblf2BTde0bXSD5Z2F9oNtKu6fJfOlBoS0KjZaE/lTHcErJV
ARC-Seal: i=1; a=rsa-sha256; t=1518778074; cv=none;
        d=google.com; s=arc-20160816;
        b=XmxC8KhcNQnI/aGNnv2ZNMC8U0qxEn40nKVsmHGT1fhWOYjP0MI0Rc6Wo0EFe+Pxg1
         KEBDo5TTJc7sYGCKe78gDId55e9PjdoJnix6FWqSaxTzgGUZg5yOEeoqsB6YGOHXbM/2
         nbH05Ce+X/gWdXjanE8Uz4h1LT9q3T/pfdNEvOmdZ7sf5LAHNS5C2x0OPNOOiPnVtjM2
         gNt9XnCQZ+hsnZQCZki3f6Vjwjrrr83/Ji/nLoYCfxa3ijio50Sq9jujZAqxeeuZ+4U5
         GDUMy3gKySp0Q9EEq3oFy585Tpy3YgCtgA0h0I5/xZoBnbmo+iYDSfRBx2KuZzAaSqeE
         Fy+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=6qU9DTiZM7UGqF97KBSUd15Pg/nX1hBaQpev9MWk/OM=;
        b=yoaTpFfEcwjsH4+8XOm3pb6KCGffiHIttKDx8cp/X86XZNbTgNtpiLhJHX2Ebwz0tJ
         oMv9NuZcwyftohliXUO3Z7A6WxnAK9JcoAx8OvGNHcofyIq0V+klHeuZxGg+YH/gSz4Q
         leoJ3Ui1LnMs9gqQfDdNdlt9gkH+UOGmmMNokkwyutPd9fJhqM+SarM4FkHySXs01/jg
         wJNjgUOughxKSJ4kUZmqm7DOPojZTC0PTPStvEEYtJVxeiR6KgDYTJht/cBTTAKiVq+6
         IenI/hAur1G17rg9gRBgkfuPX2WnL7SICZtU41xzfTOMS9hgOGpmj3/81U9S15AkY4yf
         IyBw==
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
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 00/12] USB Type-C device-connection, mux and switch support
Date: Fri, 16 Feb 2018 11:47:39 +0100
Message-Id: <20180216104751.8371-1-hdegoede@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554238403872803?=
X-GMAIL-MSGID: =?utf-8?q?1592554238403872803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

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
