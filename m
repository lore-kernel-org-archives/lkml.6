Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49EEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BCD20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0ZhkIVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BCD20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbeKAIKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbeKAIKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0206D2081B;
        Wed, 31 Oct 2018 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027440;
        bh=LGt60WPs41KuPM834uPXBLpDbf50Yznshn3+WVgfNH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0ZhkIVgIzuwDOWRvz9WrxezKZHaPI+rx3hs5UeIIOvsoYjyU2dTsv4t/P2sVSoO6
         AKCMK67GO893UzxnyFWCKQIhbORX8cYnuYAqZK35FVsdXpNKIcoZP2aRbj3Sc+D5dP
         F+J15LHoqYarpKY2fVL8V9HJGtxlVANYfG8J1pDY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 58/73] f2fs: fix to recover inode's i_flags during POR
Date:   Wed, 31 Oct 2018 19:09:33 -0400
Message-Id: <20181031230948.29203-58-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 19c73a691ccf6fb2f12d4e9cf9830023966cec88 ]

Testcase to reproduce this bug:
1. mkfs.f2fs /dev/sdd
2. mount -t f2fs /dev/sdd /mnt/f2fs
3. touch /mnt/f2fs/file
4. sync
5. chattr +A /mnt/f2fs/file
6. xfs_io -f /mnt/f2fs/file -c "fsync"
7. godown /mnt/f2fs
8. umount /mnt/f2fs
9. mount -t f2fs /dev/sdd /mnt/f2fs
10. lsattr /mnt/f2fs/file

-----------------N- /mnt/f2fs/file

But actually, we expect the corrct result is:

-------A---------N- /mnt/f2fs/file

The reason is we didn't recover inode.i_flags field during mount,
fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 9626758bc762..765fadf954af 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -210,6 +210,7 @@ static void recover_inode(struct inode *inode, struct page *page)
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
+	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
 
 	if (file_enc_name(inode))
 		name = "<encrypted>";
-- 
2.17.1

