Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09A2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F90206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 06:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfBWGsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 01:48:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfBWGsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 01:48:23 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A4F7CDC8D62B86813F93;
        Sat, 23 Feb 2019 14:48:16 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Sat, 23 Feb 2019 14:48:05 +0800
From:   Xuefeng Wang <wxf.wang@hisilicon.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wxf.wang@hisilicon.com>, <guohanjun@huawei.com>
Subject: [PATCH] Use flush tlb last level when change protection
Date:   Sat, 23 Feb 2019 14:47:27 +0800
Message-ID: <1550904447-45567-1-git-send-email-wxf.wang@hisilicon.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The protection attributes are only kept in last level tlb, so
protection changing only need invalidate last level tlb, exclude
the PWC entries.

Signed-off-by: Xuefeng Wang <wxf.wang@hisilicon.com>
---
 mm/mprotect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 36cb358..0c4303d 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -287,7 +287,7 @@ static unsigned long change_protection_range(struct vm_area_struct *vma,
 
 	/* Only flush the TLB if we actually modified any entries: */
 	if (pages)
-		flush_tlb_range(vma, start, end);
+		__flush_tlb_range(vma, start, end, PAGE_SIZE, true);
 	dec_tlb_flush_pending(mm);
 
 	return pages;
-- 
1.7.12.4

