Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932176AbeE1JCz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:02:55 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38872 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754207AbeE1I7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:59:14 -0400
X-Google-Smtp-Source: ADUXVKIvMFGNL9EV0dudj81kJH2Z0L1z3g7fBvCCRFep34sj+50XQ2xae8cv588wvTTe8uiq4WdUJw==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits equals to 0
Date: Mon, 28 May 2018 10:58:39 +0200
Message-Id: <20180528085841.26684-19-mb@lightnvm.io>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180528085841.26684-1-mb@lightnvm.io>
References: <20180528085841.26684-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>

Some devices can expose mw_cunits equal to 0, it can cause creation
of too small write buffer and cause performance to drop on write
workloads.

To handle that, we use the default value for MLC and beacause it
covers both 1.2 and 2.0 OC specification, setting up mw_cunits
in nvme_nvm_setup_12 function isn't longer necessary.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 10 +++++++++-
 drivers/nvme/host/lightnvm.c |  1 -
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index d65d2f972ccf..0f277744266b 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -356,7 +356,15 @@ static int pblk_core_init(struct pblk *pblk)
 	atomic64_set(&pblk->nr_flush, 0);
 	pblk->nr_flush_rst = 0;
 
-	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
+	if (geo->mw_cunits) {
+		pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
+	} else {
+		pblk->pgs_in_buffer = (geo->ws_opt << 3) * geo->all_luns;
+		/*
+		 * Some devices can expose mw_cunits equal to 0, so let's use
+		 * here default safe value for MLC.
+		 */
+	}
 
 	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
 	max_write_ppas = pblk->min_write_pgs * geo->all_luns;
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 41279da799ed..c747792da915 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -338,7 +338,6 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 
 	geo->ws_min = sec_per_pg;
 	geo->ws_opt = sec_per_pg;
-	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC safe values */
 
 	/* Do not impose values for maximum number of open blocks as it is
 	 * unspecified in 1.2. Users of 1.2 must be aware of this and eventually
-- 
2.11.0
