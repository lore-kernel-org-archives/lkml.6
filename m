Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423240AbeE1MIC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932509AbeE1LFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:05:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lidong Chen <lidongchen@tencent.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.16 028/272] IB/umem: Use the correct mm during ib_umem_release
Date: Mon, 28 May 2018 12:01:01 +0200
Message-Id: <20180528100243.031689488@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lidong Chen <jemmy858585@gmail.com>

commit 8e907ed4882714fd13cfe670681fc6cb5284c780 upstream.

User-space may invoke ibv_reg_mr and ibv_dereg_mr in different threads.

If ibv_dereg_mr is called after the thread which invoked ibv_reg_mr has
exited, get_pid_task will return NULL and ib_umem_release will not
decrease mm->pinned_vm.

Instead of using threads to locate the mm, use the overall tgid from the
ib_ucontext struct instead. This matches the behavior of ODP and
disassociate in handling the mm of the process that called ibv_reg_mr.

Cc: <stable@vger.kernel.org>
Fixes: 87773dd56d54 ("IB: ib_umem_release() should decrement mm->pinned_vm from ib_umem_get")
Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/umem.c |    7 +------
 include/rdma/ib_umem.h         |    1 -
 2 files changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -119,7 +119,6 @@ struct ib_umem *ib_umem_get(struct ib_uc
 	umem->length     = size;
 	umem->address    = addr;
 	umem->page_shift = PAGE_SHIFT;
-	umem->pid	 = get_task_pid(current, PIDTYPE_PID);
 	/*
 	 * We ask for writable memory if any of the following
 	 * access flags are set.  "Local write" and "remote write"
@@ -132,7 +131,6 @@ struct ib_umem *ib_umem_get(struct ib_uc
 		 IB_ACCESS_REMOTE_ATOMIC | IB_ACCESS_MW_BIND));
 
 	if (access & IB_ACCESS_ON_DEMAND) {
-		put_pid(umem->pid);
 		ret = ib_umem_odp_get(context, umem, access);
 		if (ret) {
 			kfree(umem);
@@ -148,7 +146,6 @@ struct ib_umem *ib_umem_get(struct ib_uc
 
 	page_list = (struct page **) __get_free_page(GFP_KERNEL);
 	if (!page_list) {
-		put_pid(umem->pid);
 		kfree(umem);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -231,7 +228,6 @@ out:
 	if (ret < 0) {
 		if (need_release)
 			__ib_umem_release(context->device, umem, 0);
-		put_pid(umem->pid);
 		kfree(umem);
 	} else
 		current->mm->pinned_vm = locked;
@@ -274,8 +270,7 @@ void ib_umem_release(struct ib_umem *ume
 
 	__ib_umem_release(umem->context->device, umem, 1);
 
-	task = get_pid_task(umem->pid, PIDTYPE_PID);
-	put_pid(umem->pid);
+	task = get_pid_task(umem->context->tgid, PIDTYPE_PID);
 	if (!task)
 		goto out;
 	mm = get_task_mm(task);
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -48,7 +48,6 @@ struct ib_umem {
 	int                     writable;
 	int                     hugetlb;
 	struct work_struct	work;
-	struct pid             *pid;
 	struct mm_struct       *mm;
 	unsigned long		diff;
 	struct ib_umem_odp     *odp_data;
