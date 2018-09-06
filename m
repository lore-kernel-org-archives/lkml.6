Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BFCC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E382075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E382075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbeIFSWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:22:25 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:12842 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbeIFSWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:22:24 -0400
X-IronPort-AV: E=Sophos;i="5.53,338,1531810800"; 
   d="scan'208";a="17303232"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Sep 2018 06:46:38 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Thu, 6 Sep 2018
 06:46:37 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-serial@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <gregkh@linuxfoundation.org>, <jslaby@suse.com>, <arnd@arndb.de>,
        <richard.genoud@gmail.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Subject: [PATCH v4 0/2] add ISO7816 support
Date:   Thu, 6 Sep 2018 15:42:12 +0200
Message-ID: <20180906134214.29031-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds support for the ISO7816 standard. The USART devices in
Microchip SoCs have an ISO7816 mode. It allows to let the USART managing
the CLK and I/O signals of a smart card.

Changes:
- v4
  - use the IP version number instead of the compatible string to set
  min and max values for fidi.
  - remove a useless macro for fidi.
- v3
  - add IOCTLs to parisc arch.
  - rework atmel_config_iso7816 according to the comments by Richard.
  - keep max iteration hard coded. Will see later if the user need to set
  this value. It may also concern the normal/inverse mode.
  - improve the checking of the value from the user space.
- v2
  - uart_get_iso7816_config: check there is an iso7816_config function.
  - use IOCTL macros to generate the IOCTL number.
  - check that reserved field is not used.
  - remove debug logs.
  - check that the iso7816_config is right before doing any action.
  - change the error from nack and max iteration status to a debug message.
  - remove patch 3 as it concerns both rs485 and iso7816 to think more.
  about the need of adding a lock or not.

Nicolas Ferre (2):
  tty/serial_core: add ISO7816 infrastructure
  tty/serial: atmel: add ISO7816 support

 arch/alpha/include/uapi/asm/ioctls.h   |   2 +
 arch/mips/include/uapi/asm/ioctls.h    |   2 +
 arch/parisc/include/uapi/asm/ioctls.h  |   2 +
 arch/powerpc/include/uapi/asm/ioctls.h |   2 +
 arch/sh/include/uapi/asm/ioctls.h      |   2 +
 arch/sparc/include/uapi/asm/ioctls.h   |   2 +
 arch/xtensa/include/uapi/asm/ioctls.h  |   2 +
 drivers/tty/serial/atmel_serial.c      | 190 +++++++++++++++++++++++++++++++--
 drivers/tty/serial/atmel_serial.h      |   3 +-
 drivers/tty/serial/serial_core.c       |  60 +++++++++++
 include/linux/serial_core.h            |   3 +
 include/uapi/asm-generic/ioctls.h      |   2 +
 include/uapi/linux/serial.h            |  17 +++
 13 files changed, 277 insertions(+), 12 deletions(-)

-- 
2.12.2

