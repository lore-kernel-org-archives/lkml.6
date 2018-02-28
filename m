Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933740AbeB1RKu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:10:50 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35312 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933289AbeB1Pt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:49:57 -0500
X-Google-Smtp-Source: AH8x224GVvOwculpPe5U9VYaBE/U4Jc/NvTbF4fuLq20ktwL9Lx/yCKpAvxk2eT5R1UWSOokBEwAhg==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 08/15] lightnvm: make address conversions depend on generic device
Date: Wed, 28 Feb 2018 16:49:28 +0100
Message-Id: <1519832975-25432-9-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On address conversions, use the generic device, instead of the target
device. This allows to use conversions outside of the target's realm.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c  | 4 ++--
 include/linux/lightnvm.h | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 36d76de22dfc..ed33e0b11788 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -581,7 +581,7 @@ static void nvm_ppa_tgt_to_dev(struct nvm_tgt_dev *tgt_dev,
 
 	for (i = 0; i < nr_ppas; i++) {
 		nvm_map_to_dev(tgt_dev, &ppa_list[i]);
-		ppa_list[i] = generic_to_dev_addr(tgt_dev, ppa_list[i]);
+		ppa_list[i] = generic_to_dev_addr(tgt_dev->parent, ppa_list[i]);
 	}
 }
 
@@ -591,7 +591,7 @@ static void nvm_ppa_dev_to_tgt(struct nvm_tgt_dev *tgt_dev,
 	int i;
 
 	for (i = 0; i < nr_ppas; i++) {
-		ppa_list[i] = dev_to_generic_addr(tgt_dev, ppa_list[i]);
+		ppa_list[i] = dev_to_generic_addr(tgt_dev->parent, ppa_list[i]);
 		nvm_map_to_tgt(tgt_dev, &ppa_list[i]);
 	}
 }
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 73110adf27ad..e878b95aeec4 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -399,10 +399,10 @@ struct nvm_dev {
 	struct list_head targets;
 };
 
-static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
+static inline struct ppa_addr generic_to_dev_addr(struct nvm_dev *dev,
 						  struct ppa_addr r)
 {
-	struct nvm_geo *geo = &tgt_dev->geo;
+	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr l;
 
 	if (geo->version == NVM_OCSSD_SPEC_12) {
@@ -427,10 +427,10 @@ static inline struct ppa_addr generic_to_dev_addr(struct nvm_tgt_dev *tgt_dev,
 	return l;
 }
 
-static inline struct ppa_addr dev_to_generic_addr(struct nvm_tgt_dev *tgt_dev,
+static inline struct ppa_addr dev_to_generic_addr(struct nvm_dev *dev,
 						  struct ppa_addr r)
 {
-	struct nvm_geo *geo = &tgt_dev->geo;
+	struct nvm_geo *geo = &dev->geo;
 	struct ppa_addr l;
 
 	l.ppa = 0;
-- 
2.7.4
