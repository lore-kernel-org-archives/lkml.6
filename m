Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3F7C0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F3D22353
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFm0a7Gm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F3D22353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389349AbeKLIVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:21:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389315AbeKLIVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:21:06 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6F6216FD;
        Sun, 11 Nov 2018 22:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975469;
        bh=Av0YWlbPlCz3piSQHFW6B4H+DjJRC2vOoyrTfGSmtCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFm0a7GmT4x7NwRxUAY+DEKL539PkJraDczZh9LuXOwEvUhOPQ/LSwKcb2uJXKKer
         cjJSACkP8URy2oWoBzKYwESpDd7TmxRZuGtKj/5qkfQx5FrgeKcR0TXFSXvYZQiJ0C
         T7PxHw+zVAeByVbY47y6/m09u9Rw7QircmLLatm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.18 247/350] mm/hmm: fix race between hmm_mirror_unregister() and mmu_notifier callback
Date:   Sun, 11 Nov 2018 14:21:51 -0800
Message-Id: <20181111221718.367355250@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Campbell <rcampbell@nvidia.com>

commit 86a2d59841ab0b147ffc1b7b3041af87927cf312 upstream.

In hmm_mirror_unregister(), mm->hmm is set to NULL and then
mmu_notifier_unregister_no_release() is called.  That creates a small
window where mmu_notifier can call mmu_notifier_ops with mm->hmm equal to
NULL.  Fix this by first unregistering mmu notifier callbacks and then
setting mm->hmm to NULL.

Similarly in hmm_register(), set mm->hmm before registering mmu_notifier
callbacks so callback functions always see mm->hmm set.

Link: http://lkml.kernel.org/r/20181019160442.18723-4-jglisse@redhat.com
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/hmm.c |   36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -91,16 +91,6 @@ static struct hmm *hmm_register(struct m
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
@@ -108,12 +98,27 @@ static struct hmm *hmm_register(struct m
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
@@ -275,12 +280,13 @@ void hmm_mirror_unregister(struct hmm_mi
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


