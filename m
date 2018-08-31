Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADEBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6DF20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6DF20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeHaSNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:13:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59819 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeHaSNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:13:19 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fvk3P-0003X9-7Q; Fri, 31 Aug 2018 14:05:39 +0000
From:   Colin King <colin.king@canonical.com>
To:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hfs: fix array out of bounds read of array extent
Date:   Fri, 31 Aug 2018 15:05:38 +0100
Message-Id: <20180831140538.31566-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently extent and index i are both being incremented causing
an array out of bounds read on extent[i]. Fix this by removing
the extraneous increment of extent.

Detected by CoverityScan, CID#711541 ("Out of bounds read")

Fixes: d1081202f1d0 ("HFS rewrite")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/hfs/extent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
index 5d0182654580..636cdfcecb26 100644
--- a/fs/hfs/extent.c
+++ b/fs/hfs/extent.c
@@ -300,7 +300,7 @@ int hfs_free_fork(struct super_block *sb, struct hfs_cat_file *file, int type)
 		return 0;
 
 	blocks = 0;
-	for (i = 0; i < 3; extent++, i++)
+	for (i = 0; i < 3; i++)
 		blocks += be16_to_cpu(extent[i].count);
 
 	res = hfs_free_extents(sb, extent, blocks, blocks);
-- 
2.17.1

