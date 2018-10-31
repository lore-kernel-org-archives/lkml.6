Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF36ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA5020664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQIiRL8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA5020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbeKAIJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730576AbeKAIJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8EBE2081B;
        Wed, 31 Oct 2018 23:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027370;
        bh=0IvAHkJIScNgB1pC7xf2FbFfdKMlzjS/mJgBaYBZZfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TQIiRL8zhd7KZUijoJHy05f3v1e1JYJ0y0hCuzZPLScxulq/V1OuD6bJJ5ZJv/ZQB
         FwAOUy3NDldGbFschyy41mchbOWOvQx3ZlkSA666R3a4vpgCXK2Vm5CqvgBRMQm6gX
         Mh7RNPCaJHO7qNWECrgQZuQ9NEq4ihkm0Nr6Bduk=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 106/126] f2fs: fix to recover inode's crtime during POR
Date:   Wed, 31 Oct 2018 19:07:34 -0400
Message-Id: <20181031230754.29029-106-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 5cd1f387a13b5188b4edb4c834310302a85a6ea2 ]

Testcase to reproduce this bug:
1. mkfs.f2fs -O extra_attr -O inode_crtime /dev/sdd
2. mount -t f2fs /dev/sdd /mnt/f2fs
3. touch /mnt/f2fs/file
4. xfs_io -f /mnt/f2fs/file -c "fsync"
5. godown /mnt/f2fs
6. umount /mnt/f2fs
7. mount -t f2fs /dev/sdd /mnt/f2fs
8. xfs_io -f /mnt/f2fs/file -c "statx -r"

stat.btime.tv_sec = 0
stat.btime.tv_nsec = 0

This patch fixes to recover inode creation time fields during
mount.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 52ed02b0327c..17f3d790c585 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2379,6 +2379,13 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
 								i_projid))
 			dst->i_projid = src->i_projid;
+
+		if (f2fs_sb_has_inode_crtime(sbi->sb) &&
+			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
+							i_crtime_nsec)) {
+			dst->i_crtime = src->i_crtime;
+			dst->i_crtime_nsec = src->i_crtime_nsec;
+		}
 	}
 
 	new_ni = old_ni;
-- 
2.17.1

