Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCD7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC8F20651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956964;
	bh=rm1pjeuZgujoWtqLzBSUx1GVZxftep5+WZQSIkKcL68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jc9QJnCbSKbR/QvioEC6HYohqohFCf80HhueRwSc+XM5OHs5n2gkrOjXtyxPGnUO0
	 U8AC/MApzFbKsdwq/DPk2GHa07EAj6Y8eVXV5zjaHvxaKNPaAorCnZ5sewDi3A4QPq
	 jFOTKMBK2BaUAqisqNwgUXK+j1oBc+YDHnGe6TnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfBWVWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729282AbfBWVIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:08:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0788D2086C;
        Sat, 23 Feb 2019 21:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956114;
        bh=rm1pjeuZgujoWtqLzBSUx1GVZxftep5+WZQSIkKcL68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dONF2X1is6XST831AkKMYECNcc7KJDXAbPhuuh2gKC2fHayQMQP9+KtMp5iTlqE/i
         ChEeWM9ba16Ey4KvdN6uGATNKmNHDGP3Dl9Kc1lFeG/GDKd834vzAx+SASj5ALIUWd
         aBJWwrrPsYfO3jI8/51un3BGFh9oB+/ISCSPA/F4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, autofs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 65/65] autofs: fix error return in autofs_fill_super()
Date:   Sat, 23 Feb 2019 16:06:40 -0500
Message-Id: <20190223210640.200911-65-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210640.200911-1-sashal@kernel.org>
References: <20190223210640.200911-1-sashal@kernel.org>
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
 fs/autofs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 846c052569dd4..3c14a8e45ffb6 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -255,8 +255,10 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	}
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
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

