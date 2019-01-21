Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C156C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14512084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078820;
	bh=Vxa2D0aP7dtcds2M/ZuJSFVMTpZ9Rrqq+xGeqlfri6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4SvtRJp6yA6Y+xqvcwW59oLOTL7plcuEk5dz6XFuZnhsTDMcmY9HoUu2ia3+0mNk
	 lchRoPqGHL5DJNFS6kkSHNvYiszVrXWQ6NzOdz53dLQ6+OkS4sdbvRU0Iha+HdWaBS
	 Mw+soMDL1uOpGH5tOyl7uNAXJFfdHZzqDYhPksRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfAUNxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:53:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbfAUNxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:53:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8919B2084C;
        Mon, 21 Jan 2019 13:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078816;
        bh=Vxa2D0aP7dtcds2M/ZuJSFVMTpZ9Rrqq+xGeqlfri6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aaNalk4mk6Wv9XQqDdw5OmaQZVqWIIiEvUot2mOVsLJH+FOhYHtDqjL9L93IG9BT+
         aitClpBP6q1G4u/qtswTo+uXQCgk5J7tFTGOQuLq5Qo2yyN06hRymJEeAWqwqBxlYy
         xEwswkjphE9SCghkM3Xk5eRJ1kezmtTX/0Ei3Ds4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 53/59] block/loop: Dont grab "struct file" for vfs_getattr() operation.
Date:   Mon, 21 Jan 2019 14:44:18 +0100
Message-Id: <20190121122502.791011664@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit b1ab5fa309e6c49e4e06270ec67dd7b3e9971d04 upstream.

vfs_getattr() needs "struct path" rather than "struct file".
Let's use path_get()/path_put() rather than get_file()/fput().

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1175,7 +1175,7 @@ loop_set_status(struct loop_device *lo,
 static int
 loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 {
-	struct file *file;
+	struct path path;
 	struct kstat stat;
 	int ret;
 
@@ -1200,16 +1200,16 @@ loop_get_status(struct loop_device *lo,
 	}
 
 	/* Drop lo_ctl_mutex while we call into the filesystem. */
-	file = get_file(lo->lo_backing_file);
+	path = lo->lo_backing_file->f_path;
+	path_get(&path);
 	mutex_unlock(&lo->lo_ctl_mutex);
-	ret = vfs_getattr(&file->f_path, &stat, STATX_INO,
-			  AT_STATX_SYNC_AS_STAT);
+	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
 	if (!ret) {
 		info->lo_device = huge_encode_dev(stat.dev);
 		info->lo_inode = stat.ino;
 		info->lo_rdevice = huge_encode_dev(stat.rdev);
 	}
-	fput(file);
+	path_put(&path);
 	return ret;
 }
 


