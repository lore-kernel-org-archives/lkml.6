Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0484C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782242175B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfBDUUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:20:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbfBDUTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:19:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2C7458E40;
        Mon,  4 Feb 2019 20:19:41 +0000 (UTC)
Received: from virtlab420.virt.lab.eng.bos.redhat.com (virtlab420.virt.lab.eng.bos.redhat.com [10.19.152.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F0A375C79;
        Mon,  4 Feb 2019 20:19:39 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, mst@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com
Subject: [RFC][Patch v8 3/7] KVM: Guest free page hinting functional skeleton
Date:   Mon,  4 Feb 2019 15:18:50 -0500
Message-Id: <20190204201854.2328-4-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-1-nitesh@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 04 Feb 2019 20:19:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the functional skeleton for the guest implementation.
It also enables the guest to maintain the list of pages which are
freed by the guest. Once the list is full guest_free_page invokes
scan_array() which wakes up the kernel thread responsible for further
processing.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 include/linux/page_hinting.h |  3 ++
 virt/kvm/page_hinting.c      | 60 +++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting.h
index 9bdcf63e1306..2d7ff59f3f6a 100644
--- a/include/linux/page_hinting.h
+++ b/include/linux/page_hinting.h
@@ -1,3 +1,5 @@
+#include <linux/smpboot.h>
+
 /*
  * Size of the array which is used to store the freed pages is defined by
  * MAX_FGPT_ENTRIES. If possible, we have to find a better way using which
@@ -16,6 +18,7 @@ struct hypervisor_pages {
 
 extern int guest_page_hinting_flag;
 extern struct static_key_false guest_page_hinting_key;
+extern struct smp_hotplug_thread hinting_threads;
 
 int guest_page_hinting_sysctl(struct ctl_table *table, int write,
 			      void __user *buffer, size_t *lenp, loff_t *ppos);
diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
index 4a34ea8db0c8..636990e7fbb3 100644
--- a/virt/kvm/page_hinting.c
+++ b/virt/kvm/page_hinting.c
@@ -1,7 +1,7 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
-#include <linux/kernel.h>
 #include <linux/kvm_host.h>
+#include <linux/kernel.h>
 
 /*
  * struct kvm_free_pages - Tracks the pages which are freed by the guest.
@@ -37,6 +37,7 @@ EXPORT_SYMBOL(guest_page_hinting_key);
 static DEFINE_MUTEX(hinting_mutex);
 int guest_page_hinting_flag;
 EXPORT_SYMBOL(guest_page_hinting_flag);
+static DEFINE_PER_CPU(struct task_struct *, hinting_task);
 
 int guest_page_hinting_sysctl(struct ctl_table *table, int write,
 			      void __user *buffer, size_t *lenp,
@@ -54,6 +55,63 @@ int guest_page_hinting_sysctl(struct ctl_table *table, int write,
 	return ret;
 }
 
+static void hinting_fn(unsigned int cpu)
+{
+	struct page_hinting *page_hinting_obj = this_cpu_ptr(&hinting_obj);
+
+	page_hinting_obj->kvm_pt_idx = 0;
+	put_cpu_var(hinting_obj);
+}
+
+void scan_array(void)
+{
+	struct page_hinting *page_hinting_obj = this_cpu_ptr(&hinting_obj);
+
+	if (page_hinting_obj->kvm_pt_idx == MAX_FGPT_ENTRIES)
+		wake_up_process(__this_cpu_read(hinting_task));
+}
+
+static int hinting_should_run(unsigned int cpu)
+{
+	struct page_hinting *page_hinting_obj = this_cpu_ptr(&hinting_obj);
+	int free_page_idx = page_hinting_obj->kvm_pt_idx;
+
+	if (free_page_idx == MAX_FGPT_ENTRIES)
+		return 1;
+	else
+		return 0;
+}
+
+struct smp_hotplug_thread hinting_threads = {
+	.store			= &hinting_task,
+	.thread_should_run	= hinting_should_run,
+	.thread_fn		= hinting_fn,
+	.thread_comm		= "hinting/%u",
+	.selfparking		= false,
+};
+EXPORT_SYMBOL(hinting_threads);
+
 void guest_free_page(struct page *page, int order)
 {
+	unsigned long flags;
+	struct page_hinting *page_hinting_obj = this_cpu_ptr(&hinting_obj);
+	/*
+	 * use of global variables may trigger a race condition between irq and
+	 * process context causing unwanted overwrites. This will be replaced
+	 * with a better solution to prevent such race conditions.
+	 */
+
+	local_irq_save(flags);
+	if (page_hinting_obj->kvm_pt_idx != MAX_FGPT_ENTRIES) {
+		page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].pfn =
+							page_to_pfn(page);
+		page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].zonenum =
+							page_zonenum(page);
+		page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].order =
+							order;
+		page_hinting_obj->kvm_pt_idx += 1;
+		if (page_hinting_obj->kvm_pt_idx == MAX_FGPT_ENTRIES)
+			scan_array();
+	}
+	local_irq_restore(flags);
 }
-- 
2.17.2

