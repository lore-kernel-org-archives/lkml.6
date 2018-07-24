Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A29ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD4520856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 08:46:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD4520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbeGXJvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 05:51:36 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25322 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388242AbeGXJvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 05:51:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=ol3SWcQelw6getPaZ4yqqWg8lcRMbtazynvUu06KkkiXpnLe3Rnhe39Ubd4Rm2mPnL2isMy3oVvJ
    xhLV4+uCLurbyjVRM0C2zdtC5Sv643QJpAuIZJ7PsEm3OdfEIzcA  
Received: from YEHS1XR956R00D1.lenovo.com (123.120.61.139 [123.120.61.139]) by mx.zohomail.com
        with SMTPS id 1532421945283221.46085617076346; Tue, 24 Jul 2018 01:45:45 -0700 (PDT)
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
Subject: [PATCH 3/5] s390, dcssblk: Allow a NULL-kaddr to ->direct_access()
Date:   Tue, 24 Jul 2018 16:45:08 +0800
Message-Id: <20180724084510.6104-4-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20180724084510.6104-1-yehs2007@zoho.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

dcssblk_direct_access() needs to check the validity of second rank
pointer kaddr for NULL assignment. If kaddr equals to NULL, it
doesn't need to calculate the value.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/s390/block/dcssblk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dcssblk.c b/drivers/s390/block/dcssblk.c
index 0a312e4..9c13dc5 100644
--- a/drivers/s390/block/dcssblk.c
+++ b/drivers/s390/block/dcssblk.c
@@ -915,7 +915,8 @@ static DEVICE_ATTR(save, S_IWUSR | S_IRUSR, dcssblk_save_show,
 	unsigned long dev_sz;
 
 	dev_sz = dev_info->end - dev_info->start + 1;
-	*kaddr = (void *) dev_info->start + offset;
+	if (kaddr)
+		*kaddr = (void *) dev_info->start + offset;
 	*pfn = __pfn_to_pfn_t(PFN_DOWN(dev_info->start + offset),
 			PFN_DEV|PFN_SPECIAL);
 
-- 
1.8.3.1


