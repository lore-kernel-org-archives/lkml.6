Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE536C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F5C21471
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F5C21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403807AbeHNUfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:35:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390379AbeHNUfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:35:31 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78BD3C74;
        Tue, 14 Aug 2018 17:47:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        David Airlie <airlied@linux.ie>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 31/43] mm: fix cache mode tracking in vm_insert_mixed()
Date:   Tue, 14 Aug 2018 19:18:07 +0200
Message-Id: <20180814171519.142204859@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171517.014285600@linuxfoundation.org>
References: <20180814171517.014285600@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit 87744ab3832b83ba71b931f86f9cfdb000d07da5 upstream

vm_insert_mixed() unlike vm_insert_pfn_prot() and vmf_insert_pfn_pmd(),
fails to check the pgprot_t it uses for the mapping against the one
recorded in the memtype tracking tree.  Add the missing call to
track_pfn_insert() to preclude cases where incompatible aliased mappings
are established for a given physical address range.

[groeck: Backport to v4.4.y]

Link: http://lkml.kernel.org/r/147328717909.35069.14256589123570653697.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memory.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1654,10 +1654,14 @@ EXPORT_SYMBOL(vm_insert_pfn_prot);
 int vm_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
 			unsigned long pfn)
 {
+	pgprot_t pgprot = vma->vm_page_prot;
+
 	BUG_ON(!(vma->vm_flags & VM_MIXEDMAP));
 
 	if (addr < vma->vm_start || addr >= vma->vm_end)
 		return -EFAULT;
+	if (track_pfn_insert(vma, &pgprot, pfn))
+		return -EINVAL;
 
 	/*
 	 * If we don't have pte special, then we have to use the pfn_valid()
@@ -1670,9 +1674,9 @@ int vm_insert_mixed(struct vm_area_struc
 		struct page *page;
 
 		page = pfn_to_page(pfn);
-		return insert_page(vma, addr, page, vma->vm_page_prot);
+		return insert_page(vma, addr, page, pgprot);
 	}
-	return insert_pfn(vma, addr, pfn, vma->vm_page_prot);
+	return insert_pfn(vma, addr, pfn, pgprot);
 }
 EXPORT_SYMBOL(vm_insert_mixed);
 


