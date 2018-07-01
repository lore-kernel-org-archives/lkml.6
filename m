Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC0EC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 06:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B6D25260
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 06:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B6D25260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeGAGfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 02:35:18 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25329 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751450AbeGAGfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 02:35:16 -0400
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Jul 2018 02:35:16 EDT
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=lxGD/iRtqfWLBDgU6hOsOAMk94+QUcRBPZP46qbQl8sfruoUsal2muMGapcVsfbWc1ps0m2yojBh
    6j7cn/NXZbQASvpAP2H1+2HwEb8MCVJ9ydikgFS+bXx0zOcgPT7c  
Received: from YEHS1XR956R00D1.lenovo.com (111.197.253.128 [111.197.253.128]) by mx.zohomail.com
        with SMTPS id 1530425992341132.68424756262527; Sat, 30 Jun 2018 23:19:52 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, willy@infradead.org,
        ross.zwisler@linux.intel.com, vishal.l.verma@intel.com,
        jack@suse.com, chengnt@lenovo.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 3/3] fs/ext2/inode: Optimize the condition for iomap_begin
Date:   Sun,  1 Jul 2018 14:18:48 +0800
Message-Id: <20180701061848.7036-3-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
In-Reply-To: <20180701061848.7036-1-yehs2007@zoho.com>
References: <20180701061848.7036-1-yehs2007@zoho.com>
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

If ext2_get_blocks returns negative result, ext2_iomap_begin
will return for error case.
Adjust the judging condition of ret value will be useful for
code simplification.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 fs/ext2/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index ca211bd..9b1004d 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -819,15 +819,15 @@ static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->offset = (loff_t)first_block << blkbits;
 	iomap->dax_dev = sbi->s_daxdev;
 
-	if (ret == 0) {
-		iomap->type = IOMAP_HOLE;
-		iomap->addr = IOMAP_NULL_ADDR;
-		iomap->length = 1 << blkbits;
-	} else {
+	if (ret) {
 		iomap->type = IOMAP_MAPPED;
 		iomap->addr = (u64)bno << blkbits;
 		iomap->length = (u64)ret << blkbits;
 		iomap->flags |= IOMAP_F_MERGED;
+	} else {
+		iomap->type = IOMAP_HOLE;
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->length = 1 << blkbits;
 	}
 
 	if (new)
-- 
1.8.3.1


