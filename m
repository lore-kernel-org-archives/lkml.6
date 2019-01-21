Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63947C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FB220989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079373;
	bh=kM9QCzN3tq46dsK1D1Ab99NgMHpCwKAq6ZqHjPOhHNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5+Ji9u24y/Emp7WWUeE+ia6+YL4m/pjEHhUQboE0dT0t10JFwRgw+ch2n5T4GHXu
	 efQdDh6xItIJVUkpTFyIyQfwPG94v3F/7hvuE0ghcToP2HWY0xO1DGb9GE8mBgaGRe
	 +CCFyHzgHNKrLuZ82FbZZDN8qCA7wnyHPAz2Y1Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfAUOCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:50588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732861AbfAUOCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 106D52089F;
        Mon, 21 Jan 2019 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079367;
        bh=kM9QCzN3tq46dsK1D1Ab99NgMHpCwKAq6ZqHjPOhHNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbu0Q90sYRLIS8Y8xSsN1IeReyguSlMsmclwUwtHQjQ3E6qFIUGYIJ3Nf3r7sRCCe
         4XIbshKnAGdemYF5TIMm8NiggPb/t1qPazf6DrkuRPjtIty/O0iYoGhKVL4+FQJQBE
         V+MP3Ne6098tY6lMirMJoFDBtrUmcBYE44r4ctR8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 80/99] block/loop: Dont grab "struct file" for vfs_getattr() operation.
Date:   Mon, 21 Jan 2019 14:49:12 +0100
Message-Id: <20190121134917.134272239@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1205,7 +1205,7 @@ loop_set_status(struct loop_device *lo,
 static int
 loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 {
-	struct file *file;
+	struct path path;
 	struct kstat stat;
 	int ret;
 
@@ -1230,16 +1230,16 @@ loop_get_status(struct loop_device *lo,
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
 


