Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF695C10F0B
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E8420879
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550956335;
	bh=CjtP63gQDEnVJoEwq4xL+1OkEwtb6ZssfOCf3dO1Ud4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fUwZ+NvOC+tm7Ploo9IwiGJqFGLo+yET4af+hfEdFCGRBRDQfXRxynH3BHtt2dYOT
	 tK9YSvkuw3qO+7NWaTOt6xcg1DR2WVA78KLw0pjg56qCrAjmr5PskA9uQ4cUcqe2Sf
	 pfUKYJFo7D4aOxrfDaJQiG2DQ54fqpcjo/hBfARE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbfBWVMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:12:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730144AbfBWVMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:12:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7701220879;
        Sat, 23 Feb 2019 21:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550956325;
        bh=CjtP63gQDEnVJoEwq4xL+1OkEwtb6ZssfOCf3dO1Ud4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxEjLwUtUWng8Qq4d+/f560Wc4N1OU0Pfzd9WnG9dqxjCf5Vyh++lmXQewMU/YdCW
         FlG1Wz4Ag6oV9GYtjwB+Kye69wNCPj30YfCtyxaMqizH44/L+TP1zOplnBDA2MC+Ic
         vpowsAcp0J+1nGhjvdFy4WpTIZOOgUDBPhPClzvM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>, Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 17/18] autofs: drop dentry reference only when it is never used
Date:   Sat, 23 Feb 2019 16:11:34 -0500
Message-Id: <20190223211135.203082-17-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223211135.203082-1-sashal@kernel.org>
References: <20190223211135.203082-1-sashal@kernel.org>
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
index 513b8e5d151cb..4cd4b20c69dbf 100644
--- a/fs/autofs4/expire.c
+++ b/fs/autofs4/expire.c
@@ -570,7 +570,6 @@ int autofs4_expire_run(struct super_block *sb,
 	pkt.len = dentry->d_name.len;
 	memcpy(pkt.name, dentry->d_name.name, pkt.len);
 	pkt.name[pkt.len] = '\0';
-	dput(dentry);
 
 	if ( copy_to_user(pkt_p, &pkt, sizeof(struct autofs_packet_expire)) )
 		ret = -EFAULT;
@@ -583,6 +582,8 @@ int autofs4_expire_run(struct super_block *sb,
 	complete_all(&ino->expire_complete);
 	spin_unlock(&sbi->fs_lock);
 
+	dput(dentry);
+
 	return ret;
 }
 
-- 
2.19.1

