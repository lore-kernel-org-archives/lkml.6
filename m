Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B56C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29E3214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfA2Qy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:54:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbfA2Qyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:54:54 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9CB7281DE9;
        Tue, 29 Jan 2019 16:54:53 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-2.rdu2.redhat.com [10.10.122.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97C9D102BCEB;
        Tue, 29 Jan 2019 16:54:52 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 10/10] mm/hmm: add helpers for driver to safely take the mmap_sem
Date:   Tue, 29 Jan 2019 11:54:28 -0500
Message-Id: <20190129165428.3931-11-jglisse@redhat.com>
In-Reply-To: <20190129165428.3931-1-jglisse@redhat.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 29 Jan 2019 16:54:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

The device driver context which holds reference to mirror and thus to
core hmm struct might outlive the mm against which it was created. To
avoid every driver to check for that case provide an helper that check
if mm is still alive and take the mmap_sem in read mode if so. If the
mm have been destroy (mmu_notifier release call back did happen) then
we return -EINVAL so that calling code knows that it is trying to do
something against a mm that is no longer valid.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/hmm.h | 50 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index b3850297352f..4a1454e3efba 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -438,6 +438,50 @@ struct hmm_mirror {
 int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm);
 void hmm_mirror_unregister(struct hmm_mirror *mirror);
 
+/*
+ * hmm_mirror_mm_down_read() - lock the mmap_sem in read mode
+ * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
+ * Returns: -EINVAL if the mm is dead, 0 otherwise (lock taken).
+ *
+ * The device driver context which holds reference to mirror and thus to core
+ * hmm struct might outlive the mm against which it was created. To avoid every
+ * driver to check for that case provide an helper that check if mm is still
+ * alive and take the mmap_sem in read mode if so. If the mm have been destroy
+ * (mmu_notifier release call back did happen) then we return -EINVAL so that
+ * calling code knows that it is trying to do something against a mm that is
+ * no longer valid.
+ */
+static inline int hmm_mirror_mm_down_read(struct hmm_mirror *mirror)
+{
+	struct mm_struct *mm;
+
+	/* Sanity check ... */
+	if (!mirror || !mirror->hmm)
+		return -EINVAL;
+	/*
+	 * Before trying to take the mmap_sem make sure the mm is still
+	 * alive as device driver context might outlive the mm lifetime.
+	 *
+	 * FIXME: should we also check for mm that outlive its owning
+	 * task ?
+	 */
+	mm = READ_ONCE(mirror->hmm->mm);
+	if (mirror->hmm->dead || !mm)
+		return -EINVAL;
+
+	down_read(&mm->mmap_sem);
+	return 0;
+}
+
+/*
+ * hmm_mirror_mm_up_read() - unlock the mmap_sem from read mode
+ * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
+ */
+static inline void hmm_mirror_mm_up_read(struct hmm_mirror *mirror)
+{
+	up_read(&mirror->hmm->mm->mmap_sem);
+}
+
 
 /*
  * To snapshot the CPU page table you first have to call hmm_range_register()
@@ -463,7 +507,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
  *          if (ret)
  *              return ret;
  *
- *          down_read(mm->mmap_sem);
+ *          hmm_mirror_mm_down_read(mirror);
  *      again:
  *
  *          if (!hmm_range_wait_until_valid(&range, TIMEOUT)) {
@@ -476,13 +520,13 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
  *
  *          ret = hmm_range_snapshot(&range); or hmm_range_fault(&range);
  *          if (ret == -EAGAIN) {
- *              down_read(mm->mmap_sem);
+ *              hmm_mirror_mm_down_read(mirror);
  *              goto again;
  *          } else if (ret == -EBUSY) {
  *              goto again;
  *          }
  *
- *          up_read(&mm->mmap_sem);
+ *          hmm_mirror_mm_up_read(mirror);
  *          if (ret) {
  *              hmm_range_unregister(range);
  *              return ret;
-- 
2.17.2

