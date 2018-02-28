Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbeB1PuB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 10:50:01 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40015 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752884AbeB1Ptw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:49:52 -0500
X-Google-Smtp-Source: AG47ELtfYIZtWol3Sgf9Hb1iPglOQLVa1ocuwk5KHm+F0gbNqnPef+gYdv0OfqU8TnfWk8AJmN44jQ==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 04/15] lightnvm: add shorten OCSSD version in geo
Date: Wed, 28 Feb 2018 16:49:24 +0100
Message-Id: <1519832975-25432-5-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
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
index a600e70b6e6b..85f336a79cda 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -299,6 +299,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	geo->major_ver_id = id->ver_id;
 	geo->minor_ver_id = 2;
 
+	/* Set compacted version for upper layers */
+	geo->version = NVM_OCSSD_SPEC_12;
+
 	geo->nr_chnls = src->num_ch;
 	geo->nr_luns = src->num_lun;
 	geo->all_luns = geo->nr_chnls * geo->nr_luns;
@@ -385,6 +388,9 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	geo->major_ver_id = id->mjr;
 	geo->minor_ver_id = id->mnr;
 
+	/* Set compacted version for upper layers */
+	geo->version = NVM_OCSSD_SPEC_20;
+
 	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
 		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
 				geo->major_ver_id, geo->minor_ver_id);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 4b2ecbf45fd9..b8bc158a2472 100644
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
@@ -266,6 +271,9 @@ struct nvm_geo {
 	u8	major_ver_id;
 	u8	minor_ver_id;
 
+	/* kernel short version */
+	u8	version;
+
 	/* instance specific geometry */
 	int nr_chnls;
 	int nr_luns;		/* per channel */
-- 
2.7.4
