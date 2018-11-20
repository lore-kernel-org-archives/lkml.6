Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ADAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631C9208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 05:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="IR2MbOVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631C9208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbeKTPtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 10:49:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46514 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeKTPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 10:49:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so395403pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 21:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGjhfyB62ZBE0Pl3zrr5IPaSCTrMuQUlFPIG+7VVFnc=;
        b=IR2MbOVYMj3U+8v4jTjEJi0bB/H0X8D1FslRcoRNeZ86p0CTbT3EV1LPoT3oQ/x5o1
         K0KN3NwIAjcwlPnNmIoBsk6Bcn1DswvVt75ZYvSgdYIP0jmmaPk8og5MFoPOFnBr3CJB
         sfs+xdqcSzMOVQ/gXooR1zwPOhb+OjobBu7aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGjhfyB62ZBE0Pl3zrr5IPaSCTrMuQUlFPIG+7VVFnc=;
        b=V4U+UuPaTRkxaT8GqxYl5pQk27TY6ljfRKFNTUw3SdbZUwyL12ZGJKkbJjtt10L+eT
         dBKBuex3tcgDw4GaK6NqUdfXlp0myxllpLh0XWyqS0UApEUqlS/z+BI2p7/RYc18A2HB
         6AwBB57+J3Tt/Bn6xzhgXw1+8Vg+5Ov0PgR+qOuDMGY0JoGFE8/0qD6UpP06AGQl1BgJ
         zVG/yPDmr7WKgGyE1zgYbhqNNbqAeEsyr4cZ/zYT0+5Ax3tNb4B3n2bb8/+5jBTVBye1
         DSz8EnAmJ+gxJLbUS+4QEHG9eeyOjXpFB1Ac7CopzohZhIPSscvlwXkPHRuQWJ40kxA+
         7qdw==
X-Gm-Message-State: AGRZ1gJgC9ztuNcDi+B0UyZTKCuX0y+99JOaqDk1zf+JmCRPNJv3sqN+
        ytzjxQbwWZJLjgU01eL6ZyszCOYHFKY=
X-Google-Smtp-Source: AJdET5eZckjl1cfIWi1ApcqBgha7ZlHsRT0nWreuEqc6sUj908rKDkkihjtpOuI7hwV60G5hhk5+FQ==
X-Received: by 2002:a62:1912:: with SMTP id 18-v6mr783240pfz.194.1542691317005;
        Mon, 19 Nov 2018 21:21:57 -0800 (PST)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id q199sm34237451pfc.97.2018.11.19.21.21.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 21:21:55 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH -next 1/2] mm/memfd: make F_SEAL_FUTURE_WRITE seal more robust
Date:   Mon, 19 Nov 2018 21:21:36 -0800
Message-Id: <20181120052137.74317-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A better way to do F_SEAL_FUTURE_WRITE seal was discussed [1] last week
where we don't need to modify core VFS structures to get the same
behavior of the seal. This solves several side-effects pointed out by
Andy [2].

[1] https://lore.kernel.org/lkml/20181111173650.GA256781@google.com/
[2] https://lore.kernel.org/lkml/69CE06CC-E47C-4992-848A-66EB23EE6C74@amacapital.net/

Suggested-by: Andy Lutomirski <luto@kernel.org>
Fixes: 5e653c2923fd ("mm: Add an F_SEAL_FUTURE_WRITE seal to memfd")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 fs/hugetlbfs/inode.c |  2 +-
 mm/memfd.c           | 19 -------------------
 mm/shmem.c           | 24 +++++++++++++++++++++---
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 762028994f47..5b54bf893a67 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -558,7 +558,7 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 		inode_lock(inode);
 
 		/* protected by i_mutex */
-		if (info->seals & F_SEAL_WRITE) {
+		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
 			inode_unlock(inode);
 			return -EPERM;
 		}
diff --git a/mm/memfd.c b/mm/memfd.c
index 63fff5e77114..650e65a46b9c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -201,25 +201,6 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
-	if ((seals & F_SEAL_FUTURE_WRITE) &&
-	    !(*file_seals & F_SEAL_FUTURE_WRITE)) {
-		/*
-		 * The FUTURE_WRITE seal also prevents growing and shrinking
-		 * so we need them to be already set, or requested now.
-		 */
-		int test_seals = (seals | *file_seals) &
-				 (F_SEAL_GROW | F_SEAL_SHRINK);
-
-		if (test_seals != (F_SEAL_GROW | F_SEAL_SHRINK)) {
-			error = -EINVAL;
-			goto unlock;
-		}
-
-		spin_lock(&file->f_lock);
-		file->f_mode &= ~(FMODE_WRITE | FMODE_PWRITE);
-		spin_unlock(&file->f_lock);
-	}
-
 	*file_seals |= seals;
 	error = 0;
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 32eb29bd72c6..cee9878c87f1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2121,6 +2121,23 @@ int shmem_lock(struct file *file, int lock, struct user_struct *user)
 
 static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	struct shmem_inode_info *info = SHMEM_I(file_inode(file));
+
+	/*
+	 * New PROT_READ and MAP_SHARED mmaps are not allowed when "future
+	 * write" seal active.
+	 */
+	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE) &&
+	    (info->seals & F_SEAL_FUTURE_WRITE))
+		return -EPERM;
+
+	/*
+	 * Since the F_SEAL_FUTURE_WRITE seals allow for a MAP_SHARED read-only
+	 * mapping, take care to not allow mprotect to revert protections.
+	 */
+	if (info->seals & F_SEAL_FUTURE_WRITE)
+		vma->vm_flags &= ~(VM_MAYWRITE);
+
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGE_PAGECACHE) &&
@@ -2346,8 +2363,9 @@ shmem_write_begin(struct file *file, struct address_space *mapping,
 	pgoff_t index = pos >> PAGE_SHIFT;
 
 	/* i_mutex is held by caller */
-	if (unlikely(info->seals & (F_SEAL_WRITE | F_SEAL_GROW))) {
-		if (info->seals & F_SEAL_WRITE)
+	if (unlikely(info->seals & (F_SEAL_GROW |
+				   F_SEAL_WRITE | F_SEAL_FUTURE_WRITE))) {
+		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE))
 			return -EPERM;
 		if ((info->seals & F_SEAL_GROW) && pos + len > inode->i_size)
 			return -EPERM;
@@ -2610,7 +2628,7 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(shmem_falloc_waitq);
 
 		/* protected by i_mutex */
-		if (info->seals & F_SEAL_WRITE) {
+		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
 			error = -EPERM;
 			goto out;
 		}
-- 
2.19.1.1215.g8438c0b245-goog

