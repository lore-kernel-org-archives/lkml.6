Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeFESoz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:44:55 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:48968 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbeFESov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:44:51 -0400
X-AuditID: 0a3aad16-bcfff70000000413-16-5b16da1a1985
From: Mark Jonas <mark.jonas@de.bosch.com>
To: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>, <yi.zhu5@cn.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH 0/5] can: enable multi-queue for SocketCAN devices
Date: Tue, 5 Jun 2018 20:43:55 +0200
Message-ID: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22SX0wTWRjFuZ1hOjSMGaZQPwroZtQXglgBQ6OiBh+2iVmzIdkH5WF3kIE2
        0oIzBYH4UBXUKlkFV3e3IjYsRsWAQLZsARWpRsBE0aoJ4B+MKQYRjVDRmmBwxoLtw7593zn3
        d0/uySUx5rRSS5osVl6wcEUsocJV61uSVmtHNbm6+f2r9O6nY5i++dMpTP+wu57QX2n8A9ff
        dmr05593RW4hDA2OAdww7X2CDMe/6Az+jmU/4ztVG/P5IlMZL6zZ9JvKeNF2GCuZW1Hu7zyO
        bOh+/FEURQKdAe+cfuIoUpEM/ZcCWvs7lcHlGoI/bzSh4NKJYKbOjmSEoJNhZMCNyXMs/Quc
        GT+Ey4cw+hKC8Qt3FbKhprOh+u1lpTzj9Epo73qDyzNF/wiBBx0omL0MRu7ZsaAeA4N/+76d
        wWiAvokJ7ASiHGGWI8xyIkUzihNNujJzmk6flirk8WKlbm3qrmJzBwo2p3Gjg335HkSTiI2m
        pvo0uUwkVyZWmD1oHalg46iURklaklecX2HkROOvQmkRL7JaCkVERDDq77JYmmc2iaKp2OJB
        QGJsLMV5JY7K5yoqeaE4iHlQAomzSynflvc7GbqQs/K7eb6EFxbdDSTJAmUYkcAYgS/kywtM
        RdZFm00KZmrCnfBYBRnlQelktJQdNyxniyWcWTQVLuDxQZxZVEPoHZSpXUrhciwtu8ZSy/dU
        bSJ1djA2l4kLM0LkJHqEpN7UlE8OjJY+ZSgPKLe6fgcTsyCGoDSnxNAzFNQ2sDA9lgHzPdvg
        +qEd0HBAALevDkGDexZBbdVLDEYDVTgEbCdxaPU+w6G3/UCkpLVFgrfboYRjvTdJqOo/FwUD
        df1RMGv7VwVT/xyh4IjHRUHN61YaAo+dMVBjr2ZgaHxGAx2nRuPhQ09zgnxLAvgnXEnQHrgl
        fTD7i+Uw+2L2B6i52sZOSj0qpB5flavlHq2c9X96XFBDD9PaUJsx+3ST1VXvyPkJvUvkNw1Z
        LVkBNzP8yjudwBrLss8cc+UWnphLyVs1tbl0697Mh53pQ3xsre3pNvdk2jCRcVb3JnX7vkll
        FirI7G1x+auJmpxuIquF6NrDjc2vsC+ZG+Z1vZt9u5SfL7dfKUhKXJn8+/6UjZXrppYPpP8X
        +MjiopFbm4wJIvcVIqrGvykEAAA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon request by Marc Kleine-Budde this patch series does not only
contain our patch to enable enable multi-queue for SocketCAN devices
but also a driver (Companion driver suite) which makes active use of
this feature.

The driver suite implements
  - two CAN interfaces
  - one generic command interfaces
and offers a SocketCAN as well as a char device interface. The
SocketCAN interface supports multi-queue.

The functionality bases on an external peripheral chip named Companion.
It offers two CAN interfaces, each has 8 prioritized transmit FIFOs as
well as one receive FIFO. Besides CAN, undisclosed additional functions
can be accessed through the char device.

A standard SPI interface with two additional lines for flow control is
used. The Companion chip is the SPI slave.

The driver suite consists of three separate drivers. The following
diagram illustrates the dependencies in layers.

           /dev/companion       SocketCAN                User Space
-------------------------------------------------------------------
         +----------------+ +---------------+
         | companion-char | | companion-can |
         +----------------+ +---------------+
         +----------------------------------+
         |          companion-spi           |
         +----------------------------------+
         +----------------------------------+
         |     standard SPI subsystem       |
         +----------------------------------+          Linux Kernel
-------------------------------------------------------------------
               | | | |      | |                            Hardware
            CS-+ | | |      | +-BUSY
            CLK--+ | |      +---REQUEST
            MOSI---+ |
            MISO-----+

companion-spi
   core.c: handles SPI, sysfs entry and interface to upper layer
   protocol-manager.c: handles protocol with the SPI HW
   queue-manager.c: handles buffering and packets scheduling

companion-can
   makes use of multi-queue support and allows to use tc to configure
   the queuing discipline (e.g. mqprio). Together with the SO_PRIORITY
   socket option this allows to specify the FIFO a CAN frame shall be
   sent to.

companion-char
   handles messages to other undisclosed functionality beyond CAN.

Zhu Yi (5):
  can: enable multi-queue for SocketCAN devices
  spi: implement companion-spi driver
  char: implement companion-char driver
  can: implement companion-can driver
  spi,can,char: add companion DT binding documentation

 .../devicetree/bindings/spi/bosch,companion.txt    |   82 ++
 drivers/char/Kconfig                               |    7 +
 drivers/char/Makefile                              |    2 +
 drivers/char/companion-char.c                      |  367 ++++++
 drivers/net/can/Kconfig                            |    8 +
 drivers/net/can/Makefile                           |    1 +
 drivers/net/can/companion-can.c                    |  694 ++++++++++++
 drivers/net/can/dev.c                              |    8 +-
 drivers/spi/Kconfig                                |    2 +
 drivers/spi/Makefile                               |    2 +
 drivers/spi/companion/Kconfig                      |    5 +
 drivers/spi/companion/Makefile                     |    2 +
 drivers/spi/companion/core.c                       | 1189 ++++++++++++++++++++
 drivers/spi/companion/protocol-manager.c           | 1035 +++++++++++++++++
 drivers/spi/companion/protocol-manager.h           |  348 ++++++
 drivers/spi/companion/protocol.h                   |  273 +++++
 drivers/spi/companion/queue-manager.c              |  146 +++
 drivers/spi/companion/queue-manager.h              |  245 ++++
 include/linux/can/dev.h                            |    7 +-
 include/linux/companion.h                          |  258 +++++
 20 files changed, 4677 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion.txt
 create mode 100644 drivers/char/companion-char.c
 create mode 100644 drivers/net/can/companion-can.c
 create mode 100644 drivers/spi/companion/Kconfig
 create mode 100644 drivers/spi/companion/Makefile
 create mode 100644 drivers/spi/companion/core.c
 create mode 100644 drivers/spi/companion/protocol-manager.c
 create mode 100644 drivers/spi/companion/protocol-manager.h
 create mode 100644 drivers/spi/companion/protocol.h
 create mode 100644 drivers/spi/companion/queue-manager.c
 create mode 100644 drivers/spi/companion/queue-manager.h
 create mode 100644 include/linux/companion.h

-- 
2.7.4
