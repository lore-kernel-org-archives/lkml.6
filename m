Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61123C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2069F20651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956426;
	bh=5tDtIF1j9aD4gCvrdnXmYwUbbu4+UBO6+CGXmYUbxmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lVoRX5QO/sOdDJ3vp+bVY6fitZ6W8MI9B/Ta2D5b91iZDxSzFxZAK+jRX3Ael21uC
	 egYYDdLhDObgj9ReEve9XFkc+2Vzz3tib6E0N3EcCbBA56h+vD3OUDq2qETajTWRWy
	 MNNRk7cRoQVbsiizLlYUCzM7J33SRRzTvF6ZTjhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfBWVNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbfBWVLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD8A52086D;
        Sat, 23 Feb 2019 21:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956294;
        bh=5tDtIF1j9aD4gCvrdnXmYwUbbu4+UBO6+CGXmYUbxmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbOMFPDgka2n4IeT6RVL4+bYBmu/HMUmbZ+k6SoVv0e+3P44bNUE/JlYTigC670TK
         9gfDFXzqfTkn8Y6kzSJyGss6b8xUovKRT9VC0dDHb5A+BFamOcxqGaVUuDv/IkIHq5
         jUspBYfQBe+M9PCveA8W8gR7W/z+JDN5sW+Nqg+g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 26/26] autofs: fix error return in autofs_fill_super()
Date:   Sat, 23 Feb 2019 16:10:47 -0500
Message-Id: <20190223211047.202725-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211047.202725-1-sashal@kernel.org>
References: <20190223211047.202725-1-sashal@kernel.org>
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
index 1132fe71b3124..0fd472d670291 100644
--- a/fs/autofs4/inode.c
+++ b/fs/autofs4/inode.c
@@ -255,8 +255,10 @@ int autofs4_fill_super(struct super_block *s, void *data, int silent)
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

