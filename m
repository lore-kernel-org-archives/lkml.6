Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E162C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6F9206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbeLOATf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:19:35 -0500
Received: from mail-ot1-f69.google.com ([209.85.210.69]:47191 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeLOATe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:19:34 -0500
Received: by mail-ot1-f69.google.com with SMTP id g4so3282754otl.14
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 16:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/208ycD+moxGGFGi/LJRqxZISfnckOj71DgE+PoexSc=;
        b=BHq67CMqEqO5u817YUUao3eAnQxL+WQf63zx4NLRKv0cvNFaxZ8bvqf9/ftVc0E+B1
         sA2jxUshMbLx6pkJrCkzHEvpjkUbmqLBfX9GWovGDY7BX1XxUJFrddOBQHr8RszySoWS
         ot7mDD5vsJ13W+Knb6aSwjNx1nL6gfrU2PdYYl3ZaFy31+9NUbnxOrLonhBXOvr/6pRw
         xB2OEAEk6MQvjUWLMhj/ONtYCyXXp3zW2Vb9n//AQujm8qavB4W9SUbqgZYxDi95EUfG
         eRgRqNcX3YYKoVNE6CxJVlQ9bYgMgZdd6Ymb6qHRrs5aOZ7e3skfFAWLW2Mcg8jq4ROk
         V1bQ==
X-Gm-Message-State: AA+aEWaKddouaROWqZk/vI2smGDFPX/pASPgwIi/QHTCrehhI9grqpuj
        s9FLWTcMgYW6OrEckGtsTe4Tu7dt0QIDXO07Vj14P4bSji9AgscFHAwHjGu9hhjAQ4Dx6tnsKAD
        5MwJauYxnwON+Y/aql8trbvbyeyKHM/ZkCE1ONf/j3cHjYl/iT9/1J5MpIqJZfxZWN51VgNNvtr
        M=
X-Google-Smtp-Source: AFSGD/Wmf/PahA+JgYt/c0nTm/Ln+wYnYGCV7CZBjAsSKUGLgV/JIKQ6EBhOFaBlzs9p7ScnB9mqEhLtu67n3l2r
X-Received: by 2002:aca:c796:: with SMTP id x144mr4156499oif.29.1544833173479;
 Fri, 14 Dec 2018 16:19:33 -0800 (PST)
Date:   Fri, 14 Dec 2018 17:18:34 -0700
In-Reply-To: <20181215001843.62404-1-ncrews@google.com>
Message-Id: <20181215001843.62404-2-ncrews@google.com>
Mime-Version: 1.0
References: <20181215001843.62404-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [RFC PATCH 01/10] CHROMIUM: cros_ec: Remove cros_ec dependency in lpc_mec
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Duncan Laurie <dlaurie@google.com>, Nick Crews <ncrews@google.com>,
        Olof Johansson <olof@lixom.net>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Duncan Laurie <dlaurie@google.com>

In order to allow this code to be re-used, remove the dependency
on the rest of the cros_ec code from the cros_ec_lpc_mec functions.

Instead of using a hardcoded register base address of 0x800 have
this be passed in to cros_ec_lpc_mec_init().  The existing cros_ec
use case now passes in the 0x800 base address this way.

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@google.com>
---

 drivers/platform/chrome/cros_ec_lpc_mec.c | 54 +++++++++++++++++++----
 drivers/platform/chrome/cros_ec_lpc_mec.h | 45 +++++++++++--------
 drivers/platform/chrome/cros_ec_lpc_reg.c | 43 +++++-------------
 3 files changed, 85 insertions(+), 57 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index c4edfa83e493..18bd9f82be6c 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/mfd/cros_ec_commands.h>
+#include <linux/mfd/cros_ec_lpc_mec.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
@@ -34,6 +35,7 @@
  * EC mutex because memmap data may be accessed without it being held.
  */
 static struct mutex io_mutex;
+static u16 mec_emi_base, mec_emi_end;
 
 /*
  * cros_ec_lpc_mec_emi_write_address
@@ -46,10 +48,39 @@ static struct mutex io_mutex;
 static void cros_ec_lpc_mec_emi_write_address(u16 addr,
 			enum cros_ec_lpc_mec_emi_access_mode access_type)
 {
-	/* Address relative to start of EMI range */
-	addr -= MEC_EMI_RANGE_START;
-	outb((addr & 0xfc) | access_type, MEC_EMI_EC_ADDRESS_B0);
-	outb((addr >> 8) & 0x7f, MEC_EMI_EC_ADDRESS_B1);
+	outb((addr & 0xfc) | access_type, MEC_EMI_EC_ADDRESS_B0(mec_emi_base));
+	outb((addr >> 8) & 0x7f, MEC_EMI_EC_ADDRESS_B1(mec_emi_base));
+}
+
+/*
+ * cros_ec_lpc_mec_in_range
+ *
+ * Determine if requested addresses are in MEC EMI range.
+ *
+ * @offset:      Address offset
+ * @length: Number of bytes to check
+ *
+ * @return 1 if in range, 0 if not, and -1 if there is an error
+ *         such as the mec range not being initialized
+ */
+int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
+{
+	if (length == 0)
+		return -1;
+
+	if (WARN_ON(mec_emi_base == 0 || mec_emi_end == 0))
+		return -1;
+
+	if (offset >= mec_emi_base && offset < mec_emi_end) {
+		if (WARN_ON(offset + length - 1 <= mec_emi_end))
+			return -1;
+		return 1;
+	}
+
+	if (WARN_ON(offset + length > mec_emi_base && offset < mec_emi_end))
+		return -1;
+
+	return 0;
 }
 
 /*
@@ -71,6 +102,11 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 	u8 sum = 0;
 	enum cros_ec_lpc_mec_emi_access_mode access, new_access;
 
+	/* Return checksum of 0 if window is not initialized */
+	WARN_ON(mec_emi_base == 0 || mec_emi_end == 0);
+	if (mec_emi_base == 0 || mec_emi_end == 0)
+		return 0;
+
 	/*
 	 * Long access cannot be used on misaligned data since reading B0 loads
 	 * the data register and writing B3 flushes.
@@ -86,9 +122,9 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 	cros_ec_lpc_mec_emi_write_address(offset, access);
 
 	/* Skip bytes in case of misaligned offset */
-	io_addr = MEC_EMI_EC_DATA_B0 + (offset & 0x3);
+	io_addr = MEC_EMI_EC_DATA_B0(mec_emi_base) + (offset & 0x3);
 	while (i < length) {
-		while (io_addr <= MEC_EMI_EC_DATA_B3) {
+		while (io_addr <= MEC_EMI_EC_DATA_B3(mec_emi_base)) {
 			if (io_type == MEC_IO_READ)
 				buf[i] = inb(io_addr++);
 			else
@@ -118,7 +154,7 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 		}
 
 		/* Access [B0, B3] on each loop pass */
-		io_addr = MEC_EMI_EC_DATA_B0;
+		io_addr = MEC_EMI_EC_DATA_B0(mec_emi_base);
 	}
 
 done:
@@ -128,9 +164,11 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 }
 EXPORT_SYMBOL(cros_ec_lpc_io_bytes_mec);
 
-void cros_ec_lpc_mec_init(void)
+void cros_ec_lpc_mec_init(unsigned int base, unsigned int end)
 {
 	mutex_init(&io_mutex);
+	mec_emi_base = base;
+	mec_emi_end = end;
 }
 EXPORT_SYMBOL(cros_ec_lpc_mec_init);
 
diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.h b/drivers/platform/chrome/cros_ec_lpc_mec.h
index 105068c0e919..a81cc6a8b621 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.h
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.h
@@ -24,8 +24,6 @@
 #ifndef __CROS_EC_LPC_MEC_H
 #define __CROS_EC_LPC_MEC_H
 
-#include <linux/mfd/cros_ec_commands.h>
-
 enum cros_ec_lpc_mec_emi_access_mode {
 	/* 8-bit access */
 	ACCESS_TYPE_BYTE = 0x0,
@@ -45,35 +43,46 @@ enum cros_ec_lpc_mec_io_type {
 	MEC_IO_WRITE,
 };
 
-/* Access IO ranges 0x800 thru 0x9ff using EMI interface instead of LPC */
-#define MEC_EMI_RANGE_START EC_HOST_CMD_REGION0
-#define MEC_EMI_RANGE_END   (EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE)
-
 /* EMI registers are relative to base */
-#define MEC_EMI_BASE 0x800
-#define MEC_EMI_HOST_TO_EC (MEC_EMI_BASE + 0)
-#define MEC_EMI_EC_TO_HOST (MEC_EMI_BASE + 1)
-#define MEC_EMI_EC_ADDRESS_B0 (MEC_EMI_BASE + 2)
-#define MEC_EMI_EC_ADDRESS_B1 (MEC_EMI_BASE + 3)
-#define MEC_EMI_EC_DATA_B0 (MEC_EMI_BASE + 4)
-#define MEC_EMI_EC_DATA_B1 (MEC_EMI_BASE + 5)
-#define MEC_EMI_EC_DATA_B2 (MEC_EMI_BASE + 6)
-#define MEC_EMI_EC_DATA_B3 (MEC_EMI_BASE + 7)
+#define MEC_EMI_HOST_TO_EC(MEC_EMI_BASE)	(MEC_EMI_BASE + 0)
+#define MEC_EMI_EC_TO_HOST(MEC_EMI_BASE)	(MEC_EMI_BASE + 1)
+#define MEC_EMI_EC_ADDRESS_B0(MEC_EMI_BASE)	(MEC_EMI_BASE + 2)
+#define MEC_EMI_EC_ADDRESS_B1(MEC_EMI_BASE)	(MEC_EMI_BASE + 3)
+#define MEC_EMI_EC_DATA_B0(MEC_EMI_BASE)	(MEC_EMI_BASE + 4)
+#define MEC_EMI_EC_DATA_B1(MEC_EMI_BASE)	(MEC_EMI_BASE + 5)
+#define MEC_EMI_EC_DATA_B2(MEC_EMI_BASE)	(MEC_EMI_BASE + 6)
+#define MEC_EMI_EC_DATA_B3(MEC_EMI_BASE)	(MEC_EMI_BASE + 7)
 
-/*
+/**
  * cros_ec_lpc_mec_init
  *
  * Initialize MEC I/O.
+ *
+ * @base: MEC EMI Base address
+ * @end:  MEC EMI End address
  */
-void cros_ec_lpc_mec_init(void);
+void cros_ec_lpc_mec_init(unsigned int base, unsigned int end);
 
-/*
+/**
  * cros_ec_lpc_mec_destroy
  *
  * Cleanup MEC I/O.
  */
 void cros_ec_lpc_mec_destroy(void);
 
+/**
+ * cros_ec_lpc_mec_in_range
+ *
+ * Determine if requested addresses are in MEC EMI range.
+ *
+ * @offset: Address offset
+ * @length: Number of bytes to check
+ *
+ * @return 1 if in range, 0 if not, and -1 if there is an error
+ *         such as the mec range not being initialized
+ */
+int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length);
+
 /**
  * cros_ec_lpc_io_bytes_mec - Read / write bytes to MEC EMI port
  *
diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
index fc23d535c404..4cba259b5b1e 100644
--- a/drivers/platform/chrome/cros_ec_lpc_reg.c
+++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
@@ -59,51 +59,32 @@ static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
 
 u8 cros_ec_lpc_read_bytes(unsigned int offset, unsigned int length, u8 *dest)
 {
-	if (length == 0)
-		return 0;
-
-	/* Access desired range through EMI interface */
-	if (offset >= MEC_EMI_RANGE_START && offset <= MEC_EMI_RANGE_END) {
-		/* Ensure we don't straddle EMI region */
-		if (WARN_ON(offset + length - 1 > MEC_EMI_RANGE_END))
-			return 0;
+	int in_range = cros_ec_lpc_mec_in_range(offset, length);
 
-		return cros_ec_lpc_io_bytes_mec(MEC_IO_READ, offset, length,
-						dest);
-	}
-
-	if (WARN_ON(offset + length > MEC_EMI_RANGE_START &&
-		    offset < MEC_EMI_RANGE_START))
+	if (in_range < 0)
 		return 0;
 
-	return lpc_read_bytes(offset, length, dest);
+	return in_range ?
+		cros_ec_lpc_io_bytes_mec(MEC_IO_READ, offset, length, dest) :
+		lpc_read_bytes(offset, length, dest);
 }
 
 u8 cros_ec_lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
 {
-	if (length == 0)
-		return 0;
-
-	/* Access desired range through EMI interface */
-	if (offset >= MEC_EMI_RANGE_START && offset <= MEC_EMI_RANGE_END) {
-		/* Ensure we don't straddle EMI region */
-		if (WARN_ON(offset + length - 1 > MEC_EMI_RANGE_END))
-			return 0;
+	int in_range = cros_ec_lpc_mec_in_range(offset, length);
 
-		return cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, offset, length,
-						msg);
-	}
-
-	if (WARN_ON(offset + length > MEC_EMI_RANGE_START &&
-		    offset < MEC_EMI_RANGE_START))
+	if (in_range < 0)
 		return 0;
 
-	return lpc_write_bytes(offset, length, msg);
+	return in_range ?
+		cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE, offset, length, msg) :
+		lpc_write_bytes(offset, length, msg);
 }
 
 void cros_ec_lpc_reg_init(void)
 {
-	cros_ec_lpc_mec_init();
+	cros_ec_lpc_mec_init(EC_HOST_CMD_REGION0,
+			     EC_LPC_ADDR_MEMMAP + EC_MEMMAP_SIZE);
 }
 
 void cros_ec_lpc_reg_destroy(void)
-- 
2.20.0.405.gbc1bbc6f85-goog

