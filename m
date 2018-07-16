Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4784ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9816320864
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9816320864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbeGPIEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:04:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732677AbeGPIEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:04:30 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96920CA1;
        Mon, 16 Jul 2018 07:38:28 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.17 35/67] mm: do not drop unused pages when userfaultd is running
Date:   Mon, 16 Jul 2018 09:35:04 +0200
Message-Id: <20180716073448.643250194@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073443.294323458@linuxfoundation.org>
References: <20180716073443.294323458@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit bce73e4842390f7b7309c8e253e139db71288ac3 upstream.

KVM guests on s390 can notify the host of unused pages.  This can result
in pte_unused callbacks to be true for KVM guest memory.

If a page is unused (checked with pte_unused) we might drop this page
instead of paging it.  This can have side-effects on userfaultd, when
the page in question was already migrated:

The next access of that page will trigger a fault and a user fault
instead of faulting in a new and empty zero page.  As QEMU does not
expect a userfault on an already migrated page this migration will fail.

The most straightforward solution is to ignore the pte_unused hint if a
userfault context is active for this VMA.

Link: http://lkml.kernel.org/r/20180703171854.63981-1-borntraeger@de.ibm.com
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/rmap.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -64,6 +64,7 @@
 #include <linux/backing-dev.h>
 #include <linux/page_idle.h>
 #include <linux/memremap.h>
+#include <linux/userfaultfd_k.h>
 
 #include <asm/tlbflush.h>
 
@@ -1481,11 +1482,16 @@ static bool try_to_unmap_one(struct page
 				set_pte_at(mm, address, pvmw.pte, pteval);
 			}
 
-		} else if (pte_unused(pteval)) {
+		} else if (pte_unused(pteval) && !userfaultfd_armed(vma)) {
 			/*
 			 * The guest indicated that the page content is of no
 			 * interest anymore. Simply discard the pte, vmscan
 			 * will take care of the rest.
+			 * A future reference will then fault in a new zero
+			 * page. When userfaultfd is active, we must not drop
+			 * this page though, as its main user (postcopy
+			 * migration) will not expect userfaults on already
+			 * copied pages.
 			 */
 			dec_mm_counter(mm, mm_counter(page));
 			/* We have to invalidate as we cleared the pte */


