Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57707C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1347121486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789790;
	bh=5tlCNz3LZdp1AVGKLX9V++84n+pRM+5khOfoONeLZig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aipcM+ftgf9SSxaQN81mjOdlFtRp//xlhbF5bBhZFZ5JworjhgUwYg3kDgtR4obO0
	 KPn19Ife/c1zZ/0te31rVEu7i+t9CLUjWpsZOL42V1f7NaydxcUpUfiqF9VNI3oQ7h
	 N4xxHsuxoQqx9ATARA/lr2ixeaSbEXMtvJu533IQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1347121486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbeLNMQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:16:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732139AbeLNMQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD20214AE;
        Fri, 14 Dec 2018 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789783;
        bh=5tlCNz3LZdp1AVGKLX9V++84n+pRM+5khOfoONeLZig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eyg4EoHtgVGUBNsRw+zlomzPPH1dWNg0A2c1ZraHo0LvW+lLDFjkfqIpuWXZB5XcA
         +FMXik1diXDOTpNT9o5NckUuShJYSMBMFrLR0pHA1ocLWEa7CMGDmKP6LdPw9NqBxf
         GWPj9xod0cXAUXAu43cbHUHhPsl6f1K2CADVGVoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 75/88] mm: remove write/force parameters from __get_user_pages_unlocked()
Date:   Fri, 14 Dec 2018 13:00:49 +0100
Message-Id: <20181214115708.360510296@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes <lstoakes@gmail.com>

commit d4944b0ecec0af882483fe44b66729316e575208 upstream.

This removes the redundant 'write' and 'force' parameters from
__get_user_pages_unlocked() to make the use of FOLL_FORCE explicit in
callers as use of this flag can result in surprising behaviour (and
hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 4.4:
 - Defer changes in process_vm_rw_single_vec() and async_pf_execute() since
   they use get_user_pages_unlocked() here
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mm.h  |    3 +--
 mm/gup.c            |   19 ++++++++++---------
 mm/nommu.c          |   14 ++++++++++----
 virt/kvm/kvm_main.c |   11 ++++++++---
 4 files changed, 29 insertions(+), 18 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1207,8 +1207,7 @@ long get_user_pages_locked(struct task_s
 		    int *locked);
 long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 			       unsigned long start, unsigned long nr_pages,
-			       int write, int force, struct page **pages,
-			       unsigned int gup_flags);
+			       struct page **pages, unsigned int gup_flags);
 long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 		    unsigned long start, unsigned long nr_pages,
 		    int write, int force, struct page **pages);
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -764,17 +764,11 @@ EXPORT_SYMBOL(get_user_pages_locked);
  */
 __always_inline long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 					       unsigned long start, unsigned long nr_pages,
-					       int write, int force, struct page **pages,
-					       unsigned int gup_flags)
+					       struct page **pages, unsigned int gup_flags)
 {
 	long ret;
 	int locked = 1;
 
-	if (write)
-		gup_flags |= FOLL_WRITE;
-	if (force)
-		gup_flags |= FOLL_FORCE;
-
 	down_read(&mm->mmap_sem);
 	ret = __get_user_pages_locked(tsk, mm, start, nr_pages, pages, NULL,
 				      &locked, false, gup_flags);
@@ -805,8 +799,15 @@ long get_user_pages_unlocked(struct task
 			     unsigned long start, unsigned long nr_pages,
 			     int write, int force, struct page **pages)
 {
-	return __get_user_pages_unlocked(tsk, mm, start, nr_pages, write,
-					 force, pages, FOLL_TOUCH);
+	unsigned int flags = FOLL_TOUCH;
+
+	if (write)
+		flags |= FOLL_WRITE;
+	if (force)
+		flags |= FOLL_FORCE;
+
+	return __get_user_pages_unlocked(tsk, mm, start, nr_pages,
+					 pages, flags);
 }
 EXPORT_SYMBOL(get_user_pages_unlocked);
 
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -211,8 +211,7 @@ EXPORT_SYMBOL(get_user_pages_locked);
 
 long __get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 			       unsigned long start, unsigned long nr_pages,
-			       int write, int force, struct page **pages,
-			       unsigned int gup_flags)
+			       struct page **pages, unsigned int gup_flags)
 {
 	long ret;
 	down_read(&mm->mmap_sem);
@@ -227,8 +226,15 @@ long get_user_pages_unlocked(struct task
 			     unsigned long start, unsigned long nr_pages,
 			     int write, int force, struct page **pages)
 {
-	return __get_user_pages_unlocked(tsk, mm, start, nr_pages, write,
-					 force, pages, 0);
+	unsigned int flags = 0;
+
+	if (write)
+		flags |= FOLL_WRITE;
+	if (force)
+		flags |= FOLL_FORCE;
+
+	return __get_user_pages_unlocked(tsk, mm, start, nr_pages,
+					 pages, flags);
 }
 EXPORT_SYMBOL(get_user_pages_unlocked);
 
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1352,10 +1352,15 @@ static int hva_to_pfn_slow(unsigned long
 		npages = get_user_page_nowait(current, current->mm,
 					      addr, write_fault, page);
 		up_read(&current->mm->mmap_sem);
-	} else
+	} else {
+		unsigned int flags = FOLL_TOUCH | FOLL_HWPOISON;
+
+		if (write_fault)
+			flags |= FOLL_WRITE;
+
 		npages = __get_user_pages_unlocked(current, current->mm, addr, 1,
-						   write_fault, 0, page,
-						   FOLL_TOUCH|FOLL_HWPOISON);
+						   page, flags);
+	}
 	if (npages != 1)
 		return npages;
 


