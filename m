Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F213AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47CA20880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 03:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47CA20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeILIjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 04:39:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:25880 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbeILIjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 04:39:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 20:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,363,1531810800"; 
   d="scan'208";a="72252232"
Received: from shbuild000.sh.intel.com (HELO byang_ol.sh.intel.com) ([10.239.144.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 20:36:40 -0700
From:   Bin Yang <bin.yang@intel.com>
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        bin.yang@intel.com
Subject: [PATCH] pstore: fix incorrect persistent ram buffer mapping
Date:   Wed, 12 Sep 2018 03:36:34 +0000
Message-Id: <1536723394-14616-1-git-send-email-bin.yang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

persistent_ram_vmap() returns the page start vaddr.
persistent_ram_iomap() supports non-page-aligned mapping.

persistent_ram_buffer_map() always adds offset-in-page to the vaddr
returned from these two functions, which causes incorrect mapping of
non-page-aligned persistent ram buffer.

Signed-off-by: Bin Yang <bin.yang@intel.com>
---
 fs/pstore/ram_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 951a14e..7c05fdd 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -429,7 +429,7 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
 	vaddr = vmap(pages, page_count, VM_MAP, prot);
 	kfree(pages);
 
-	return vaddr;
+	return vaddr + offset_in_page(start);
 }
 
 static void *persistent_ram_iomap(phys_addr_t start, size_t size,
@@ -468,7 +468,7 @@ static int persistent_ram_buffer_map(phys_addr_t start, phys_addr_t size,
 		return -ENOMEM;
 	}
 
-	prz->buffer = prz->vaddr + offset_in_page(start);
+	prz->buffer = prz->vaddr;
 	prz->buffer_size = size - sizeof(struct persistent_ram_buffer);
 
 	return 0;
@@ -515,7 +515,7 @@ void persistent_ram_free(struct persistent_ram_zone *prz)
 
 	if (prz->vaddr) {
 		if (pfn_valid(prz->paddr >> PAGE_SHIFT)) {
-			vunmap(prz->vaddr);
+			vunmap(prz->vaddr - offset_in_page(prz->paddr));
 		} else {
 			iounmap(prz->vaddr);
 			release_mem_region(prz->paddr, prz->size);
-- 
2.7.4

