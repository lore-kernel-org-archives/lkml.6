Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328E9C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBC020892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790497;
	bh=1Vkybmx96OXwzK0sRocKr3m9Wi+fvljgNcLd6YYNG1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IlyCobCTT7tH1BJjAyG+WTeyGDRlcmSXw/NsU+rqw46fdavfamIMxUIT99Z/rYepG
	 qyNwq0sWUfqpN/Egv57YlpgFxDt1FB4qp0jpCkVrkUQbVC7E6lYuwf6z5hwKTn6sOs
	 viuG5t3RG6WJoruW+2Ma+pgdA5AP3CshDgCnqbwc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBC020892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbeLNMKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:10:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731677AbeLNMKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:10:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865B12147D;
        Fri, 14 Dec 2018 12:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789449;
        bh=1Vkybmx96OXwzK0sRocKr3m9Wi+fvljgNcLd6YYNG1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XyhVIILM9Dr8xaCQ32fhM2tP5ho4w7BKtbNSks8xfzFoVrEUtvU98qfzU4hwYvSal
         Zk0tWcQrzYrBo1HNBD1JeJk/9Eg46UcFKkVZK6EMrHpEhXfkGANBDKR1QwcTujfWRI
         a73xKSk/jmfKWDF5SoP3mIw8E+mz2iG5UddOuoUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Igor Druzhinin <igor.druzhinin@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 67/89] Revert "xen/balloon: Mark unallocated host memory as UNUSABLE"
Date:   Fri, 14 Dec 2018 13:00:20 +0100
Message-Id: <20181214115732.980600779@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 123664101aa2156d05251704fc63f9bcbf77741a ]

This reverts commit b3cf8528bb21febb650a7ecbf080d0647be40b9f.

That commit unintentionally broke Xen balloon memory hotplug with
"hotplug_unpopulated" set to 1. As long as "System RAM" resource
got assigned under a new "Unusable memory" resource in IO/Mem tree
any attempt to online this memory would fail due to general kernel
restrictions on having "System RAM" resources as 1st level only.

The original issue that commit has tried to workaround fa564ad96366
("x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f,
60-7f)") also got amended by the following 03a551734 ("x86/PCI: Move
and shrink AMD 64-bit window to avoid conflict") which made the
original fix to Xen ballooning unnecessary.

Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/xen/enlighten.c | 78 ----------------------------------------
 arch/x86/xen/setup.c     |  6 ++--
 drivers/xen/balloon.c    | 65 +++++----------------------------
 include/xen/balloon.h    |  5 ---
 4 files changed, 13 insertions(+), 141 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index df208af3cd74..515d5e4414c2 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -7,7 +7,6 @@
 
 #include <xen/features.h>
 #include <xen/page.h>
-#include <xen/interface/memory.h>
 
 #include <asm/xen/hypercall.h>
 #include <asm/xen/hypervisor.h>
@@ -336,80 +335,3 @@ void xen_arch_unregister_cpu(int num)
 }
 EXPORT_SYMBOL(xen_arch_unregister_cpu);
 #endif
-
-#ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
-void __init arch_xen_balloon_init(struct resource *hostmem_resource)
-{
-	struct xen_memory_map memmap;
-	int rc;
-	unsigned int i, last_guest_ram;
-	phys_addr_t max_addr = PFN_PHYS(max_pfn);
-	struct e820_table *xen_e820_table;
-	const struct e820_entry *entry;
-	struct resource *res;
-
-	if (!xen_initial_domain())
-		return;
-
-	xen_e820_table = kmalloc(sizeof(*xen_e820_table), GFP_KERNEL);
-	if (!xen_e820_table)
-		return;
-
-	memmap.nr_entries = ARRAY_SIZE(xen_e820_table->entries);
-	set_xen_guest_handle(memmap.buffer, xen_e820_table->entries);
-	rc = HYPERVISOR_memory_op(XENMEM_machine_memory_map, &memmap);
-	if (rc) {
-		pr_warn("%s: Can't read host e820 (%d)\n", __func__, rc);
-		goto out;
-	}
-
-	last_guest_ram = 0;
-	for (i = 0; i < memmap.nr_entries; i++) {
-		if (xen_e820_table->entries[i].addr >= max_addr)
-			break;
-		if (xen_e820_table->entries[i].type == E820_TYPE_RAM)
-			last_guest_ram = i;
-	}
-
-	entry = &xen_e820_table->entries[last_guest_ram];
-	if (max_addr >= entry->addr + entry->size)
-		goto out; /* No unallocated host RAM. */
-
-	hostmem_resource->start = max_addr;
-	hostmem_resource->end = entry->addr + entry->size;
-
-	/*
-	 * Mark non-RAM regions between the end of dom0 RAM and end of host RAM
-	 * as unavailable. The rest of that region can be used for hotplug-based
-	 * ballooning.
-	 */
-	for (; i < memmap.nr_entries; i++) {
-		entry = &xen_e820_table->entries[i];
-
-		if (entry->type == E820_TYPE_RAM)
-			continue;
-
-		if (entry->addr >= hostmem_resource->end)
-			break;
-
-		res = kzalloc(sizeof(*res), GFP_KERNEL);
-		if (!res)
-			goto out;
-
-		res->name = "Unavailable host RAM";
-		res->start = entry->addr;
-		res->end = (entry->addr + entry->size < hostmem_resource->end) ?
-			    entry->addr + entry->size : hostmem_resource->end;
-		rc = insert_resource(hostmem_resource, res);
-		if (rc) {
-			pr_warn("%s: Can't insert [%llx - %llx) (%d)\n",
-				__func__, res->start, res->end, rc);
-			kfree(res);
-			goto  out;
-		}
-	}
-
- out:
-	kfree(xen_e820_table);
-}
-#endif /* CONFIG_XEN_BALLOON_MEMORY_HOTPLUG */
diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
index 6e0d2086eacb..c114ca767b3b 100644
--- a/arch/x86/xen/setup.c
+++ b/arch/x86/xen/setup.c
@@ -808,6 +808,7 @@ char * __init xen_memory_setup(void)
 	addr = xen_e820_table.entries[0].addr;
 	size = xen_e820_table.entries[0].size;
 	while (i < xen_e820_table.nr_entries) {
+		bool discard = false;
 
 		chunk_size = size;
 		type = xen_e820_table.entries[i].type;
@@ -823,10 +824,11 @@ char * __init xen_memory_setup(void)
 				xen_add_extra_mem(pfn_s, n_pfns);
 				xen_max_p2m_pfn = pfn_s + n_pfns;
 			} else
-				type = E820_TYPE_UNUSABLE;
+				discard = true;
 		}
 
-		xen_align_and_add_e820_region(addr, chunk_size, type);
+		if (!discard)
+			xen_align_and_add_e820_region(addr, chunk_size, type);
 
 		addr += chunk_size;
 		size -= chunk_size;
diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index 065f0b607373..f77e499afddd 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -257,25 +257,10 @@ static void release_memory_resource(struct resource *resource)
 	kfree(resource);
 }
 
-/*
- * Host memory not allocated to dom0. We can use this range for hotplug-based
- * ballooning.
- *
- * It's a type-less resource. Setting IORESOURCE_MEM will make resource
- * management algorithms (arch_remove_reservations()) look into guest e820,
- * which we don't want.
- */
-static struct resource hostmem_resource = {
-	.name   = "Host RAM",
-};
-
-void __attribute__((weak)) __init arch_xen_balloon_init(struct resource *res)
-{}
-
 static struct resource *additional_memory_resource(phys_addr_t size)
 {
-	struct resource *res, *res_hostmem;
-	int ret = -ENOMEM;
+	struct resource *res;
+	int ret;
 
 	res = kzalloc(sizeof(*res), GFP_KERNEL);
 	if (!res)
@@ -284,42 +269,13 @@ static struct resource *additional_memory_resource(phys_addr_t size)
 	res->name = "System RAM";
 	res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 
-	res_hostmem = kzalloc(sizeof(*res), GFP_KERNEL);
-	if (res_hostmem) {
-		/* Try to grab a range from hostmem */
-		res_hostmem->name = "Host memory";
-		ret = allocate_resource(&hostmem_resource, res_hostmem,
-					size, 0, -1,
-					PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
-	}
-
-	if (!ret) {
-		/*
-		 * Insert this resource into iomem. Because hostmem_resource
-		 * tracks portion of guest e820 marked as UNUSABLE noone else
-		 * should try to use it.
-		 */
-		res->start = res_hostmem->start;
-		res->end = res_hostmem->end;
-		ret = insert_resource(&iomem_resource, res);
-		if (ret < 0) {
-			pr_err("Can't insert iomem_resource [%llx - %llx]\n",
-				res->start, res->end);
-			release_memory_resource(res_hostmem);
-			res_hostmem = NULL;
-			res->start = res->end = 0;
-		}
-	}
-
-	if (ret) {
-		ret = allocate_resource(&iomem_resource, res,
-					size, 0, -1,
-					PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
-		if (ret < 0) {
-			pr_err("Cannot allocate new System RAM resource\n");
-			kfree(res);
-			return NULL;
-		}
+	ret = allocate_resource(&iomem_resource, res,
+				size, 0, -1,
+				PAGES_PER_SECTION * PAGE_SIZE, NULL, NULL);
+	if (ret < 0) {
+		pr_err("Cannot allocate new System RAM resource\n");
+		kfree(res);
+		return NULL;
 	}
 
 #ifdef CONFIG_SPARSEMEM
@@ -331,7 +287,6 @@ static struct resource *additional_memory_resource(phys_addr_t size)
 			pr_err("New System RAM resource outside addressable RAM (%lu > %lu)\n",
 			       pfn, limit);
 			release_memory_resource(res);
-			release_memory_resource(res_hostmem);
 			return NULL;
 		}
 	}
@@ -810,8 +765,6 @@ static int __init balloon_init(void)
 	set_online_page_callback(&xen_online_page);
 	register_memory_notifier(&xen_memory_nb);
 	register_sysctl_table(xen_root);
-
-	arch_xen_balloon_init(&hostmem_resource);
 #endif
 
 #ifdef CONFIG_XEN_PV
diff --git a/include/xen/balloon.h b/include/xen/balloon.h
index 61f410fd74e4..4914b93a23f2 100644
--- a/include/xen/balloon.h
+++ b/include/xen/balloon.h
@@ -44,8 +44,3 @@ static inline void xen_balloon_init(void)
 {
 }
 #endif
-
-#ifdef CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
-struct resource;
-void arch_xen_balloon_init(struct resource *hostmem_resource);
-#endif
-- 
2.19.1



