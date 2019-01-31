Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA406C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E1C218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbfAaKa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:30:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfAaKa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:30:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1341DC05E740;
        Thu, 31 Jan 2019 10:30:29 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B15675D787;
        Thu, 31 Jan 2019 10:30:23 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alistair Popple <alistair@popple.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Balbir Singh <bsingharora@gmail.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv/npu: Remove redundant change_pte() hook
Date:   Thu, 31 Jan 2019 18:30:22 +0800
Message-Id: <20190131103022.10218-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 31 Jan 2019 10:30:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change_pte() notifier was designed to use as a quick path to
update secondary MMU PTEs on write permission changes or PFN changes.
For KVM, it could reduce the vm-exits when vcpu faults on the pages
that was touched up by KSM.  It's not used to do cache invalidations,
for example, if we see the notifier will be called before the real PTE
update after all (please see set_pte_at_notify that set_pte_at was
called later).

All the necessary cache invalidation should all be done in
invalidate_range() already.

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Michael Ellerman <mpe@ellerman.id.au>
CC: Alistair Popple <alistair@popple.id.au>
CC: Alexey Kardashevskiy <aik@ozlabs.ru>
CC: Mark Hairgrove <mhairgrove@nvidia.com>
CC: Balbir Singh <bsingharora@gmail.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Andrea Arcangeli <aarcange@redhat.com>
CC: Jerome Glisse <jglisse@redhat.com>
CC: Jason Wang <jasowang@redhat.com>
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 3f58c7dbd581..c003b29d870e 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -917,15 +917,6 @@ static void pnv_npu2_mn_release(struct mmu_notifier *mn,
 	mmio_invalidate(npu_context, 0, ~0UL);
 }
 
-static void pnv_npu2_mn_change_pte(struct mmu_notifier *mn,
-				struct mm_struct *mm,
-				unsigned long address,
-				pte_t pte)
-{
-	struct npu_context *npu_context = mn_to_npu_context(mn);
-	mmio_invalidate(npu_context, address, PAGE_SIZE);
-}
-
 static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long start, unsigned long end)
@@ -936,7 +927,6 @@ static void pnv_npu2_mn_invalidate_range(struct mmu_notifier *mn,
 
 static const struct mmu_notifier_ops nv_nmmu_notifier_ops = {
 	.release = pnv_npu2_mn_release,
-	.change_pte = pnv_npu2_mn_change_pte,
 	.invalidate_range = pnv_npu2_mn_invalidate_range,
 };
 
-- 
2.17.1

