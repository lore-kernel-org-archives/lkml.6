Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167424AbeBOVfF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:35:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54022 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163332AbeBOVdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:33:39 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v15 05/11] fw_cfg: fix sparse warning reading FW_CFG_ID
Date: Thu, 15 Feb 2018 22:33:06 +0100
Message-Id: <20180215213312.29234-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180215213312.29234-1-marcandre.lureau@redhat.com>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
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
index 6ee12c9e079a..71672cb8c427 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -512,6 +512,7 @@ static inline void fw_cfg_kobj_cleanup(struct kobject *kobj)
 static int fw_cfg_sysfs_probe(struct platform_device *pdev)
 {
 	int err;
+	__le32 rev;
 
 	/* NOTE: If we supported multiple fw_cfg devices, we'd first create
 	 * a subdirectory named after e.g. pdev->id, then hang per-device
@@ -537,8 +538,8 @@ static int fw_cfg_sysfs_probe(struct platform_device *pdev)
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
