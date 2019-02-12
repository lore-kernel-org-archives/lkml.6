Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA25FC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E87D20836
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549938827;
	bh=5thc25MoSC5++AcwkSrqH6f/WBc14Hc54s3B34ocKIw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SCHB7iz9DWQ5+gvBNRoalE6rOOKnZxdweUJxqJCds/kPHBLGFVSum/ubIqsf5UtKs
	 x7ZeDkhhkR6mqcEamQthXrXRl4LTQNgEh1xAfo1THOgQliPtas+6a6/1r11Ykf5QF4
	 yJjeuIsKfqIoC+9XH072bp6o/TCepQBd15YQSspk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfBLCdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:33:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:45456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfBLCdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:33:45 -0500
Received: from localhost (unknown [104.132.1.80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C94492070D;
        Tue, 12 Feb 2019 02:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549938824;
        bh=5thc25MoSC5++AcwkSrqH6f/WBc14Hc54s3B34ocKIw=;
        h=From:To:Cc:Subject:Date:From;
        b=SPewK2pO55Zybj4OxOSUQMh8cn06GE4O1bpPsrrOjTfF6wE7uRaije0WWOpNtG+g/
         gePYl/BpXRKY78pua9Hh6LbmZAKG6FNFu0InpL+RpNeusJv1oy+tvI1GnCMsFaGO+j
         73EudO84bj4jEuV7HScpR1K8bKUG4830PLL4C6q4=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG
Date:   Mon, 11 Feb 2019 18:33:43 -0800
Message-Id: <20190212023343.52215-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we met this once, let fsck.f2fs clear this only.
Note that, this addresses all the subtle fault injection test.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 03fea4efd64b..10a3ada28715 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1267,8 +1267,6 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH))
 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
-	else
-		__clear_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
 
 	if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR))
 		__set_ckpt_flags(ckpt, CP_QUOTA_NEED_FSCK_FLAG);
-- 
2.19.0.605.g01d371f741-goog

