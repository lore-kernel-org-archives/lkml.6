Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF01C282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C462082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbfBDUUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:20:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbfBDUUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:20:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E788C05001B;
        Mon,  4 Feb 2019 20:20:05 +0000 (UTC)
Received: from virtlab420.virt.lab.eng.bos.redhat.com (virtlab420.virt.lab.eng.bos.redhat.com [10.19.152.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E23188AD88;
        Mon,  4 Feb 2019 20:19:57 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, mst@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com
Subject: [RFC][Patch v8 7/7] KVM: Adding tracepoints for guest page hinting
Date:   Mon,  4 Feb 2019 15:18:54 -0500
Message-Id: <20190204201854.2328-8-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-1-nitesh@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 04 Feb 2019 20:20:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables to track the pages freed by the guest and
the pages isolated by the page hinting code through kernel
tracepoints.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 include/trace/events/kmem.h | 40 +++++++++++++++++++++++++++++++++++++
 virt/kvm/page_hinting.c     | 10 ++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..69f6da9ff939 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -315,6 +315,46 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+TRACE_EVENT(guest_free_page,
+	    TP_PROTO(struct page *page, unsigned int order),
+
+	TP_ARGS(page, order),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned int, order)
+	),
+
+	TP_fast_assign(
+		__entry->pfn            = page_to_pfn(page);
+		__entry->order          = order;
+	),
+
+	TP_printk("page=%p pfn=%lu number of pages=%d",
+		  pfn_to_page(__entry->pfn),
+		  __entry->pfn,
+		  (1 << __entry->order))
+);
+
+TRACE_EVENT(guest_isolated_pfn,
+	    TP_PROTO(unsigned long pfn, unsigned int pages),
+
+	TP_ARGS(pfn, pages),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, pfn)
+		__field(unsigned int, pages)
+	),
+
+	TP_fast_assign(
+		__entry->pfn            = pfn;
+		__entry->pages          = pages;
+	),
+
+	TP_printk("pfn=%lu number of pages=%u",
+		  __entry->pfn,
+		  __entry->pages)
+);
 #endif /* _TRACE_KMEM_H */
 
 /* This part must be outside protection */
diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
index 315099fcda43..395d94e52c74 100644
--- a/virt/kvm/page_hinting.c
+++ b/virt/kvm/page_hinting.c
@@ -4,6 +4,7 @@
 #include <linux/kvm_host.h>
 #include <linux/sort.h>
 #include <linux/kernel.h>
+#include <trace/events/kmem.h>
 
 /*
  * struct kvm_free_pages - Tracks the pages which are freed by the guest.
@@ -140,7 +141,11 @@ static void hinting_fn(unsigned int cpu)
 					int l_idx = page_hinting_obj->hyp_idx;
 					struct hypervisor_pages *l_obj =
 					page_hinting_obj->hypervisor_pagelist;
+					unsigned int buddy_pages =
+						1 << buddy_order;
 
+					trace_guest_isolated_pfn(pfn,
+								 buddy_pages);
 					l_obj[l_idx].pfn = pfn;
 					l_obj[l_idx].order = buddy_order;
 					page_hinting_obj->hyp_idx += 1;
@@ -163,7 +168,11 @@ static void hinting_fn(unsigned int cpu)
 					page_hinting_obj->hypervisor_pagelist;
 					unsigned long buddy_pfn =
 						page_to_pfn(buddy_page);
+					unsigned int buddy_pages =
+						1 << buddy_order;
 
+					trace_guest_isolated_pfn(pfn,
+								 buddy_pages);
 					l_obj[l_idx].pfn = buddy_pfn;
 					l_obj[l_idx].order = buddy_order;
 					page_hinting_obj->hyp_idx += 1;
@@ -294,6 +303,7 @@ void guest_free_page(struct page *page, int order)
 	local_irq_save(flags);
 	if (page_hinting_obj->kvm_pt_idx != MAX_FGPT_ENTRIES) {
 		disable_page_poisoning();
+		trace_guest_free_page(page, order);
 		page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].pfn =
 							page_to_pfn(page);
 		page_hinting_obj->kvm_pt[page_hinting_obj->kvm_pt_idx].zonenum =
-- 
2.17.2

