Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5FCC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03D8208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03D8208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbeGKCYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:24:04 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45504 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732346AbeGKCYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:24:03 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4la-0003HS-Dt; Wed, 11 Jul 2018 02:22:06 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>, stable@kernel.org
Subject: [RFC][PATCH 02/42] cxl_getfile(): fix double-iput() on alloc_file() failures
Date:   Wed, 11 Jul 2018 03:21:26 +0100
Message-Id: <20180711022206.12571-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
References: <20180711021136.GN30522@ZenIV.linux.org.uk>
 <20180711022206.12571-1-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Doing iput() after path_put() is wrong.

Cc: stable@kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/misc/cxl/api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 753b1a698fc4..6b16946f9b05 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -103,15 +103,15 @@ static struct file *cxl_getfile(const char *name,
 	d_instantiate(path.dentry, inode);
 
 	file = alloc_file(&path, OPEN_FMODE(flags), fops);
-	if (IS_ERR(file))
-		goto err_dput;
+	if (IS_ERR(file)) {
+		path_put(&path);
+		goto err_fs;
+	}
 	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
 	file->private_data = priv;
 
 	return file;
 
-err_dput:
-	path_put(&path);
 err_inode:
 	iput(inode);
 err_fs:
-- 
2.11.0

