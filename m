Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A10C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D25E204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D25E204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbeGYRmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:42:37 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25325 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbeGYRmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:42:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=jp8VGJs5soN22vzWQ7c3bpKokb3GM0auhPIehJhF1SOnqoNNCmrv1ZYUChHHC9fJuDGYSLJiQYGf
    l7FrY2sasOEixHgohKi9/N7vhSbxEg4r34ZaLAeWq818TnonPSeP  
Received: from YEHS1XR956R00D1.lenovo.com (114.245.13.10 [114.245.13.10]) by mx.zohomail.com
        with SMTPS id 1532536186173683.0214219839062; Wed, 25 Jul 2018 09:29:46 -0700 (PDT)
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
Subject: [PATCH v2 4/6] dax/super: Do not request a pointer kaddr when not required
Date:   Thu, 26 Jul 2018 00:28:47 +0800
Message-Id: <20180725162849.8320-5-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20180725162849.8320-1-yehs2007@zoho.com>
References: <20180725162849.8320-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

Function __bdev_dax_supported doesn't need to get local pointer kaddr
from direct_access. Using NULL instead of having to pass in a useless
local pointer that caller then just throw away.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/dax/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 45276ab..6e928f3 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -89,7 +89,6 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 	struct request_queue *q;
 	pgoff_t pgoff;
 	int err, id;
-	void *kaddr;
 	pfn_t pfn;
 	long len;
 	char buf[BDEVNAME_SIZE];
@@ -122,7 +121,7 @@ bool __bdev_dax_supported(struct block_device *bdev, int blocksize)
 	}
 
 	id = dax_read_lock();
-	len = dax_direct_access(dax_dev, pgoff, 1, &kaddr, &pfn);
+	len = dax_direct_access(dax_dev, pgoff, 1, NULL, &pfn);
 	dax_read_unlock(id);
 
 	put_dax(dax_dev);
-- 
1.8.3.1


