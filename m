Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2348FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D9E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789912;
	bh=BFv2iExViJaM8SDOqkRGJHYnu3AQSOBy0pwxIruNQzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZCcp9KmORCJPF9p8XK34YLSzSKqg1r96PPryWUkGWzZTpFJgxKPj4EhpwBWKcvZ5h
	 RXOq1j4SC68BUSsmgIKWhmK3cjXhbTxkxTIC9gf4XriH69PntXWtjE9c37KS5DFb4m
	 2Hr+qFnXpt72sRjB51gc2W1GWKO1w0+mu+exv4oo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D9E2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbeLNMSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731714AbeLNMQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A0121479;
        Fri, 14 Dec 2018 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789786;
        bh=BFv2iExViJaM8SDOqkRGJHYnu3AQSOBy0pwxIruNQzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HX1U78rEW3S7kh3FGurb6BGe4+FFmo883NKpx04DlC5TNOhxHVpu/EYuj7v8FquFw
         xxFEbZ0CRgpeJKq56VzpEA6drVd28wbB9flhvqB0s24JXuBBRp7deASVD0xXjNDreK
         3kgBSWWeC5OyTfRzM1lY1alHKOvotLsue2v6wnyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 76/88] mm: replace get_user_pages_unlocked() write/force parameters with gup_flags
Date:   Fri, 14 Dec 2018 13:00:50 +0100
Message-Id: <20181214115708.418012869@linuxfoundation.org>
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

commit c164154f66f0c9b02673f07aa4f044f1d9c70274 upstream.

This removes the 'write' and 'force' use from get_user_pages_unlocked()
and replaces them with 'gup_flags' to make the use of FOLL_FORCE
explicit in callers as use of this flag can result in surprising
behaviour (and hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 4.4:
 - Also update calls from process_vm_rw_single_vec() and async_pf_execute()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/mm/gup.c                 |    2 +-
 arch/s390/mm/gup.c                 |    2 +-
 arch/sh/mm/gup.c                   |    3 ++-
 arch/sparc/mm/gup.c                |    3 ++-
 arch/x86/mm/gup.c                  |    2 +-
 drivers/media/pci/ivtv/ivtv-udma.c |    3 ++-
 drivers/media/pci/ivtv/ivtv-yuv.c  |    8 ++++----
 drivers/scsi/st.c                  |    5 ++---
 drivers/video/fbdev/pvr2fb.c       |    2 +-
 include/linux/mm.h                 |    2 +-
 mm/gup.c                           |   14 ++++----------
 mm/nommu.c                         |   11 ++---------
 mm/process_vm_access.c             |    6 +++++-
 mm/util.c                          |    2 +-
 net/ceph/pagevec.c                 |    2 +-
 virt/kvm/async_pf.c                |    2 +-
 16 files changed, 31 insertions(+), 38 deletions(-)

--- a/arch/mips/mm/gup.c
+++ b/arch/mips/mm/gup.c
@@ -303,7 +303,7 @@ slow_irqon:
 
 	ret = get_user_pages_unlocked(current, mm, start,
 				      (end - start) >> PAGE_SHIFT,
-				      write, 0, pages);
+				      pages, write ? FOLL_WRITE : 0);
 
 	/* Have to be a bit careful with return values */
 	if (nr > 0) {
--- a/arch/s390/mm/gup.c
+++ b/arch/s390/mm/gup.c
@@ -242,7 +242,7 @@ int get_user_pages_fast(unsigned long st
 	start += nr << PAGE_SHIFT;
 	pages += nr;
 	ret = get_user_pages_unlocked(current, mm, start,
-			     nr_pages - nr, write, 0, pages);
+			     nr_pages - nr, pages, write ? FOLL_WRITE : 0);
 	/* Have to be a bit careful with return values */
 	if (nr > 0)
 		ret = (ret < 0) ? nr : ret + nr;
--- a/arch/sh/mm/gup.c
+++ b/arch/sh/mm/gup.c
@@ -258,7 +258,8 @@ slow_irqon:
 		pages += nr;
 
 		ret = get_user_pages_unlocked(current, mm, start,
-			(end - start) >> PAGE_SHIFT, write, 0, pages);
+			(end - start) >> PAGE_SHIFT, pages,
+			write ? FOLL_WRITE : 0);
 
 		/* Have to be a bit careful with return values */
 		if (nr > 0) {
--- a/arch/sparc/mm/gup.c
+++ b/arch/sparc/mm/gup.c
@@ -250,7 +250,8 @@ slow:
 		pages += nr;
 
 		ret = get_user_pages_unlocked(current, mm, start,
-			(end - start) >> PAGE_SHIFT, write, 0, pages);
+			(end - start) >> PAGE_SHIFT, pages,
+			write ? FOLL_WRITE : 0);
 
 		/* Have to be a bit careful with return values */
 		if (nr > 0) {
--- a/arch/x86/mm/gup.c
+++ b/arch/x86/mm/gup.c
@@ -388,7 +388,7 @@ slow_irqon:
 
 		ret = get_user_pages_unlocked(current, mm, start,
 					      (end - start) >> PAGE_SHIFT,
-					      write, 0, pages);
+					      pages, write ? FOLL_WRITE : 0);
 
 		/* Have to be a bit careful with return values */
 		if (nr > 0) {
--- a/drivers/media/pci/ivtv/ivtv-udma.c
+++ b/drivers/media/pci/ivtv/ivtv-udma.c
@@ -125,7 +125,8 @@ int ivtv_udma_setup(struct ivtv *itv, un
 
 	/* Get user pages for DMA Xfer */
 	err = get_user_pages_unlocked(current, current->mm,
-			user_dma.uaddr, user_dma.page_count, 0, 1, dma->map);
+			user_dma.uaddr, user_dma.page_count, dma->map,
+			FOLL_FORCE);
 
 	if (user_dma.page_count != err) {
 		IVTV_DEBUG_WARN("failed to map user pages, returned %d instead of %d\n",
--- a/drivers/media/pci/ivtv/ivtv-yuv.c
+++ b/drivers/media/pci/ivtv/ivtv-yuv.c
@@ -76,13 +76,13 @@ static int ivtv_yuv_prep_user_dma(struct
 
 	/* Get user pages for DMA Xfer */
 	y_pages = get_user_pages_unlocked(current, current->mm,
-				y_dma.uaddr, y_dma.page_count, 0, 1,
-				&dma->map[0]);
+				y_dma.uaddr, y_dma.page_count,
+				&dma->map[0], FOLL_FORCE);
 	uv_pages = 0; /* silence gcc. value is set and consumed only if: */
 	if (y_pages == y_dma.page_count) {
 		uv_pages = get_user_pages_unlocked(current, current->mm,
-					uv_dma.uaddr, uv_dma.page_count, 0, 1,
-					&dma->map[y_pages]);
+					uv_dma.uaddr, uv_dma.page_count,
+					&dma->map[y_pages], FOLL_FORCE);
 	}
 
 	if (y_pages != y_dma.page_count || uv_pages != uv_dma.page_count) {
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -4821,9 +4821,8 @@ static int sgl_map_user_pages(struct st_
 		current->mm,
 		uaddr,
 		nr_pages,
-		rw == READ,
-		0, /* don't force */
-		pages);
+		pages,
+		rw == READ ? FOLL_WRITE : 0); /* don't force */
 
 	/* Errors and no page mapped should return here */
 	if (res < nr_pages)
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -687,7 +687,7 @@ static ssize_t pvr2fb_write(struct fb_in
 		return -ENOMEM;
 
 	ret = get_user_pages_unlocked(current, current->mm, (unsigned long)buf,
-				      nr_pages, WRITE, 0, pages);
+				      nr_pages, pages, FOLL_WRITE);
 
 	if (ret < nr_pages) {
 		nr_pages = ret;
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1210,7 +1210,7 @@ long __get_user_pages_unlocked(struct ta
 			       struct page **pages, unsigned int gup_flags);
 long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 		    unsigned long start, unsigned long nr_pages,
-		    int write, int force, struct page **pages);
+		    struct page **pages, unsigned int gup_flags);
 int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 			struct page **pages);
 
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -797,17 +797,10 @@ EXPORT_SYMBOL(__get_user_pages_unlocked)
  */
 long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 			     unsigned long start, unsigned long nr_pages,
-			     int write, int force, struct page **pages)
+			     struct page **pages, unsigned int gup_flags)
 {
-	unsigned int flags = FOLL_TOUCH;
-
-	if (write)
-		flags |= FOLL_WRITE;
-	if (force)
-		flags |= FOLL_FORCE;
-
 	return __get_user_pages_unlocked(tsk, mm, start, nr_pages,
-					 pages, flags);
+					 pages, gup_flags | FOLL_TOUCH);
 }
 EXPORT_SYMBOL(get_user_pages_unlocked);
 
@@ -1427,7 +1420,8 @@ int get_user_pages_fast(unsigned long st
 		pages += nr;
 
 		ret = get_user_pages_unlocked(current, mm, start,
-					      nr_pages - nr, write, 0, pages);
+					      nr_pages - nr, pages,
+					      write ? FOLL_WRITE : 0);
 
 		/* Have to be a bit careful with return values */
 		if (nr > 0) {
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -224,17 +224,10 @@ EXPORT_SYMBOL(__get_user_pages_unlocked)
 
 long get_user_pages_unlocked(struct task_struct *tsk, struct mm_struct *mm,
 			     unsigned long start, unsigned long nr_pages,
-			     int write, int force, struct page **pages)
+			     struct page **pages, unsigned int gup_flags)
 {
-	unsigned int flags = 0;
-
-	if (write)
-		flags |= FOLL_WRITE;
-	if (force)
-		flags |= FOLL_FORCE;
-
 	return __get_user_pages_unlocked(tsk, mm, start, nr_pages,
-					 pages, flags);
+					 pages, gup_flags);
 }
 EXPORT_SYMBOL(get_user_pages_unlocked);
 
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -88,19 +88,23 @@ static int process_vm_rw_single_vec(unsi
 	ssize_t rc = 0;
 	unsigned long max_pages_per_loop = PVM_MAX_KMALLOC_PAGES
 		/ sizeof(struct pages *);
+	unsigned int flags = 0;
 
 	/* Work out address and page range required */
 	if (len == 0)
 		return 0;
 	nr_pages = (addr + len - 1) / PAGE_SIZE - addr / PAGE_SIZE + 1;
 
+	if (vm_write)
+		flags |= FOLL_WRITE;
+
 	while (!rc && nr_pages && iov_iter_count(iter)) {
 		int pages = min(nr_pages, max_pages_per_loop);
 		size_t bytes;
 
 		/* Get the pages we're interested in */
 		pages = get_user_pages_unlocked(task, mm, pa, pages,
-						vm_write, 0, process_pages);
+						process_pages, flags);
 		if (pages <= 0)
 			return -EFAULT;
 
--- a/mm/util.c
+++ b/mm/util.c
@@ -278,7 +278,7 @@ int __weak get_user_pages_fast(unsigned
 {
 	struct mm_struct *mm = current->mm;
 	return get_user_pages_unlocked(current, mm, start, nr_pages,
-				       write, 0, pages);
+				       pages, write ? FOLL_WRITE : 0);
 }
 EXPORT_SYMBOL_GPL(get_user_pages_fast);
 
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -26,7 +26,7 @@ struct page **ceph_get_direct_page_vecto
 	while (got < num_pages) {
 		rc = get_user_pages_unlocked(current, current->mm,
 		    (unsigned long)data + ((unsigned long)got * PAGE_SIZE),
-		    num_pages - got, write_page, 0, pages + got);
+		    num_pages - got, pages + got, write_page ? FOLL_WRITE : 0);
 		if (rc < 0)
 			break;
 		BUG_ON(rc == 0);
--- a/virt/kvm/async_pf.c
+++ b/virt/kvm/async_pf.c
@@ -80,7 +80,7 @@ static void async_pf_execute(struct work
 
 	might_sleep();
 
-	get_user_pages_unlocked(NULL, mm, addr, 1, 1, 0, NULL);
+	get_user_pages_unlocked(NULL, mm, addr, 1, NULL, FOLL_WRITE);
 	kvm_async_page_present_sync(vcpu, apf);
 
 	spin_lock(&vcpu->async_pf.lock);


