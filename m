Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3647CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9CD2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9CD2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeHaRr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:47:57 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:58936 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeHaRr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:47:56 -0400
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="16999747"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Aug 2018 06:40:23 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Fri, 31 Aug 2018 06:40:22 -0700
From:   Radu Pirea <radu.pirea@microchip.com>
To:     <richard.genoud@gmail.com>, <pirea.radu@gmail.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: [RESEND PATCH v11 0/6] Driver for at91 usart in spi mode
Date:   Fri, 31 Aug 2018 16:41:35 +0300
Message-ID: <20180831134141.9335-1-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the 11th version of driver. I added a mfd driver which by
default probes atmel_serial driver and if in dt is specified to probe
the spi driver, then the spi-at91-usart driver will be probed. The
compatible for atmel_serial is now the compatible for at91-usart mfd
driver and compatilbe for atmel_serial driver was changed in order to
keep the bindings for serial as they are.

@Lee, could you take this patch series into your tree? I addressed all Mark
remarks.

In this resend I changed my email address from MAINTAINERS file.

Changes in v11:
- removed "depends on HAS_DMA" from drivers/spi/Kconfig because the driver has
no dma support
- changed "selects MFD_AT91_USART" to "depends on MFD_AT91_USART" in
drivers/spi/Kconfig
- changed comment style in spi-at91-usart.c

Changes in v10:
-fixed kbuild test robot warning

Changes in v9:
- minor changes
- rebased on top of broonie/for-4.19

Changes in v8:
- fixed passing an empty mfd cell if "atmel,usart-mode" value is invalid

Changes in v7:
- synced up  SPDIX license with module license
- numbering of usart modes starts from 0 insteand of 1

Changes in v6:
- removed unused compatible strings from serial and spi drivers

Changes in v5:
- fixed usage of stdout-path property with atmel_serial driver

Changes in v4:
- modified the spi driver to use cs gpio support form spi subsystem
- fixed dma transfers for serial driver
- squashed binding for spi and serial and moved them to mfd/atmel-usart.txt

Changes in v3:
- fixed spi slaves probing

Changes in v2:
- added at91-usart mfd driver
- modified spi-at91-usart driver to work as mfd driver child
- modified atmel_serial driver to work as mfd driver child

Changes in v1:
- added spi-at91-usart driver

Radu Pirea (6):
  MAINTAINERS: add at91 usart mfd driver
  dt-bindings: add binding for atmel-usart in SPI mode
  mfd: at91-usart: added mfd driver for usart
  MAINTAINERS: add at91 usart spi driver
  spi: at91-usart: add driver for at91-usart as spi
  tty/serial: atmel: change the driver to work under at91-usart mfd

 .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
 MAINTAINERS                                   |  16 +
 drivers/mfd/Kconfig                           |   9 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/at91-usart.c                      |  71 +++
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/atmel_serial.c             |  42 +-
 include/dt-bindings/mfd/at91-usart.h          |  17 +
 11 files changed, 606 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
2.18.0

