Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163274AbeBOVdc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:33:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1162678AbeBOVda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:33:30 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v15 03/11] fw_cfg: fix sparse warnings in fw_cfg_sel_endianness()
Date: Thu, 15 Feb 2018 22:33:04 +0100
Message-Id: <20180215213312.29234-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180215213312.29234-1-marcandre.lureau@redhat.com>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dispatch to the appropriate iowrite() instead of casting restricted
type to u16.

- if fw_cfg_is_mmio:
  before: iowrite16(cpu_to_be16(key))
  after: iowrite16be(key)
- if !fw_cfg_is_mmio:
  before: iowrite16(cpu_to_le16(key))
  after: iowrite16(key)
  which is equivalent on little-endian systems, where fw_cfg IO is supported.

Fixes:
$ make C=1 CF=-D__CHECK_ENDIAN__ drivers/firmware/qemu_fw_cfg.o

drivers/firmware/qemu_fw_cfg.c:55:33: warning: restricted __be16 degrades to integer
drivers/firmware/qemu_fw_cfg.c:55:52: warning: restricted __le16 degrades to integer

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 42601a3eaed5..6164731a3c35 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -50,9 +50,12 @@ static void __iomem *fw_cfg_reg_data;
 static DEFINE_MUTEX(fw_cfg_dev_lock);
 
 /* pick appropriate endianness for selector key */
-static inline u16 fw_cfg_sel_endianness(u16 key)
+static void fw_cfg_sel_endianness(u16 key)
 {
-	return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
+	if (fw_cfg_is_mmio)
+		iowrite16be(key, fw_cfg_reg_ctrl);
+	else
+		iowrite16(key, fw_cfg_reg_ctrl);
 }
 
 /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
@@ -74,7 +77,7 @@ static inline void fw_cfg_read_blob(u16 key,
 	}
 
 	mutex_lock(&fw_cfg_dev_lock);
-	iowrite16(fw_cfg_sel_endianness(key), fw_cfg_reg_ctrl);
+	fw_cfg_sel_endianness(key);
 	while (pos-- > 0)
 		ioread8(fw_cfg_reg_data);
 	ioread8_rep(fw_cfg_reg_data, buf, count);
-- 
2.16.1.73.g5832b7e9f2
