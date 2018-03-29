Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeC2WIt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:08:49 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35974 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeC2WHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:39 -0400
X-Google-Smtp-Source: AIpwx48s6VrYWHLSDrQ1sY5mLcFsIq+i46lezsPdWTjrJZkT+lurgXD59Lt/krui2bq0Lv3Pb1qayg==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 31/37] lightnvm: pblk: check for supported version
Date: Fri, 30 Mar 2018 00:05:18 +0200
Message-Id: <20180329220524.30363-32-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@cnexlabs.com>

At this point, only 1.2 spec is supported, thus check for it. Also,
since device-side L2P is only supported in the 1.2 spec, make sure to
only check its value under 1.2.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 4656d1ff81a6..34ff47705293 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1016,9 +1016,15 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
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
2.11.0
