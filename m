Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCE8C4151A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D5AF2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfBDUUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:20:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728269AbfBDUT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:19:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DBDD4C9DA6;
        Mon,  4 Feb 2019 20:19:57 +0000 (UTC)
Received: from virtlab420.virt.lab.eng.bos.redhat.com (virtlab420.virt.lab.eng.bos.redhat.com [10.19.152.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51B4A8A29D;
        Mon,  4 Feb 2019 20:19:56 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, mst@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com
Subject: [RFC][Patch v8 6/7] KVM: Enables the kernel to isolate and report free pages
Date:   Mon,  4 Feb 2019 15:18:53 -0500
Message-Id: <20190204201854.2328-7-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-1-nitesh@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 04 Feb 2019 20:19:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the kernel to scan the per cpu array and
compress it by removing the repetitive/re-allocated pages.
Once the per cpu array is completely filled with pages in the
buddy it wakes up the kernel per cpu thread which re-scans the
entire per cpu array by acquiring a zone lock corresponding to
the page which is being scanned. If the page is still free and
present in the buddy it tries to isolate the page and adds it
to another per cpu array.

Once this scanning process is complete and if there are any
isolated pages added to the new per cpu array kernel thread
invokes hyperlist_ready().

In hyperlist_ready() a hypercall is made to report these pages to
the host using the virtio-balloon framework. In order to do so
another virtqueue 'hinting_vq' is added to the balloon framework.
As the host frees all the reported pages, the kernel thread returns
them back to the buddy.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 drivers/virtio/virtio_balloon.c     |  56 +++++++-
 include/linux/page_hinting.h        |  18 ++-
 include/uapi/linux/virtio_balloon.h |   1 +
 mm/page_alloc.c                     |   2 +-
 virt/kvm/page_hinting.c             | 202 +++++++++++++++++++++++++++-
 5 files changed, 269 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 728ecd1eea30..8af34e0b9a32 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -57,13 +57,15 @@ enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_INFLATE,
 	VIRTIO_BALLOON_VQ_DEFLATE,
 	VIRTIO_BALLOON_VQ_STATS,
+	VIRTIO_BALLOON_VQ_HINTING,
 	VIRTIO_BALLOON_VQ_FREE_PAGE,
 	VIRTIO_BALLOON_VQ_MAX
 };
 
 struct virtio_balloon {
 	struct virtio_device *vdev;
-	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
+	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq,
+								*hinting_vq;
 
 	/* Balloon's own wq for cpu-intensive work items */
 	struct workqueue_struct *balloon_wq;
@@ -122,6 +124,40 @@ static struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
+#ifdef CONFIG_KVM_FREE_PAGE_HINTING
+void virtballoon_page_hinting(struct virtio_balloon *vb, u64 gvaddr,
+			      int hyper_entries)
+{
+	u64 gpaddr = virt_to_phys((void *)gvaddr);
+
+	virtqueue_add_desc(vb->hinting_vq, gpaddr, hyper_entries, 0);
+	virtqueue_kick_sync(vb->hinting_vq);
+}
+
+static void hinting_ack(struct virtqueue *vq)
+{
+	struct virtio_balloon *vb = vq->vdev->priv;
+
+	wake_up(&vb->acked);
+}
+
+static void enable_hinting(struct virtio_balloon *vb)
+{
+	guest_page_hinting_flag = 1;
+	static_branch_enable(&guest_page_hinting_key);
+	request_hypercall = (void *)&virtballoon_page_hinting;
+	balloon_ptr = vb;
+	WARN_ON(smpboot_register_percpu_thread(&hinting_threads));
+}
+
+static void disable_hinting(void)
+{
+	guest_page_hinting_flag = 0;
+	static_branch_enable(&guest_page_hinting_key);
+	balloon_ptr = NULL;
+}
+#endif
+
 static u32 page_to_balloon_pfn(struct page *page)
 {
 	unsigned long pfn = page_to_pfn(page);
@@ -481,6 +517,7 @@ static int init_vqs(struct virtio_balloon *vb)
 	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
 	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
 	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
+	names[VIRTIO_BALLOON_VQ_HINTING] = NULL;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
@@ -492,11 +529,18 @@ static int init_vqs(struct virtio_balloon *vb)
 		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	}
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINTING)) {
+		names[VIRTIO_BALLOON_VQ_HINTING] = "hinting_vq";
+		callbacks[VIRTIO_BALLOON_VQ_HINTING] = hinting_ack;
+	}
 	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
 					 vqs, callbacks, names, NULL, NULL);
 	if (err)
 		return err;
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINTING))
+		vb->hinting_vq = vqs[VIRTIO_BALLOON_VQ_HINTING];
+
 	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
 	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
@@ -908,6 +952,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		if (err)
 			goto out_del_balloon_wq;
 	}
+
+#ifdef CONFIG_KVM_FREE_PAGE_HINTING
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINTING))
+		enable_hinting(vb);
+#endif
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
@@ -950,6 +999,10 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	cancel_work_sync(&vb->update_balloon_size_work);
 	cancel_work_sync(&vb->update_balloon_stats_work);
 
+#ifdef CONFIG_KVM_FREE_PAGE_HINTING
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINTING))
+		disable_hinting();
+#endif
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
 		cancel_work_sync(&vb->report_free_page_work);
 		destroy_workqueue(vb->balloon_wq);
@@ -1009,6 +1062,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_MUST_TELL_HOST,
 	VIRTIO_BALLOON_F_STATS_VQ,
 	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
+	VIRTIO_BALLOON_F_HINTING,
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 };
diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting.h
index e800c6b07561..3ba8c1f3b4a4 100644
--- a/include/linux/page_hinting.h
+++ b/include/linux/page_hinting.h
@@ -1,15 +1,12 @@
 #include <linux/smpboot.h>
 
-/*
- * Size of the array which is used to store the freed pages is defined by
- * MAX_FGPT_ENTRIES. If possible, we have to find a better way using which
- * we can get rid of the hardcoded array size.
- */
 #define MAX_FGPT_ENTRIES	1000
 /*
  * hypervisor_pages - It is a dummy structure passed with the hypercall.
- * @pfn: page frame number for the page which needs to be sent to the host.
- * @order: order of the page needs to be reported to the host.
+ * @pfn - page frame number for the page which is to be freed.
+ * @pages - number of pages which are supposed to be freed.
+ * A global array object is used to to hold the list of pfn and pages and is
+ * passed as part of the hypercall.
  */
 struct hypervisor_pages {
 	unsigned long pfn;
@@ -19,11 +16,18 @@ struct hypervisor_pages {
 extern int guest_page_hinting_flag;
 extern struct static_key_false guest_page_hinting_key;
 extern struct smp_hotplug_thread hinting_threads;
+extern void (*request_hypercall)(void *, u64, int);
+extern void *balloon_ptr;
 extern bool want_page_poisoning;
 
 int guest_page_hinting_sysctl(struct ctl_table *table, int write,
 			      void __user *buffer, size_t *lenp, loff_t *ppos);
 void guest_free_page(struct page *page, int order);
+extern int __isolate_free_page(struct page *page, unsigned int order);
+extern void free_one_page(struct zone *zone,
+			  struct page *page, unsigned long pfn,
+			  unsigned int order,
+			  int migratetype);
 
 static inline void disable_page_poisoning(void)
 {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index a1966cd7b677..2b0f62814e22 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -36,6 +36,7 @@
 #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
+#define VIRTIO_BALLOON_F_HINTING	5 /* Page hinting virtqueue */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d295c9bc01a8..93224cba9243 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1199,7 +1199,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	spin_unlock(&zone->lock);
 }
 
-static void free_one_page(struct zone *zone,
+void free_one_page(struct zone *zone,
 				struct page *page, unsigned long pfn,
 				unsigned int order,
 				int migratetype)
diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
index be529f6f2bc0..315099fcda43 100644
--- a/virt/kvm/page_hinting.c
+++ b/virt/kvm/page_hinting.c
@@ -1,6 +1,8 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
+#include <linux/page_ref.h>
 #include <linux/kvm_host.h>
+#include <linux/sort.h>
 #include <linux/kernel.h>
 
 /*
@@ -39,6 +41,11 @@ int guest_page_hinting_flag;
 EXPORT_SYMBOL(guest_page_hinting_flag);
 static DEFINE_PER_CPU(struct task_struct *, hinting_task);
 
+void (*request_hypercall)(void *, u64, int);
+EXPORT_SYMBOL(request_hypercall);
+void *balloon_ptr;
+EXPORT_SYMBOL(balloon_ptr);
+
 int guest_page_hinting_sysctl(struct ctl_table *table, int write,
 			      void __user *buffer, size_t *lenp,
 			      loff_t *ppos)
@@ -55,18 +62,201 @@ int guest_page_hinting_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
+void hyperlist_ready(struct hypervisor_pages *guest_isolated_pages, int entries)
+{
+	int i = 0;
+	int mt = 0;
+
+	if (balloon_ptr)
+		request_hypercall(balloon_ptr, (u64)&guest_isolated_pages[0],
+				  entries);
+
+	while (i < entries) {
+		struct page *page = pfn_to_page(guest_isolated_pages[i].pfn);
+
+		mt = get_pageblock_migratetype(page);
+		free_one_page(page_zone(page), page, page_to_pfn(page),
+			      guest_isolated_pages[i].order, mt);
+		i++;
+	}
+}
+
+struct page *get_buddy_page(struct page *page)
+{
+	unsigned long pfn = page_to_pfn(page);
+	unsigned int order;
+
+	for (order = 0; order < MAX_ORDER; order++) {
+		struct page *page_head = page - (pfn & ((1 << order) - 1));
+
+		if (PageBuddy(page_head) && page_private(page_head) >= order)
+			return page_head;
+	}
+	return NULL;
+}
+
 static void hinting_fn(unsigned int cpu)
 {
 	struct page_hinting *page_hinting_obj = this_cpu_ptr(&hinting_obj);
+	int idx = 0, ret = 0;
+	struct zone *zone_cur;
+	unsigned long flags = 0;
+
+	while (idx < MAX_FGPT_ENTRIES) {
+		unsigned long pfn = page_hinting_obj->kvm_pt[idx].pfn;
+		unsigned long pfn_end = page_hinting_obj->kvm_pt[idx].pfn +
+			(1 << page_hinting_obj->kvm_pt[idx].order) - 1;
+
+		while (pfn <= pfn_end) {
+			struct page *page = pfn_to_page(pfn);
+			struct page *buddy_page = NULL;
+
+			zone_cur = page_zone(page);
+			spin_lock_irqsave(&zone_cur->lock, flags);
+
+			if (PageCompound(page)) {
+				struct page *head_page = compound_head(page);
+				unsigned long head_pfn = page_to_pfn(head_page);
+				unsigned int alloc_pages =
+					1 << compound_order(head_page);
+
+				pfn = head_pfn + alloc_pages;
+				spin_unlock_irqrestore(&zone_cur->lock, flags);
+				continue;
+			}
+
+			if (page_ref_count(page)) {
+				pfn++;
+				spin_unlock_irqrestore(&zone_cur->lock, flags);
+				continue;
+			}
+
+			if (PageBuddy(page)) {
+				int buddy_order = page_private(page);
 
+				ret = __isolate_free_page(page, buddy_order);
+				if (!ret) {
+				} else {
+					int l_idx = page_hinting_obj->hyp_idx;
+					struct hypervisor_pages *l_obj =
+					page_hinting_obj->hypervisor_pagelist;
+
+					l_obj[l_idx].pfn = pfn;
+					l_obj[l_idx].order = buddy_order;
+					page_hinting_obj->hyp_idx += 1;
+				}
+				pfn = pfn + (1 << buddy_order);
+				spin_unlock_irqrestore(&zone_cur->lock, flags);
+				continue;
+			}
+
+			buddy_page = get_buddy_page(page);
+			if (buddy_page) {
+				int buddy_order = page_private(buddy_page);
+
+				ret = __isolate_free_page(buddy_page,
+							  buddy_order);
+				if (!ret) {
+				} else {
+					int l_idx = page_hinting_obj->hyp_idx;
+					struct hypervisor_pages *l_obj =
+					page_hinting_obj->hypervisor_pagelist;
+					unsigned long buddy_pfn =
+						page_to_pfn(buddy_page);
+
+					l_obj[l_idx].pfn = buddy_pfn;
+					l_obj[l_idx].order = buddy_order;
+					page_hinting_obj->hyp_idx += 1;
+				}
+				pfn = page_to_pfn(buddy_page) +
+					(1 << buddy_order);
+				spin_unlock_irqrestore(&zone_cur->lock, flags);
+				continue;
+			}
+			spin_unlock_irqrestore(&zone_cur->lock, flags);
+			pfn++;
+		}
+		page_hinting_obj->kvm_pt[idx].pfn = 0;
+		page_hinting_obj->kvm_pt[idx].order = -1;
+		page_hinting_obj->kvm_pt[idx].zonenum = -1;
+		idx++;
+	}
+	if (page_hinting_obj->hyp_idx > 0) {
+		hyperlist_ready(page_hinting_obj->hypervisor_pagelist,
+				page_hinting_obj->hyp_idx);
+		page_hinting_obj->hyp_idx = 0;
+	}
 	page_hinting_obj->kvm_pt_idx = 0;
 	put_cpu_var(hinting_obj);
 }
 
+int if_exist(struct page *page)
+{
+	int i = 0;
+	struct page_hinting *page_hinting_obj = this_cpu_ptr(&hinting_obj);
+
+	while (i < MAX_FGPT_ENTRIES) {
+		if (page_to_pfn(page) == page_hinting_obj->kvm_pt[i].pfn)
+			return 1;
+		i++;
+	}
+	return 0;
+}
+
+void pack_array(void)
+{
+	int i = 0, j = 0;
+	struct page_hinting *page_hinting_obj = this_cpu_ptr(&hinting_obj);
+
+	while (i < MAX_FGPT_ENTRIES) {
+		if (page_hinting_obj->kvm_pt[i].pfn != 0) {
+			if (i != j) {
+				page_hinting_obj->kvm_pt[j].pfn =
+					page_hinting_obj->kvm_pt[i].pfn;
+				page_hinting_obj->kvm_pt[j].order =
+					page_hinting_obj->kvm_pt[i].order;
+				page_hinting_obj->kvm_pt[j].zonenum =
+					page_hinting_obj->kvm_pt[i].zonenum;
+			}
+			j++;
+		}
+		i++;
+	}
+	i = j;
+	page_hinting_obj->kvm_pt_idx = j;
+	while (j < MAX_FGPT_ENTRIES) {
+		page_hinting_obj->kvm_pt[j].pfn = 0;
+		page_hinting_obj->kvm_pt[j].order = -1;
+		page_hinting_obj->kvm_pt[j].zonenum = -1;
+		j++;
+	}
+}
+
 void scan_array(void)
 {
 	struct page_hinting *page_hinting_obj = this_cpu_ptr(&hinting_obj);
+	int i = 0;
 
+	while (i < MAX_FGPT_ENTRIES) {
+		struct page *page =
+			pfn_to_page(page_hinting_obj->kvm_pt[i].pfn);
+		struct page *buddy_page = get_buddy_page(page);
+
+		if (!PageBuddy(page) && buddy_page) {
+			if (if_exist(buddy_page)) {
+				page_hinting_obj->kvm_pt[i].pfn = 0;
+				page_hinting_obj->kvm_pt[i].order = -1;
+				page_hinting_obj->kvm_pt[i].zonenum = -1;
+			} else {
+				page_hinting_obj->kvm_pt[i].pfn =
+					page_to_pfn(buddy_page);
+				page_hinting_obj->kvm_pt[i].order =
+					page_private(buddy_page);
+			}
+		}
+		i++;
+	}
+	pack_array();
 	if (page_hinting_obj->kvm_pt_idx == MAX_FGPT_ENTRIES)
 		wake_up_process(__this_cpu_read(hinting_task));
 }
@@ -111,8 +301,18 @@ void guest_free_page(struct page *page, int order)
 		page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].order =
 							order;
 		page_hinting_obj->kvm_pt_idx += 1;
-		if (page_hinting_obj->kvm_pt_idx == MAX_FGPT_ENTRIES)
+		if (page_hinting_obj->kvm_pt_idx == MAX_FGPT_ENTRIES) {
+			/*
+			 * We are depending on the buddy free-list to identify
+			 * if a page is free or not. Hence, we are dumping all
+			 * the per-cpu pages back into the buddy allocator. This
+			 * will ensure less failures when we try to isolate free
+			 * captured pages and hence more memory reporting to the
+			 * host.
+			 */
+			drain_local_pages(NULL);
 			scan_array();
+		}
 	}
 	local_irq_restore(flags);
 }
-- 
2.17.2

