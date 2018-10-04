Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D76AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44BF921477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 03:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifYIebv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BF921477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbeJDKGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 06:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbeJDKGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 06:06:51 -0400
Received: from localhost.localdomain (unknown [58.212.179.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790B920645;
        Thu,  4 Oct 2018 03:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538622941;
        bh=d8UHqyjaE0/SVXTOGiD8WpKprTeHzC299EEZuAUb5gY=;
        h=From:To:Cc:Subject:Date:From;
        b=ifYIebv6Xa9kFVkJA8FaE8SHLkJM5FX4CTGGNsxXdmg37GmDgu+Qsp0y7JlleX5yE
         ZtdoswTKPi3tDlEJtlAIPKG3MDgYjYqTZo5TD9IQxO2InEBZbYq3jjQ1QvQxhgYchW
         3BUaI4QC/4gnafC+QXiw1+g/I2toA45MT9ks2yOo=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: shrink sbi->sb_lock coverage in set_file_temperature()
Date:   Thu,  4 Oct 2018 11:15:18 +0800
Message-Id: <20181004031520.4096-1-chao@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

file_set_{cold,hot} doesn't need holding sbi->sb_lock, so moving them
out of the lock.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a14632744a6a..d5de8a99532d 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -182,16 +182,19 @@ static inline void set_file_temperature(struct f2fs_sb_info *sbi, struct inode *
 	hot_count = sbi->raw_super->hot_ext_count;
 
 	for (i = 0; i < cold_count + hot_count; i++) {
-		if (!is_extension_exist(name, extlist[i]))
-			continue;
-		if (i < cold_count)
-			file_set_cold(inode);
-		else
-			file_set_hot(inode);
-		break;
+		if (is_extension_exist(name, extlist[i]))
+			break;
 	}
 
 	up_read(&sbi->sb_lock);
+
+	if (i == cold_count + hot_count)
+		return;
+
+	if (i < cold_count)
+		file_set_cold(inode);
+	else
+		file_set_hot(inode);
 }
 
 int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
-- 
2.18.0

