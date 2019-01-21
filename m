Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D3C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AE820823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbfAUH7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:59:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbfAUH7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:59:05 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A1EB9FDD4;
        Mon, 21 Jan 2019 07:59:05 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62EC9608C2;
        Mon, 21 Jan 2019 07:58:57 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH RFC 11/24] userfaultfd: wp: userfaultfd_pte/huge_pmd_wp() helpers
Date:   Mon, 21 Jan 2019 15:57:09 +0800
Message-Id: <20190121075722.7945-12-peterx@redhat.com>
In-Reply-To: <20190121075722.7945-1-peterx@redhat.com>
References: <20190121075722.7945-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 21 Jan 2019 07:59:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <aarcange@redhat.com>

Implement helpers methods to invoke userfaultfd wp faults more
selectively: not only when a wp fault triggers on a vma with
vma->vm_flags VM_UFFD_WP set, but only if the _PAGE_UFFD_WP bit is set
in the pagetable too.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index e82f3156f4e9..0d3b32b54e2a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -14,6 +14,8 @@
 #include <linux/userfaultfd.h> /* linux/include/uapi/linux/userfaultfd.h */
 
 #include <linux/fcntl.h>
+#include <linux/mm.h>
+#include <asm-generic/pgtable_uffd.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -57,6 +59,18 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_UFFD_WP;
 }
 
+static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
+				      pte_t pte)
+{
+	return userfaultfd_wp(vma) && pte_uffd_wp(pte);
+}
+
+static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
+					   pmd_t pmd)
+{
+	return userfaultfd_wp(vma) && pmd_uffd_wp(pmd);
+}
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
@@ -106,6 +120,19 @@ static inline bool userfaultfd_wp(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
+				      pte_t pte)
+{
+	return false;
+}
+
+static inline bool userfaultfd_huge_pmd_wp(struct vm_area_struct *vma,
+					   pmd_t pmd)
+{
+	return false;
+}
+
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return false;
-- 
2.17.1

