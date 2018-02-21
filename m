Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeBUJbK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:31:10 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41954 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753308AbeBUJ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:27:19 -0500
X-Google-Smtp-Source: AH8x2240ZiHef8chma8RV0L+qkhNuuymkjI5ewpSZKOf7JYXflO0pjW564Ucm/OOIGpHPk3hnyZtfw==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
Date: Wed, 21 Feb 2018 10:26:46 +0100
Message-Id: <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Complete the generic geometry structure with the maxoc and maxocpu
felds, present in the 2.0 spec.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/nvme/host/lightnvm.c | 4 ++++
 include/linux/lightnvm.h     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index cca32da05316..9c1f8225c4e1 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 	dev_geo->c.ws_min = sec_per_pg;
 	dev_geo->c.ws_opt = sec_per_pg;
 	dev_geo->c.mw_cunits = 8;		/* default to MLC safe values */
+	dev_geo->c.maxoc = dev_geo->all_luns;	/* default to 1 chunk per LUN */
+	dev_geo->c.maxocpu = 1;			/* default to 1 chunk per LUN */
 
 	dev_geo->c.mccap = le32_to_cpu(src->mccap);
 
@@ -405,6 +407,8 @@ static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 	dev_geo->c.ws_min = le32_to_cpu(id->ws_min);
 	dev_geo->c.ws_opt = le32_to_cpu(id->ws_opt);
 	dev_geo->c.mw_cunits = le32_to_cpu(id->mw_cunits);
+	dev_geo->c.maxoc = le32_to_cpu(id->maxoc);
+	dev_geo->c.maxocpu = le32_to_cpu(id->maxocpu);
 
 	dev_geo->c.mccap = le32_to_cpu(id->mccap);
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index ccc5faa63cb7..e1c4292ea33d 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -215,6 +215,8 @@ struct nvm_common_geo {
 	u32	ws_min;		/* minimum write size */
 	u32	ws_opt;		/* optimal write size */
 	u32	mw_cunits;	/* distance required for successful read */
+	u32	maxoc;		/* maximum open chunks */
+	u32	maxocpu;	/* maximum open chunks per parallel unit */
 
 	/* device capabilities */
 	u32	mccap;
-- 
2.7.4
