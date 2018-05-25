Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935541AbeEYMxl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:53:41 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40552 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeEYMxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:53:37 -0400
X-Google-Smtp-Source: AB8JxZpYH7vqcCmt729P8PQmV8myd3vge/Ys00Q1uQqIIxZRQQ0ZRaVO+m8RR1KplLhMQBqnL/djSg==
From: Johan Hovold <johan@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [RFC PATCH 0/3] USB: serial: add device tree (and serdev) support
Date: Fri, 25 May 2018 14:52:54 +0200
Message-Id: <20180525125257.29124-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are some patches I've been using to test out using serdev with USB
serial. Adding device-tree support to USB serial is really a
separate matter and could be merged before the remaining issues related
to hotplug are addressed for serdev.

Note that this has been a low-intensity on-going effort where most
prerequisites are already upstream including USB device tree support
(4.15), device-tree node sharing (4.13), musb device-node propagation
(linux-next) and various fixes along the way (driver core, usb core,
musb).

What left to be decided is how to deal with multi-port devices. This
series uses child nodes to represent each port, which may be a little
counter-intuitive for devices (or rather interfaces) with just a single
port:

	&usb_interface {
		#address-cells = <1>;
		#size-cells = <0>;

		serial@0 {
			reg = <0>;
		};
	};

but I still think this it how it needs to be implemented.

Another thing that's currently lacking is binding documentation.

For completeness (and per request), the second patch enables serdev
support and can be used for testing purposes. The third patch can be
used as a base for testing this on a BBB and describes two USB serial
devices attached to an external hub.

Note that this series depends on a couple of patches (for usb-serial and
musb) that are still in linux-next. For convenience, I've prepared a
branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of

Johan


Johan Hovold (3):
  USB: serial: add device-tree support
  USB: serial: enable serdev support
  dbg: ARM: dts: boneblack: add USB topology and serdev nodes

 arch/arm/boot/dts/am335x-boneblack.dts | 57 ++++++++++++++++++++++++++
 drivers/usb/serial/bus.c               |  7 ++--
 drivers/usb/serial/usb-serial.c        | 28 ++++++++++++-
 3 files changed, 88 insertions(+), 4 deletions(-)

-- 
2.17.0
