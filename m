Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22571C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCF16248C5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCF16248C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbeGCUE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:04:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45343 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753121AbeGCUCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:02:08 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1faRUu-0001tM-9L; Tue, 03 Jul 2018 22:02:00 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/6] bdi: Use refcount_t for reference counting instead atomic_t
Date:   Tue,  3 Jul 2018 22:01:38 +0200
Message-Id: <20180703200141.28415-4-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180703200141.28415-1-bigeasy@linutronix.de>
References: <20180703200141.28415-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t type and corresponding API should be used instead of atomic_t wh=
en
the variable is used as a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free situations.

Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/backing-dev-defs.h |  3 ++-
 include/linux/backing-dev.h      |  4 ++--
 mm/backing-dev.c                 | 12 ++++++------
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-d=
efs.h
index 24251762c20c..9a6bc0951cfa 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -12,6 +12,7 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 #include <linux/kref.h>
+#include <linux/refcount.h>
=20
 struct page;
 struct device;
@@ -75,7 +76,7 @@ enum wb_reason {
  */
 struct bdi_writeback_congested {
 	unsigned long state;		/* WB_[a]sync_congested flags */
-	atomic_t refcnt;		/* nr of attached wb's and blkg */
+	refcount_t refcnt;		/* nr of attached wb's and blkg */
=20
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct backing_dev_info *__bdi;	/* the associated bdi, set to NULL
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 72ca0f3d39f3..c28a47cbe355 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -404,13 +404,13 @@ static inline bool inode_cgwb_enabled(struct inode *i=
node)
 static inline struct bdi_writeback_congested *
 wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t =
gfp)
 {
-	atomic_inc(&bdi->wb_congested->refcnt);
+	refcount_inc(&bdi->wb_congested->refcnt);
 	return bdi->wb_congested;
 }
=20
 static inline void wb_congested_put(struct bdi_writeback_congested *conges=
ted)
 {
-	if (atomic_dec_and_test(&congested->refcnt))
+	if (refcount_dec_and_test(&congested->refcnt))
 		kfree(congested);
 }
=20
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 2e5d3df0853d..55a233d75f39 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -438,10 +438,10 @@ wb_congested_get_create(struct backing_dev_info *bdi,=
 int blkcg_id, gfp_t gfp)
 	if (new_congested) {
 		/* !found and storage for new one already allocated, insert */
 		congested =3D new_congested;
-		new_congested =3D NULL;
 		rb_link_node(&congested->rb_node, parent, node);
 		rb_insert_color(&congested->rb_node, &bdi->cgwb_congested_tree);
-		goto found;
+		spin_unlock_irqrestore(&cgwb_lock, flags);
+		return congested;
 	}
=20
 	spin_unlock_irqrestore(&cgwb_lock, flags);
@@ -451,13 +451,13 @@ wb_congested_get_create(struct backing_dev_info *bdi,=
 int blkcg_id, gfp_t gfp)
 	if (!new_congested)
 		return NULL;
=20
-	atomic_set(&new_congested->refcnt, 0);
+	refcount_set(&new_congested->refcnt, 1);
 	new_congested->__bdi =3D bdi;
 	new_congested->blkcg_id =3D blkcg_id;
 	goto retry;
=20
 found:
-	atomic_inc(&congested->refcnt);
+	refcount_inc(&congested->refcnt);
 	spin_unlock_irqrestore(&cgwb_lock, flags);
 	kfree(new_congested);
 	return congested;
@@ -474,7 +474,7 @@ void wb_congested_put(struct bdi_writeback_congested *c=
ongested)
 	unsigned long flags;
=20
 	local_irq_save(flags);
-	if (!atomic_dec_and_lock(&congested->refcnt, &cgwb_lock)) {
+	if (!refcount_dec_and_lock(&congested->refcnt, &cgwb_lock)) {
 		local_irq_restore(flags);
 		return;
 	}
@@ -804,7 +804,7 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	if (!bdi->wb_congested)
 		return -ENOMEM;
=20
-	atomic_set(&bdi->wb_congested->refcnt, 1);
+	refcount_set(&bdi->wb_congested->refcnt, 1);
=20
 	err =3D wb_init(&bdi->wb, bdi, 1, GFP_KERNEL);
 	if (err) {
--=20
2.18.0

