Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F712C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DAB2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfBDUTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:19:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728042AbfBDUTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:19:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D69D8B10E;
        Mon,  4 Feb 2019 20:19:39 +0000 (UTC)
Received: from virtlab420.virt.lab.eng.bos.redhat.com (virtlab420.virt.lab.eng.bos.redhat.com [10.19.152.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D0538AD93;
        Mon,  4 Feb 2019 20:19:37 +0000 (UTC)
From:   Nitesh Narayan Lal <nitesh@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com,
        wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com,
        david@redhat.com, mst@redhat.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com
Subject: [RFC][Patch v8 2/7] KVM: Enabling guest free page hinting via static key
Date:   Mon,  4 Feb 2019 15:18:49 -0500
Message-Id: <20190204201854.2328-3-nitesh@redhat.com>
In-Reply-To: <20190204201854.2328-1-nitesh@redhat.com>
References: <20190204201854.2328-1-nitesh@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Mon, 04 Feb 2019 20:19:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the guest free page hinting support
to enable or disable based on the STATIC key which
could be set via sysctl.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 include/linux/gfp.h          |  2 ++
 include/linux/page_hinting.h |  5 +++++
 kernel/sysctl.c              |  9 +++++++++
 virt/kvm/page_hinting.c      | 23 +++++++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index e596527284ba..8389219a076a 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -461,6 +461,8 @@ static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 #define HAVE_ARCH_FREE_PAGE
 static inline void arch_free_page(struct page *page, int order)
 {
+	if (!static_branch_unlikely(&guest_page_hinting_key))
+		return;
 	guest_free_page(page, order);
 }
 #endif
diff --git a/include/linux/page_hinting.h b/include/linux/page_hinting.h
index b54f7428f348..9bdcf63e1306 100644
--- a/include/linux/page_hinting.h
+++ b/include/linux/page_hinting.h
@@ -14,4 +14,9 @@ struct hypervisor_pages {
 	unsigned int order;
 };
 
+extern int guest_page_hinting_flag;
+extern struct static_key_false guest_page_hinting_key;
+
+int guest_page_hinting_sysctl(struct ctl_table *table, int write,
+			      void __user *buffer, size_t *lenp, loff_t *ppos);
 void guest_free_page(struct page *page, int order);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ba4d9e85feb8..5d53629c9bfb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1690,6 +1690,15 @@ static struct ctl_table vm_table[] = {
 		.extra1		= (void *)&mmap_rnd_compat_bits_min,
 		.extra2		= (void *)&mmap_rnd_compat_bits_max,
 	},
+#endif
+#ifdef CONFIG_KVM_FREE_PAGE_HINTING
+	{
+		.procname	= "guest-page-hinting",
+		.data		= &guest_page_hinting_flag,
+		.maxlen		= sizeof(guest_page_hinting_flag),
+		.mode		= 0644,
+		.proc_handler   = guest_page_hinting_sysctl,
+	},
 #endif
 	{ }
 };
diff --git a/virt/kvm/page_hinting.c b/virt/kvm/page_hinting.c
index 818bd6b84e0c..4a34ea8db0c8 100644
--- a/virt/kvm/page_hinting.c
+++ b/virt/kvm/page_hinting.c
@@ -1,6 +1,7 @@
 #include <linux/gfp.h>
 #include <linux/mm.h>
 #include <linux/kernel.h>
+#include <linux/kvm_host.h>
 
 /*
  * struct kvm_free_pages - Tracks the pages which are freed by the guest.
@@ -31,6 +32,28 @@ struct page_hinting {
 
 DEFINE_PER_CPU(struct page_hinting, hinting_obj);
 
+struct static_key_false guest_page_hinting_key  = STATIC_KEY_FALSE_INIT;
+EXPORT_SYMBOL(guest_page_hinting_key);
+static DEFINE_MUTEX(hinting_mutex);
+int guest_page_hinting_flag;
+EXPORT_SYMBOL(guest_page_hinting_flag);
+
+int guest_page_hinting_sysctl(struct ctl_table *table, int write,
+			      void __user *buffer, size_t *lenp,
+			      loff_t *ppos)
+{
+	int ret;
+
+	mutex_lock(&hinting_mutex);
+	ret = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (guest_page_hinting_flag)
+		static_key_enable(&guest_page_hinting_key.key);
+	else
+		static_key_disable(&guest_page_hinting_key.key);
+	mutex_unlock(&hinting_mutex);
+	return ret;
+}
+
 void guest_free_page(struct page *page, int order)
 {
 }
-- 
2.17.2

