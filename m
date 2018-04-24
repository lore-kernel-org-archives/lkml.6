Return-Path: <jhovold@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524588643; cv=none;
        d=google.com; s=arc-20160816;
        b=suOXyIu7ZJME6uLs0JYMc4EMTmiTM2+ig+3f1liAAYPqRVafFsnqXe0N19q1WDltIN
         A8B9nm1wbXS1SknUBxmK/eb+SDkmKnamU5jv5WSqVArzcXyfTsun6oBt0+h4GSG0XcmG
         4S3Tuyf2FQpkNktGQy4jJrgAK3uN4M7z+v8K8PXeofheypy2oVt1nKA8xCOfOtsaGnko
         Vz6VZu7a+ht38rzuc01SRmlRSqO3kV0jze/7GeVdNIuyVKBc6Zn7gMOIBt4KgaEWO2Op
         VFOGPmynUdYm377D5JYXWyGORC5Jtcbe3w+87pU2hyGS90HIcvMLAEwl7odB+J/5zyGI
         snJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=smZW1BPwnSB7S678WB1zMleOqc2SV2CG8eD9q6upYXs=;
        b=QeoiaIS9Xed32l31SVYoSCMN3JpGxnT7CdNX6NOF/XfSea8Y9V5+jyPVapaF4zWiku
         65C26urmnTUOiBl8ged41XPSDLk9V7nyLRAMd8iFb0sWZS3OAwsA1/kjfhRPefkNqVPD
         ia0FTuKvso+UnAdIg+8s3NbstydcHSqVv9c0oQcwedHrJel6CCBbx0Cne9ddtTLACCdk
         SS+S2+bvwo8UAMQ1Qf8zokyRBlV+gof2jAiHOCGlggcIpHEL6x5AmoZgGJnOObbh6t6O
         7Nc6SC+XjzGOWwf+Xu72L+KtvspF9XhxscvWZvBZFsxLDJ8P9EzQo5bNjKSHwiLUXBqL
         TsAg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nhqO+i/W;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nhqO+i/W;
       spf=pass (google.com: domain of jhovold@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jhovold@gmail.com
X-Google-Smtp-Source: AB8JxZrYwgbkWqISvUnB0c25Yklkh0ObwKH4Z2TEePFAxqvvoR+J53eOXdOIV2OZbktzOwaaTJlfyQ==
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Arnd Bergmann <arnd@arndb.de>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Pavel Machek <pavel@ucw.cz>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/7] gnss: add new GNSS subsystem
Date: Tue, 24 Apr 2018 18:34:51 +0200
Message-Id: <20180424163458.11947-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598647061282688193?=
X-GMAIL-MSGID: =?utf-8?q?1598647061282688193?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
detection and (eventually) identification of GNSS devices.

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

As proof-of-concept I have implemented drivers for receivers based on
two common GNSS chipsets (SiRFstar and u-blox), but due to lack of
hardware these have so far only been tested using mockup devices and a
USB-serial-based GPS device (using out-of-tree code). [ Let me know if
you've got any evalutation kits to spare. ]

Finally, note that documentation (including kerneldoc) remains to be
written, but hopefully this will not hinder review given that the
current interfaces are fairly self-describing.

Johan


Johan Hovold (7):
  gnss: add GNSS receiver subsystem
  dt-bindings: add generic gnss binding
  gnss: add generic serial driver
  dt-bindings: gnss: add u-blox binding
  gnss: add driver for u-blox receivers
  dt-bindings: gnss: add sirfstar binding
  gnss: add driver for sirfstar-based receivers

 .../devicetree/bindings/gnss/gnss.txt         |  36 ++
 .../devicetree/bindings/gnss/sirfstar.txt     |  38 ++
 .../devicetree/bindings/gnss/u-blox.txt       |  31 ++
 .../devicetree/bindings/vendor-prefixes.txt   |   4 +
 MAINTAINERS                                   |   7 +
 drivers/Kconfig                               |   2 +
 drivers/Makefile                              |   1 +
 drivers/gnss/Kconfig                          |  43 ++
 drivers/gnss/Makefile                         |  16 +
 drivers/gnss/core.c                           | 385 ++++++++++++++++
 drivers/gnss/serial.c                         | 288 ++++++++++++
 drivers/gnss/serial.h                         |  47 ++
 drivers/gnss/sirf.c                           | 415 ++++++++++++++++++
 drivers/gnss/ubx.c                            | 133 ++++++
 include/linux/gnss.h                          |  64 +++
 15 files changed, 1510 insertions(+)
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
2.17.0
