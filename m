Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C95C61CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4482087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y5rrk4h/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfASAOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:14:36 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37941 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730238AbfASAOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:14:32 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so12227772ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jnsBySVcj3rMOF075ErfzZ31fLDI5tWDjToe4o5Z9w4=;
        b=Y5rrk4h/TOW3apZzJgm2Uwk5zlBYyiUJTls+ev0a9++P+rpx9MIJXylNThwPwSgMOU
         +FSg1BvaA+0LMtqGLah7lTbye2pxwHM9TK4HaDchW+PhJ3vIjtPEZOk8oATDREed7Tal
         gJlgP56HVVaq+YEUhlgA3Bt846WhWiSYUMGTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jnsBySVcj3rMOF075ErfzZ31fLDI5tWDjToe4o5Z9w4=;
        b=rmHnLD7zicujYm8E3/s40Z2b3VORMNjrlVCU9sSfGqtG0UO0stu6pOaWZM6q7qSreH
         XWy0rQoj9zsmPJt69MvBMqIkuOmID9y1TL46BwTkI9ZeqQuuk7kmDp+H2e4V7voZzTJO
         EQpEOKPv/qxsJaiR1kz6ARuYQE1ydJ/pWOu3ENlGO8gmPQvErnvfv+lq2bg79mK2K5EB
         eVSfOjqKSPavCgwrKFZW4PVKHD8Yx36/1aK6d8dHSgnDywWTrpNWgDCLjxZ4DjnVxN7Y
         04UjT45naJEBMcDQubH6SXTfydqFiIzVV2AamdDxjNiz3CLoLGu9DETwoUxTbkHytyku
         DicQ==
X-Gm-Message-State: AJcUukd9ctMsM13a4WXu4RQd+fygMF+X7453cTa6r/xzfpiRqq1Iaeyh
        SgWiF+r6LGYsI+Pj1A19OkziveWsWWk=
X-Google-Smtp-Source: ALg8bN6FcHgx59rpysblJn0RxCKAqUgYWwsjHjOLK7JrylByCnCEQyqVcgkwlbNhPwCcIycJvp3dPQ==
X-Received: by 2002:a5e:de01:: with SMTP id e1mr11870606iok.137.1547856871177;
        Fri, 18 Jan 2019 16:14:31 -0800 (PST)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id e22sm2382062iod.47.2019.01.18.16.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:14:30 -0800 (PST)
From:   Nick Crews <ncrews@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, djkurtz@google.com,
        dlaurie@chromium.org, Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: [PATCH v3 1/9] platform/chrome: Remove cros_ec dependency in lpc_mec
Date:   Fri, 18 Jan 2019 17:14:14 -0700
Message-Id: <20190119001422.48186-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
In-Reply-To: <20190119001422.48186-1-ncrews@chromium.org>
References: <20190119001422.48186-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

There are some error checks that happen in cros_ec_lpc_mec_in_range()
that probably shouldn't be there, as they are checking kernel-space
callers and not user-space input. However, we'll just do the refactor in
this patch, and in a future patch might remove this error checking and
fix all the instances of code that calls this.

There's a similar problem in cros_ec_lpc_read_bytes(), where we return a
checksum, but on error just return 0. This should probably be changed so
that it returns int, but we don't want to have to mess with all the
calling code for this fix. Maybe we'll come back through later and fix
this.

Signed-off-by: Duncan Laurie <dlaurie@google.com>
Signed-off-by: Nick Crews <ncrews@chromium.org>
---

Changes in v3:
- Change <= to >= in mec_in_range()
- Add " - EC_HOST_CMD_REGION0" to offset arg for io_bytes_mec()

Changes in v2:
- Fixed kernel-doc comments
- Fixed include of linux/mfd/cros_ec_lpc_mec.h
- cros_ec_lpc_mec_in_range() returns -EINVAL on error
- Added parens around macro variables

 drivers/platform/chrome/cros_ec_lpc_mec.c | 52 +++++++++++++++++++----
 drivers/platform/chrome/cros_ec_lpc_mec.h | 43 ++++++++++---------
 drivers/platform/chrome/cros_ec_lpc_reg.c | 47 +++++++-------------
 3 files changed, 83 insertions(+), 59 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index c4edfa83e493..782e238a8d4e 100644
--- a/drivers/platform/chrome/cros_ec_lpc_mec.c
+++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
@@ -23,7 +23,6 @@
 
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/mfd/cros_ec_commands.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
@@ -34,6 +33,7 @@
  * EC mutex because memmap data may be accessed without it being held.
  */
 static struct mutex io_mutex;
+static u16 mec_emi_base, mec_emi_end;
 
 /*
  * cros_ec_lpc_mec_emi_write_address
@@ -46,10 +46,37 @@ static struct mutex io_mutex;
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
+/**
+ * cros_ec_lpc_mec_in_range() - Determine if addresses are in MEC EMI range.
+ *
+ * @offset: Address offset
+ * @length: Number of bytes to check
+ *
+ * Return: 1 if in range, 0 if not, and -EINVAL on failure
+ *         such as the mec range not being initialized
+ */
+int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length)
+{
+	if (length == 0)
+		return -EINVAL;
+
+	if (WARN_ON(mec_emi_base == 0 || mec_emi_end == 0))
+		return -EINVAL;
+
+	if (offset >= mec_emi_base && offset < mec_emi_end) {
+		if (WARN_ON(offset + length - 1 >= mec_emi_end))
+			return -EINVAL;
+		return 1;
+	}
+
+	if (WARN_ON(offset + length > mec_emi_base && offset < mec_emi_end))
+		return -EINVAL;
+
+	return 0;
 }
 
 /*
@@ -71,6 +98,11 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
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
@@ -86,9 +118,9 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
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
@@ -118,7 +150,7 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
 		}
 
 		/* Access [B0, B3] on each loop pass */
-		io_addr = MEC_EMI_EC_DATA_B0;
+		io_addr = MEC_EMI_EC_DATA_B0(mec_emi_base);
 	}
 
 done:
@@ -128,9 +160,11 @@ u8 cros_ec_lpc_io_bytes_mec(enum cros_ec_lpc_mec_io_type io_type,
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
index 105068c0e919..896fffd174b3 100644
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
@@ -45,27 +43,23 @@ enum cros_ec_lpc_mec_io_type {
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
+#define MEC_EMI_HOST_TO_EC(MEC_EMI_BASE)	((MEC_EMI_BASE) + 0)
+#define MEC_EMI_EC_TO_HOST(MEC_EMI_BASE)	((MEC_EMI_BASE) + 1)
+#define MEC_EMI_EC_ADDRESS_B0(MEC_EMI_BASE)	((MEC_EMI_BASE) + 2)
+#define MEC_EMI_EC_ADDRESS_B1(MEC_EMI_BASE)	((MEC_EMI_BASE) + 3)
+#define MEC_EMI_EC_DATA_B0(MEC_EMI_BASE)	((MEC_EMI_BASE) + 4)
+#define MEC_EMI_EC_DATA_B1(MEC_EMI_BASE)	((MEC_EMI_BASE) + 5)
+#define MEC_EMI_EC_DATA_B2(MEC_EMI_BASE)	((MEC_EMI_BASE) + 6)
+#define MEC_EMI_EC_DATA_B3(MEC_EMI_BASE)	((MEC_EMI_BASE) + 7)
 
-/*
- * cros_ec_lpc_mec_init
+/**
+ * cros_ec_lpc_mec_init() - Initialize MEC I/O.
  *
- * Initialize MEC I/O.
+ * @base: MEC EMI Base address
+ * @end: MEC EMI End address
  */
-void cros_ec_lpc_mec_init(void);
+void cros_ec_lpc_mec_init(unsigned int base, unsigned int end);
 
 /*
  * cros_ec_lpc_mec_destroy
@@ -74,6 +68,17 @@ void cros_ec_lpc_mec_init(void);
  */
 void cros_ec_lpc_mec_destroy(void);
 
+/**
+ * cros_ec_lpc_mec_in_range() - Determine if addresses are in MEC EMI range.
+ *
+ * @offset: Address offset
+ * @length: Number of bytes to check
+ *
+ * Return: 1 if in range, 0 if not, and -EINVAL on failure
+ *         such as the mec range not being initialized
+ */
+int cros_ec_lpc_mec_in_range(unsigned int offset, unsigned int length);
+
 /**
  * cros_ec_lpc_io_bytes_mec - Read / write bytes to MEC EMI port
  *
diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
index fc23d535c404..1d9f3b7ffb3e 100644
--- a/drivers/platform/chrome/cros_ec_lpc_reg.c
+++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
@@ -59,51 +59,36 @@ static u8 lpc_write_bytes(unsigned int offset, unsigned int length, u8 *msg)
 
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
+		cros_ec_lpc_io_bytes_mec(MEC_IO_READ,
+					 offset - EC_HOST_CMD_REGION0,
+					 length, dest) :
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
+		cros_ec_lpc_io_bytes_mec(MEC_IO_WRITE,
+					 offset - EC_HOST_CMD_REGION0,
+					 length, msg) :
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
2.20.1.321.g9e740568ce-goog

