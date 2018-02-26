Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753603AbeBZNXz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:23:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35491 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeBZNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:17:31 -0500
X-Google-Smtp-Source: AH8x226gqFO57LWVbiUXZv7fIAhrIWotobX25sO+VISLy4dDaPe+wuQsG7Lz0n68rc8PV1UqGMNekw==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 04/19] lightnvm: add shorten OCSSD version in geo
Date: Mon, 26 Feb 2018 14:17:03 +0100
Message-Id: <1519651038-16845-5-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a shorten version to use in the generic geometry.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 6 ++++++
 include/linux/lightnvm.h     | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8befb60eeacb..a48950a37b8d 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -299,6 +299,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	dev_geo->major_ver_id = id->ver_id;
 	dev_geo->minor_ver_id = 2;
 
+	/* Set compacted version for upper layers */
+	dev_geo->c.version = NVM_OCSSD_SPEC_12;
+
 	dev_geo->nr_chnls = src->num_ch;
 	dev_geo->nr_luns = src->num_lun;
 	dev_geo->all_luns = dev_geo->nr_chnls * dev_geo->nr_luns;
@@ -385,6 +388,9 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	dev_geo->major_ver_id = id->mjr;
 	dev_geo->minor_ver_id = id->mnr;
 
+	/* Set compacted version for upper layers */
+	dev_geo->c.version = NVM_OCSSD_SPEC_20;
+
 	if (!(dev_geo->major_ver_id == 2 && dev_geo->minor_ver_id == 0)) {
 		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
 				dev_geo->major_ver_id, dev_geo->minor_ver_id);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index ccaf8a30202d..57d00644a1c6 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -23,6 +23,11 @@ enum {
 #define NVM_LUN_BITS (8)
 #define NVM_CH_BITS  (7)
 
+enum {
+	NVM_OCSSD_SPEC_12 = 12,
+	NVM_OCSSD_SPEC_20 = 20,
+};
+
 struct ppa_addr {
 	/* Generic structure for all addresses */
 	union {
@@ -262,6 +267,9 @@ enum {
 
 /* Device common geometry */
 struct nvm_common_geo {
+	/* kernel short version */
+	u8	version;
+
 	/* chunk geometry */
 	u32	num_chk;	/* chunks per lun */
 	u32	clba;		/* sectors per chunk */
-- 
2.7.4
