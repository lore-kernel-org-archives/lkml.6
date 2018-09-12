Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CDBC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB59720833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB59720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbeILLwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:52:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbeILLwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:52:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E752340216F5;
        Wed, 12 Sep 2018 06:49:31 +0000 (UTC)
Received: from xz-x1.redhat.com (ovpn-12-111.pek2.redhat.com [10.72.12.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6802156701;
        Wed, 12 Sep 2018 06:49:21 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Henry Willard <henry.willard@oracle.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>, linux-mm@kvack.org
Subject: [PATCH v2] mm: mprotect: check page dirty when change ptes
Date:   Wed, 12 Sep 2018 14:49:21 +0800
Message-Id: <20180912064921.31015-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 06:49:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 12 Sep 2018 06:49:32 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'peterx@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an extra check on page dirty bit in change_pte_range() since there
might be case where PTE dirty bit is unset but it's actually dirtied.
One example is when a huge PMD is splitted after written: the dirty bit
will be set on the compound page however we won't have the dirty bit set
on each of the small page PTEs.

I noticed this when debugging with a customized kernel that implemented
userfaultfd write-protect.  In that case, the dirty bit will be critical
since that's required for userspace to handle the write protect page
fault (otherwise it'll get a SIGBUS with a loop of page faults).
However it should still be good even for upstream Linux to cover more
scenarios where we shouldn't need to do extra page faults on the small
pages if the previous huge page is already written, so the dirty bit
optimization path underneath can cover more.

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Mel Gorman <mgorman@techsingularity.net>
CC: Khalid Aziz <khalid.aziz@oracle.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: "David S. Miller" <davem@davemloft.net>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Andi Kleen <ak@linux.intel.com>
CC: Henry Willard <henry.willard@oracle.com>
CC: Anshuman Khandual <khandual@linux.vnet.ibm.com>
CC: Andrea Arcangeli <aarcange@redhat.com>
CC: Kirill A. Shutemov <kirill@shutemov.name>
CC: Jerome Glisse <jglisse@redhat.com>
CC: Zi Yan <zi.yan@cs.rutgers.edu>
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
v2:
- checking the dirty bit when changing PTE entries rather than fixing up
  the dirty bit when splitting the huge page PMD.
- rebase to 4.19-rc3

Instead of keeping this in my local tree, I'm giving it another shot to
see whether this could be acceptable for upstream since IMHO it should
still benefit the upstream.  Thanks,
---
 mm/mprotect.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 6d331620b9e5..5fe752515161 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -115,6 +115,17 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (preserve_write)
 				ptent = pte_mk_savedwrite(ptent);
 
+                       /*
+                        * The extra PageDirty() check will make sure
+                        * we'll capture the dirty page even if the PTE
+                        * dirty bit is unset.  One case is when the
+                        * PTE is splitted from a huge PMD, in that
+                        * case the dirty flag might only be set on the
+                        * compound page instead of this PTE.
+                        */
+			if (PageDirty(pte_page(ptent)))
+				ptent = pte_mkdirty(ptent);
+
 			/* Avoid taking write faults for known dirty pages */
 			if (dirty_accountable && pte_dirty(ptent) &&
 					(pte_soft_dirty(ptent) ||
-- 
2.17.1

