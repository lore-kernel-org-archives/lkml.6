Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187F4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99882147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99882147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbeHPVpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:45:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbeHPVpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:45:53 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 59E7CCC4;
        Thu, 16 Aug 2018 18:45:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 12/22] ACPI / APEI: Remove ghes_ioremap_area
Date:   Thu, 16 Aug 2018 20:45:13 +0200
Message-Id: <20180816171624.623030411@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180816171622.831964729@linuxfoundation.org>
References: <20180816171622.831964729@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit 520e18a5080d2c444a03280d99c8a35cb667d321 upstream.

Now that nothing is using the ghes_ioremap_area pages, rip them out.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Borislav Petkov <bp@suse.de>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/apei/ghes.c |   39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -114,19 +114,7 @@ static DEFINE_MUTEX(ghes_list_mutex);
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
  * handler, but general ioremap can not be used in atomic context, so
  * the fixmap is used instead.
- */
-
-/*
- * Two virtual pages are used, one for IRQ/PROCESS context, the other for
- * NMI context (optionally).
- */
-#define GHES_IOREMAP_PAGES           2
-#define GHES_IOREMAP_IRQ_PAGE(base)	(base)
-#define GHES_IOREMAP_NMI_PAGE(base)	((base) + PAGE_SIZE)
-
-/* virtual memory area for atomic ioremap */
-static struct vm_struct *ghes_ioremap_area;
-/*
+ *
  * These 2 spinlocks are used to prevent the fixmap entries from being used
  * simultaneously.
  */
@@ -141,23 +129,6 @@ static atomic_t ghes_estatus_cache_alloc
 
 static int ghes_panic_timeout __read_mostly = 30;
 
-static int ghes_ioremap_init(void)
-{
-	ghes_ioremap_area = __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
-		VM_IOREMAP, VMALLOC_START, VMALLOC_END);
-	if (!ghes_ioremap_area) {
-		pr_err(GHES_PFX "Failed to allocate virtual memory area for atomic ioremap.\n");
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void ghes_ioremap_exit(void)
-{
-	free_vm_area(ghes_ioremap_area);
-}
-
 static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
 {
 	phys_addr_t paddr;
@@ -1247,13 +1218,9 @@ static int __init ghes_init(void)
 
 	ghes_nmi_init_cxt();
 
-	rc = ghes_ioremap_init();
-	if (rc)
-		goto err;
-
 	rc = ghes_estatus_pool_init();
 	if (rc)
-		goto err_ioremap_exit;
+		goto err;
 
 	rc = ghes_estatus_pool_expand(GHES_ESTATUS_CACHE_AVG_SIZE *
 				      GHES_ESTATUS_CACHE_ALLOCED_MAX);
@@ -1277,8 +1244,6 @@ static int __init ghes_init(void)
 	return 0;
 err_pool_exit:
 	ghes_estatus_pool_exit();
-err_ioremap_exit:
-	ghes_ioremap_exit();
 err:
 	return rc;
 }


