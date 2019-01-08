Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44325C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130502183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="t/6BSrAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbfAHJQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:16:01 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35696 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfAHJP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:15:56 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so3485253edx.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtdPGnoNcOA+uAMeykOlFvJi5M25GSj2otU8Jlp5mq4=;
        b=t/6BSrACMpojsU1VWdUposfrHgGClFWcP71qT2s+vhPd/29df5n7Ij1XEIkIpX3trL
         Ng0MgVNjxdG8ubvZUNa5zZLkG5dheBnqizItOOhgONxNx/eyS9KTcjKDTeANVeRPf6UO
         zJMQmr/kkrSCSqcLoqc6J5iPa83k2FKKpUaRPVsmLDK1VnY2wx4fCVi2/l3E15nwXem4
         q9K6APrr05FYA/HC093TIqL6BiD0WWAuCYBcfsDPC/qaF+wCBvs4uTjCvX7BDzSq1wn8
         afdElkXMePx1AXpaQ9JW0FsxZUUJM4Q1znYXW8A0gCDU/LIzplp2S240APmLJjWaGBl0
         M/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtdPGnoNcOA+uAMeykOlFvJi5M25GSj2otU8Jlp5mq4=;
        b=CWq7pdBwBohqw6EBxQIv623XmIW6jVj2rsqtPK9Yw/aH+KuuYm9q1TH99NVG4J4/Iz
         l0abrlCVvVxMfQoHH4qjWy0mYZ85wc71DCxIDH0geHWV3iKMvS/3Lz9/xmkP/m4tryJQ
         kdU2dQHo4ewqLMPyPtOpJIFkIm18Wkf4q5NK6eDcsPs2g2O0PrcvJOB/7PAXTEjnWgEd
         gmFaG/KIOF11NEd7441HMkfXbkBiy+qu2QGJ9CiKLN9zozc+I6/Tl+ap8e0b8c3L5kTT
         H4TUTMBGdA2GZ46gAkPRsKiI/nIxRdRwLnJZIE8UJiUw8fpOIw1GXxam9e/Ncl1AEgzk
         CZ8Q==
X-Gm-Message-State: AJcUukeIWgLvlNvKlEANVp6ZJNbZrZNzEixy5YlRROwsY+H04jFsXkYS
        POW5Yhx6KaGrSZtqZFjrybrQxA==
X-Google-Smtp-Source: ALg8bN6piq7qJ+WWVxnfv6jG2DOxdEePGwG+y2iIZUUo5LaSwZYTsK5Ajo1QMxe2Al6D7q6w0wW7Eg==
X-Received: by 2002:a50:f5af:: with SMTP id u44mr1351249edm.172.1546938955234;
        Tue, 08 Jan 2019 01:15:55 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id gp22-v6sm18373560ejb.4.2019.01.08.01.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 01:15:54 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 05/12] ARM: davinci: dm644x-evm: use device properties for at24 eeprom
Date:   Tue,  8 Jan 2019 10:15:32 +0100
Message-Id: <20190108091539.16674-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108091539.16674-1-brgl@bgdev.pl>
References: <20190108091539.16674-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

Remove the at24_platform_data structure and replace it with an array
of property entries. Drop the byte_len/size property, as the model name
already implies the EEPROM's size.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 arch/arm/mach-davinci/board-dm644x-evm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index e1428115067f..efe4e170e87d 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -16,8 +16,8 @@
 #include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/platform_data/pcf857x.h>
-#include <linux/platform_data/at24.h>
 #include <linux/platform_data/gpio-davinci.h>
+#include <linux/property.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
@@ -532,12 +532,9 @@ static struct nvmem_cell_lookup dm644evm_nvmem_cell_lookup = {
 	.con_id		= "mac-address",
 };
 
-static struct at24_platform_data eeprom_info = {
-	.byte_len	= (256*1024) / 8,
-	.page_size	= 64,
-	.flags		= AT24_FLAG_ADDR16,
-	.setup          = davinci_get_mac_addr,
-	.context	= (void *)0x7f00,
+static const struct property_entry eeprom_properties[] = {
+	PROPERTY_ENTRY_U32("pagesize", 64),
+	{ }
 };
 
 /*
@@ -647,7 +644,7 @@ static struct i2c_board_info __initdata i2c_info[] =  {
 	},
 	{
 		I2C_BOARD_INFO("24c256", 0x50),
-		.platform_data	= &eeprom_info,
+		.properties = eeprom_properties,
 	},
 	{
 		I2C_BOARD_INFO("tlv320aic33", 0x1b),
-- 
2.19.1

