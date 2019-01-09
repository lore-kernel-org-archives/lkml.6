Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC813C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D17C2146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 02:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfAICCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 21:02:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58108 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbfAICCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 21:02:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0F8488319;
        Wed,  9 Jan 2019 02:02:08 +0000 (UTC)
Received: from sky.random (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA69B101963E;
        Wed,  9 Jan 2019 02:02:05 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 1/1] mm/hugetlb.c: teach follow_hugetlb_page() to handle FOLL_NOWAIT
Date:   Tue,  8 Jan 2019 21:02:03 -0500
Message-Id: <20190109020203.26669-2-aarcange@redhat.com>
In-Reply-To: <20190109020203.26669-1-aarcange@redhat.com>
References: <20190109020203.26669-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 09 Jan 2019 02:02:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb needs the same fix as faultin_nopage (which was applied in
96312e61282ae3f6537a562625706498cbc75594) or KVM hangs because it
thinks the mmap_sem was already released by hugetlb_fault() if it
returned VM_FAULT_RETRY, but it wasn't in the FOLL_NOWAIT case.

Fixes: ce53053ce378 ("kvm: switch get_user_page_nowait() to get_user_pages_unlocked()")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
Tested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reported-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
---
 mm/hugetlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e37efd5d8318..b3622d7888c8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4301,7 +4301,8 @@ long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 				break;
 			}
 			if (ret & VM_FAULT_RETRY) {
-				if (nonblocking)
+				if (nonblocking &&
+				    !(fault_flags & FAULT_FLAG_RETRY_NOWAIT))
 					*nonblocking = 0;
 				*nr_pages = 0;
 				/*
