Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5FCC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C504420864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C504420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965434AbeFRIWS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:22:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964950AbeFRIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:22:15 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6E15ABAD;
        Mon, 18 Jun 2018 08:22:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 152/279] ARM: davinci: fix GPIO lookup for I2C
Date:   Mon, 18 Jun 2018 10:12:17 +0200
Message-Id: <20180618080615.129091092@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sekhar Nori <nsekhar@ti.com>

[ Upstream commit 9411ac07cd764be34bbd7ff09125a6b7b9175d4c ]

The GPIO chip is called davinci_gpio.0 in legacy mode. Fix it, so that
I2C can correctly lookup the recovery gpios.

Note that it is the gpio-davinci driver that sets the gpiochip label to
davinci_gpio.0.

Also, the I2C device uses an id of 1 on DM644x and DM355.

While at it, convert to using GPIO_TO_PIN() for referring to GPIO pin
numbers, like it is done in rest of the board support files.

Fixes: e53537653791 ("i2c/ARM: davinci: Deep refactoring of I2C recovery")
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-davinci/board-dm355-evm.c  |    9 ++++++---
 arch/arm/mach-davinci/board-dm644x-evm.c |   10 +++++++---
 2 files changed, 13 insertions(+), 6 deletions(-)

--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -110,12 +110,15 @@ static struct platform_device davinci_na
 	},
 };
 
+#define DM355_I2C_SDA_PIN	GPIO_TO_PIN(0, 15)
+#define DM355_I2C_SCL_PIN	GPIO_TO_PIN(0, 14)
+
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
-	.dev_id = "i2c_davinci",
+	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio", 15, "sda",
+		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio", 14, "scl",
+		GPIO_LOOKUP("davinci_gpio.0", DM355_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
 #include <linux/platform_data/at24.h>
+#include <linux/platform_data/gpio-davinci.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -596,12 +597,15 @@ static struct i2c_board_info __initdata
 	},
 };
 
+#define DM644X_I2C_SDA_PIN	GPIO_TO_PIN(2, 12)
+#define DM644X_I2C_SCL_PIN	GPIO_TO_PIN(2, 11)
+
 static struct gpiod_lookup_table i2c_recovery_gpiod_table = {
-	.dev_id = "i2c_davinci",
+	.dev_id = "i2c_davinci.1",
 	.table = {
-		GPIO_LOOKUP("davinci_gpio", 44, "sda",
+		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SDA_PIN, "sda",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
-		GPIO_LOOKUP("davinci_gpio", 43, "scl",
+		GPIO_LOOKUP("davinci_gpio.0", DM644X_I2C_SCL_PIN, "scl",
 			    GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
 	},
 };


