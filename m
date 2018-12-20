Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4EEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC442176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 08:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbeLTIZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 03:25:02 -0500
Received: from ozlabs.ru ([107.173.13.209]:54840 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731085AbeLTIY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 03:24:59 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id B5A2DAE80381;
        Thu, 20 Dec 2018 03:24:54 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        Alistair Popple <alistair@popple.id.au>,
        Reza Arbab <arbab@linux.ibm.com>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Piotr Jaroszynski <pjaroszynski@nvidia.com>,
        =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= 
        <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>,
        Daniel Henrique Barboza <danielhb413@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH kernel v7 17/20] powerpc/powernv/npu: Fault user page into the hypervisor's pagetable
Date:   Thu, 20 Dec 2018 19:23:47 +1100
Message-Id: <20181220082350.58113-18-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a page fault happens in a GPU, the GPU signals the OS and the GPU
driver calls the fault handler which populated a page table; this allows
the GPU to complete an ATS request.

On the bare metal get_user_pages() is enough as it adds a pte to
the kernel page table but under KVM the partition scope tree does not get
updated so ATS will still fail.

This reads a byte from an effective address which causes HV storage
interrupt and KVM updates the partition scope tree.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index c6163b9..12b8421 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -1133,6 +1133,8 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 	u64 rc = 0, result = 0;
 	int i, is_write;
 	struct page *page[1];
+	const char __user *u;
+	char c;
 
 	/* mmap_sem should be held so the struct_mm must be present */
 	struct mm_struct *mm = context->mm;
@@ -1145,18 +1147,17 @@ int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 					is_write ? FOLL_WRITE : 0,
 					page, NULL, NULL);
 
-		/*
-		 * To support virtualised environments we will have to do an
-		 * access to the page to ensure it gets faulted into the
-		 * hypervisor. For the moment virtualisation is not supported in
-		 * other areas so leave the access out.
-		 */
 		if (rc != 1) {
 			status[i] = rc;
 			result = -EFAULT;
 			continue;
 		}
 
+		/* Make sure partition scoped tree gets a pte */
+		u = page_address(page[0]);
+		if (__get_user(c, u))
+			result = -EFAULT;
+
 		status[i] = 0;
 		put_page(page[0]);
 	}
-- 
2.17.1

