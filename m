Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A51FC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089F02146D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEOR+bEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089F02146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732802AbeK3Ba0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732789AbeK3Ba0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38952133F;
        Thu, 29 Nov 2018 14:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501494;
        bh=X5pEFkr/FeCSE0h4MpHittvlsc0CJ0MO0c1lPj1n5S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEOR+bEQGepybZYj+VnSScGCAMUzlYZ6WZNK7oQJ7Cb9V2UcFiM11P/1IZXM6QU3T
         Wh1gYF4WEJHrSnGKJSB0o+izWvN73C2DDzRZHMBI4horYgVqz8mTroXOdvpwkKBTaG
         CZBdq6fbiaHwIQMABGaO3SK4JRqOo6sLObqln9H4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dominique Martinet <dominique.martinet@cea.fr>,
        syzbot+d4252148d198410b864f@syzkaller.appspotmail.com
Subject: [PATCH 4.14 021/100] v9fs_dir_readdir: fix double-free on p9stat_read error
Date:   Thu, 29 Nov 2018 15:11:51 +0100
Message-Id: <20181129140100.598768296@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominique Martinet <dominique.martinet@cea.fr>

commit 81c99089bce693b94b775b6eb888115d2d540086 upstream.

p9stat_read will call p9stat_free on error, we should only free the
struct content on success.

There also is no need to "p9stat_init" st as the read function will
zero the whole struct for us anyway, so clean up the code a bit while
we are here.

Link: http://lkml.kernel.org/r/1535410108-20650-1-git-send-email-asmadeus@codewreck.org
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Reported-by: syzbot+d4252148d198410b864f@syzkaller.appspotmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/9p/vfs_dir.c |   11 -----------
 1 file changed, 11 deletions(-)

--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -76,15 +76,6 @@ static inline int dt_type(struct p9_wsta
 	return rettype;
 }
 
-static void p9stat_init(struct p9_wstat *stbuf)
-{
-	stbuf->name  = NULL;
-	stbuf->uid   = NULL;
-	stbuf->gid   = NULL;
-	stbuf->muid  = NULL;
-	stbuf->extension = NULL;
-}
-
 /**
  * v9fs_alloc_rdir_buf - Allocate buffer used for read and readdir
  * @filp: opened file structure
@@ -145,12 +136,10 @@ static int v9fs_dir_readdir(struct file
 			rdir->tail = n;
 		}
 		while (rdir->head < rdir->tail) {
-			p9stat_init(&st);
 			err = p9stat_read(fid->clnt, rdir->buf + rdir->head,
 					  rdir->tail - rdir->head, &st);
 			if (err) {
 				p9_debug(P9_DEBUG_VFS, "returned %d\n", err);
-				p9stat_free(&st);
 				return -EIO;
 			}
 			reclen = st.size+2;


