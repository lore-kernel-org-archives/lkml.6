Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18F4C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979A421486
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789823;
	bh=zqn8TNlCjx0pGrXPIRxII2vEXmEDqvM5NYbICZw4L0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=supAewcV7YkyTtrSZj93VOr1KfwiojeL45tKShiNfA9ncyD/ypR6E6YhNlA1yCeFl
	 YWdJYoOi25O3C+keI81d35pxYhBuuTtKp0Q+gwBpXuwdjS8bF1PAFt5U8hVG01bujg
	 ROyqyApyyddbkWXOEDmntzLXPfI6Ox/8jbe+QM/M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979A421486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbeLNMRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732840AbeLNMQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DF22214C1;
        Fri, 14 Dec 2018 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789817;
        bh=zqn8TNlCjx0pGrXPIRxII2vEXmEDqvM5NYbICZw4L0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F4KzHyzof8zeKhN3tRxH02dXgbYjHoP0t5aLlc16ce2vqgY/DU8EPbz/WdTOA+UJ8
         7cnJGOqV2WDTPdJ0qaEPmuphUjwPJTSSrEEEFtFUG3nlTT4n8ogI11xYOqqIL4U4nk
         XJl7s5437P42yMgk/WM+5kb8Fv89sWy3hE829820=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 80/88] mm: replace __access_remote_vm() write parameter with gup_flags
Date:   Fri, 14 Dec 2018 13:00:54 +0100
Message-Id: <20181214115708.714280836@linuxfoundation.org>
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

commit 442486ec1096781c50227b73f721a63974b0fdda upstream.

This removes the 'write' argument from __access_remote_vm() and replaces
it with 'gup_flags' as use of this function previously silently implied
FOLL_FORCE, whereas after this patch callers explicitly pass this flag.

We make this explicit as use of FOLL_FORCE can result in surprising
behaviour (and hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |   23 +++++++++++++++--------
 mm/nommu.c  |    9 ++++++---
 2 files changed, 21 insertions(+), 11 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3711,14 +3711,11 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
  * given task for page fault accounting.
  */
 static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long addr, void *buf, int len, int write)
+		unsigned long addr, void *buf, int len, unsigned int gup_flags)
 {
 	struct vm_area_struct *vma;
 	void *old_buf = buf;
-	unsigned int flags = FOLL_FORCE;
-
-	if (write)
-		flags |= FOLL_WRITE;
+	int write = gup_flags & FOLL_WRITE;
 
 	down_read(&mm->mmap_sem);
 	/* ignore errors, just check how much was successfully transferred */
@@ -3728,7 +3725,7 @@ static int __access_remote_vm(struct tas
 		struct page *page = NULL;
 
 		ret = get_user_pages(tsk, mm, addr, 1,
-				flags, &page, &vma);
+				gup_flags, &page, &vma);
 		if (ret <= 0) {
 #ifndef CONFIG_HAVE_IOREMAP_PROT
 			break;
@@ -3787,7 +3784,12 @@ static int __access_remote_vm(struct tas
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, int write)
 {
-	return __access_remote_vm(NULL, mm, addr, buf, len, write);
+	unsigned int flags = FOLL_FORCE;
+
+	if (write)
+		flags |= FOLL_WRITE;
+
+	return __access_remote_vm(NULL, mm, addr, buf, len, flags);
 }
 
 /*
@@ -3800,12 +3802,17 @@ int access_process_vm(struct task_struct
 {
 	struct mm_struct *mm;
 	int ret;
+	unsigned int flags = FOLL_FORCE;
 
 	mm = get_task_mm(tsk);
 	if (!mm)
 		return 0;
 
-	ret = __access_remote_vm(tsk, mm, addr, buf, len, write);
+	if (write)
+		flags |= FOLL_WRITE;
+
+	ret = __access_remote_vm(tsk, mm, addr, buf, len, flags);
+
 	mmput(mm);
 
 	return ret;
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1929,9 +1929,10 @@ void filemap_map_pages(struct vm_area_st
 EXPORT_SYMBOL(filemap_map_pages);
 
 static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long addr, void *buf, int len, int write)
+		unsigned long addr, void *buf, int len, unsigned int gup_flags)
 {
 	struct vm_area_struct *vma;
+	int write = gup_flags & FOLL_WRITE;
 
 	down_read(&mm->mmap_sem);
 
@@ -1973,7 +1974,8 @@ static int __access_remote_vm(struct tas
 int access_remote_vm(struct mm_struct *mm, unsigned long addr,
 		void *buf, int len, int write)
 {
-	return __access_remote_vm(NULL, mm, addr, buf, len, write);
+	return __access_remote_vm(NULL, mm, addr, buf, len,
+			write ? FOLL_WRITE : 0);
 }
 
 /*
@@ -1991,7 +1993,8 @@ int access_process_vm(struct task_struct
 	if (!mm)
 		return 0;
 
-	len = __access_remote_vm(tsk, mm, addr, buf, len, write);
+	len = __access_remote_vm(tsk, mm, addr, buf, len,
+			write ? FOLL_WRITE : 0);
 
 	mmput(mm);
 	return len;


