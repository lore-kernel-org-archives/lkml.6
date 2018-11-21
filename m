Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850E5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D842145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D842145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeKUQzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:55:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41006 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeKUQzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:55:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA7BC89ACE;
        Wed, 21 Nov 2018 06:21:52 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74DD2600C3;
        Wed, 21 Nov 2018 06:21:44 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Jerome Glisse <jglisse@redhat.com>, peterx@redhat.com,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RFC v3 4/4] mm: gup: allow VM_FAULT_RETRY for multiple times
Date:   Wed, 21 Nov 2018 14:21:03 +0800
Message-Id: <20181121062103.18835-5-peterx@redhat.com>
In-Reply-To: <20181121062103.18835-1-peterx@redhat.com>
References: <20181121062103.18835-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 21 Nov 2018 06:21:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the gup counterpart of the change that allows the VM_FAULT_RETRY
to happen for more than once.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/gup.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a40111c742ba..7c3b3ab6be88 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -528,7 +528,10 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
 	if (*flags & FOLL_NOWAIT)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT;
 	if (*flags & FOLL_TRIED) {
-		VM_WARN_ON_ONCE(fault_flags & FAULT_FLAG_ALLOW_RETRY);
+		/*
+		 * Note: FAULT_FLAG_ALLOW_RETRY and FAULT_FLAG_TRIED
+		 * can co-exist
+		 */
 		fault_flags |= FAULT_FLAG_TRIED;
 	}
 
@@ -944,17 +947,23 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
 		/* VM_FAULT_RETRY triggered, so seek to the faulting offset */
 		pages += ret;
 		start += ret << PAGE_SHIFT;
+		lock_dropped = true;
 
+retry:
 		/*
 		 * Repeat on the address that fired VM_FAULT_RETRY
-		 * without FAULT_FLAG_ALLOW_RETRY but with
+		 * with both FAULT_FLAG_ALLOW_RETRY and
 		 * FAULT_FLAG_TRIED.
 		 */
 		*locked = 1;
-		lock_dropped = true;
 		down_read(&mm->mmap_sem);
 		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
-				       pages, NULL, NULL);
+				       pages, NULL, locked);
+		if (!*locked) {
+			/* Continue to retry until we succeeded */
+			BUG_ON(ret != 0);
+			goto retry;
+		}
 		if (ret != 1) {
 			BUG_ON(ret > 1);
 			if (!pages_done)
-- 
2.17.1

