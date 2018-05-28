Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754370AbeE1JCu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:02:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40104 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754209AbeE1I7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 04:59:15 -0400
X-Google-Smtp-Source: ADUXVKKwmsJV8WHOXs2UQxRYU8DTzyWlfVGHAVEQzbSeTcoTwNJwmuHRPufPmI+CdmUY+uWyBjhcpQ==
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To: axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 19/20] lightnvm: pblk: add possibility to set write buffer size manually
Date: Mon, 28 May 2018 10:58:40 +0200
Message-Id: <20180528085841.26684-20-mb@lightnvm.io>
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

In some cases, users can want set write buffer size manually, e.g. to
adjust it to specific workload. This patch provides the possibility
to set write buffer size via module parameter feature.

Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 0f277744266b..25aa1e73984f 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -20,6 +20,11 @@
 
 #include "pblk.h"
 
+unsigned int write_buffer_size;
+
+module_param(write_buffer_size, uint, 0644);
+MODULE_PARM_DESC(write_buffer_size, "number of entries in a write buffer");
+
 static struct kmem_cache *pblk_ws_cache, *pblk_rec_cache, *pblk_g_rq_cache,
 				*pblk_w_rq_cache;
 static DECLARE_RWSEM(pblk_lock);
@@ -172,10 +177,15 @@ static int pblk_rwb_init(struct pblk *pblk)
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_rb_entry *entries;
-	unsigned long nr_entries;
+	unsigned long nr_entries, buffer_size;
 	unsigned int power_size, power_seg_sz;
 
-	nr_entries = pblk_rb_calculate_size(pblk->pgs_in_buffer);
+	if (write_buffer_size && (write_buffer_size > pblk->pgs_in_buffer))
+		buffer_size = write_buffer_size;
+	else
+		buffer_size = pblk->pgs_in_buffer;
+
+	nr_entries = pblk_rb_calculate_size(buffer_size);
 
 	entries = vzalloc(nr_entries * sizeof(struct pblk_rb_entry));
 	if (!entries)
-- 
2.11.0
