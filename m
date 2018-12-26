Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6ECC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484192148E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 00:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbeLZApD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 19:45:03 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57382 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeLZAoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 19:44:01 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id F11482952A; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <c0ac6246160312a47407110bb7edb357df1c62d2.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 21/25] nvram: Drop nvram_* symbol exports and prototypes
Date:   Wed, 26 Dec 2018 11:37:59 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers now use the arch_nvram_ops calls so remove the function exports and
prototypes. nvram_check_checksum() is unused so remove it.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/atari/nvram.c |  6 +++---
 drivers/char/nvram.c    | 27 +++++----------------------
 include/linux/nvram.h   |  8 --------
 3 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/arch/m68k/atari/nvram.c b/arch/m68k/atari/nvram.c
index 0a6fe59c95e8..2906743f0da3 100644
--- a/arch/m68k/atari/nvram.c
+++ b/arch/m68k/atari/nvram.c
@@ -34,13 +34,13 @@
  * periodic 11 min sync from kernel/time/ntp.c vs. this driver.)
  */
 
-unsigned char __nvram_read_byte(int i)
+static unsigned char __nvram_read_byte(int i)
 {
 	return CMOS_READ(NVRAM_FIRST_BYTE + i);
 }
 
 /* This races nicely with trying to read with checksum checking */
-void __nvram_write_byte(unsigned char c, int i)
+static void __nvram_write_byte(unsigned char c, int i)
 {
 	CMOS_WRITE(c, NVRAM_FIRST_BYTE + i);
 }
@@ -52,7 +52,7 @@ void __nvram_write_byte(unsigned char c, int i)
 #define ATARI_CKS_RANGE_END	47
 #define ATARI_CKS_LOC		48
 
-int __nvram_check_checksum(void)
+static int __nvram_check_checksum(void)
 {
 	int i;
 	unsigned char sum = 0;
diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 466e1fb02052..8339885e8e9b 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -81,13 +81,12 @@ static ssize_t nvram_size;
  * periodic 11 min sync from kernel/time/ntp.c vs. this driver.)
  */
 
-unsigned char __nvram_read_byte(int i)
+static unsigned char __nvram_read_byte(int i)
 {
 	return CMOS_READ(NVRAM_FIRST_BYTE + i);
 }
-EXPORT_SYMBOL(__nvram_read_byte);
 
-unsigned char nvram_read_byte(int i)
+static unsigned char nvram_read_byte(int i)
 {
 	unsigned long flags;
 	unsigned char c;
@@ -97,16 +96,14 @@ unsigned char nvram_read_byte(int i)
 	spin_unlock_irqrestore(&rtc_lock, flags);
 	return c;
 }
-EXPORT_SYMBOL(nvram_read_byte);
 
 /* This races nicely with trying to read with checksum checking (nvram_read) */
-void __nvram_write_byte(unsigned char c, int i)
+static void __nvram_write_byte(unsigned char c, int i)
 {
 	CMOS_WRITE(c, NVRAM_FIRST_BYTE + i);
 }
-EXPORT_SYMBOL(__nvram_write_byte);
 
-void nvram_write_byte(unsigned char c, int i)
+static void nvram_write_byte(unsigned char c, int i)
 {
 	unsigned long flags;
 
@@ -114,14 +111,13 @@ void nvram_write_byte(unsigned char c, int i)
 	__nvram_write_byte(c, i);
 	spin_unlock_irqrestore(&rtc_lock, flags);
 }
-EXPORT_SYMBOL(nvram_write_byte);
 
 /* On PCs, the checksum is built only over bytes 2..31 */
 #define PC_CKS_RANGE_START	2
 #define PC_CKS_RANGE_END	31
 #define PC_CKS_LOC		32
 
-int __nvram_check_checksum(void)
+static int __nvram_check_checksum(void)
 {
 	int i;
 	unsigned short sum = 0;
@@ -133,19 +129,6 @@ int __nvram_check_checksum(void)
 	    __nvram_read_byte(PC_CKS_LOC+1);
 	return (sum & 0xffff) == expect;
 }
-EXPORT_SYMBOL(__nvram_check_checksum);
-
-int nvram_check_checksum(void)
-{
-	unsigned long flags;
-	int rv;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	rv = __nvram_check_checksum();
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	return rv;
-}
-EXPORT_SYMBOL(nvram_check_checksum);
 
 static void __nvram_set_checksum(void)
 {
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index 24a57675dba1..251472f1b2bd 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -4,14 +4,6 @@
 
 #include <uapi/linux/nvram.h>
 
-/* __foo is foo without grabbing the rtc_lock - get it yourself */
-extern unsigned char __nvram_read_byte(int i);
-extern unsigned char nvram_read_byte(int i);
-extern void __nvram_write_byte(unsigned char c, int i);
-extern void nvram_write_byte(unsigned char c, int i);
-extern int __nvram_check_checksum(void);
-extern int nvram_check_checksum(void);
-
 struct nvram_ops {
 	ssize_t         (*read)(char *, size_t, loff_t *);
 	ssize_t         (*write)(char *, size_t, loff_t *);
-- 
2.19.2

