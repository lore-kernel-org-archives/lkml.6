Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeFENaC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:30:02 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:37489 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbeFEN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:29:58 -0400
X-Google-Smtp-Source: ADUXVKKacsC2CTZurrbQkuSU2tudcpeo0l5FG4FmGApmwKUxqgdOuhQE3cWBFZid4mS1hbecT8lq+w==
From: Josef Bacik <josef@toxicpanda.com>
To: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/13] swap,blkcg: issue swap io with the appropriate context
Date: Tue,  5 Jun 2018 09:29:40 -0400
Message-Id: <20180605132948.1664-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605132948.1664-1-josef@toxicpanda.com>
References: <20180605132948.1664-1-josef@toxicpanda.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tejun Heo <tj@kernel.org>

For backcharging we need to know who the page belongs to when swapping
it out.

Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Josef Bacik <jbacik@fb.com>
---
 block/bio.c         | 24 ++++++++++++++++++++++++
 include/linux/bio.h |  7 +++++++
 mm/page_io.c        |  1 +
 3 files changed, 32 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 57c4b1986e76..c77fe1b4caa8 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -2005,6 +2005,30 @@ EXPORT_SYMBOL(bioset_create);
 
 #ifdef CONFIG_BLK_CGROUP
 
+#ifdef CONFIG_MEMCG
+/**
+ * bio_associate_blkcg_from_page - associate a bio with the page's blkcg
+ * @bio: target bio
+ * @page: the page to lookup the blkcg from
+ *
+ * Associate @bio with the blkcg from @page's owning memcg.  This works like
+ * every other associate function wrt references.
+ */
+int bio_associate_blkcg_from_page(struct bio *bio, struct page *page)
+{
+	struct cgroup_subsys_state *blkcg_css;
+
+	if (unlikely(bio->bi_css))
+		return -EBUSY;
+	if (!page->mem_cgroup)
+		return 0;
+	blkcg_css = cgroup_get_e_css(page->mem_cgroup->css.cgroup,
+				     &io_cgrp_subsys);
+	bio->bi_css = blkcg_css;
+	return 0;
+}
+#endif /* CONFIG_MEMCG */
+
 /**
  * bio_associate_blkcg - associate a bio with the specified blkcg
  * @bio: target bio
diff --git a/include/linux/bio.h b/include/linux/bio.h
index f2f3f1428e81..eef1e8877048 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -545,6 +545,13 @@ do {						\
 #define bio_dev(bio) \
 	disk_devt((bio)->bi_disk)
 
+#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
+int bio_associate_blkcg_from_page(struct bio *bio, struct page *page);
+#else
+static inline int bio_associate_blkcg_from_page(struct bio *bio,
+						struct page *page) {  return 0; }
+#endif
+
 #ifdef CONFIG_BLK_CGROUP
 int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
 int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
diff --git a/mm/page_io.c b/mm/page_io.c
index a552cb37e220..aafd19ec1db4 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -339,6 +339,7 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
 		goto out;
 	}
 	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
+	bio_associate_blkcg_from_page(bio, page);
 	count_swpout_vm_event(page);
 	set_page_writeback(page);
 	unlock_page(page);
-- 
2.14.3
