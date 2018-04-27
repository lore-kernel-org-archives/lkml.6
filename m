Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932904AbeD0Wa2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 18:30:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46900 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932453AbeD0Wa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 18:30:26 -0400
X-Google-Smtp-Source: AB8JxZqk8Ce2ROz7nQPHe8yQMpql1Z3b73DdpE1pTvTB1SYRKcO614FHhbhi3+Agxg7FvkUGjxGwEw==
From: Kyle Spiers <ksspiers@google.com>
To: lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, keescook@chromium.org,
        Kyle Spiers <ksspiers@google.com>
Subject: [PATCH v2] rave-sp: Remove VLA
Date: Fri, 27 Apr 2018 15:30:23 -0700
Message-Id: <20180427223023.11849-1-ksspiers@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
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
index 5c858e784a89..4ce96b7137db 100644
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
+	if (unlikely(checksum_length > sizeof(crc_calculated))) {
+		dev_warn(dev, "Checksum too long, dropping\n");
+		return;
+	}
 
 	print_hex_dump(KERN_DEBUG, "rave-sp rx: ", DUMP_PREFIX_NONE,
 		       16, 1, data, length, false);
-- 
2.17.0.441.gb46fe60e1d-goog
