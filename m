Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7114DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A8120871
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A8120871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeGJIYJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:24:09 -0400
Received: from mga06.intel.com ([134.134.136.31]:56568 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751210AbeGJIYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:24:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 01:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,333,1526367600"; 
   d="scan'208";a="73579946"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2018 01:24:06 -0700
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.78])
        by linux.intel.com (Postfix) with ESMTP id DA51D5803A0;
        Tue, 10 Jul 2018 01:24:06 -0700 (PDT)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, rkrcmar@redhat.com,
        Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [PATCH V2 3/4] mm: add a function to differentiate the pages is from DAX device memory
Date:   Wed, 11 Jul 2018 01:02:30 +0800
Message-Id: <a0d220839ce0414f13e9394dffcd9abe8689dafe.1531241281.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531241281.git.yi.z.zhang@linux.intel.com>
References: <cover.1531241281.git.yi.z.zhang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAX driver hotplug the device memory and move it to memory zone, these
pages will be marked reserved flag, however, some other kernel componet
will misconceive these pages are reserved mmio (ex: we map these dev_dax
or fs_dax pages to kvm for DIMM/NVDIMM backend). Together with the type
MEMORY_DEVICE_FS_DAX, we can use is_dax_page() to differentiate the pages
is DAX device memory or not.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Zhang Yu <yu.c.zhang@linux.intel.com>
---
 include/linux/mm.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6e19265..9f0f690 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -856,6 +856,13 @@ static inline bool is_device_public_page(const struct page *page)
 		page->pgmap->type == MEMORY_DEVICE_PUBLIC;
 }
 
+static inline bool is_dax_page(const struct page *page)
+{
+	return is_zone_device_page(page) &&
+		(page->pgmap->type == MEMORY_DEVICE_FS_DAX ||
+		page->pgmap->type == MEMORY_DEVICE_DEV_DAX);
+}
+
 #else /* CONFIG_DEV_PAGEMAP_OPS */
 static inline void dev_pagemap_get_ops(void)
 {
@@ -879,6 +886,11 @@ static inline bool is_device_public_page(const struct page *page)
 {
 	return false;
 }
+
+static inline bool is_dax_page(const struct page *page)
+{
+	return false;
+}
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
 static inline void get_page(struct page *page)
-- 
2.7.4

