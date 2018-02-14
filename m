Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030413AbeBNOTO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:19:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030288AbeBNOTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:19:10 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, slp@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v14 5/9] fw_cfg: fix sparse warning reading FW_CFG_ID
Date: Wed, 14 Feb 2018 15:18:46 +0100
Message-Id: <20180214141850.4017-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180214141850.4017-1-marcandre.lureau@redhat.com>
References: <20180214141850.4017-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a restricted type for reading FW_CFG_ID, fixing sparse warning:

drivers/firmware/qemu_fw_cfg.c:540:22: warning: cast to restricted __le32

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 8ad19086e5c5..4c4813409447 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -511,6 +511,7 @@ static inline void fw_cfg_kobj_cleanup(struct kobject *kobj)
 static int fw_cfg_sysfs_probe(struct platform_device *pdev)
 {
 	int err;
+	__le32 rev;
 
 	/* NOTE: If we supported multiple fw_cfg devices, we'd first create
 	 * a subdirectory named after e.g. pdev->id, then hang per-device
@@ -536,8 +537,8 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
 		goto err_probe;
 
 	/* get revision number, add matching top-level attribute */
-	fw_cfg_read_blob(FW_CFG_ID, &fw_cfg_rev, 0, sizeof(fw_cfg_rev));
-	fw_cfg_rev = le32_to_cpu(fw_cfg_rev);
+	fw_cfg_read_blob(FW_CFG_ID, &rev, 0, sizeof(rev));
+	fw_cfg_rev = le32_to_cpu(rev);
 	err = sysfs_create_file(fw_cfg_top_ko, &fw_cfg_rev_attr.attr);
 	if (err)
 		goto err_rev;
-- 
2.16.1.73.g5832b7e9f2
