Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D87ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D634920B80
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 09:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D634920B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeGPKKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 06:10:51 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:2323 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbeGPKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 06:10:50 -0400
X-IronPort-AV: E=Sophos;i="5.51,360,1526367600"; 
   d="scan'208";a="16360956"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jul 2018 02:44:15 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Mon, 16 Jul 2018
 02:44:14 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <me@jue.yt>, <wsa@the-dreams.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 0/3] i2c: at91: slave mode support
Date:   Mon, 16 Jul 2018 11:40:34 +0200
Message-ID: <20180716094037.1843-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Ludovic Desroches: see 'Changes in v3' section]

Based on the discussion we had on the i2c-linux list [1], I wrote a patch for
AT91 hardware and tried to fulfill the Linux I2C slave interface description
[2] as good as possible. This enables aforementioned hardware to act as an I2C
slave that can be accessed by a remote I2C master.

I have tested this patchset successfully on an ATSAMA5D27.

                                 ^  3.3V   ^  3.3V
    +-----------------------+    |         |         +-----------------------+
    | Slave: ATSAMA5D27     |   +-+       +-+        | Master: ATSAMA5D35    |
    | with i2c-slave-eeprom |   | | 100k  | | 100k   | with i2cset           |
    +-------------------+-+-+   +-+       +-+        +-+-+-------------------+
                        | |      |         |           | |
                        | +------+---------|---(SDA)---+ |
                        +------------------+---(SCL)-----+

    Schematic: Connection of slave and master with 100kOhm pullup resistors.

On the master the following BASH script has been used to stress the slave.

	root@emblinux:~# cat ./stress.sh
	#!/bin/bash
	I=0
	while true
	do
		if i2cset -y -r 1 0x64 0 $I w | grep mismatch
		then
			echo "$(date): Error in transmission ${I}"
		fi
		((I++))
		if [ $I -eq 65536 ]
		then
			I=0
			echo "$(date): Sent 65536 transmissions"
		fi
	done

After running the script for some time I had the following output. To me this
looks promising :)

	root@emblinux:~# ./stress.sh
	Thu Nov  9 13:58:45 CTE 2017: Sent 65536 transmissions
	Thu Nov  9 14:35:20 CTE 2017: Sent 65536 transmissions
	Thu Nov  9 15:12:11 CTE 2017: Sent 65536 transmissions
	Thu Nov  9 15:49:04 CTE 2017: Sent 65536 transmissions
	Thu Nov  9 16:26:00 CTE 2017: Sent 65536 transmissions
	Thu Nov  9 17:03:07 UTC 2017: Sent 65536 transmissions
	Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions

	If you have some hardware with an at91-i2c interface included at hand, I really
	would appreciate if you can run the test script on your hardware and test this
	driver.

Best regards
  Juergen


[Ludovic Desroches]
Changes in v3:
 - rebase (cherry-pick was enough)
 - fix checkpatch errors
 - tests:
   - hangs with a SAMA5D4 (master and slave on different busses) after about
   100 transfers. It's the firs time I do this test.
   - some mismatches with a SAMA5D4 as slave and a SAMA5D2 as master
   I don't know if it's a regression. I don't remember having seen this
   behavior previously.
   I think it's worth taking those patches even if there are some possible
   bugs. It'll allow to get more people using it and so to consolidate the
   slave mode support.

Changes in v2:
 - Implemented all suggestions made by Ludovic. (Thank you!)
 - Reworked the IRQ handler completely. Have a look in patch 3 fort further
   details.

[1] https://marc.info/?t=150824004800001&r=1&w=1
[2] https://www.kernel.org/doc/Documentation/i2c/slave-interface

Juergen Fitschen (3):
  i2c: at91: segregate master mode specific code from probe and init
    func
  i2c: at91: split driver into core and master file
  i2c: at91: added slave mode support

 MAINTAINERS                                        |   3 +-
 drivers/i2c/busses/Makefile                        |   4 +
 drivers/i2c/busses/i2c-at91-core.c                 | 380 +++++++++++++++++
 .../i2c/busses/{i2c-at91.c => i2c-at91-master.c}   | 453 +--------------------
 drivers/i2c/busses/i2c-at91-slave.c                | 147 +++++++
 drivers/i2c/busses/i2c-at91.h                      | 179 ++++++++
 6 files changed, 719 insertions(+), 447 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-at91-core.c
 rename drivers/i2c/busses/{i2c-at91.c => i2c-at91-master.c} (67%)
 create mode 100644 drivers/i2c/busses/i2c-at91-slave.c
 create mode 100644 drivers/i2c/busses/i2c-at91.h

-- 
2.12.2

