Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3DDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6455320869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6455320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeIDMTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:19:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38770 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbeIDMTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:19:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54CBD87927;
        Tue,  4 Sep 2018 07:55:21 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B109202704B;
        Tue,  4 Sep 2018 07:55:11 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Zi Yan <zi.yan@cs.rutgers.edu>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Souptick Joarder <jrdr.linux@gmail.com>, linux-mm@kvack.org
Subject: [PATCH] mm: hugepage: mark splitted page dirty when needed
Date:   Tue,  4 Sep 2018 15:55:10 +0800
Message-Id: <20180904075510.22338-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 07:55:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 04 Sep 2018 07:55:21 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'peterx@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When splitting a huge page, we should set all small pages as dirty if
the original huge page has the dirty bit set before.  Otherwise we'll
lose the original dirty bit.

CC: Andrea Arcangeli <aarcange@redhat.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Michal Hocko <mhocko@suse.com>
CC: Zi Yan <zi.yan@cs.rutgers.edu>
CC: Huang Ying <ying.huang@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>
CC: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
CC: "Jérôme Glisse" <jglisse@redhat.com>
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
CC: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
CC: Souptick Joarder <jrdr.linux@gmail.com>
CC: linux-mm@kvack.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---

To the reviewers: I'm new to the mm world so sorry if this patch is
making silly mistakes, however it did solve a problem for me when
testing with a customized Linux tree mostly based on Andrea's userfault
write-protect work.  Without the change, my customized QEMU/tcg tree
will not be able to do correct UFFDIO_WRITEPROTECT and then QEMU will
get a SIGBUS when faulting multiple times.  With the change (or of
course disabling THP) then UFFDIO_WRITEPROTECT will be able to correctly
resolve the write protections then it runs well.  Any comment would be
welcomed.  TIA.
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c3bc7e9c9a2a..0754a16923d5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2176,6 +2176,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 				entry = pte_mkold(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
+			if (dirty)
+				entry = pte_mkdirty(entry);
 		}
 		pte = pte_offset_map(&_pmd, addr);
 		BUG_ON(!pte_none(*pte));
-- 
2.17.1

