Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD7C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A6D21479
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYWjgcCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A6D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbeJDKGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeJDKGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:06:54 -0400
Received: from localhost.localdomain (unknown [58.212.179.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A7D21473;
        Thu,  4 Oct 2018 03:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538622944;
        bh=1j0F3hxQnNkK6RlXlhNRGLccJ+zmp+CnAqBaps0/99g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYWjgcCsD+301i90O9/m2WeRNhT1786+ZG0C3rzDrlooNwiywfcSGp2A12xUd+zry
         sk4vFtsZmj9kluGPddNu5A+1FkLkTQv75cahWCfQ+6sDi02/VtY+BjZq6DWcfzfJOi
         4caYHau4oWiCThlzhB8mpRxTE5Wh0bim5B0e0fsM=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 3/3] f2fs: remove unneeded disable_nat_bits()
Date:   Thu,  4 Oct 2018 11:15:20 +0800
Message-Id: <20181004031520.4096-3-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004031520.4096-1-chao@kernel.org>
References: <20181004031520.4096-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Commit 7735730d39d7 ("f2fs: fix to propagate error from __get_meta_page()")
added disable_nat_bits() in error path of __get_nat_bitmaps(), but it's
unneeded, beause we will fail mount, we won't have chance to change nid
usage status w/o nat full/empty bitmaps.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8c0367cfb1bb..2b34206486d8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2879,10 +2879,8 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
 		struct page *page;
 
 		page = f2fs_get_meta_page(sbi, nat_bits_addr++);
-		if (IS_ERR(page)) {
-			disable_nat_bits(sbi, true);
+		if (IS_ERR(page))
 			return PTR_ERR(page);
-		}
 
 		memcpy(nm_i->nat_bits + (i << F2FS_BLKSIZE_BITS),
 					page_address(page), F2FS_BLKSIZE);
-- 
2.18.0

