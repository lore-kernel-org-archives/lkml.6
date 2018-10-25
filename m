Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEE6ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F4420834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1Ws9hLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F4420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbeJYWrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbeJYWrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:47 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C17422084A;
        Thu, 25 Oct 2018 14:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476890;
        bh=n+Hn9L4tMvWZ0fdB2FuinQMmbqlg8r0niWewoJQyOZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1Ws9hLZGqqAb47YaHggf3nInvKk5B8yrPZP2xbMnIDv+2onBKl/e36yrIgONRWM0
         /iW6MxIvIy0WkR4N13Kofd1H1vL8x8megGeVWLveC49juBPFcMZ26QKWABno9fwx6H
         +qNeR86X1m2cpvMq1oIs+LtXVt1ZIK9BrAIc7Mvg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 16/98] orangefs: off by ones in xattr size checks
Date:   Thu, 25 Oct 2018 10:13:01 -0400
Message-Id: <20181025141423.213774-16-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5f13e58767a53ebb54265e03c0c4a67650286263 ]

A previous patch which claimed to remove off by ones actually introduced
them.

strlen() returns the length of the string not including the NUL
character.  We are using strcpy() to copy "name" into a buffer which is
ORANGEFS_MAX_XATTR_NAMELEN characters long.  We should make sure to
leave space for the NUL, otherwise we're writing one character beyond
the end of the buffer.

Fixes: e675c5ec51fe ("orangefs: clean up oversize xattr validation")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/orangefs/xattr.c b/fs/orangefs/xattr.c
index 237c9c04dc3b..a34b25be39c5 100644
--- a/fs/orangefs/xattr.c
+++ b/fs/orangefs/xattr.c
@@ -76,7 +76,7 @@ ssize_t orangefs_inode_getxattr(struct inode *inode, const char *name,
 	if (S_ISLNK(inode->i_mode))
 		return -EOPNOTSUPP;
 
-	if (strlen(name) > ORANGEFS_MAX_XATTR_NAMELEN)
+	if (strlen(name) >= ORANGEFS_MAX_XATTR_NAMELEN)
 		return -EINVAL;
 
 	fsuid = from_kuid(&init_user_ns, current_fsuid());
@@ -169,7 +169,7 @@ static int orangefs_inode_removexattr(struct inode *inode, const char *name,
 	struct orangefs_kernel_op_s *new_op = NULL;
 	int ret = -ENOMEM;
 
-	if (strlen(name) > ORANGEFS_MAX_XATTR_NAMELEN)
+	if (strlen(name) >= ORANGEFS_MAX_XATTR_NAMELEN)
 		return -EINVAL;
 
 	down_write(&orangefs_inode->xattr_sem);
@@ -233,7 +233,7 @@ int orangefs_inode_setxattr(struct inode *inode, const char *name,
 
 	if (size > ORANGEFS_MAX_XATTR_VALUELEN)
 		return -EINVAL;
-	if (strlen(name) > ORANGEFS_MAX_XATTR_NAMELEN)
+	if (strlen(name) >= ORANGEFS_MAX_XATTR_NAMELEN)
 		return -EINVAL;
 
 	internal_flag = convert_to_internal_xattr_flags(flags);
-- 
2.17.1

