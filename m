Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751509AbeFAIX3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:23:29 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40882 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFAIXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:23:25 -0400
X-Google-Smtp-Source: ADUXVKLyw+lHbfKlXZPtEYTePNSbhPxJceOaMLKu+2W0PaUhslo5Wn6tl6rlHz4FUpWPJ/JlVN/LTg==
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>, Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Pavel Machek <pavel@ucw.cz>, Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 0/8] gnss: add new GNSS subsystem
Date: Fri,  1 Jun 2018 10:22:51 +0200
Message-Id: <20180601082259.17563-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a new subsystem for GNSS receivers (e.g. GPS
receivers).

While GNSS receivers are typically accessed using a UART interface they
often also support other I/O interfaces such as I2C, SPI and USB, while
yet other devices use iomem or even some form of remote-processor
messaging (rpmsg).

The new GNSS subsystem abstracts the underlying interface and provides a
new "gnss" class type, which exposes a character-device interface (e.g.
/dev/gnss0) to user space. This allows GNSS receivers to have a
representation in the Linux device model, something which is important
not least for power management purposes and which also allows for easy
detection and identification of GNSS devices.

Note that the character-device interface provides raw access to whatever
protocol the receiver is (currently) using, such as NMEA 0183, UBX or
SiRF Binary. These protocols are expected to be continued to be handled
by user space for the time being, even if some hybrid solutions are also
conceivable (e.g. to have kernel drivers issue management commands).

This will still allow for better platform integration by allowing GNSS
devices and their resources (e.g. regulators and enable-gpios) to be
described by firmware and managed by kernel drivers rather than
platform-specific scripts and services.

While the current interface is kept minimal, it could be extended using
IOCTLs, sysfs or uevents as needs and proper abstraction levels are
identified and determined (e.g. for device and feature identification).

Another possible extension is to add generic 1PPS support.

I decided to go with a custom character-device interface rather than
pretend that these abstract GNSS devices are still TTY devices (e.g.
/dev/ttyGNSS0). Obviously, modifying line settings or reading modem
control signals does not make any sense for a device using, say, a
USB (not USB-serial) or iomem interface. This also means, however, that
user space would no longer be able to set the line speed to match a new
port configuration that can be set using the various GNSS protocols when
the underlying interface is indeed a UART; instead this would need to be
taken care of by the driver.

Also note that writes are always synchronous instead of requiring user
space to call tcdrain() after every command.

This all seems to work well-enough (e.g. with gpsd), but please let me
know if I've overlooked something which would indeed require a TTY
interface instead.

I have implemented drivers for receivers based on two common GNSS
chipsets; SiRFstar and u-blox. Due to lack of hardware, the sirf driver
has been tested using a mockup device and a USB-serial-based SiRFstar IV
GPS (using out-of-tree USB-serial code). [ Let me know if you've got any
evaluation kits to spare. ] The ubx driver has been tested using a
u-blox 8 GNSS evaluation kit (thanks u-blox!).

Finally, note that documentation (including kerneldoc) remains to be
written, but hopefully this will not hinder review given that the
current interfaces are fairly self-describing.

Johan


Changes in v3
 - dt-bindings
   - clarify that "u-blox,extint-gpios" is connected to a device input
     pin (Rob)
   - fix space-before-tab whitespace issues (Rob)
 - use "receiver" instead of "device" in the receiver type documentation
   for better consistency with the rest of the series

Changes in v2
 - add device type support (new patch 8/8)
 - fix one unprotected access to ops->write_raw
 - add support for optional v_bckp supply to ubx driver
 - drop unnecessary dev_dbgs (Greg)
 - simplify open() error path (Greg)
 - indent function parameters further
 - use gserial->drvdata to access variable length data
 - dt-bindings
   - document required reg property for I2C, SPI and USB bindings (Rob)
   - use "pin name:" prefix when referring to datasheet names (Rob)
   - add vendor prefix to sirf gpios (Rob)
   - add optional u-blox v-bckp supply (Rob)
   - add optional u-blox extint gpio
   - minor clean ups
   - add Rob's Reviewed-by tag (patches 2/8 and 6/8)


Johan Hovold (8):
  gnss: add GNSS receiver subsystem
  dt-bindings: add generic gnss binding
  gnss: add generic serial driver
  dt-bindings: gnss: add u-blox binding
  gnss: add driver for u-blox receivers
  dt-bindings: gnss: add sirfstar binding
  gnss: add driver for sirfstar-based receivers
  gnss: add receiver type support

 Documentation/ABI/testing/sysfs-class-gnss    |  15 +
 .../devicetree/bindings/gnss/gnss.txt         |  36 ++
 .../devicetree/bindings/gnss/sirfstar.txt     |  45 ++
 .../devicetree/bindings/gnss/u-blox.txt       |  44 ++
 .../devicetree/bindings/vendor-prefixes.txt   |   4 +
 MAINTAINERS                                   |   8 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/gnss/Kconfig                          |  43 ++
 drivers/gnss/Makefile                         |  16 +
 drivers/gnss/core.c                           | 420 ++++++++++++++++++
 drivers/gnss/serial.c                         | 275 ++++++++++++
 drivers/gnss/serial.h                         |  47 ++
 drivers/gnss/sirf.c                           | 408 +++++++++++++++++
 drivers/gnss/ubx.c                            | 153 +++++++
 include/linux/gnss.h                          |  75 ++++
 16 files changed, 1592 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-gnss
 create mode 100644 Documentation/devicetree/bindings/gnss/gnss.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/sirfstar.txt
 create mode 100644 Documentation/devicetree/bindings/gnss/u-blox.txt
 create mode 100644 drivers/gnss/Kconfig
 create mode 100644 drivers/gnss/Makefile
 create mode 100644 drivers/gnss/core.c
 create mode 100644 drivers/gnss/serial.c
 create mode 100644 drivers/gnss/serial.h
 create mode 100644 drivers/gnss/sirf.c
 create mode 100644 drivers/gnss/ubx.c
 create mode 100644 include/linux/gnss.h

-- 
2.17.1
