Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF760ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A941320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A941320856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbeGXJve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:51:34 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25320 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388242AbeGXJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:51:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=kt/CtdzRXVJWkaXdAT1401ODDy5I5GXu2CBbrFpQrFpDEKRuohNH5m8CKclsZkijXkr86cJntFIR
    d7AjwpWkR6a6Ig/6he2RWSZWquatVg7co8yMYXIhsQl4D5XuDaHR  
Received: from YEHS1XR956R00D1.lenovo.com (123.120.61.139 [123.120.61.139]) by mx.zohomail.com
        with SMTPS id 1532421938910645.9391778437785; Tue, 24 Jul 2018 01:45:38 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc:     ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 2/5] tools/testing/nvdimm: Allow a NULL-kaddr to ->direct_access()
Date:   Tue, 24 Jul 2018 16:45:07 +0800
Message-Id: <20180724084510.6104-3-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20180724084510.6104-1-yehs2007@zoho.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The mock / test version of pmem_direct_access() needs to check the
validity of second rank pointer kaddr for NULL assignment. If kaddr
equals to NULL, it doesn't need to calculate the value.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 tools/testing/nvdimm/pmem-dax.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index b53596a..c3ba159 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -31,7 +31,8 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (get_nfit_res(pmem->phys_addr + offset)) {
 		struct page *page;
 
-		*kaddr = pmem->virt_addr + offset;
+		if (kaddr)
+			*kaddr = pmem->virt_addr + offset;
 		page = vmalloc_to_page(pmem->virt_addr + offset);
 		*pfn = page_to_pfn_t(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
@@ -40,7 +41,8 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 		return 1;
 	}
 
-	*kaddr = pmem->virt_addr + offset;
+	if (kaddr)
+		*kaddr = pmem->virt_addr + offset;
 	*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
 
 	/*
-- 
1.8.3.1


