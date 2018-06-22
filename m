Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEC4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA359240A0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 10:49:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA359240A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933548AbeFVKtv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 06:49:51 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49364 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932918AbeFVKtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 06:49:46 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 60B9520DC3; Fri, 22 Jun 2018 12:49:43 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id A4FC4206D8;
        Fri, 22 Jun 2018 12:49:32 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v5 00/10] Add the I3C subsystem
Date:   Fri, 22 Jun 2018 12:49:20 +0200
Message-Id: <20180622104930.32050-1-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is a proposal for a new I3C subsystem.

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

Only minor things have changes since v3, you can go check the changelog
in each patch for more details.

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

Thanks,

Boris

Boris Brezillon (10):
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
 .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     |   39 +
 .../devicetree/bindings/i3c/cdns,i3c-master.txt    |   44 +
 Documentation/devicetree/bindings/i3c/i3c.txt      |  140 ++
 Documentation/driver-api/i3c/device-driver-api.rst |    9 +
 Documentation/driver-api/i3c/index.rst             |   11 +
 Documentation/driver-api/i3c/master-driver-api.rst |   10 +
 Documentation/driver-api/i3c/protocol.rst          |  203 +++
 Documentation/driver-api/index.rst                 |    1 +
 MAINTAINERS                                        |   10 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    2 +-
 drivers/gpio/Kconfig                               |   11 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-cdns-i3c.c                       |  411 +++++
 drivers/i3c/Kconfig                                |   24 +
 drivers/i3c/Makefile                               |    4 +
 drivers/i3c/core.c                                 |  620 +++++++
 drivers/i3c/device.c                               |  294 ++++
 drivers/i3c/internals.h                            |   28 +
 drivers/i3c/master.c                               | 1722 ++++++++++++++++++++
 drivers/i3c/master/Kconfig                         |    5 +
 drivers/i3c/master/Makefile                        |    1 +
 drivers/i3c/master/i3c-master-cdns.c               | 1651 +++++++++++++++++++
 include/dt-bindings/i3c/i3c.h                      |   28 +
 include/linux/i3c/ccc.h                            |  382 +++++
 include/linux/i3c/device.h                         |  307 ++++
 include/linux/i3c/master.h                         |  587 +++++++
 include/linux/mod_devicetable.h                    |   17 +
 29 files changed, 6658 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
 create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
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

