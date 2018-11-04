Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA2C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEDC204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjdmYfvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEDC204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbeKDXLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:11:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:49516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729469AbeKDXJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:09:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C45020880;
        Sun,  4 Nov 2018 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339672;
        bh=pIdqZ7W3EhBNfhmr6+zS5RZ9wonaPivVJ9SvANmud50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjdmYfvT4vmEfEaJgANlk+XZWtHG2OpMBRNvFGHpgF0VS8Kvc0XnIFByNYxnEYsYf
         bu5ONAB5eQkRLikx2JkZkAmTUWUbIMr9KTgC4g39Nu7l6e8fG2Coi9aaNwBnNjGmS3
         FLAMF5H5+c5N6KTcfO6I01fFotM3j8cRaFdLbzBA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 14/15] 9p locks: fix glock.client_id leak in do_lock
Date:   Sun,  4 Nov 2018 08:54:16 -0500
Message-Id: <20181104135417.88671-14-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135417.88671-1-sashal@kernel.org>
References: <20181104135417.88671-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominique Martinet <dominique.martinet@cea.fr>

[ Upstream commit b4dc44b3cac9e8327e0655f530ed0c46f2e6214c ]

the 9p client code overwrites our glock.client_id pointing to a static
buffer by an allocated string holding the network provided value which
we do not care about; free and reset the value as appropriate.

This is almost identical to the leak in v9fs_file_getlock() fixed by
Al Viro in commit ce85dd58ad5a6 ("9p: we are leaking glock.client_id
in v9fs_file_getlock()"), which was returned as an error by a coverity
false positive -- while we are here attempt to make the code slightly
more robust to future change of the net/9p/client code and hopefully
more clear to coverity that there is no problem.

Link: http://lkml.kernel.org/r/1536339057-21974-5-git-send-email-asmadeus@codewreck.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_file.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 12ceaf52dae6..e7b3d2c4472d 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -204,6 +204,14 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 			break;
 		if (schedule_timeout_interruptible(P9_LOCK_TIMEOUT) != 0)
 			break;
+		/*
+		 * p9_client_lock_dotl overwrites flock.client_id with the
+		 * server message, free and reuse the client name
+		 */
+		if (flock.client_id != fid->clnt->name) {
+			kfree(flock.client_id);
+			flock.client_id = fid->clnt->name;
+		}
 	}
 
 	/* map 9p status to VFS status */
@@ -235,6 +243,8 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
 		locks_lock_file_wait(filp, fl);
 		fl->fl_type = fl_type;
 	}
+	if (flock.client_id != fid->clnt->name)
+		kfree(flock.client_id);
 out:
 	return res;
 }
@@ -269,7 +279,7 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 
 	res = p9_client_getlock_dotl(fid, &glock);
 	if (res < 0)
-		return res;
+		goto out;
 	/* map 9p lock type to os lock type */
 	switch (glock.type) {
 	case P9_LOCK_TYPE_RDLCK:
@@ -290,7 +300,9 @@ static int v9fs_file_getlock(struct file *filp, struct file_lock *fl)
 			fl->fl_end = glock.start + glock.length - 1;
 		fl->fl_pid = glock.proc_id;
 	}
-	kfree(glock.client_id);
+out:
+	if (glock.client_id != fid->clnt->name)
+		kfree(glock.client_id);
 	return res;
 }
 
-- 
2.17.1

