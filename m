Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59662C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1364820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="abdrov4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1364820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbeGZAeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731431AbeGZAeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:34:13 -0400
Received: from localhost.localdomain (unknown [180.111.133.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BE1B20833;
        Wed, 25 Jul 2018 23:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532560818;
        bh=mK2ZhP7TCSdLdwnstHNpKCeWwvmzlKLmciXqjCB1+DQ=;
        h=From:To:Cc:Subject:Date:From;
        b=abdrov4jVpRYEvZnzZE1V7w8g8D4UHXo0BkZ4miUNMu8OHyZJzqocsxQbJawjcowU
         7ff8ttEzkPwKid1qhynW7T1pL5omwEOQ6W+JOSnF2AyZ3JTUUtn1V8At3hK4b+fxFz
         JAdkf6S5zWODUK82/Ya1NWfNGMe58NF+9iqDnMmw=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH RESEND] f2fs: fix to restrict mount condition when without CONFIG_QUOTA
Date:   Thu, 26 Jul 2018 07:19:48 +0800
Message-Id: <20180725231948.18075-1-chao@kernel.org>
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
index dbc1cb53581f..bc7c14a055bb 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -775,6 +775,12 @@ static int parse_options(struct super_block *sb, char *options)
 			 "without CONFIG_QUOTA");
 		return -EINVAL;
 	}
+	if (f2fs_sb_has_project_quota(sbi->sb) && !f2fs_readonly(sbi->sb)) {
+		f2fs_msg(sb, KERN_ERR,
+			"Filesystem with project quota feature cannot be "
+			"mounted RDWR without CONFIG_QUOTA");
+		return -EINVAL;
+	}
 #endif
 
 	if (F2FS_IO_SIZE_BITS(sbi) && !test_opt(sbi, LFS)) {
-- 
2.16.2.17.g38e79b1fd

