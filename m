Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AA8C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256822087A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256822087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeIGOEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:04:55 -0400
Received: from mga03.intel.com ([134.134.136.65]:33040 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbeIGOEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:04:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 02:24:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="71100215"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 07 Sep 2018 02:24:52 -0700
Received: from dazhang1-ssd.sh.intel.com (unknown [10.239.48.163])
        by linux.intel.com (Postfix) with ESMTP id 780375802B3;
        Fri,  7 Sep 2018 02:24:49 -0700 (PDT)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de
Cc:     linux-mm@kvack.org, rkrcmar@redhat.com, jglisse@redhat.com,
        yi.z.zhang@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [PATCH V5 3/4] mm: add a function to differentiate the pages is from DAX device memory
Date:   Sat,  8 Sep 2018 02:03:55 +0800
Message-Id: <044309496afbb4121447dff6a453bd6b96d6068d.1536342881.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
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
Acked-by: Jan Kara <jack@suse.cz>
---
 include/linux/mm.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 68a5121..de5cbc3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -889,6 +889,13 @@ static inline bool is_device_public_page(const struct page *page)
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
@@ -912,6 +919,11 @@ static inline bool is_device_public_page(const struct page *page)
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

