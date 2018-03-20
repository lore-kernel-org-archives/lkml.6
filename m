Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeCTCBI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 22:01:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752076AbeCTCAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 22:00:44 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 04/15] mm/hmm: unregister mmu_notifier when last HMM client quit
Date: Mon, 19 Mar 2018 22:00:26 -0400
Message-Id: <20180320020038.3360-5-jglisse@redhat.com>
In-Reply-To: <20180320020038.3360-1-jglisse@redhat.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This code was lost in translation at one point. This properly call
mmu_notifier_unregister_no_release() once last user is gone. This
fix the zombie mm_struct as without this patch we do not drop the
refcount we have on it.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 mm/hmm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/mm/hmm.c b/mm/hmm.c
index 6088fa6ed137..667944630dc9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -244,10 +244,29 @@ EXPORT_SYMBOL(hmm_mirror_register);
 void hmm_mirror_unregister(struct hmm_mirror *mirror)
 {
 	struct hmm *hmm = mirror->hmm;
+	struct mm_struct *mm = NULL;
+	bool unregister = false;
 
 	down_write(&hmm->mirrors_sem);
 	list_del_init(&mirror->list);
+	unregister = list_empty(&hmm->mirrors);
 	up_write(&hmm->mirrors_sem);
+
+	if (!unregister)
+		return;
+
+	spin_lock(&hmm->mm->page_table_lock);
+	if (hmm->mm->hmm == hmm) {
+		mm = hmm->mm;
+		mm->hmm = NULL;
+	}
+	spin_unlock(&hmm->mm->page_table_lock);
+
+	if (mm == NULL)
+		return;
+
+	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
+	kfree(hmm);
 }
 EXPORT_SYMBOL(hmm_mirror_unregister);
 
-- 
2.14.3
