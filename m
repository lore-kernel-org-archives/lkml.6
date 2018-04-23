Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeDWUDB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:03:01 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41767 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932306AbeDWUDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:03:00 -0400
X-Google-Smtp-Source: AIpwx4+T8ehC91C62LVbCOfUVpOMoVrStzsOF5GOBuA3hwh73I4NEnqYz0+KXbqmmMhXMUev2UJ0aQ==
From: Kyle Spiers <ksspiers@google.com>
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, keescook@chromium.org,
        Kyle Spiers <ksspiers@google.com>
Subject: [PATCH] rave-sp: Remove VLA
Date: Mon, 23 Apr 2018 13:02:55 -0700
Message-Id: <20180423200255.154645-1-ksspiers@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to remove VLAs from the kernel[1], this creates
constants for the checksum lengths of CCITT and 8B2C and changes
crc_calculated to be the maximum size of a checksum.

https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kyle Spiers <ksspiers@google.com>
---
 drivers/mfd/rave-sp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 5c858e784a89..99fa482419f9 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -45,7 +45,9 @@
 #define RAVE_SP_DLE			0x10
 
 #define RAVE_SP_MAX_DATA_SIZE		64
-#define RAVE_SP_CHECKSUM_SIZE		2  /* Worst case scenario on RDU2 */
+#define RAVE_SP_CHECKSUM_8B2C		1
+#define RAVE_SP_CHECKSUM_CCITT		2
+#define RAVE_SP_CHECKSUM_SIZE		RAVE_SP_CHECKSUM_CCITT
 /*
  * We don't store STX, ETX and unescaped bytes, so Rx is only
  * DATA + CSUM
@@ -415,7 +417,12 @@ static void rave_sp_receive_frame(struct rave_sp *sp,
 	const size_t payload_length  = length - checksum_length;
 	const u8 *crc_reported       = &data[payload_length];
 	struct device *dev           = &sp->serdev->dev;
-	u8 crc_calculated[checksum_length];
+	u8 crc_calculated[RAVE_SP_CHECKSUM_SIZE];
+
+	if (unlikely(length > sizeof(crc_calculated))) {
+		dev_warn(dev, "Dropping oversized frame\n");
+		return;
+	}
 
 	print_hex_dump(KERN_DEBUG, "rave-sp rx: ", DUMP_PREFIX_NONE,
 		       16, 1, data, length, false);
-- 
2.17.0.484.g0c8726318c-goog
