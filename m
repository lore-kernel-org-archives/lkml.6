Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932316AbeCLXNv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:13:51 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:47098 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbeCLXNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:13:49 -0400
X-Google-Smtp-Source: AG47ELudDmrmFQjsbfpXKwUsyURddAqrj1wdhmsL93eFvKYsQ09+R8bZ3jRMsUycqtz4iQLrpr8/YA==
From: Stefano Manni <stefano.manni@gmail.com>
To: a.zummo@towertech.it, alexandre.belloni@free-electrons.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH] rtc: mcp795: remove VLA usage
Date: Tue, 13 Mar 2018 00:13:38 +0100
Message-Id: <20180312231338.3756-1-stefano.manni@gmail.com>
X-Mailer: git-send-email 2.9.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLAs and replace them with
fixed-length arrays instead.

rtc-mcp795.c uses a variable-length array declaration to contain
the command to write the rtcc; this can be replaced by a fixed-
size array of length 2 (instruction, address) + 32 (data out),
assuming a maximum data length of 32 bytes before wrap up.

This was prompted by https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/rtc/rtc-mcp795.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
index 77f21331ae21..a5f504e2364c 100644
--- a/drivers/rtc/rtc-mcp795.c
+++ b/drivers/rtc/rtc-mcp795.c
@@ -61,6 +61,9 @@
 
 #define SEC_PER_DAY		(24 * 60 * 60)
 
+/* Maximum length for data out in write operation to RTCC */
+#define MCP795_MAX_DATAOUT_LEN	32
+
 static int mcp795_rtcc_read(struct device *dev, u8 addr, u8 *buf, u8 count)
 {
 	struct spi_device *spi = to_spi_device(dev);
@@ -82,7 +85,10 @@ static int mcp795_rtcc_write(struct device *dev, u8 addr, u8 *data, u8 count)
 {
 	struct spi_device *spi = to_spi_device(dev);
 	int ret;
-	u8 tx[2 + count];
+	u8 tx[2 + MCP795_MAX_DATAOUT_LEN];
+
+	if (count > MCP795_MAX_DATAOUT_LEN)
+		return -EINVAL;
 
 	tx[0] = MCP795_WRITE;
 	tx[1] = addr;
-- 
2.14.3
