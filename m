Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2A9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F121E20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsoY/mL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F121E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeLEJ47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:35584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729773AbeLEJ46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:56:58 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1D1A214F1;
        Wed,  5 Dec 2018 09:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003817;
        bh=K4t0j8gSCS4kHdN+PRobSec8+BKi0oSoDAOAe8uDIAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsoY/mL2U4JCdlX1zsnVEJ9AQppxvqAzvapVfJBx7z4L1sWBvuHQVHgVouRilW3RV
         0BQVD4mnu8R5gXpvgT6lD1hVXOodQEVvv0HaMaBePryK9G0/TCDym7ygA7WadtU9Sy
         u+0evyLINh04GB9mHoNr4tlG/9G4scvVF3ge32Fc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 26/26] ocfs2: fix potential use after free
Date:   Wed,  5 Dec 2018 04:54:30 -0500
Message-Id: <20181205095430.8019-26-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095430.8019-1-sashal@kernel.org>
References: <20181205095430.8019-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 164f7e586739d07eb56af6f6d66acebb11f315c8 ]

ocfs2_get_dentry() calls iput(inode) to drop the reference count of
inode, and if the reference count hits 0, inode is freed.  However, in
this function, it then reads inode->i_generation, which may result in a
use after free bug.  Move the put operation later.

Link: http://lkml.kernel.org/r/1543109237-110227-1-git-send-email-bianpan2016@163.com
Fixes: 781f200cb7a("ocfs2: Remove masklog ML_EXPORT.")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/export.c b/fs/ocfs2/export.c
index 29651167190d..01ac16b3feac 100644
--- a/fs/ocfs2/export.c
+++ b/fs/ocfs2/export.c
@@ -125,10 +125,10 @@ static struct dentry *ocfs2_get_dentry(struct super_block *sb,
 
 check_gen:
 	if (handle->ih_generation != inode->i_generation) {
-		iput(inode);
 		trace_ocfs2_get_dentry_generation((unsigned long long)blkno,
 						  handle->ih_generation,
 						  inode->i_generation);
+		iput(inode);
 		result = ERR_PTR(-ESTALE);
 		goto bail;
 	}
-- 
2.17.1

