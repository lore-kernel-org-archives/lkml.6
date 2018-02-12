Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932857AbeBLWsc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:32 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37529 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932682AbeBLWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:26 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 07/45] rtc: ds1305: put ds1305_nvmem_cfg on the stack
Date: Mon, 12 Feb 2018 23:47:21 +0100
Message-Id: <20180212224759.15999-8-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes to code safer on system using two similar RTCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1305.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ds1305.c b/drivers/rtc/rtc-ds1305.c
index affa90da26f1..3d2400a39da9 100644
--- a/drivers/rtc/rtc-ds1305.c
+++ b/drivers/rtc/rtc-ds1305.c
@@ -544,15 +544,6 @@ static int ds1305_nvram_write(void *priv, unsigned int off, void *buf,
 	return spi_sync(spi, &m);
 }
 
-static struct nvmem_config ds1305_nvmem_cfg = {
-	.name = "ds1305_nvram",
-	.word_size = 1,
-	.stride = 1,
-	.size = DS1305_NVRAM_LEN,
-	.reg_read = ds1305_nvram_read,
-	.reg_write = ds1305_nvram_write,
-};
-
 /*----------------------------------------------------------------------*/
 
 /*
@@ -566,6 +557,14 @@ static int ds1305_probe(struct spi_device *spi)
 	u8				addr, value;
 	struct ds1305_platform_data	*pdata = dev_get_platdata(&spi->dev);
 	bool				write_ctrl = false;
+	struct nvmem_config ds1305_nvmem_cfg = {
+		.name = "ds1305_nvram",
+		.word_size = 1,
+		.stride = 1,
+		.size = DS1305_NVRAM_LEN,
+		.reg_read = ds1305_nvram_read,
+		.reg_write = ds1305_nvram_write,
+	};
 
 	/* Sanity check board setup data.  This may be hooked up
 	 * in 3wire mode, but we don't care.  Note that unless
-- 
2.16.1
