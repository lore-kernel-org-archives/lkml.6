Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932246AbeB1NeP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 08:34:15 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:57295 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932185AbeB1NeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 08:34:13 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Vasyl Gomonovych <gomonovych@gmail.com>, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fw_cfg: avoid unused function warning
Date: Wed, 28 Feb 2018 14:33:49 +0100
Message-Id: <20180228133357.1848600-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:BrHYVvR3dpn9WUCBjSId6/kWQbpReZhJFSRN6/W1vAwWdFj76zf
 0aElZkGPffnu3N+WdN4/K27U3gE5DD50GbKfuZXosBlL1mJh+eIMEw+OzoCmSIq6rxFT1Kd
 0TS5xO1d6IAGalcczNwhjq88bPjQU1xbyn1uBHTthejnU1p0sMQpUVlFs7XIE7Upzh8dasj
 3h/vYKieFX6sypHruofAQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TFXL65DSNA8=:RDj2BYfaHk0THwxjYA6rC7
 GpxdJ1T2QWo3fI65tPK5kdT+boEf95NNi8sF6QRpSf06yV8SX6uxSjyvMM/gv9zNw/xnNFOTD
 US68SrF9Dy0rzxyfmRMx8M8i9l394DpC0a34fhS0f8Bq2ttLcdiBj6TaDzYVh4mf6qd5ndKst
 OvqTyC4Iy9tymhp8EwNxn/3tlwc7NQWb/gCLldw/JvkAcdHwwpz6cG8cfaBC45RhJrfi7w+aD
 vIz+odm2J/5L/zKtRpafcV1J8nFWqHimcwa19gVRr9k8CoZecjxcGqUGe1azXgiQ8uAZ8FBDX
 nr3L2jxUAkHRBRDmXI4HrM3rHThvsnQnF6Ya1mR9tnvhAR+kGw5JL3fWvgNb7ni1ONDWz/HLk
 EIalgFH59yzbyrBO7PGUFsuEhIVKofnI9mPtSyAj38L8syoNLHXYnbu9A+8/5udahqw5om0zM
 9DeIEOYg63xQNPRCToHaLwSo6Igik4203cNSHwHhjUKTFqiEgO749bxcG1mpCcclQ+ikW07+T
 NWwlHGxycua2J9BJND95eIpP03Q2H7jfDVWVxU4u8YQYfYdaZgt1z+r1V25eg2caliKXOBNsR
 b2excilWmXNgYW07QkUwnuGhNnsugvp12y8I52xu3FWa1wQ+8kvYXSE/vmfT6Ck0A16ta++Kf
 eKqpcCbrbcfKA0QlMFL81y1eDFpocCPZFxqL2i49u4kG7aEUw6hNc0CFSdyWRQ9Zn9lGDvl9c
 +Ls6wTPqx8Jw3haVxlwc2EHGr3+dtgMWxOWmDg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly introduced fw_cfg_dma_transfer() function is unused when
CONFIG_CRASH_CORE is disabled:

drivers/firmware/qemu_fw_cfg.c:89:16: error: 'fw_cfg_dma_transfer' defined but not used [-Werror=unused-function]
 static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)

This moves it into the #ifdef section that hides its caller to avoid the
warning.

Fixes: 47e78bfb5426 ("fw_cfg: write vmcoreinfo details")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/qemu_fw_cfg.c | 60 +++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 3015e77aebca..f002bb40519b 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -66,6 +66,36 @@ static void fw_cfg_sel_endianness(u16 key)
 		iowrite16(key, fw_cfg_reg_ctrl);
 }
 
+/* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
+static ssize_t fw_cfg_read_blob(u16 key,
+				void *buf, loff_t pos, size_t count)
+{
+	u32 glk = -1U;
+	acpi_status status;
+
+	/* If we have ACPI, ensure mutual exclusion against any potential
+	 * device access by the firmware, e.g. via AML methods:
+	 */
+	status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
+	if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
+		/* Should never get here */
+		WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
+		memset(buf, 0, count);
+		return -EINVAL;
+	}
+
+	mutex_lock(&fw_cfg_dev_lock);
+	fw_cfg_sel_endianness(key);
+	while (pos-- > 0)
+		ioread8(fw_cfg_reg_data);
+	ioread8_rep(fw_cfg_reg_data, buf, count);
+	mutex_unlock(&fw_cfg_dev_lock);
+
+	acpi_release_global_lock(glk);
+	return count;
+}
+
+#ifdef CONFIG_CRASH_CORE
 static inline bool fw_cfg_dma_enabled(void)
 {
 	return (fw_cfg_rev & FW_CFG_VERSION_DMA) && fw_cfg_reg_dma;
@@ -124,36 +154,6 @@ static ssize_t fw_cfg_dma_transfer(void *address, u32 length, u32 control)
 	return ret;
 }
 
-/* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
-static ssize_t fw_cfg_read_blob(u16 key,
-				void *buf, loff_t pos, size_t count)
-{
-	u32 glk = -1U;
-	acpi_status status;
-
-	/* If we have ACPI, ensure mutual exclusion against any potential
-	 * device access by the firmware, e.g. via AML methods:
-	 */
-	status = acpi_acquire_global_lock(ACPI_WAIT_FOREVER, &glk);
-	if (ACPI_FAILURE(status) && status != AE_NOT_CONFIGURED) {
-		/* Should never get here */
-		WARN(1, "fw_cfg_read_blob: Failed to lock ACPI!\n");
-		memset(buf, 0, count);
-		return -EINVAL;
-	}
-
-	mutex_lock(&fw_cfg_dev_lock);
-	fw_cfg_sel_endianness(key);
-	while (pos-- > 0)
-		ioread8(fw_cfg_reg_data);
-	ioread8_rep(fw_cfg_reg_data, buf, count);
-	mutex_unlock(&fw_cfg_dev_lock);
-
-	acpi_release_global_lock(glk);
-	return count;
-}
-
-#ifdef CONFIG_CRASH_CORE
 /* write chunk of given fw_cfg blob (caller responsible for sanity-check) */
 static ssize_t fw_cfg_write_blob(u16 key,
 				 void *buf, loff_t pos, size_t count)
-- 
2.9.0
