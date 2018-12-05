Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8117DC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D5E92133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5E92133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeLET5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:57:23 -0500
Received: from foss.arm.com ([217.140.101.70]:34560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728767AbeLET5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:57:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C59F15AD;
        Wed,  5 Dec 2018 11:57:21 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EDDB13F614;
        Wed,  5 Dec 2018 11:57:18 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     m.szyprowski@samsung.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, cai@gmx.us, salil.mehta@huawei.com,
        john.garry@huawei.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH v2 6/8] x86/dma/amd-gart: Stop resizing dma_debug_entry pool
Date:   Wed,  5 Dec 2018 19:56:55 +0000
Message-Id: <3e96f3efb0b5bc869603e656527cab2b4705c870.1544037783.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
In-Reply-To: <cover.1544037783.git.robin.murphy@arm.com>
References: <cover.1544037783.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma-debug is now capable of adding new entries to its pool on-demand if
the initial preallocation was insufficient, so the IOMMU_LEAK logic no
longer needs to explicitly change the pool size. This does lose it the
ability to save a couple of megabytes of RAM by reducing the pool size
below its default, but it seems unlikely that that is a realistic
concern these days (or indeed that anyone is actively debugging AGP
drivers' DMA usage any more). Getting rid of dma_debug_resize_entries()
will make room for further streamlining in the dma-debug code itself.

Removing the call reveals quite a lot of cruft which has been useless
for nearly a decade since commit 19c1a6f5764d ("x86 gart: reimplement
IOMMU_LEAK feature by using DMA_API_DEBUG"), including the entire
'iommu=leak' parameter, which controlled nothing except whether
dma_debug_resize_entries() was called or not.

CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New

 Documentation/x86/x86_64/boot-options.txt |  5 +----
 arch/x86/kernel/amd_gart_64.c             | 23 -----------------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
index ad6d2a80cf05..abc53886655e 100644
--- a/Documentation/x86/x86_64/boot-options.txt
+++ b/Documentation/x86/x86_64/boot-options.txt
@@ -209,7 +209,7 @@ IOMMU (input/output memory management unit)
       mapping with memory protection, etc.
       Kernel boot message: "PCI-DMA: Using Calgary IOMMU"
 
- iommu=[<size>][,noagp][,off][,force][,noforce][,leak[=<nr_of_leak_pages>]
+ iommu=[<size>][,noagp][,off][,force][,noforce]
 	[,memaper[=<order>]][,merge][,fullflush][,nomerge]
 	[,noaperture][,calgary]
 
@@ -228,9 +228,6 @@ IOMMU (input/output memory management unit)
     allowed            Overwrite iommu off workarounds for specific chipsets.
     fullflush          Flush IOMMU on each allocation (default).
     nofullflush        Don't use IOMMU fullflush.
-    leak               Turn on simple iommu leak tracing (only when
-                       CONFIG_IOMMU_LEAK is on). Default number of leak pages
-                       is 20.
     memaper[=<order>]  Allocate an own aperture over RAM with size 32MB<<order.
                        (default: order=1, i.e. 64MB)
     merge              Do scatter-gather (SG) merging. Implies "force"
diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index 3f9d1b4019bb..aa7706bf4d25 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -155,9 +155,6 @@ static void flush_gart(void)
 
 #ifdef CONFIG_IOMMU_LEAK
 /* Debugging aid for drivers that don't free their IOMMU tables */
-static int leak_trace;
-static int iommu_leak_pages = 20;
-
 static void dump_leak(void)
 {
 	static int dump;
@@ -774,16 +771,6 @@ int __init gart_iommu_init(void)
 	if (!iommu_gart_bitmap)
 		panic("Cannot allocate iommu bitmap\n");
 
-#ifdef CONFIG_IOMMU_LEAK
-	if (leak_trace) {
-		int ret;
-
-		ret = dma_debug_resize_entries(iommu_pages);
-		if (ret)
-			pr_debug("PCI-DMA: Cannot trace all the entries\n");
-	}
-#endif
-
 	/*
 	 * Out of IOMMU space handling.
 	 * Reserve some invalid pages at the beginning of the GART.
@@ -853,16 +840,6 @@ void __init gart_parse_options(char *p)
 {
 	int arg;
 
-#ifdef CONFIG_IOMMU_LEAK
-	if (!strncmp(p, "leak", 4)) {
-		leak_trace = 1;
-		p += 4;
-		if (*p == '=')
-			++p;
-		if (isdigit(*p) && get_option(&p, &arg))
-			iommu_leak_pages = arg;
-	}
-#endif
 	if (isdigit(*p) && get_option(&p, &arg))
 		iommu_size = arg;
 	if (!strncmp(p, "fullflush", 9))
-- 
2.19.1.dirty

