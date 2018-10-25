Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A61ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1CF20883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYJveZJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1CF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeJYWsX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbeJYWsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:23 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE73120834;
        Thu, 25 Oct 2018 14:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476926;
        bh=GHM8Eo7NPy8EM6GY+ltkvDNds3fUSIs/MCGrVANLftI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYJveZJfY5cIPdGjBHFW7Es4GATuuP7G9f5khx62Y8QEgfxn2+qYXVOAIDnTjSQR9
         rUrymKW4gjMGkYvWn0z5u9qN9jTq6U5jS67E0mbdBlzAXJobmAwQ/RNymdIuydt1eV
         D9sp5oxuQudc4yJFNva8lRgFK6tGdgjHaHc0eQsQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 42/98] ufs: we need to sync inode before freeing it
Date:   Thu, 25 Oct 2018 10:13:27 -0400
Message-Id: <20181025141423.213774-42-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 67a70017fa0a152657bc7e337e69bb9c9f5549bf ]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ufs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index a2760a2869f4..0f22c036699a 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -846,6 +846,7 @@ void ufs_evict_inode(struct inode * inode)
 		inode->i_size = 0;
 		if (inode->i_blocks)
 			ufs_truncate_blocks(inode);
+		ufs_update_inode(inode, inode_needs_sync(inode));
 	}
 
 	invalidate_inode_buffers(inode);
-- 
2.17.1

