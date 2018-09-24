Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA499ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9042521486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9042521486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbeIXR7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:59:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbeIXR7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:59:55 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 91AB11072;
        Mon, 24 Sep 2018 11:58:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>
Subject: [PATCH 4.4 70/70] MIPS: VDSO: Drop gic_get_usm_range() usage
Date:   Mon, 24 Sep 2018 13:53:09 +0200
Message-Id: <20180924113108.147610264@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 00578cd864d45ae4b8fa3f684f8d6f783dd8d15d upstream.

We don't really need gic_get_usm_range() to abstract discovery of the
address of the GIC user-visible section now that we have access to its
base address globally.

Switch to calculating it ourselves, which will allow us to stop
requiring the irqchip driver to care about a counter exposed to userland
for use via the VDSO.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/17040/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kernel/vdso.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -13,7 +13,6 @@
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
-#include <linux/irqchip/mips-gic.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
@@ -21,6 +20,7 @@
 #include <linux/timekeeper_internal.h>
 
 #include <asm/abi.h>
+#include <asm/mips-cps.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
 
@@ -101,9 +101,8 @@ int arch_setup_additional_pages(struct l
 {
 	struct mips_vdso_image *image = current->thread.abi->vdso;
 	struct mm_struct *mm = current->mm;
-	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr;
+	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pfn;
 	struct vm_area_struct *vma;
-	struct resource gic_res;
 	int ret;
 
 	down_write(&mm->mmap_sem);
@@ -116,7 +115,7 @@ int arch_setup_additional_pages(struct l
 	 * only map a page even though the total area is 64K, as we only need
 	 * the counter registers at the start.
 	 */
-	gic_size = gic_present ? PAGE_SIZE : 0;
+	gic_size = mips_gic_present() ? PAGE_SIZE : 0;
 	vvar_size = gic_size + PAGE_SIZE;
 	size = vvar_size + image->size;
 
@@ -157,13 +156,9 @@ int arch_setup_additional_pages(struct l
 
 	/* Map GIC user page. */
 	if (gic_size) {
-		ret = gic_get_usm_range(&gic_res);
-		if (ret)
-			goto out;
+		gic_pfn = virt_to_phys(mips_gic_base + MIPS_GIC_USER_OFS) >> PAGE_SHIFT;
 
-		ret = io_remap_pfn_range(vma, base,
-					 gic_res.start >> PAGE_SHIFT,
-					 gic_size,
+		ret = io_remap_pfn_range(vma, base, gic_pfn, gic_size,
 					 pgprot_noncached(PAGE_READONLY));
 		if (ret)
 			goto out;


