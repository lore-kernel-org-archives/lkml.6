Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118B6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5EC20855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956298;
	bh=uinlcuwV9Bbg5k7k5KKp88YQpCmsGReZTRqbkTcxo1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XuNsZzLPGBp3UUNWNhGIL4Qt/ytxrbswEFW1L/aOKxkwvAqHxnhv1qnSmjU+My66b
	 DORokdWLd0W5oXv5PyjFz82svf/Ar7zqfhGCQmxeWim+45uVPhIOPjMiYQPQtT3jNN
	 AE9sIiiaz7YqP/nyxTQTZfYAAu10AFobl3EuoBjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfBWVLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:11:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbfBWVLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:11:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE99D20878;
        Sat, 23 Feb 2019 21:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956292;
        bh=uinlcuwV9Bbg5k7k5KKp88YQpCmsGReZTRqbkTcxo1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Sn4pSzgu/z527FPK58Nx0kthstIJTvrM0aOTF9uACgZe/APYHKjzGicmafBq94AN
         lUO/RjeN3y+edW3MMnlwC3xywNcp10Dzh7qMxlkCQqBA2rzyjU2PcE2pL1oFW9oCiI
         SgaQqYyPRdm/D2BREfZANULTJHJq6QQ6bT4ASlIg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>, Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 25/26] autofs: drop dentry reference only when it is never used
Date:   Sat, 23 Feb 2019 16:10:46 -0500
Message-Id: <20190223211047.202725-25-sashal@kernel.org>
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

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 63ce5f552beb9bdb41546b3a26c4374758b21815 ]

autofs_expire_run() calls dput(dentry) to drop the reference count of
dentry.  However, dentry is read via autofs_dentry_ino(dentry) after
that.  This may result in a use-free-bug.  The patch drops the reference
count of dentry only when it is never used.

Link: http://lkml.kernel.org/r/154725122396.11260.16053424107144453867.stgit@pluto-themaw-net
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/autofs4/expire.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/autofs4/expire.c b/fs/autofs4/expire.c
index 7a5a598a2d945..0d8b9c4f27f21 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -560,7 +560,6 @@ int autofs4_expire_run(struct super_block *sb,
 	pkt.len = dentry->d_name.len;
 	memcpy(pkt.name, dentry->d_name.name, pkt.len);
 	pkt.name[pkt.len] = '\0';
-	dput(dentry);
 
 	if ( copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)) )
 		ret = -EFAULT;
@@ -573,6 +572,8 @@ int autofs4_expire_run(struct super_block *sb,
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
 
+	dput(dentry);
+
 	return ret;
 }
 
-- 
2.19.1

