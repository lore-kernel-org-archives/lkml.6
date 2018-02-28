Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933395AbeB1RJr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:09:47 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51746 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933621AbeB1Pt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:49:59 -0500
X-Google-Smtp-Source: AG47ELtcBqFi3ce2kT2xf3Ci6o2gyoDCKLGv+wmnnxmAam0+9gwz7J7PT5l5d2HrO+oZrMJoSFYpow==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 10/15] lightnvm: pblk: check for supported version
Date: Wed, 28 Feb 2018 16:49:30 +0100
Message-Id: <1519832975-25432-11-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this point, only 1.2 spec is supported, thus check for it. Also,
since device-side L2P is only supported in the 1.2 spec, make sure to
only check its value under 1.2.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 11424beb214c..b67b5b11ae16 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -991,9 +991,15 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	struct pblk *pblk;
 	int ret;
 
-	if (dev->geo.dom & NVM_RSP_L2P) {
+	if (geo->version != NVM_OCSSD_SPEC_12) {
+		pr_err("pblk: OCSSD version not supported (%u)\n",
+							geo->version);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (geo->version == NVM_OCSSD_SPEC_12 && geo->dom & NVM_RSP_L2P) {
 		pr_err("pblk: host-side L2P table not supported. (%x)\n",
-							dev->geo.dom);
+							geo->dom);
 		return ERR_PTR(-EINVAL);
 	}
 
-- 
2.7.4
