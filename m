Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE98C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DA320873
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 07:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSBlO/iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DA320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeK1ScI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:32:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbeK1ScI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 13:32:08 -0500
Received: from localhost (c-98-234-55-98.hsd1.ca.comcast.net [98.234.55.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AD3C2081C;
        Wed, 28 Nov 2018 07:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543390287;
        bh=efG1lFb7OfdNX4ha2wALj6Azj5KdX1EZ/9zicD6jDMY=;
        h=From:To:Cc:Subject:Date:From;
        b=HSBlO/iGbb6tyD7CXJyknheK0ylkYvY29uPRRNK/1tjbhGMQy5NWpjUv9wqDP1SJl
         QfwxKmlMH9rwDx0vEaRV6ZL4LcW4fa7nV+WuK3MWqGbCBazLN0F+VjuXPxA4cFsz/M
         Vcl9Rq0/WNpPKpHucJOaMNWQWnlxDp5HoFmrfyNE=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid frequent costly fsck triggers
Date:   Tue, 27 Nov 2018 23:31:25 -0800
Message-Id: <20181128073125.39102-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we want to re-enable nat_bits, we rely on fsck which requires full scan
of directory tree. Let's do that by regular fsck or unclean shutdown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c28a9d1cb278..aa500239baf2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1621,7 +1621,11 @@ static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
 {
 	unsigned long flags;
 
-	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	/*
+	 * In order to re-enable nat_bits we need to call fsck.f2fs by
+	 * set_sbi_flag(sbi, SBI_NEED_FSCK). But it may give huge cost,
+	 * so let's rely on regular fsck or unclean shutdown.
+	 */
 
 	if (lock)
 		spin_lock_irqsave(&sbi->cp_lock, flags);
-- 
2.19.0.605.g01d371f741-goog

