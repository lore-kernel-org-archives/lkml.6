Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04896C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5CB20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA5CB20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbeLFIqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:46:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbeLFIqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:46:13 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A1E630013B2;
        Thu,  6 Dec 2018 08:46:12 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2172D19C7B;
        Thu,  6 Dec 2018 08:46:05 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org
Subject: [PATCH] mm: thp: fix soft dirty for migration when split
Date:   Thu,  6 Dec 2018 16:46:04 +0800
Message-Id: <20181206084604.17167-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 06 Dec 2018 08:46:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When splitting a huge migrating PMD, we'll transfer the soft dirty bit
from the huge page to the small pages.  However we're possibly using a
wrong data since when fetching the bit we're using pmd_soft_dirty()
upon a migration entry.  Fix it up.

CC: Andrea Arcangeli <aarcange@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Michal Hocko <mhocko@suse.com>
CC: Dave Jiang <dave.jiang@intel.com>
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
CC: Souptick Joarder <jrdr.linux@gmail.com>
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---

I noticed this during code reading.  Only compile tested.  I'm sending
a patch directly for review comments since it's relatively
straightforward and not easy to test.  Please have a look, thanks.
---
 mm/huge_memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f2d19e4fe854..fb0787c3dd3b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2161,7 +2161,10 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		SetPageDirty(page);
 	write = pmd_write(old_pmd);
 	young = pmd_young(old_pmd);
-	soft_dirty = pmd_soft_dirty(old_pmd);
+	if (unlikely(pmd_migration))
+		soft_dirty = pmd_swp_soft_dirty(old_pmd);
+	else
+		soft_dirty = pmd_soft_dirty(old_pmd);
 
 	/*
 	 * Withdraw the table only after we mark the pmd entry invalid.
-- 
2.17.1

