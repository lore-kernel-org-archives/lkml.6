Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E456C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB95720877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB95720877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbeIYNmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:42:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727698AbeIYNma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:42:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 735B9E0143DF5;
        Tue, 25 Sep 2018 15:36:13 +0800 (CST)
Received: from szvp000201624.huawei.com (10.120.216.130) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Tue, 25 Sep 2018 15:36:08 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/6] f2fs: fix to recover inode's i_flags during POR
Date:   Tue, 25 Sep 2018 15:35:59 +0800
Message-ID: <20180925073603.102125-2-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180925073603.102125-1-yuchao0@huawei.com>
References: <20180925073603.102125-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 fs/f2fs/recovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index c7e292f21b64..4a0f49654573 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -266,6 +266,7 @@ static int recover_inode(struct inode *inode, struct page *page)
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
+	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
 
 	recover_inline_flags(inode, raw);
 
-- 
2.18.0.rc1

