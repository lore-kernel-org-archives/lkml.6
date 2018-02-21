Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753374AbeBUJbO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:31:14 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43389 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753294AbeBUJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:17 -0500
X-Google-Smtp-Source: AH8x2278SGj981086rZQn2ov3hVr/Gs6VB8u/jcrfh8OI/ZzAsA8/DU5CIHIq5lHsK6BakPkD689pQ==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 06/20] lightnvm: add shorten OCSSD version in geo
Date: Wed, 21 Feb 2018 10:26:44 +0100
Message-Id: <1519205218-26994-7-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
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
index f22331e61cef..bd97672e0b4f 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -299,6 +299,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	dev_geo->major_ver_id = id->ver_id;
 	dev_geo->minor_ver_id = 2;
 
+	/* Set compacted version for upper layers */
+	dev_geo->c.version = NVM_OCSSD_SPEC_12;
+
 	dev_geo->num_ch = src->num_ch;
 	dev_geo->num_lun = src->num_lun;
 	dev_geo->all_luns = dev_geo->num_ch * dev_geo->num_lun;
@@ -381,6 +384,9 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	dev_geo->major_ver_id = id->mjr;
 	dev_geo->minor_ver_id = id->mnr;
 
+	/* Set compacted version for upper layers */
+	dev_geo->c.version = NVM_OCSSD_SPEC_20;
+
 	if (!(dev_geo->major_ver_id == 2 && dev_geo->minor_ver_id == 0)) {
 		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
 				dev_geo->major_ver_id, dev_geo->minor_ver_id);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 28d429e0a1c9..02f1fd617781 100644
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
@@ -197,6 +202,9 @@ struct nvm_addr_format {
 
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
