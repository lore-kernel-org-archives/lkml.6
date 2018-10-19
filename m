Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D5EECDE45
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B5B20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B5B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeJTALe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:11:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJTALe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:11:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C77B4E4C0;
        Fri, 19 Oct 2018 16:04:50 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-124-217.rdu2.redhat.com [10.10.124.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45BA46594C;
        Fri, 19 Oct 2018 16:04:49 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: [PATCH 2/6] mm/rmap: map_pte() was not handling private ZONE_DEVICE page properly v3
Date:   Fri, 19 Oct 2018 12:04:38 -0400
Message-Id: <20181019160442.18723-3-jglisse@redhat.com>
In-Reply-To: <20181019160442.18723-1-jglisse@redhat.com>
References: <20181019160442.18723-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 19 Oct 2018 16:04:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

Private ZONE_DEVICE pages use a special pte entry and thus are not
present. Properly handle this case in map_pte(), it is already handled
in check_pte(), the map_pte() part was lost in some rebase most probably.

Without this patch the slow migration path can not migrate back to any
private ZONE_DEVICE memory to regular memory. This was found after stress
testing migration back to system memory. This ultimatly can lead to the CPU
constantly page fault looping on the special swap entry.

Changes since v2:
    - add comments explaining what is going on
Changes since v1:
    - properly lock pte directory in map_pte()

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org
---
 mm/page_vma_mapped.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae3c2a35d61b..11df03e71288 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -21,7 +21,29 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 			if (!is_swap_pte(*pvmw->pte))
 				return false;
 		} else {
-			if (!pte_present(*pvmw->pte))
+			/*
+			 * We get here when we are trying to unmap a private
+			 * device page from the process address space. Such
+			 * page is not CPU accessible and thus is mapped as
+			 * a special swap entry, nonetheless it still does
+			 * count as a valid regular mapping for the page (and
+			 * is accounted as such in page maps count).
+			 *
+			 * So handle this special case as if it was a normal
+			 * page mapping ie lock CPU page table and returns
+			 * true.
+			 *
+			 * For more details on device private memory see HMM
+			 * (include/linux/hmm.h or mm/hmm.c).
+			 */
+			if (is_swap_pte(*pvmw->pte)) {
+				swp_entry_t entry;
+
+				/* Handle un-addressable ZONE_DEVICE memory */
+				entry = pte_to_swp_entry(*pvmw->pte);
+				if (!is_device_private_entry(entry))
+					return false;
+			} else if (!pte_present(*pvmw->pte))
 				return false;
 		}
 	}
-- 
2.17.2

