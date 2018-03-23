Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AG47ELvXfQ7nDcxYeCXX6iIt7718u0lE9jf2XiPmdOjQYbHLmFixSBo34W+71ASfleOfq5JZr4HQ
ARC-Seal: i=1; a=rsa-sha256; t=1521802834; cv=none;
        d=google.com; s=arc-20160816;
        b=jVh+EMtUlSyGXxKIMFt10kMNhKZzppdGILRp9+Ss8Ufs2OxxscI9sb7Jz7TxHg2UhA
         PpmUXXTeqz2ymD6R/COUkAqv4uLttr+AKKGkyus20XMlbF/xRvB9NGkM35WX0c2f8Fdt
         odQZO2RcSwihW86pkqDuY0tuqKxz9S7lNJZYZgRmP59PVIr2IJeEmtQw8dun7n1LJ98P
         nCd+qvZSH7edP1RZC4m/aCPpkTfanJS9Eh9PXmrcBlxsfYxPaJvnM80eVLCK6T5FME7e
         OGY8IiB9iNC24wASlHKMqL/JmYasizx68n6a2UkqTW/uPgnMVSzZmf7PZJKSrnRY9Sb2
         hiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=wrjEdlimgXAEg1uoYBci5LxQGS4Fz8UYvM9vTAcKiO8=;
        b=HNu0UPY9aV2KTw9p7XJlMLgypgqwFSOBSf6h0By+N1nurr4/XuDE//SPY4tEA8fhys
         IRABCQIxw5IrVrgeg+V77jvnVUPfKq9YSR38aAQf5F7pixtRAxh6p7OgVsSsZXd8z3SL
         l/l3xLti73JgHZGYT8XjtEnILbE6xF6nPe4/BxAqZ8SmCVsCeyiqYveD7TWag02on0d1
         tTZOHGuvwjWomC2UlEfBf6c6ntxboGB8H5UAyLl+hTRyLPmtI7lIyVtC9TDM1CDrXxQ1
         vzinWurHsDuFmgtyoaR5MC0Ce85BbSBJmoN09VPjJluMM7104avUff9f/lDk8XBgD33o
         ljPA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>,
	Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>,
	linux-gpio@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v3 00/11] Add the I3C subsystem
Date: Fri, 23 Mar 2018 12:00:09 +0100
Message-Id: <20180323110020.19080-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725929392804192?=
X-GMAIL-MSGID: =?utf-8?q?1595725929392804192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch series is a proposal for a new I3C [1] subsystem.

This infrastructure is not complete yet and will be extended over
time.

There are a few design choices that are worth mentioning because they
impact the way I3C device drivers can interact with their devices:

- all functions used to send I3C/I2C frames must be called in
  non-atomic context. Mainly done this way to ease implementation, but
  this is still open to discussion. Please let me know if you think it's
  worth considering an asynchronous model here
- the bus element is a separate object and is not implicitly described
  by the master (as done in I2C). The reason is that I want to be able
  to handle multiple master connected to the same bus and visible to
  Linux.
  In this situation, we should only have one instance of the device and
  not one per master, and sharing the bus object would be part of the
  solution to gracefully handle this case.
  I'm not sure if we will ever need to deal with multiple masters
  controlling the same bus and exposed under Linux, but separating the
  bus and master concept is pretty easy, hence the decision to do it
  now, just in case we need it some day.
  The other benefit of separating the bus and master concepts is that
  master devices appear under the bus directory in sysfs.
- I2C backward compatibility has been designed to be transparent to I2C
  drivers and the I2C subsystem. The I3C master just registers an I2C
  adapter which creates a new I2C bus. I'd say that, from a
  representation PoV it's not ideal because what should appear as a
  single I3C bus exposing I3C and I2C devices here appears as 2
  different busses connected to each other through the parenting (the
  I3C master is the parent of the I2C and I3C busses).
  On the other hand, I don't see a better solution if we want something
  that is not invasive.

Missing features in this preliminary version:
- support for HDR modes (has been removed because of lack of real users)
- no support for multi-master and the associated concepts (mastership
  handover, support for secondary masters, ...)
- I2C devices can only be described using DT because this is the only
  use case I have. However, the framework can easily be extended with
  ACPI and board info support
- I3C slave framework. This has been completely omitted, but shouldn't
  have a huge impact on the I3C framework because I3C slaves don't see
  the whole bus, it's only about handling master requests and generating
  IBIs. Some of the struct, constant and enum definitions could be
  shared, but most of the I3C slave framework logic will be different

Main changes between v2 and v3 are:
- Reworked the DT bindings as suggested by Rob
- Reworked the bus initialization step as suggested by Vitor
- Added a driver for an I3C GPIO expander

Main changes between the initial RFC and this v2 are:
- Add a generic infrastructure to support IBIs. It's worth mentioning
  that I tried exposing IBIs as a regular IRQs, but after several
  attempts and a discussion with Mark Zyngier, it appeared that it was
  not really fitting in the Linux IRQ model (the fact that you have
  payload attached to IBIs, the fact that most of the time an IBI will
  generate a transfer on the bus which has to be done in an atomic
  context, ...)
  The counterpart of this decision is the latency induced by the
  workqueue approach, but since I don't have real use cases, I don't
  know if this can be a problem or not. 
- Add helpers to support Hot Join
- Add support for IBIs and Hot Join in Cadence I3C master driver
- Address several issues in how I was using the device model

I'll finish on a good news: this week the MIPI alliance opened the I3C
spec. So everyone can now review the patches (no need to be member of
the MIPI I3C group).
I'll let you find the link in the doc, this way maybe I'll have reviews
on the doc itself :-).

Thanks,

Boris

Boris Brezillon (11):
  i2c: Export of_i2c_get_board_info()
  i3c: Add core I3C infrastructure
  docs: driver-api: Add I3C documentation
  i3c: Add sysfs ABI spec
  dt-bindings: i3c: Document core bindings
  dt-bindings: i3c: Add macros to help fill I3C/I2C device's reg
    property
  MAINTAINERS: Add myself as the I3C subsystem maintainer
  i3c: master: Add driver for Cadence IP
  dt-bindings: i3c: Document Cadence I3C master bindings
  gpio: Add a driver for Cadence I3C GPIO expander
  dt-bindings: gpio: Add bindings for Cadence I3C gpio expander

 Documentation/ABI/testing/sysfs-bus-i3c            |   95 ++
 .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     |   38 +
 .../devicetree/bindings/i3c/cdns,i3c-master.txt    |   45 +
 Documentation/devicetree/bindings/i3c/i3c.txt      |  140 ++
 Documentation/driver-api/i3c/conf.py               |   10 +
 Documentation/driver-api/i3c/device-driver-api.rst |    7 +
 Documentation/driver-api/i3c/index.rst             |    9 +
 Documentation/driver-api/i3c/master-driver-api.rst |    8 +
 Documentation/driver-api/i3c/protocol.rst          |  201 +++
 Documentation/driver-api/index.rst                 |    1 +
 MAINTAINERS                                        |    9 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +-
 drivers/gpio/Kconfig                               |   11 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-cdns-i3c.c                       |  380 +++++
 drivers/i2c/i2c-core-base.c                        |    2 +-
 drivers/i2c/i2c-core-of.c                          |   66 +-
 drivers/i3c/Kconfig                                |   24 +
 drivers/i3c/Makefile                               |    4 +
 drivers/i3c/core.c                                 |  620 +++++++
 drivers/i3c/device.c                               |  294 ++++
 drivers/i3c/internals.h                            |   28 +
 drivers/i3c/master.c                               | 1723 ++++++++++++++++++++
 drivers/i3c/master/Kconfig                         |    5 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/i3c-master-cdns.c               | 1648 +++++++++++++++++++
 include/dt-bindings/i3c/i3c.h                      |   28 +
 include/linux/i2c.h                                |   10 +
 include/linux/i3c/ccc.h                            |  382 +++++
 include/linux/i3c/device.h                         |  305 ++++
 include/linux/i3c/master.h                         |  587 +++++++
 include/linux/mod_devicetable.h                    |   17 +
 33 files changed, 6673 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
 create mode 100644 Documentation/driver-api/i3c/conf.py
 create mode 100644 Documentation/driver-api/i3c/device-driver-api.rst
 create mode 100644 Documentation/driver-api/i3c/index.rst
 create mode 100644 Documentation/driver-api/i3c/master-driver-api.rst
 create mode 100644 Documentation/driver-api/i3c/protocol.rst
 create mode 100644 drivers/gpio/gpio-cdns-i3c.c
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile
 create mode 100644 drivers/i3c/core.c
 create mode 100644 drivers/i3c/device.c
 create mode 100644 drivers/i3c/internals.h
 create mode 100644 drivers/i3c/master.c
 create mode 100644 drivers/i3c/master/Kconfig
 create mode 100644 drivers/i3c/master/Makefile
 create mode 100644 drivers/i3c/master/i3c-master-cdns.c
 create mode 100644 include/dt-bindings/i3c/i3c.h
 create mode 100644 include/linux/i3c/ccc.h
 create mode 100644 include/linux/i3c/device.h
 create mode 100644 include/linux/i3c/master.h

-- 
2.14.1
