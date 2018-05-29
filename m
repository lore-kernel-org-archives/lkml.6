Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967574AbeE2VUa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:20:30 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41029 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967178AbeE2VRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:17:35 -0400
X-Google-Smtp-Source: ADUXVKJeWmMLx5ZuE+IcTSuh3RBDVubhd3d+6lx7Q/yHSizuSngCDVAPYfAevChwgZtdVduNU7tBsQ==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/13] swap,blkcg: issue swap io with the appropriate context
Date: Tue, 29 May 2018 17:17:16 -0400
Message-Id: <20180529211724.4531-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180529211724.4531-1-josef@toxicpanda.com>
References: <20180529211724.4531-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

For backcharging we need to know who the page belongs to when swapping
it out.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 mm/page_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/page_io.c b/mm/page_io.c
index a552cb37e220..61e1268e5dbc 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -339,6 +339,16 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		goto out;
 	}
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
+#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
+	if (page->mem_cgroup) {
+		struct cgroup_subsys_state *blkcg_css;
+
+		blkcg_css = cgroup_get_e_css(page->mem_cgroup->css.cgroup,
+					     &io_cgrp_subsys);
+		bio_associate_blkcg(bio, blkcg_css);
+		css_put(blkcg_css);
+	}
+#endif
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.14.3
