Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620C7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B029208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhRP7BwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B029208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbeKTDEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732128AbeKTDEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:04:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8444520831;
        Mon, 19 Nov 2018 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645638;
        bh=UNC49mJC5dC9PZp0h7Le73w0ENIDENV/TLPPzmcIhfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JhRP7BwKFNWqEfxp7wjlKyYm3hhMbg7JiDVuqzRj0f/CN7JqdLRN0dylCiKBtdlQd
         ZhUb8+L0FTDr5xhlNpHDlgEYwOn/b3hf/RQ8UGkeYgajyb9pFq8kg3wrCEpf8qFT6p
         fTcmixTGGJRhmhR4OD4Rb3iGtBwpEm+WTo8Ag1zQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 031/171] 9p locks: fix glock.client_id leak in do_lock
Date:   Mon, 19 Nov 2018 17:27:07 +0100
Message-Id: <20181119162624.809908643@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/9p/vfs_file.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -204,6 +204,14 @@ static int v9fs_file_do_lock(struct file
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
@@ -235,6 +243,8 @@ out_unlock:
 		locks_lock_file_wait(filp, fl);
 		fl->fl_type = fl_type;
 	}
+	if (flock.client_id != fid->clnt->name)
+		kfree(flock.client_id);
 out:
 	return res;
 }
@@ -269,7 +279,7 @@ static int v9fs_file_getlock(struct file
 
 	res = p9_client_getlock_dotl(fid, &glock);
 	if (res < 0)
-		return res;
+		goto out;
 	/* map 9p lock type to os lock type */
 	switch (glock.type) {
 	case P9_LOCK_TYPE_RDLCK:
@@ -290,7 +300,9 @@ static int v9fs_file_getlock(struct file
 			fl->fl_end = glock.start + glock.length - 1;
 		fl->fl_pid = -glock.proc_id;
 	}
-	kfree(glock.client_id);
+out:
+	if (glock.client_id != fid->clnt->name)
+		kfree(glock.client_id);
 	return res;
 }
 


