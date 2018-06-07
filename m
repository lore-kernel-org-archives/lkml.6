Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gpDHOjYQGVtKFwAAmS7hNA
	; Thu, 07 Jun 2018 11:01:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 871E6608C1; Thu,  7 Jun 2018 11:01:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 02B1E607DC;
	Thu,  7 Jun 2018 11:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 02B1E607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932559AbeFGK7t (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:59:49 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:31666 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeFGK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:59:46 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="12270494"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 07 Jun 2018 03:59:29 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Thu, 7 Jun 2018 03:59:07 -0700
From: Radu Pirea <radu.pirea@microchip.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee.jones@linaro.org>,
        <richard.genoud@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC: <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v6 0/6] Driver for at91 usart in spi mode
Date: Thu, 7 Jun 2018 14:00:14 +0300
Message-ID: <20180607110020.20565-1-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is the second version of driver. I added a mfd driver which by
default probes atmel_serial driver and if in dt is specified to probe
the spi driver, then the spi-at91-usart driver will be probed. The
compatible for atmel_serial is now the compatible for at91-usart mfd
driver and compatilbe for atmel_serial driver was changed in order to
keep the bindings for serial as they are.

Changes in v1:
- added spi-at91-usart driver

Changes in v2:
- added at91-usart mfd driver
- modified spi-at91-usart driver to work as mfd driver child
- modified atmel_serial driver to work as mfd driver child

Changes in v3:
- fixed spi slaves probing

Changes in v4:
- modified the spi driver to use cs gpio support form spi subsystem
- fixed dma transfers for serial driver
- squashed binding for spi and serial and moved them to mfd/atmel-usart.txt

Changes in v5:
- fixed usage of stdout-path property with atmel_serial driver

Changes in v6:
- removed unused compatible strings from serial and spi drivers

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
 drivers/mfd/at91-usart.c                      |  68 +++
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 434 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/atmel_serial.c             |  42 +-
 include/dt-bindings/mfd/at91-usart.h          |  17 +
 11 files changed, 606 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
2.17.1
