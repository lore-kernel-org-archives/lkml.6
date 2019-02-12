Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EE1C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451C921773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfBLC54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:57:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbfBLC54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:57:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA48A81DEB;
        Tue, 12 Feb 2019 02:57:55 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D30F600C6;
        Tue, 12 Feb 2019 02:57:37 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>, peterx@redhat.com,
        Martin Cracauer <cracauer@cons.org>, Shaohua Li <shli@fb.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Pavel Emelyanov <xemul@parallels.com>,
        Rik van Riel <riel@redhat.com>
Subject: [PATCH v2 06/26] userfaultfd: wp: add helper for writeprotect check
Date:   Tue, 12 Feb 2019 10:56:12 +0800
Message-Id: <20190212025632.28946-7-peterx@redhat.com>
In-Reply-To: <20190212025632.28946-1-peterx@redhat.com>
References: <20190212025632.28946-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 12 Feb 2019 02:57:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaohua Li <shli@fb.com>

add helper for writeprotect check. Will use it later.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Pavel Emelyanov <xemul@parallels.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 37c9eba75c98..38f748e7186e 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -50,6 +50,11 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 	return vma->vm_flags & VM_UFFD_MISSING;
 }
 
+static inline bool userfaultfd_wp(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_UFFD_WP;
+}
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP);
@@ -94,6 +99,11 @@ static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 	return false;
 }
 
+static inline bool userfaultfd_wp(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 {
 	return false;
-- 
2.17.1

