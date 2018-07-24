Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABD5C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21ADA20891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl1LoJfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21ADA20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeGYQwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728341AbeGYQwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:52:51 -0400
Received: from localhost.localdomain (unknown [180.111.133.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C938420843;
        Wed, 25 Jul 2018 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532533238;
        bh=feoCyXxk15IQrR/drYpYXy2JRh08Gqf4/FoQUDLF/wk=;
        h=From:To:Cc:Subject:Date:From;
        b=tl1LoJfNgliUAofYSIa9IydbAlGmCCBcx6Baoa48yQZvuw7GSzZDI89NykVqdhoed
         T5utw9qOSwj/7AoA+kzZLOcnwrhsMrFscoJPeUiwNp/iKVnio3u/lw9A5XujhEBD61
         zPo1bSah/AnT0b8HtI4LbobxgtMklIjdDMgdoEyA=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to restrict mount condition when without CONFIG_QUOTA
Date:   Wed, 25 Jul 2018 00:55:46 +0800
Message-Id: <20180724165546.12924-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

Like quota_ino feature, we need to reject mounting RDWR with image
which enables project_quota feature when there is no CONFIG_QUOTA
be set in kernel.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dbc1cb53581f..bb40f08d2861 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
 			 "without CONFIG_QUOTA");
 		return -EINVAL;
 	}
+	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
+		ext4_msg(sb, KERN_ERR,
+			"Filesystem with project quota feature cannot be "
+			"mounted RDWR without CONFIG_QUOTA");
+		return -EINVAL;
+	}
 #endif
 
 	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
-- 
2.16.2.17.g38e79b1fd

