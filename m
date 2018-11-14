Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0D2208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz681WT1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0D2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388670AbeKOI35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388646AbeKOI34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:56 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4747322546;
        Wed, 14 Nov 2018 22:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234292;
        bh=EA74UsFSDdstekUBbx+ZC2OVblpYI4QF90hzEyYVreA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gz681WT1mY6h+Skz8qq/dPaASPsNSf4ewadEZCFKVb9lfoweEuQTEV9/I1opQxLzZ
         7dEdJ79/KudCBlC8lXWuNfGGZSHme144sUGQWmpGBqUdER0yC5a2DjzJRB6STtckJ0
         G5rwiEj9xZLN7PnnGjNEghF80mx7i5q27NMZqV68=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>, Theodore Ts'o <tytso@mit.edu>,
        stable@kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 53/59] ext4: missing !bh check in ext4_xattr_inode_write()
Date:   Wed, 14 Nov 2018 17:23:25 -0500
Message-Id: <20181114222335.99339-53-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit eb6984fa4ce2837dcb1f66720a600f31b0bb3739 ]

According to Ted Ts'o ext4_getblk() called in ext4_xattr_inode_write()
should not return bh = NULL

The only time that bh could be NULL, then, would be in the case of
something really going wrong; a programming error elsewhere (perhaps a
wild pointer dereference) or I/O error causing on-disk file system
corruption (although that would be highly unlikely given that we had
*just* allocated the blocks and so the metadata blocks in question
probably would still be in the cache).

Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@kernel.org # 4.13
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/xattr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index f36fc5d5b257..302725176571 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1388,6 +1388,12 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 		bh = ext4_getblk(handle, ea_inode, block, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
+		if (!bh) {
+			WARN_ON_ONCE(1);
+			EXT4_ERROR_INODE(ea_inode,
+					 "ext4_getblk() return bh = NULL");
+			return -EFSCORRUPTED;
+		}
 		ret = ext4_journal_get_write_access(handle, bh);
 		if (ret)
 			goto out;
-- 
2.17.1

