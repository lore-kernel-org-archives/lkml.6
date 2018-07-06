Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C84C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD3522BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqiZu5Tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD3522BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932412AbeGFVJK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753707AbeGFVJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:09:06 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E48D22BE9;
        Fri,  6 Jul 2018 21:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530911346;
        bh=GTF2egIJheKlg2RVnKQwHU1++flI0EBDcP7KhKeIaqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UqiZu5TtF3DUhtSVg16wNaTqaM1Z8fqt6IQmFshDqNTW+2xAM+SfD+S7uoS55R/Ja
         nRRBxd5LVQJS/92q9oMmQ4Hri8+VdnpZmdQFHZ6uVuK2fIA8pDIy2uPceKoHulEeJQ
         rstnd3ol4iT8p7gzZ+yaEejuBbnMdcVAce4aoV6E=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs: allow wrong configure dio to buffered write
Date:   Fri,  6 Jul 2018 14:09:01 -0700
Message-Id: <20180706210903.77887-2-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180706210903.77887-1-jaegeuk@kernel.org>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes to support unaligned dio as buffered writes.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e66379961804..6e8e78bb64a7 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2425,7 +2425,7 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 
 	err = check_direct_IO(inode, iter, offset);
 	if (err)
-		return err;
+		return 0;
 
 	if (f2fs_force_buffered_io(inode, rw))
 		return 0;
-- 
2.17.0.441.gb46fe60e1d-goog

