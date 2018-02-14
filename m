Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030734AbeBNOVQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:21:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030578AbeBNOS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:18:57 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, slp@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v14 3/9] fw_cfg: fix sparse warnings in fw_cfg_sel_endianness()
Date: Wed, 14 Feb 2018 15:18:44 +0100
Message-Id: <20180214141850.4017-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180214141850.4017-1-marcandre.lureau@redhat.com>
References: <20180214141850.4017-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function is used for both LE & BE target type, use __force casting.

Fixes:
$ make C=1 CF=-D__CHECK_ENDIAN__ drivers/firmware/qemu_fw_cfg.o

drivers/firmware/qemu_fw_cfg.c:55:33: warning: restricted __be16 degrades to integer
drivers/firmware/qemu_fw_cfg.c:55:52: warning: restricted __le16 degrades to integer

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 90f467232777..85e693287d87 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -52,7 +52,9 @@ static DEFINE_MUTEX(fw_cfg_dev_lock);
 /* pick appropriate endianness for selector key */
 static inline u16 fw_cfg_sel_endianness(u16 key)
 {
-	return fw_cfg_is_mmio ? cpu_to_be16(key) : cpu_to_le16(key);
+	return fw_cfg_is_mmio ?
+		(u16 __force)cpu_to_be16(key) :
+		(u16 __force)cpu_to_le16(key);
 }
 
 /* read chunk of given fw_cfg blob (caller responsible for sanity-check) */
-- 
2.16.1.73.g5832b7e9f2
