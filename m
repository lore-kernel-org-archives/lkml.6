Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A95C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A90214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxTO+L2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A90214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbeKLJRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:17:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388898AbeKLIUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:40 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C33208A3;
        Sun, 11 Nov 2018 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975444;
        bh=CYZ21I0HtpZ1Gz2pCEoONEkfnzmi/v0TJPBGq+gPStw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxTO+L2AUq3w5QpJo0jnlcMEFFo6jOWXaBTswxV+F0mTkQJzB60Lq4DKNQfqee9yc
         YEiU0DHh7/1LuH8gargBgOPvZfpgwAFapturm+l0vCHI1MLtwENlNW6ruHAboX6Eag
         40J4ygE1m93zC8YmosZ4CIfMnIHfj0WNAiqg3KF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 167/350] f2fs: fix to recover inodes i_flags during POR
Date:   Sun, 11 Nov 2018 14:20:31 -0800
Message-Id: <20181111221715.027221090@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/recovery.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -221,6 +221,7 @@ static void recover_inode(struct inode *
 	inode->i_mtime.tv_nsec = le32_to_cpu(raw->i_mtime_nsec);
 
 	F2FS_I(inode)->i_advise = raw->i_advise;
+	F2FS_I(inode)->i_flags = le32_to_cpu(raw->i_flags);
 
 	recover_inline_flags(inode, raw);
 


