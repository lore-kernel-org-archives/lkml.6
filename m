Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753654AbeBZNYF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:24:05 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52437 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbeBZNR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:17:29 -0500
X-Google-Smtp-Source: AH8x226+0OkZkGFrTNxrB82o/cVQpqXQ+UaylFr5kYLDEjQzVsdHm5lxMb8Q7PDaVMnw3aR6DbXHdQ==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 02/19] lightnvm: add controller capabilities to 2.0
Date: Mon, 26 Feb 2018 14:17:01 +0100
Message-Id: <1519651038-16845-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign missing mccap value on 2.0 path

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 4 +++-
 include/linux/lightnvm.h     | 8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8f541331b1a9..10392a664b50 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -318,7 +318,7 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	dev_geo->c.ws_opt = sec_per_pg;
 	dev_geo->c.mw_cunits = 8;		/* default to MLC safe values */
 
-	dev_geo->c.mccap = le32_to_cpu(src->mccap);
+	dev_geo->c.cap = le32_to_cpu(src->mccap);
 
 	dev_geo->c.trdt = le32_to_cpu(src->trdt);
 	dev_geo->c.trdm = le32_to_cpu(src->trdm);
@@ -399,6 +399,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	dev_geo->c.ws_opt = le32_to_cpu(id->ws_opt);
 	dev_geo->c.mw_cunits = le32_to_cpu(id->mw_cunits);
 
+	dev_geo->c.cap = le32_to_cpu(id->mccap);
+
 	dev_geo->c.trdt = le32_to_cpu(id->trdt);
 	dev_geo->c.trdm = le32_to_cpu(id->trdm);
 	dev_geo->c.tprt = le32_to_cpu(id->twrt);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 4537c0140386..42704c4ca9af 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -273,8 +273,10 @@ struct nvm_common_geo {
 	u32	ws_opt;		/* optimal write size */
 	u32	mw_cunits;	/* distance required for successful read */
 
-	/* device capabilities */
-	u32	mccap;
+	/* device capabilities. Note that this represents capabilities in 1.2
+	 * and media and controller capabilities in 2.0
+	 */
+	u32	cap;
 
 	/* device timings */
 	u32	trdt;		/* Avg. Tread (ns) */
@@ -289,7 +291,7 @@ struct nvm_common_geo {
 
 	/* 1.2 compatibility */
 	u8	vmnt;
-	u32	cap;
+	u32	mccap;
 	u32	dom;
 
 	u8	mtype;
-- 
2.7.4
