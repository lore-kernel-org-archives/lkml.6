Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0AA7FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D76208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="AzdU/DOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D76208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.bosch.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935814AbeFMOiO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:38:14 -0400
Received: from de-out1.bosch-org.com ([139.15.230.186]:33682 "EHLO
        de-out1.bosch-org.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeFMOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:38:11 -0400
Received: from fe0vm1650.rbesz01.com (unknown [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 415TrK3Qczz4f3lwt;
        Wed, 13 Jun 2018 16:38:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=2015-01-21; t=1528900689;
        bh=yzKooamTiNN6TaJo1x9nGgi9v7llwNHi4SKug+vKDNw=; l=10;
        h=From:From:Reply-To:Sender;
        b=AzdU/DOX2qZK5CwN32V19IThhJmsm8jDVjYyTai9JkrjPR1Hu42pHwgfcMgdDZiox
         bRn0ySUnT+NeGsYry3Cbi+f2ruZnQHZ1KFG2n2C/lsEwzZR/Qyi5tACLxfrUV1E5SO
         abpQrLVFgIRK5r7MH02AWnBfBuc62T7d5rCUXPJA=
Received: from fe0vm7918.rbesz01.com (unknown [10.58.172.176])
        by fe0vm1650.rbesz01.com (Postfix) with ESMTPS id 415TrK2qWwz1Cf;
        Wed, 13 Jun 2018 16:38:09 +0200 (CEST)
X-AuditID: 0a3aad10-427ff70000000ee7-b8-5b212c5e95c1
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm7918.rbesz01.com (SMG Outbound) with SMTP id 7B.6E.03815.E5C212B5; Wed, 13 Jun 2018 16:38:22 +0200 (CEST)
Received: from SI-HUB1000.de.bosch.com (si-hub1000.de.bosch.com [10.4.103.106])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 415TrK1NXPzBpBZ;
        Wed, 13 Jun 2018 16:38:09 +0200 (CEST)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB1000.de.bosch.com (10.4.103.106) with Microsoft SMTP Server id
 14.3.319.2; Wed, 13 Jun 2018 16:38:08 +0200
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hs@denx.de>,
        <yi.zhu5@cn.bosch.com>, <petar.petrovic2@de.bosch.com>,
        <stephan.baetge@de.bosch.com>, <andy.shevchenko@gmail.com>,
        <socketcan@hartkopp.net>, <o.rempel@pengutronix.de>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH v2 0/5] can: enable multi-queue for SocketCAN devices
Date:   Wed, 13 Jun 2018 16:37:16 +0200
Message-ID: <1528900641-18677-1-git-send-email-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sb0wbZRzHeXpHe21629OjwI8i27hsiWEyQCGcf4Lbi8UmJlNfLAM65w57
        0EZa8K7gmMZ0lZExiAMmUQph6DaNJJsOO+1AVin/jekS0IRtwiayrMM/ERixZipeW1j7wnff
        5/d9Ps/3nu89FMGMqQyU1e4QRDtfySo1pOapCxnZhx7LNOWurnDcvZZhxHl/vEVwvX+2E9x0
        f5eS++yj90hurCeFW5hD3Mzivyru/NyVxN1qY7d7gjRecc+qjEtTN5HxnbURlfHUP7nGlb4t
        LypLNc+YhUprrSDmFB3WWCbf/QlVB3Yc8Sx/RzjRL4aTSE0BzocLo3PkSaShGPyBAk77gkR0
        MYigvatjffEVgt6lTlUYUeIsuD7hJcJaj/dD552GCE7gqwq4OdiEwkYS3gvHnEMRTeId0HJ3
        JKJp/Bx86QkS0ewtcD3QGNFqbIQHx3+PBDDynkBfgIzu18Fkx0JEExhgKBgkWtBmd5zljrN6
        kKIXJZcLubW2wifzuF1imSAdzc3b9WqVrQ9Fm8Ze5J4s8yNMIVZLd2zNNDGJfK1UZ/OjAkrB
        JtP7WraZmE1lVeY6Cy9ZXhFrKgWJNdAoISGBSXo4lmrKbFZJslbZ/QgogtXT+4IyR5v5uqOC
        WBXF/CidItlUutn8VimDK3iH8JogVAvihvs0RbFASzvlb9CJQoVwpNxa6diw2YxoZkq8Ex+r
        oNR+9ASllbPV4SNoqZq3SdaKdTwtijMb0xj6LSo0pNJjWTKDw66lxv4w1fAIbfLIF0mOM2Lk
        Ivoeyb0l0W+HA7XyI47lAe1N6iphdOvDGPR4j8zgU5uhtZuFpVv5sDbwPFxtKIFulwjehTYE
        3d5VBK318wTcCNWTEHKeJuHi1CwJvkuuRHn2eSJM9btV0OQbpqB+/IwaJtrG1bDq9Gjg17Mn
        aDjhv0xD872LGEI/9OigufE4A9PnvtDDtTvLKdDXfiMN7g/0poePSoeV4OUMuBQakV9f4+2t
        MDN4f9ui3KNC7nF0NPwPJQfv+J8e16exixmciE4749qeMh84WJo9sMkwlfC+xbGzYLz9QdrL
        f33oKiz/dG2PKcdRlJE5faDk2UeLdQ3zxenUG3uXO88Nc039Pxfov27yu3BDTtH+hWMT7oqP
        jTNv7in8u1xp1vpePy9ZZz/R7h56IXTI79t+sL41++61l37zzC7etnq+yW9L/aP4sN7OkpKF
        z8siRIn/D/+NY+dZBAAA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- use GPIO descriptor API
- make error handling pattern consistent
- use more kernel helper macros and functions
- fix coding style issues
- remove superfluous subsystem name from filename

---

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
 drivers/char/Makefile                              |    3 +
 drivers/char/companion.c                           |  360 ++++++
 drivers/net/can/Kconfig                            |    8 +
 drivers/net/can/Makefile                           |    2 +
 drivers/net/can/companion.c                        |  693 ++++++++++++
 drivers/net/can/dev.c                              |    8 +-
 drivers/spi/Kconfig                                |    2 +
 drivers/spi/Makefile                               |    2 +
 drivers/spi/companion/Kconfig                      |    5 +
 drivers/spi/companion/Makefile                     |    2 +
 drivers/spi/companion/core.c                       | 1185 ++++++++++++++++++++
 drivers/spi/companion/protocol-manager.c           | 1032 +++++++++++++++++
 drivers/spi/companion/protocol-manager.h           |  341 ++++++
 drivers/spi/companion/protocol.h                   |  273 +++++
 drivers/spi/companion/queue-manager.c              |  144 +++
 drivers/spi/companion/queue-manager.h              |  245 ++++
 include/linux/can/dev.h                            |    7 +-
 include/linux/companion.h                          |  259 +++++
 20 files changed, 4656 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/bosch,companion.txt
 create mode 100644 drivers/char/companion.c
 create mode 100644 drivers/net/can/companion.c
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

