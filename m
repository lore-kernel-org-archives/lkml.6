Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65117ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14438208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14438208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kobol.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeISJV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:21:58 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54347 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeISJV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:21:58 -0400
X-Originating-IP: 36.71.235.160
Received: from ubuntuVM.lan (unknown [36.71.235.160])
        (Authenticated sender: aditya@kobol.io)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2C66960003;
        Wed, 19 Sep 2018 03:45:53 +0000 (UTC)
From:   Aditya Prayoga <aditya@kobol.io>
To:     linux-ide@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Daniel Golle <daniel@makrotopia.org>,
        Aditya Prayoga <aditya@kobol.io>
Subject: [PATCH 0/2] Add support per ATA port ledtrigger on armada 38x
Date:   Wed, 19 Sep 2018 11:45:28 +0800
Message-Id: <1537328730-9156-1-git-send-email-aditya@kobol.io>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series adds support LED trigger for each ATA port indicating disk activity
in Armada 38x. I pick up the work done by Daniel Golle which can be found at [1]

Helios4 which is based on Armada 388, has four LEDs designed to indicate disk
activity on each SATA ports. As the final switch (CONFIG_ATA_LEDS) to enable
the codepath by default is no, it should not affect the rest of Armada 38x 
based boards.

[1] https://patchwork.ozlabs.org/patch/420733/ 
---
Notes
  checkpatch.pl complains about "WARNING: please write a paragraph that
    describes the config symbol fully" but I think the description is clear
    enough to ignore the warning.

  Some performance number tested on Western Digital Red 2TB WD20EFRX
    using fio randrw
    * CONFIG_ATA_LEDS disabled and selected trigger is none
      read : iops=326
      write : iops=109
    * CONFIG_ATA_LEDS disabled and selected trigger is disk-activity
      read : iops=325
      write : iops=108
    * CONFIG_ATA_LEDS enabled and selected trigger is ata1
      read : iops=325
      write : iops=108

---
Aditya Prayoga (1):
  ARM: mvebu: Enable ARCH_WANT_LIBATA_LEDS in Armada 38x

Daniel Golle (1):
  libata: add ledtrig support

 arch/arm/mach-mvebu/Kconfig |  1 +
 drivers/ata/Kconfig         | 16 +++++++++++++
 drivers/ata/libata-core.c   | 56 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/libata.h      |  7 ++++++
 4 files changed, 80 insertions(+)

-- 
2.7.4

