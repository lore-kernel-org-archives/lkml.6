Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80791C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F67F20651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956543;
	bh=SSp73W2j5ukKRPpRgJrxAvA0DqdykVS34m1GgEFARB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pbSD2BEqwr9hVb7PSpHLy9G/NP5zyU2FYFqepgKBqElcKYULQ0ImDuIUvPvhAtLUM
	 AaIo4+FdxMvrQt/TtSUVYTuEAHJsrP7sROEInv0ZsczbhrXjKnMYH8kYGG3kgHUt4P
	 3DbkbkJY1qkx9zyAtgutrsW+6PlyrNrkBJqsgW/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfBWVPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:15:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729833AbfBWVKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:10:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DC8B2086D;
        Sat, 23 Feb 2019 21:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956246;
        bh=SSp73W2j5ukKRPpRgJrxAvA0DqdykVS34m1GgEFARB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wPgrKybqbtjO7klelc4Wjv578dBmyDOh1ZUjYhgT8l6Du/WLp1wu7x4EFK9EwZY8y
         +UC23MrW8zDMALfafDvbvMZ5fb0ISQqjuuSKkimg9l/g/+cZvpwue3uRAkTDifnIww
         y0TpBMOLw2bBGblJQ6+9e1ZBpPveZ2Wwcl+lI2hg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 32/32] autofs: fix error return in autofs_fill_super()
Date:   Sat, 23 Feb 2019 16:09:51 -0500
Message-Id: <20190223210951.202268-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210951.202268-1-sashal@kernel.org>
References: <20190223210951.202268-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Kent <raven@themaw.net>

[ Upstream commit f585b283e3f025754c45bbe7533fc6e5c4643700 ]

In autofs_fill_super() on error of get inode/make root dentry the return
should be ENOMEM as this is the only failure case of the called
functions.

Link: http://lkml.kernel.org/r/154725123240.11260.796773942606871359.stgit@pluto-themaw-net
Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs4/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/inode.c b/fs/autofs4/inode.c
index ce0c6ea96a874..d9a3264909d0b 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -259,8 +259,10 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
 	}
 	root_inode = autofs4_get_inode(s, S_IFDIR | 0755);
 	root = d_make_root(root_inode);
-	if (!root)
+	if (!root) {
+		ret = -ENOMEM;
 		goto fail_ino;
+	}
 	pipe = NULL;
 
 	root->d_fsdata = ino;
-- 
2.19.1

