Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752823AbeC2WHq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 18:07:46 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35982 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeC2WHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 18:07:43 -0400
X-Google-Smtp-Source: AIpwx49NX3YJe3vRn3Ug75tkLXMNzwUZXTCz5jLzUW/myRBbV7XFv0+32EhWDSOXcwS+Df27frzZdw==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, javier@cnexlabs.com,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 35/37] lightnvm: pblk: don't recover unwritten lines
Date: Fri, 30 Mar 2018 00:05:22 +0200
Message-Id: <20180329220524.30363-36-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180329220524.30363-1-mb@lightnvm.io>
References: <20180329220524.30363-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

If the line has not been written to, we should not
try to recover any data from it, so check the state of the
chunks in the line before attempting to read smeta.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-recovery.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 26356429dc72..3e079c2afa6e 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -864,6 +864,21 @@ static void pblk_recov_wa_counters(struct pblk *pblk,
 	}
 }
 
+static int pblk_line_was_written(struct pblk_line *line,
+			    struct pblk_line_meta *lm)
+{
+
+	int i;
+	int state_mask = NVM_CHK_ST_OFFLINE | NVM_CHK_ST_FREE;
+
+	for (i = 0; i < lm->blk_per_line; i++) {
+		if (!(line->chks[i].state & state_mask))
+			return 1;
+	}
+
+	return 0;
+}
+
 struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 {
 	struct pblk_line_meta *lm = &pblk->lm;
@@ -900,6 +915,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 		line->lun_bitmap = ((void *)(smeta_buf)) +
 						sizeof(struct line_smeta);
 
+		if (!pblk_line_was_written(line, lm))
+			continue;
+
 		/* Lines that cannot be read are assumed as not written here */
 		if (pblk_line_read_smeta(pblk, line))
 			continue;
-- 
2.11.0
