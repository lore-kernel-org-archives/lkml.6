Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163429AbeBOVdn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:33:43 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163344AbeBOVdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:33:41 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: slp@redhat.com, bhe@redhat.com, mst@redhat.com, somlo@cmu.edu,
        xiaolong.ye@intel.com,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v15 06/11] fw_cfg: fix sparse warnings around FW_CFG_FILE_DIR read
Date: Thu, 15 Feb 2018 22:33:07 +0100
Message-Id: <20180215213312.29234-7-marcandre.lureau@redhat.com>
In-Reply-To: <20180215213312.29234-1-marcandre.lureau@redhat.com>
References: <20180215213312.29234-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use struct fw_cfg_files to read the directory size, fixing the sparse
warnings:

drivers/firmware/qemu_fw_cfg.c:485:17: warning: cast to restricted __be32

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 71672cb8c427..805372e8e50d 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -478,19 +478,20 @@ static int fw_cfg_register_file(const struct fw_cfg_file *f)
 static int fw_cfg_register_dir_entries(void)
 {
 	int ret = 0;
+	__be32 files_count;
 	u32 count, i;
 	struct fw_cfg_file *dir;
 	size_t dir_size;
 
-	fw_cfg_read_blob(FW_CFG_FILE_DIR, &count, 0, sizeof(count));
-	count = be32_to_cpu(count);
+	fw_cfg_read_blob(FW_CFG_FILE_DIR, &files_count, 0, sizeof(files_count));
+	count = be32_to_cpu(files_count);
 	dir_size = count * sizeof(struct fw_cfg_file);
 
 	dir = kmalloc(dir_size, GFP_KERNEL);
 	if (!dir)
 		return -ENOMEM;
 
-	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(count), dir_size);
+	fw_cfg_read_blob(FW_CFG_FILE_DIR, dir, sizeof(files_count), dir_size);
 
 	for (i = 0; i < count; i++) {
 		ret = fw_cfg_register_file(&dir[i]);
-- 
2.16.1.73.g5832b7e9f2
