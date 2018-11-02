Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7304EC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4CD20848
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2h7Q9y34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4CD20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeKCEAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:17 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86F3D2081F;
        Fri,  2 Nov 2018 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184722;
        bh=roGjfw9XDI9a+9IirSRmUuji9e0yi4vOJanp8pBB9pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2h7Q9y341ZqH2WeA6XN8dHttVLQrF9LnSug8UB5Ld/+J0PtPyt+8LaQx/SL352pQl
         +j/lFhIMP6jO9m24O/Fbs4zjsvWMafnMZAIr/6QxpwRJc4NNSiw+afUqvwutMYM3X6
         0ZzKe2KRjYTnL3JMV2oxgw1aOCGvLfqT+H4++VS0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 080/143] IB/usnic: Update with bug fixes from core code
Date:   Fri,  2 Nov 2018 19:34:25 +0100
Message-Id: <20181102182903.970772262@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 43cbd64b1fdc1da89abdad88a022d9e87a98e9c6 ]

usnic has a modified version of the core codes' ib_umem_get() and
related, and the copy misses many of the bug fixes done over the years:

Commit bc3e53f682d9 ("mm: distinguish between mlocked and pinned pages")
Commit 87773dd56d54 ("IB: ib_umem_release() should decrement mm->pinned_vm
                      from ib_umem_get")
Commit 8494057ab5e4 ("IB/uverbs: Prevent integer overflow in ib_umem_get
                      address arithmetic")
Commit 8abaae62f3fd ("IB/core: disallow registering 0-sized memory region")
Commit 66578b0b2f69 ("IB/core: don't disallow registering region starting
                      at 0x0")
Commit 53376fedb9da ("RDMA/core: not to set page dirty bit if it's already
                      set.")
Commit 8e907ed48827 ("IB/umem: Use the correct mm during ib_umem_release")

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/usnic/usnic_ib_verbs.c |  2 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c     | 40 ++++++++++++++------
 drivers/infiniband/hw/usnic/usnic_uiom.h     |  5 ++-
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
index e4113ef09315..3c3453d213dc 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_verbs.c
@@ -642,7 +642,7 @@ int usnic_ib_dereg_mr(struct ib_mr *ibmr)
 
 	usnic_dbg("va 0x%lx length 0x%zx\n", mr->umem->va, mr->umem->length);
 
-	usnic_uiom_reg_release(mr->umem, ibmr->pd->uobject->context->closing);
+	usnic_uiom_reg_release(mr->umem, ibmr->uobject->context);
 	kfree(mr);
 	return 0;
 }
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 4381c0a9a873..9dd39daa602b 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -41,6 +41,7 @@
 #include <linux/workqueue.h>
 #include <linux/list.h>
 #include <linux/pci.h>
+#include <rdma/ib_verbs.h>
 
 #include "usnic_log.h"
 #include "usnic_uiom.h"
@@ -88,7 +89,7 @@ static void usnic_uiom_put_pages(struct list_head *chunk_list, int dirty)
 		for_each_sg(chunk->page_list, sg, chunk->nents, i) {
 			page = sg_page(sg);
 			pa = sg_phys(sg);
-			if (dirty)
+			if (!PageDirty(page) && dirty)
 				set_page_dirty_lock(page);
 			put_page(page);
 			usnic_dbg("pa: %pa\n", &pa);
@@ -114,6 +115,16 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 	dma_addr_t pa;
 	unsigned int gup_flags;
 
+	/*
+	 * If the combination of the addr and size requested for this memory
+	 * region causes an integer overflow, return error.
+	 */
+	if (((addr + size) < addr) || PAGE_ALIGN(addr + size) < (addr + size))
+		return -EINVAL;
+
+	if (!size)
+		return -EINVAL;
+
 	if (!can_do_mlock())
 		return -EPERM;
 
@@ -127,7 +138,7 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 
 	down_write(&current->mm->mmap_sem);
 
-	locked = npages + current->mm->locked_vm;
+	locked = npages + current->mm->pinned_vm;
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 
 	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
@@ -143,7 +154,7 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 	ret = 0;
 
 	while (npages) {
-		ret = get_user_pages(cur_base,
+		ret = get_user_pages_longterm(cur_base,
 					min_t(unsigned long, npages,
 					PAGE_SIZE / sizeof(struct page *)),
 					gup_flags, page_list, NULL);
@@ -186,7 +197,7 @@ out:
 	if (ret < 0)
 		usnic_uiom_put_pages(chunk_list, 0);
 	else
-		current->mm->locked_vm = locked;
+		current->mm->pinned_vm = locked;
 
 	up_write(&current->mm->mmap_sem);
 	free_page((unsigned long) page_list);
@@ -420,18 +431,22 @@ out_free_uiomr:
 	return ERR_PTR(err);
 }
 
-void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr, int closing)
+void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr,
+			    struct ib_ucontext *ucontext)
 {
+	struct task_struct *task;
 	struct mm_struct *mm;
 	unsigned long diff;
 
 	__usnic_uiom_reg_release(uiomr->pd, uiomr, 1);
 
-	mm = get_task_mm(current);
-	if (!mm) {
-		kfree(uiomr);
-		return;
-	}
+	task = get_pid_task(ucontext->tgid, PIDTYPE_PID);
+	if (!task)
+		goto out;
+	mm = get_task_mm(task);
+	put_task_struct(task);
+	if (!mm)
+		goto out;
 
 	diff = PAGE_ALIGN(uiomr->length + uiomr->offset) >> PAGE_SHIFT;
 
@@ -443,7 +458,7 @@ void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr, int closing)
 	 * up here and not be able to take the mmap_sem.  In that case
 	 * we defer the vm_locked accounting to the system workqueue.
 	 */
-	if (closing) {
+	if (ucontext->closing) {
 		if (!down_write_trylock(&mm->mmap_sem)) {
 			INIT_WORK(&uiomr->work, usnic_uiom_reg_account);
 			uiomr->mm = mm;
@@ -455,9 +470,10 @@ void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr, int closing)
 	} else
 		down_write(&mm->mmap_sem);
 
-	current->mm->locked_vm -= diff;
+	mm->pinned_vm -= diff;
 	up_write(&mm->mmap_sem);
 	mmput(mm);
+out:
 	kfree(uiomr);
 }
 
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.h b/drivers/infiniband/hw/usnic/usnic_uiom.h
index 431efe4143f4..8c096acff123 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.h
@@ -39,6 +39,8 @@
 
 #include "usnic_uiom_interval_tree.h"
 
+struct ib_ucontext;
+
 #define USNIC_UIOM_READ			(1)
 #define USNIC_UIOM_WRITE		(2)
 
@@ -89,7 +91,8 @@ void usnic_uiom_free_dev_list(struct device **devs);
 struct usnic_uiom_reg *usnic_uiom_reg_get(struct usnic_uiom_pd *pd,
 						unsigned long addr, size_t size,
 						int access, int dmasync);
-void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr, int closing);
+void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr,
+			    struct ib_ucontext *ucontext);
 int usnic_uiom_init(char *drv_name);
 void usnic_uiom_fini(void);
 #endif /* USNIC_UIOM_H_ */
-- 
2.17.1



