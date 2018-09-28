Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10366C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E672082C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf3qgdTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E672082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeI2ANs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbeI2ANs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:13:48 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF0C20685;
        Fri, 28 Sep 2018 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538156936;
        bh=IIgQ2+zMijKI6VWN6Q+gSG8sNC42S0bUAxd9nEfVqmI=;
        h=From:To:Cc:Subject:Date:From;
        b=kf3qgdTHig6UgRty26SLE25EupDypTlg7wZM0E6objJBrqJ+ASerWOIJA6HCyFDaT
         FImNql+Rh3KCZ76C7l8UbsoLGK6CrALek8OTYhkGFguts8jNo6wFSbfUSbVAKvDWOl
         FLtuBiTaLuSlbnP5Co5+Ma98mtQxiuBdFlyAjwKA=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] f2fs: fix missing up_read
Date:   Fri, 28 Sep 2018 10:48:53 -0700
Message-Id: <20180928174854.65978-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes missing up_read call.

Fixes: c9b60788fc76 ("f2fs: fix to do sanity check with block address in main area")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3994b44541b4..acb819b8fc42 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1541,8 +1541,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	}
 
 	if (__is_valid_data_blkaddr(ni.blk_addr) &&
-		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC))
+		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC)) {
+		up_read(&sbi->node_write);
 		goto redirty_out;
+	}
 
 	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
-- 
2.19.0.605.g01d371f741-goog

