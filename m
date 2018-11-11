Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CC9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEE422353
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDH+2HW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEE422353
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbeKLIRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732005AbeKLIRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:46 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45629208A3;
        Sun, 11 Nov 2018 22:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975270;
        bh=x+FNQHUsIZUt3lHb6Hyi05wqnu4tWjTP9DbKEX+Yx+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YDH+2HW/yr/qbrQrjoHVuraEPnF5H2wPRQ8JoHMCyGaopmMaiamtDbSTRzKyO+dGD
         3X0LFta9+j9zLQa2jUsNRleYgI5BA8IE/kAR83xcxGoppqsaOiC0BwljyAsSU1bVj3
         HtEFWBHcVix1tYT4SL6iX6l6tdN6XWBm2/ODjg8A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 167/361] f2fs: fix to recover inodes crtime during POR
Date:   Sun, 11 Nov 2018 14:18:34 -0800
Message-Id: <20181111221643.822421928@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/node.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2560,6 +2560,13 @@ retry:
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


