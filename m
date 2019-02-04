Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074FDC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F382087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfBDOhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:37:47 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:15725 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfBDOhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:37:46 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 145F513F89C;
        Mon,  4 Feb 2019 15:37:22 +0100 (CET)
Subject: [RESEND PATCH v2] of: fix kmemleak crash caused by imbalance in early
 memory reservation
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prateek Patel <prpatel@nvidia.com>,
        DT <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
References: <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
 <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
 <20190121143704.GE29504@arrakis.emea.arm.com>
 <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
 <20190121174234.GC26461@rapoport-lnx>
 <2bb30550-435a-046c-4f45-21dd594aa695@free.fr>
 <3c886941-bf9d-f040-b568-ee7a8eba9a04@free.fr>
 <CGME20190123055509epcas3p18a6d66fa08412f2308cb2c1997328ea8@epcas3p1.samsung.com>
 <20190123055414.GA4747@rapoport-lnx>
 <78f4ea8a-996d-038e-9e33-5ff02fa2c43f@samsung.com>
 <20190123123143.GE4747@rapoport-lnx>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <4b8f82c4-7f8f-b814-c1ec-9902e43963f6@free.fr>
Date:   Mon, 4 Feb 2019 15:37:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190123123143.GE4747@rapoport-lnx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Marc Gonzalez reported the following kmemleak crash:

Unable to handle kernel paging request at virtual address ffffffc021e00000
Mem abort info:
  ESR = 0x96000006
  Exception class = DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 39-bit VAs, pgdp = (____ptrval____)
[ffffffc021e00000] pgd=000000017e3ba803, pud=000000017e3ba803,
pmd=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 6 PID: 523 Comm: kmemleak Tainted: G S      W         5.0.0-rc1 #13
Hardware name: Qualcomm Technologies, Inc. MSM8998 v1 MTP (DT)
pstate: 80000085 (Nzcv daIf -PAN -UAO)
pc : scan_block+0x70/0x190
lr : scan_block+0x6c/0x190
sp : ffffff8012e8bd20
x29: ffffff8012e8bd20 x28: ffffffc0fdbaf018
x27: ffffffc022000000 x26: 0000000000000080
x25: ffffff8011aadf70 x24: ffffffc0f8cc8000
x23: ffffff8010dc8000 x22: ffffff8010dc8830
x21: ffffffc021e00ff9 x20: ffffffc0f8cc8050
x19: ffffffc021e00000 x18: 0000000000002409
x17: 0000000000000200 x16: 0000000000000000
x15: ffffff8010e14dd8 x14: 0000000000002406
x13: 000000004c4dd0c6 x12: ffffffc0f77dad58
x11: 0000000000000001 x10: ffffff8010d9e688
x9 : ffffff8010d9f000 x8 : ffffff8010d9e688
x7 : 0000000000000002 x6 : 0000000000000000
x5 : ffffff8011511c20 x4 : 00000000000026d1
x3 : ffffff8010e14d88 x2 : 5b36396f4e7d4000
x1 : 0000000000208040 x0 : 0000000000000000
Process kmemleak (pid: 523, stack limit = 0x(____ptrval____))
Call trace:
 scan_block+0x70/0x190
 scan_gray_list+0x108/0x1c0
 kmemleak_scan+0x33c/0x7c0
 kmemleak_scan_thread+0x98/0xf0
 kthread+0x11c/0x120
 ret_from_fork+0x10/0x1c
Code: f9000fb4 d503201f 97ffffd2 35000580 (f9400260)
---[ end trace 176d6ed9d86a0c33 ]---
note: kmemleak[523] exited with preempt_count 2

The crash happens when a no-map area is allocated in
early_init_dt_alloc_reserved_memory_arch(). The allocated region is
registered with kmemleak, but it is then removed from memblock using
memblock_remove() that is not kmemleak-aware.

Replacing __memblock_alloc_base() with memblock_find_in_range() makes sure
that the allocated memory is not added to kmemleak and then
memblock_remove()'ing this memory is safe.

As a bonus, since memblock_find_in_range() ensures the allocation in the
specified range, the bounds check can be removed.

Cc: stable@vger.kernel.org # 3.15+
Fixes: 3f0c820664483 ("drivers: of: add initialization code for dynamic reserved memory")
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Prateek Patel <prpatel@nvidia.com>
Tested-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
Resend with DT CCed to reach robh's patch queue
I added CC: stable, Fixes, and Prateek's ack
Trim recipients list to minimize inconvenience
---
 drivers/of/of_reserved_mem.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0adcb1..2ae81604ffef 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -31,27 +31,19 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	phys_addr_t *res_base)
 {
 	phys_addr_t base;
-	/*
-	 * We use __memblock_alloc_base() because memblock_alloc_base()
-	 * panic()s on allocation failure.
-	 */
+
 	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
 	align = !align ? SMP_CACHE_BYTES : align;
-	base = __memblock_alloc_base(size, align, end);
+	base = memblock_find_in_range(size, align, start, end);
 	if (!base)
 		return -ENOMEM;
 
-	/*
-	 * Check if the allocated region fits in to start..end window
-	 */
-	if (base < start) {
-		memblock_free(base, size);
-		return -ENOMEM;
-	}
-
 	*res_base = base;
 	if (nomap)
 		return memblock_remove(base, size);
+	else
+		return memblock_reserve(base, size);
+
 	return 0;
 }
 
-- 
2.7.4
