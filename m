Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F835C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BDF2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 04:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfAOEYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 23:24:24 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:37460 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfAOEWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 23:22:25 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 08A7129E65; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org
Message-Id: <c458ac4d4300dcbb8956bd13c7e034911603479e.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 05/22] m68k/atari: Implement arch_nvram_ops struct
Date:   Tue, 15 Jan 2019 15:18:56 +1100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By implementing an arch_nvram_ops struct, a platform can re-use the
drivers/char/nvram.c module without needing any arch-specific code
in that module. Atari does so here.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v8:
 - Added static inline wrapper functions to nvram.h.
 - Removed excess whitespace.
 - Renamed functions to avoid collisions with nvram.h wrapper functions.
 - Moved nvram_check_checksum() changes to the preceding patch.
---
 arch/m68k/atari/nvram.c | 49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nvram.h   | 14 ++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/m68k/atari/nvram.c b/arch/m68k/atari/nvram.c
index 1d767847ffa6..e75adebe6e7d 100644
--- a/arch/m68k/atari/nvram.c
+++ b/arch/m68k/atari/nvram.c
@@ -74,6 +74,55 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
+static ssize_t atari_nvram_read(char *buf, size_t count, loff_t *ppos)
+{
+	char *p = buf;
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+	if (!__nvram_check_checksum()) {
+		spin_unlock_irq(&rtc_lock);
+		return -EIO;
+	}
+	for (i = *ppos; count > 0 && i < NVRAM_BYTES; --count, ++i, ++p)
+		*p = __nvram_read_byte(i);
+	spin_unlock_irq(&rtc_lock);
+
+	*ppos = i;
+	return p - buf;
+}
+
+static ssize_t atari_nvram_write(char *buf, size_t count, loff_t *ppos)
+{
+	char *p = buf;
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+	if (!__nvram_check_checksum()) {
+		spin_unlock_irq(&rtc_lock);
+		return -EIO;
+	}
+	for (i = *ppos; count > 0 && i < NVRAM_BYTES; --count, ++i, ++p)
+		__nvram_write_byte(*p, i);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+
+	*ppos = i;
+	return p - buf;
+}
+
+static ssize_t atari_nvram_get_size(void)
+{
+	return NVRAM_BYTES;
+}
+
+const struct nvram_ops arch_nvram_ops = {
+	.read           = atari_nvram_read,
+	.write          = atari_nvram_write,
+	.get_size       = atari_nvram_get_size,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+
 #ifdef CONFIG_PROC_FS
 static struct {
 	unsigned char val;
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index eb5b52a9a747..a1e01dc89759 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -5,8 +5,18 @@
 #include <linux/errno.h>
 #include <uapi/linux/nvram.h>
 
+struct nvram_ops {
+	ssize_t         (*get_size)(void);
+	ssize_t         (*read)(char *, size_t, loff_t *);
+	ssize_t         (*write)(char *, size_t, loff_t *);
+};
+
+extern const struct nvram_ops arch_nvram_ops;
+
 static inline ssize_t nvram_get_size(void)
 {
+	if (arch_nvram_ops.get_size)
+		return arch_nvram_ops.get_size();
 	return -ENODEV;
 }
 
@@ -21,11 +31,15 @@ static inline void nvram_write_byte(unsigned char val, int addr)
 
 static inline ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
 {
+	if (arch_nvram_ops.read)
+		return arch_nvram_ops.read(buf, count, ppos);
 	return -ENODEV;
 }
 
 static inline ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
 {
+	if (arch_nvram_ops.write)
+		return arch_nvram_ops.write(buf, count, ppos);
 	return -ENODEV;
 }
 
-- 
2.19.2

