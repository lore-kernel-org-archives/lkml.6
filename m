Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BD6C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148AE2183F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548719257;
	bh=d65mwd0fmOb9GOEtqx9ELDI4p7UE30aluKyJXmrLLpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mS2SL3i0awExcdWMQVA5KaXyWbcf/AD5EsTBYk1IRnbKLVcPC2lNk39XJzJaO+RC5
	 91zOIOHpcHek4DN4vXZXbU3DYVqaNgiHKnuj0DwRD5QF4zeGolEEH59apMWTUSeYfg
	 OJccgXnHlG/AXLuxKYnKkVN5xXi2aVjbw1r0qBsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfA1Xre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfA1Xrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:47:32 -0500
Received: from localhost (203-69-98-252.HINET-IP.hinet.net [203.69.98.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F39D92175B;
        Mon, 28 Jan 2019 23:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548719252;
        bh=d65mwd0fmOb9GOEtqx9ELDI4p7UE30aluKyJXmrLLpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTJmRX6XcbEa92ZDUvhcq5RpwgD+UUozLVhjcM6owu3bLRBn0S6+wedabSmTkm6c1
         iXKwxZ/iNPuf1bgsWMlGZPJhQr9Nl93VkHxRjg5GuOonOFe/JSHBOq7sDQCTz4xoJF
         +hzQkfRUM3POVOrmz2RrH3OsS8hGYsBDNUgVS7xk=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/7] f2fs: avoid null pointer exception in dcc_info
Date:   Tue, 29 Jan 2019 07:47:15 +0800
Message-Id: <20190128234717.77225-5-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20190128234717.77225-1-jaegeuk@kernel.org>
References: <20190128234717.77225-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If dcc_info is not set yet, we can get null pointer panic.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fe95abb05d40..8c928cd72b61 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2161,10 +2161,17 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 		get_pages(sbi, F2FS_RD_META) || get_pages(sbi, F2FS_WB_DATA) ||
 		get_pages(sbi, F2FS_WB_CP_DATA) ||
 		get_pages(sbi, F2FS_DIO_READ) ||
-		get_pages(sbi, F2FS_DIO_WRITE) ||
-		atomic_read(&SM_I(sbi)->dcc_info->queued_discard) ||
-		atomic_read(&SM_I(sbi)->fcc_info->queued_flush))
+		get_pages(sbi, F2FS_DIO_WRITE))
 		return false;
+
+	if (SM_I(sbi) && SM_I(sbi)->dcc_info &&
+			atomic_read(&SM_I(sbi)->dcc_info->queued_discard))
+		return false;
+
+	if (SM_I(sbi) && SM_I(sbi)->fcc_info &&
+			atomic_read(&SM_I(sbi)->fcc_info->queued_flush))
+		return false;
+
 	return f2fs_time_over(sbi, type);
 }
 
-- 
2.19.0.605.g01d371f741-goog

