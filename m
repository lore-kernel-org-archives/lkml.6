Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFB6C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDEF208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDEF208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388083AbeHWMhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:37:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56236 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbeHWMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:37:31 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4CC02BBF;
        Thu, 23 Aug 2018 09:08:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 299/324] mm: make vm_area_dup() actually copy the old vma data
Date:   Thu, 23 Aug 2018 09:56:05 +0200
Message-Id: <20180823075011.033786809@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit 95faf6992df468f617edb788da8c21c6eed0dfa7 ]

.. and re-initialize th eanon_vma_chain head.

This removes some boiler-plate from the users, and also makes it clear
why it didn't need use the 'zalloc()' version.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/fork.c |   10 +++++++---
 mm/mmap.c     |    7 -------
 mm/nommu.c    |    1 -
 3 files changed, 7 insertions(+), 11 deletions(-)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -315,7 +315,13 @@ struct vm_area_struct *vm_area_alloc(voi
 
 struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 {
-	return kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+
+	if (new) {
+		*new = *orig;
+		INIT_LIST_HEAD(&new->anon_vma_chain);
+	}
+	return new;
 }
 
 void vm_area_free(struct vm_area_struct *vma)
@@ -473,8 +479,6 @@ static __latent_entropy int dup_mmap(str
 		tmp = vm_area_dup(mpnt);
 		if (!tmp)
 			goto fail_nomem;
-		*tmp = *mpnt;
-		INIT_LIST_HEAD(&tmp->anon_vma_chain);
 		retval = vma_dup_policy(mpnt, tmp);
 		if (retval)
 			goto fail_nomem_policy;
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2624,11 +2624,6 @@ int __split_vma(struct mm_struct *mm, st
 	if (!new)
 		return -ENOMEM;
 
-	/* most fields are the same, copy all, and then fixup */
-	*new = *vma;
-
-	INIT_LIST_HEAD(&new->anon_vma_chain);
-
 	if (new_below)
 		new->vm_end = addr;
 	else {
@@ -3205,13 +3200,11 @@ struct vm_area_struct *copy_vma(struct v
 		new_vma = vm_area_dup(vma);
 		if (!new_vma)
 			goto out;
-		*new_vma = *vma;
 		new_vma->vm_start = addr;
 		new_vma->vm_end = addr + len;
 		new_vma->vm_pgoff = pgoff;
 		if (vma_dup_policy(vma, new_vma))
 			goto out_free_vma;
-		INIT_LIST_HEAD(&new_vma->anon_vma_chain);
 		if (anon_vma_clone(new_vma, vma))
 			goto out_free_mempol;
 		if (new_vma->vm_file)
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1476,7 +1476,6 @@ int split_vma(struct mm_struct *mm, stru
 	}
 
 	/* most fields are the same, copy all, and then fixup */
-	*new = *vma;
 	*region = *vma->vm_region;
 	new->vm_region = region;
 


