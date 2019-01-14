Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78153C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44732205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfANWEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:04:15 -0500
Received: from mail-yw1-f71.google.com ([209.85.161.71]:53472 "EHLO
        mail-yw1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbfANWEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:04:14 -0500
Received: by mail-yw1-f71.google.com with SMTP id h3so282503ywc.20
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 14:04:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AEz/lA1ykJDg2del3qhR92C/0GyQH3oyqANQCrlMD98=;
        b=sJZE2lAgr9Y+MLJ4wj8Gf15qqNudVY0PiKiDOvk5TgDVpjPqfTkT3NPIUfQU/SLy4K
         9zKymdV5FNH/E18rO+OpCdb2h0UJ2o4P/v7vtWsnHE5BSTOUg6NoYcMJdPWDsv3NHTYH
         mDnug0pUsLsaVIEpQVlCh2LEf2+oHw2H7KaCHASGa6lzoVpkyxTXUuoj1u/kVGySOUBp
         I0qDxNj70a874XlbDQhOdmEGGJpeYKU25vUnLLowTQT1T63mMIPOPHEfPNS39coXyKxa
         SgDRda3ERZ3TWt/gPGXcvHD0++xkrP27AxKcqil+L+vMp2vvL0ZM+P5pcF3UUQBGe5DN
         YE2g==
X-Gm-Message-State: AJcUukeAMKRhw0nIQPIYjofBRQK57iNJW3CpgjJqAyUOk2kj5zd4a4Db
        hTIRwuIx81w2AmfInHl2cj7US191j2tGvLs+HduFQw4UBSN5Uv8icn63ZbLI7NEUYP6OOQmNZQi
        bkv6qxqO8qHw2zBfZmKnAvyJ/VHnHTmKhxuamFL4qHfKtO5vQms3PNeo43RjFdT2//Y6a9QDzSV
        s=
X-Google-Smtp-Source: ALg8bN6Me9XVrKw5vxZ4jlmFDhTPPAIJp2LDf+5h+9xMRDqGge1Lhx62lXpAo+VwfGOSJfARDeul6YIYgXXGPjvr
X-Received: by 2002:a25:4d8a:: with SMTP id a132mr283996ybb.10.1547503450687;
 Mon, 14 Jan 2019 14:04:10 -0800 (PST)
Date:   Mon, 14 Jan 2019 15:03:48 -0700
In-Reply-To: <20190114220356.108916-1-ncrews@google.com>
Message-Id: <20190114220356.108916-2-ncrews@google.com>
Mime-Version: 1.0
References: <20190114220356.108916-1-ncrews@google.com>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
Subject: [PATCH v2 1/9] platform/chrome: Remove cros_ec dependency in lpc_mec
From:   Nick Crews <ncrews@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, sjg@chromium.org, dlaurie@chromium.org,
        Duncan Laurie <dlaurie@google.com>,
        Nick Crews <ncrews@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
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
Signed-off-by: Nick Crews <ncrews@google.com>
---

Changes in v2:
- Fixed kernel-doc comments
- Fixed include of linux/mfd/cros_ec_lpc_mec.h
- cros_ec_lpc_mec_in_range() returns -EINVAL on error
- Added parens around macro variables

 drivers/platform/chrome/cros_ec_lpc_mec.c | 52 +++++++++++++++++++----
 drivers/platform/chrome/cros_ec_lpc_mec.h | 43 ++++++++++---------
 drivers/platform/chrome/cros_ec_lpc_reg.c | 43 ++++++-------------
 3 files changed, 79 insertions(+), 59 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
index c4edfa83e493..36f22aacfeb4 100644
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
+		if (WARN_ON(offset + length - 1 <= mec_emi_end))
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
2.20.1.97.g81188d93c3-goog

