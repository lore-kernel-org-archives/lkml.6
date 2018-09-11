Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014DFC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E77E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrdIsKYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E77E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeILBQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbeILBQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:16:43 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E0D0206BB;
        Tue, 11 Sep 2018 20:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536696948;
        bh=WDNJNMqOMHEupZD0ltx3TP7I15uhoAoSsQdJ+Psp6Vg=;
        h=From:To:Cc:Subject:Date:From;
        b=GrdIsKYqAA71lykXSDnXCVKyqoLWLpoRyJd6zzlU/wd9VmqLvmIrDRNSrISZdTcRZ
         z5HZKe3PFWucaXVzrlfsL/UP+ki+TpPz7IbsBk2OEVigWa1uRYnNIkrUDRpu8I33Bl
         btr9Uup7rfMIS7eZLK4iDX7Kg+1nKjTKQ6MyGRUc=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix quota info to adjust recovered data
Date:   Tue, 11 Sep 2018 13:15:46 -0700
Message-Id: <20180911201546.56566-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fsck.f2fs is able to recover the quota structure, since roll-forward recovery
can recover it based on previous user information.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/recovery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 95511ed11a22..1fde86a2107e 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -675,6 +675,9 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 
 	need_writecp = true;
 
+	/* quota is not fully updated due to the lack of user information. */
+	set_sbi_flag(sbi, SBI_NEED_FSCK);
+
 	/* step #2: recover data */
 	err = recover_data(sbi, &inode_list, &dir_list);
 	if (!err)
-- 
2.17.0.441.gb46fe60e1d-goog

