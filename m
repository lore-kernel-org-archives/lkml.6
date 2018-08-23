Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E1EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC92208EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 05:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC92208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbeHWImR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:42:17 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:58674 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728374AbeHWImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:42:17 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 22 Aug 2018 22:14:15 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 437B1B09EB;
        Thu, 23 Aug 2018 01:14:24 -0400 (EDT)
From:   Nadav Amit <namit@vmware.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Nadav Amit <namit@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <stable@vger.kernel.org>
Subject: [PATCH] mm: respect arch_dup_mmap() return value
Date:   Wed, 22 Aug 2018 22:12:29 -0700
Message-ID: <20180823051229.211856-1-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-001.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d70f2a14b72a4 ("include/linux/sched/mm.h: uninline
mmdrop_async(), etc") ignored the return value of arch_dup_mmap(). As a
result, on x86, a failure to duplicate the LDT (e.g., due to memory
allocation error), would leave the duplicated memory mapping in an
inconsistent state.

Fix by regarding the return value, as it was before the change.

Fixes: d70f2a14b72a4 ("include/linux/sched/mm.h: uninline mmdrop_async(), etc")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 kernel/fork.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 1b27babc4c78..4527d1d331de 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -549,8 +549,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			goto out;
 	}
 	/* a new mm has just been created */
-	arch_dup_mmap(oldmm, mm);
-	retval = 0;
+	retval = arch_dup_mmap(oldmm, mm);
 out:
 	up_write(&mm->mmap_sem);
 	flush_tlb_mm(oldmm);
-- 
2.17.1

