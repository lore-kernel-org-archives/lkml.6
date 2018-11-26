Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C311C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23CC2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 03:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bgoZpqFN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23CC2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeKZOBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 09:01:19 -0500
Received: from m12-12.163.com ([220.181.12.12]:37470 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbeKZOBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 09:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=sZHw3HwZvqhwcBwOFj
        MO9QS8Qu4C+xqi4pUgXqgre/Q=; b=bgoZpqFNaiXTDqx/DhRlXR4zLrLYQYeMSA
        ri9Egs+UGoOIcPk0BIOOFcbgyEYtVaVvs19gvfAnEtqXKg8hiblp8DyUSnoBkV61
        Rhs0+RqJb5gMMP3JGvmVcjeriVqr1Cxzjx8Af+MgeRJfermvClgMh2wQEsW06UrC
        kl9E4H9vg=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp8 (Coremail) with SMTP id DMCowACHx0OuY_tbmdfiBw--.64245S3;
        Mon, 26 Nov 2018 11:08:33 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] nilfs2: fix potential use after free
Date:   Mon, 26 Nov 2018 11:08:29 +0800
Message-Id: <1543201709-53191-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowACHx0OuY_tbmdfiBw--.64245S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrWDCrW7XF1kury8Jw4xZwb_yoWktwc_WF
        ykta48K3yqgws3Ja1DJry3trWDZ3ZrKwn5ur1xtFW7GFWqyF4DZF1kXanavFWUXayxu3s8
        WFnrC3Z3tryjgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ByxtUUUUU==
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBURILclaD0T68gAAAs8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

brelse(bh) is called to drop the reference count of bh when the call
to nilfs_dat_translate fails. If the reference count hits 0, bh may be
freed. However, bh->b_page is unlocked and put after that, which may
result in a use-after-free bug. This patch moves the release operation
after unlocking and putting the page.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 fs/nilfs2/gcinode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index aa3c328..a24bb29 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 
 		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
-		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
-			brelse(bh);
+		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
 			goto failed;
-		}
 	}
 
 	lock_buffer(bh);
@@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
  failed:
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
+	if (unlikely(err))
+		brelse(bh);
 	return err;
 }
 
-- 
2.7.4


