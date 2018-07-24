Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D0DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C9E20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C9E20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbeGXJvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:51:51 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25474 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388309AbeGXJvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:51:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=qRAFapu8KPe4xfhMEFhW5JhX6o47j2tJupaj9NeiIcXRBBZK1TYh5lY885YrZ06nWcJH4dBRA3hV
    Dg9FKduoc4k7Dsqs0PUyEtcPSBTIVxdzndAUkjOQBFCJq7ORpBwJ  
Received: from YEHS1XR956R00D1.lenovo.com (123.120.61.139 [123.120.61.139]) by mx.zohomail.com
        with SMTPS id 1532421958498232.824748445154; Tue, 24 Jul 2018 01:45:58 -0700 (PDT)
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
Subject: [PATCH 5/5] dax/super: Do not request a pointer kaddr when not required
Date:   Tue, 24 Jul 2018 16:45:10 +0800
Message-Id: <20180724084510.6104-6-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20180724084510.6104-1-yehs2007@zoho.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Some functions within driver/dax don't need to get pointer kaddr from
direct_access. In support of allowing memmap initialization to run in
the background elide requests for pointer kaddr when not required.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/dax/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 2b2332b..fad68d2 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -88,7 +88,6 @@ int __bdev_dax_supported(struct super_block *sb, int blocksize)
 	struct dax_device *dax_dev;
 	pgoff_t pgoff;
 	int err, id;
-	void *kaddr;
 	pfn_t pfn;
 	long len;
 
@@ -113,7 +112,7 @@ int __bdev_dax_supported(struct super_block *sb, int blocksize)
 	}
 
 	id = dax_read_lock();
-	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
+	len = dax_direct_access(dax_dev, pgoff, 1, NULL, &pfn);
 	dax_read_unlock(id);
 
 	put_dax(dax_dev);
-- 
1.8.3.1


