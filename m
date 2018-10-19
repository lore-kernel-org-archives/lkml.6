Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F111BECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09EF20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09EF20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeJTALy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:11:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48426 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbeJTALe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:11:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1AF9F32B660;
        Fri, 19 Oct 2018 16:04:51 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-124-217.rdu2.redhat.com [10.10.124.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6220165314;
        Fri, 19 Oct 2018 16:04:50 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, stable@vger.kernel.org
Subject: [PATCH 3/6] mm/hmm: fix race between hmm_mirror_unregister() and mmu_notifier callback
Date:   Fri, 19 Oct 2018 12:04:39 -0400
Message-Id: <20181019160442.18723-4-jglisse@redhat.com>
In-Reply-To: <20181019160442.18723-1-jglisse@redhat.com>
References: <20181019160442.18723-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 19 Oct 2018 16:04:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

In hmm_mirror_unregister(), mm->hmm is set to NULL and then
mmu_notifier_unregister_no_release() is called. That creates a small
window where mmu_notifier can call mmu_notifier_ops with mm->hmm equal
to NULL. Fix this by first unregistering mmu notifier callbacks and
then setting mm->hmm to NULL.

Similarly in hmm_register(), set mm->hmm before registering mmu_notifier
callbacks so callback functions always see mm->hmm set.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
---
 mm/hmm.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 9a068a1da487..a16678d08127 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -91,16 +91,6 @@ static struct hmm *hmm_register(struct mm_struct *mm)
 	spin_lock_init(&hmm->lock);
 	hmm->mm = mm;
 
-	/*
-	 * We should only get here if hold the mmap_sem in write mode ie on
-	 * registration of first mirror through hmm_mirror_register()
-	 */
-	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
-	if (__mmu_notifier_register(&hmm->mmu_notifier, mm)) {
-		kfree(hmm);
-		return NULL;
-	}
-
 	spin_lock(&mm->page_table_lock);
 	if (!mm->hmm)
 		mm->hmm = hmm;
@@ -108,12 +98,27 @@ static struct hmm *hmm_register(struct mm_struct *mm)
 		cleanup = true;
 	spin_unlock(&mm->page_table_lock);
 
-	if (cleanup) {
-		mmu_notifier_unregister(&hmm->mmu_notifier, mm);
-		kfree(hmm);
-	}
+	if (cleanup)
+		goto error;
+
+	/*
+	 * We should only get here if hold the mmap_sem in write mode ie on
+	 * registration of first mirror through hmm_mirror_register()
+	 */
+	hmm->mmu_notifier.ops = &hmm_mmu_notifier_ops;
+	if (__mmu_notifier_register(&hmm->mmu_notifier, mm))
+		goto error_mm;
 
 	return mm->hmm;
+
+error_mm:
+	spin_lock(&mm->page_table_lock);
+	if (mm->hmm == hmm)
+		mm->hmm = NULL;
+	spin_unlock(&mm->page_table_lock);
+error:
+	kfree(hmm);
+	return NULL;
 }
 
 void hmm_mm_destroy(struct mm_struct *mm)
@@ -278,12 +283,13 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)
 	if (!should_unregister || mm == NULL)
 		return;
 
+	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
+
 	spin_lock(&mm->page_table_lock);
 	if (mm->hmm == hmm)
 		mm->hmm = NULL;
 	spin_unlock(&mm->page_table_lock);
 
-	mmu_notifier_unregister_no_release(&hmm->mmu_notifier, mm);
 	kfree(hmm);
 }
 EXPORT_SYMBOL(hmm_mirror_unregister);
-- 
2.17.2

