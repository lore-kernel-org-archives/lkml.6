Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932555AbeCOShP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:37:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752117AbeCOShM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:37:12 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 3/4] mm/hmm: HMM should have a callback before MM is destroyed
Date: Thu, 15 Mar 2018 14:36:59 -0400
Message-Id: <20180315183700.3843-4-jglisse@redhat.com>
In-Reply-To: <20180315183700.3843-1-jglisse@redhat.com>
References: <20180315183700.3843-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

The hmm_mirror_register() function registers a callback for when
the CPU pagetable is modified. Normally, the device driver will
call hmm_mirror_unregister() when the process using the device is
finished. However, if the process exits uncleanly, the struct_mm
can be destroyed with no warning to the device driver.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/hmm.h | 10 ++++++++++
 mm/hmm.c            | 20 +++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index ef6044d08cc5..61b0e1c05ee1 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -218,6 +218,16 @@ enum hmm_update_type {
  * @update: callback to update range on a device
  */
 struct hmm_mirror_ops {
+	/* release() - release hmm_mirror
+	 *
+	 * @mirror: pointer to struct hmm_mirror
+	 *
+	 * This is called when the mm_struct is being released.
+	 * The callback should make sure no references to the mirror occur
+	 * after the callback returns.
+	 */
+	void (*release)(struct hmm_mirror *mirror);
+
 	/* sync_cpu_device_pagetables() - synchronize page tables
 	 *
 	 * @mirror: pointer to struct hmm_mirror
diff --git a/mm/hmm.c b/mm/hmm.c
index 320545b98ff5..db24d9f9f046 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -160,6 +160,23 @@ static void hmm_invalidate_range(struct hmm *hmm,
 	up_read(&hmm->mirrors_sem);
 }
 
+static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct hmm *hmm = mm->hmm;
+	struct hmm_mirror *mirror;
+	struct hmm_mirror *mirror_next;
+
+	VM_BUG_ON(!hmm);
+
+	down_write(&hmm->mirrors_sem);
+	list_for_each_entry_safe(mirror, mirror_next, &hmm->mirrors, list) {
+		list_del_init(&mirror->list);
+		if (mirror->ops->release)
+			mirror->ops->release(mirror);
+	}
+	up_write(&hmm->mirrors_sem);
+}
+
 static void hmm_invalidate_range_start(struct mmu_notifier *mn,
 				       struct mm_struct *mm,
 				       unsigned long start,
@@ -185,6 +202,7 @@ static void hmm_invalidate_range_end(struct mmu_notifier *mn,
 }
 
 static const struct mmu_notifier_ops hmm_mmu_notifier_ops = {
+	.release		= hmm_release,
 	.invalidate_range_start	= hmm_invalidate_range_start,
 	.invalidate_range_end	= hmm_invalidate_range_end,
 };
@@ -230,7 +248,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)
 	struct hmm *hmm = mirror->hmm;
 
 	down_write(&hmm->mirrors_sem);
-	list_del(&mirror->list);
+	list_del_init(&mirror->list);
 	up_write(&hmm->mirrors_sem);
 }
 EXPORT_SYMBOL(hmm_mirror_unregister);
-- 
2.14.3
