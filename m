Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeB1RNj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:13:39 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40008 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752856AbeB1Ptu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:49:50 -0500
X-Google-Smtp-Source: AG47ELsgrZzbAn7DMYLZ9gtDy/VgsNfKE8x/45gj3l5RZHErEpb0jhKh2gfqbzabgB76peVu5zdWBQ==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 02/15] lightnvm: add controller capabilities to 2.0
Date: Wed, 28 Feb 2018 16:49:22 +0100
Message-Id: <1519832975-25432-3-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
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
index e276ace28c64..5b2024ebac76 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -318,7 +318,7 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	geo->ws_opt = sec_per_pg;
 	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC safe values */
 
-	geo->mccap = le32_to_cpu(src->mccap);
+	geo->cap = le32_to_cpu(src->mccap);
 
 	geo->trdt = le32_to_cpu(src->trdt);
 	geo->trdm = le32_to_cpu(src->trdm);
@@ -396,6 +396,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	geo->ws_opt = le32_to_cpu(id->ws_opt);
 	geo->mw_cunits = le32_to_cpu(id->mw_cunits);
 
+	geo->cap = le32_to_cpu(id->mccap);
+
 	geo->trdt = le32_to_cpu(id->trdt);
 	geo->trdm = le32_to_cpu(id->trdm);
 	geo->tprt = le32_to_cpu(id->twrt);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 16255fcd5250..b9f0d2070de9 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -288,8 +288,10 @@ struct nvm_geo {
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
@@ -304,7 +306,7 @@ struct nvm_geo {
 
 	/* 1.2 compatibility */
 	u8	vmnt;
-	u32	cap;
+	u32	mccap;
 	u32	dom;
 
 	u8	mtype;
-- 
2.7.4
