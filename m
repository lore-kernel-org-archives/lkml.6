Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233D0C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73F82082C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73F82082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbeH3Soa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:44:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729048AbeH3So3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:44:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4259F804B9F4;
        Thu, 30 Aug 2018 14:42:00 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.20.6.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9C9563F25;
        Thu, 30 Aug 2018 14:41:59 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Balbir Singh <bsingharora@gmail.com>, stable@vger.kernel.org
Subject: [PATCH 3/7] mm/rmap: map_pte() was not handling private ZONE_DEVICE page properly v2
Date:   Thu, 30 Aug 2018 10:41:56 -0400
Message-Id: <20180830144156.7226-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20180824192549.30844-3-jglisse@redhat.com>
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 14:42:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 30 Aug 2018 14:42:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jglisse@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

Private ZONE_DEVICE pages use a special pte entry and thus are not
present. Properly handle this case in map_pte(), it is already handled
in check_pte(), the map_pte() part was lost in some rebase most probably.

Without this patch the slow migration path can not migrate back private
ZONE_DEVICE memory to regular memory. This was found after stress
testing migration back to system memory. This ultimatly can lead the
CPU to an infinite page fault loop on the special swap entry.

Changes since v1:
    - properly lock pte directory in map_pte()

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: stable@vger.kernel.org
---
 mm/page_vma_mapped.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index ae3c2a35d61b..bd67e23dce33 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -21,7 +21,14 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw)
 			if (!is_swap_pte(*pvmw->pte))
 				return false;
 		} else {
-			if (!pte_present(*pvmw->pte))
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
2.17.1

