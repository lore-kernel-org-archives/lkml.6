Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C30C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287182087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWyp5oGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287182087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbeLDLDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:03:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeLDLDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:03:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6668D2146D;
        Tue,  4 Dec 2018 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921384;
        bh=SMsU7mcoDOT7t9nSiZKmXh6zRFpInWLFTs4/Gr9/rKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pWyp5oGLkAgFeXfH/RVwJAjxu45XVw9GoeJ2gjtbS/PcCIJCSQKq7KY5f5xWej27l
         GrpUS2P84Pf8/br8os7bqa2UrWpAXAm05pZ44tc2g4wFImPbwqlmz0RZurrxa1RFWK
         JLbxlnE4Xu+DHDo9QEP10XUQ2GgOJulz9SvNx5gw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 050/146] f2fs: Add sanity_check_inode() function
Date:   Tue,  4 Dec 2018 11:48:56 +0100
Message-Id: <20181204103728.863000922@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

This was done as part of commit 5d64600d4f33 "f2fs: avoid bug_on on
corrupted inode" upstream, but the specific check that commit added is
not applicable to 4.14.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index b1c0eb433841..917a6c3d5649 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -180,6 +180,13 @@ void f2fs_inode_chksum_set(struct f2fs_sb_info *sbi, struct page *page)
 	ri->i_inode_checksum = cpu_to_le32(f2fs_inode_chksum(sbi, page));
 }
 
+static bool sanity_check_inode(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+
+	return true;
+}
+
 static int do_read_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -281,6 +288,10 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	ret = do_read_inode(inode);
 	if (ret)
 		goto bad_inode;
+	if (!sanity_check_inode(inode)) {
+		ret = -EINVAL;
+		goto bad_inode;
+	}
 make_now:
 	if (ino == F2FS_NODE_INO(sbi)) {
 		inode->i_mapping->a_ops = &f2fs_node_aops;
-- 
2.17.1



