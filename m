Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67223C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22338204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22338204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbeGYRm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:42:28 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25309 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbeGYRm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:42:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=PvBVzqOaFRyx0/aCaj6my9vH64ieet5+AuTx3Nhl5oldcUtOI1PaGHr3ZCkLLB0BMtpbck6AX0D2
    rMJQTfHnmfyoBDuY+Sqppn4m3SomFbn8xqfTbv7ZlclvafRzhdd5  
Received: from YEHS1XR956R00D1.lenovo.com (114.245.13.10 [114.245.13.10]) by mx.zohomail.com
        with SMTPS id 1532536177219161.6186001027811; Wed, 25 Jul 2018 09:29:37 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org, dan.j.williams@intel.com
Cc:     ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        viro@zeniv.linux.org.uk, martin.petersen@oracle.com,
        axboe@kernel.dk, gregkh@linuxfoundation.org,
        bart.vanassche@wdc.com, jack@suse.cz, agk@redhat.com,
        snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, chengnt@lenovo.com, colyli@suse.de,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH v2 3/6] tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()
Date:   Thu, 26 Jul 2018 00:28:46 +0800
Message-Id: <20180725162849.8320-4-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20180725162849.8320-1-yehs2007@zoho.com>
References: <20180725162849.8320-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The mock / test version of pmem_direct_access() needs to check the
validity of pointers kaddr and pfn for NULL assignment. If anyone
equals to NULL, it doesn't need to calculate the value.

If pointer equals to NULL, that is to say callers may have no need for
kaddr or pfn, so this patch is prepared for allowing them to pass in
NULL instead of having to pass in a local pointer or variable that
they then just throw away.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 tools/testing/nvdimm/pmem-dax.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-dax.c
index b53596a..2e7fd82 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -31,17 +31,21 @@ long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 	if (get_nfit_res(pmem->phys_addr + offset)) {
 		struct page *page;
 
-		*kaddr = pmem->virt_addr + offset;
+		if (kaddr)
+			*kaddr = pmem->virt_addr + offset;
 		page = vmalloc_to_page(pmem->virt_addr + offset);
-		*pfn = page_to_pfn_t(page);
+		if (pfn)
+			*pfn = page_to_pfn_t(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
 				__func__, pmem, pgoff, page_to_pfn(page));
 
 		return 1;
 	}
 
-	*kaddr = pmem->virt_addr + offset;
-	*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+	if (kaddr)
+		*kaddr = pmem->virt_addr + offset;
+	if (pfn)
+		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
 
 	/*
 	 * If badblocks are present, limit known good range to the
-- 
1.8.3.1


