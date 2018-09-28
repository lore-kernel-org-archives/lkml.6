Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43830C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD10D206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD10D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeI2E6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:58:02 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55445 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725938AbeI2E6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:58:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T9evJAE_1538173916;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T9evJAE_1538173916)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Sep 2018 06:32:02 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     dan.j.williams@intel.com, jack@suse.cz,
        ross.zwisler@linux.intel.com, kirill.shutemov@linux.intel.com,
        akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: enforce THP for VM_NOHUGEPAGE dax mappings
Date:   Sat, 29 Sep 2018 06:31:56 +0800
Message-Id: <1538173916-95849-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit baabda261424517110ea98c6651f632ebf2561e3 ("mm: always enable thp
for dax mappings") says madvise hguepage policy makes less sense for
dax, and force enabling thp for dax mappings in all cases, even though
THP is set to "never".

However, transparent_hugepage_enabled() may return false if
VM_NOHUGEPAGE is set even though the mapping is dax.

So, move is_vma_dax() check to the very beginning to enforce THP for dax
mappings in all cases.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
I didn't find anyone mention the check should be before VM_NOHUGEPAGE in
the review for Dan's original patch. And, that patch commit log states
clearly that THP for dax mapping for all cases even though THP is never.
So, I'm supposed it should behave in this way.

 include/linux/huge_mm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 99c19b0..b2ad305 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -95,6 +95,9 @@ extern ssize_t single_hugepage_flag_show(struct kobject *kobj,
 
 static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 {
+	if (vma_is_dax(vma))
+		return true;
+
 	if (vma->vm_flags & VM_NOHUGEPAGE)
 		return false;
 
@@ -107,9 +110,6 @@ static inline bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
 		return true;
 
-	if (vma_is_dax(vma))
-		return true;
-
 	if (transparent_hugepage_flags &
 				(1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
 		return !!(vma->vm_flags & VM_HUGEPAGE);
-- 
1.8.3.1

