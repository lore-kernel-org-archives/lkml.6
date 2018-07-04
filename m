Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C324C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4187244E8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4187244E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933589AbeGDGmE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:42:04 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25362 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753529AbeGDGmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:42:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=ax1loErtujNi/IhcipszvX7zvTJIN5Z9gjsnODXpd1nH1eAIFFR8XWgNOe5WhR+7AuQ8nmVaJ2VT
    upzeBzkvswChSzf1mjuvuLt1ZrRRrdRSjDqt9o2K/kercCBhyAO/  
Received: from YEHS1XR956R00D1.lenovo.com (114.246.209.104 [114.246.209.104]) by mx.zohomail.com
        with SMTPS id 1530686483792632.9088456310267; Tue, 3 Jul 2018 23:41:23 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        mawilcox@microsoft.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk,
        martin.petersen@oracle.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.com,
        chengnt@lenovo.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 1/3] nvdimm/pmem: check the validity of the pointer pfn
Date:   Wed,  4 Jul 2018 14:40:56 +0800
Message-Id: <20180704064058.1344-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Some functions within fs/dax don't need to get gfn from direct_access.
Assigning NULL to gfn of dax_direct_access is more intuitive and simple
than offering a useless local variable.

So direct_access needs to check validity of the pointer pfn For NULL
assignment.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/nvdimm/pmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 9d71492..018f990 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -233,7 +233,8 @@ __weak long __pmem_direct_access(struct pmem_device *pmem, pgoff_t pgoff,
 					PFN_PHYS(nr_pages))))
 		return -EIO;
 	*kaddr = pmem->virt_addr + offset;
-	*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+	if (pfn)
+		*pfn = phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
 
 	/*
 	 * If badblocks are present, limit known good range to the
-- 
1.8.3.1


