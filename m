Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36650C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09945214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079341;
	bh=xt3K6zjpq4/ogTZKuj//FzF3ipctRcEuVB52vyq9/tE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oDXLzF2FyLQ6ZeH5YsWVphapTBRcl3utorQ3zXUZJwHs1HJZAD3uPDxKJijPyfmsJ
	 xhIEUwP/BwUkW+PKV4U30aFRrTjmsVHKC6R/eAY++O1GhqTk1zpScSZXVCz7aDNs4e
	 q9qamD6VpOtUI79/xczUl+RgU6qxovU2ZyKlmMIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbfAUOCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732756AbfAUOCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1BF421734;
        Mon, 21 Jan 2019 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079337;
        bh=xt3K6zjpq4/ogTZKuj//FzF3ipctRcEuVB52vyq9/tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NkHKtz4u4KygLgJzE/jFZPJl821QZAKpPspZZuxWE21fnIfJT4K93bQWz+1m/2jEJ
         ChFN06rSgrTOi1ju1Sev/YKefeJ6kK2bFhE6coojtbZ0uUg067jUw5m0rEgYMpqRIH
         lFK/L4rfAfAHN6ZgYKm+e1C5qP93Ym39ija/bcpQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 90/99] loop: Push loop_ctl_mutex down to loop_change_fd()
Date:   Mon, 21 Jan 2019 14:49:22 +0100
Message-Id: <20190121134917.933331750@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit c371077000f4138ee3c15fbed50101ff24bdc91d upstream.

Push loop_ctl_mutex down to loop_change_fd(). We will need this to be
able to call loop_reread_partitions() without loop_ctl_mutex.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -692,19 +692,22 @@ static int loop_change_fd(struct loop_de
 	struct file	*file, *old_file;
 	int		error;
 
+	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	if (error)
+		return error;
 	error = -ENXIO;
 	if (lo->lo_state != Lo_bound)
-		goto out;
+		goto out_unlock;
 
 	/* the loop device has to be read-only */
 	error = -EINVAL;
 	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
-		goto out;
+		goto out_unlock;
 
 	error = -EBADF;
 	file = fget(arg);
 	if (!file)
-		goto out;
+		goto out_unlock;
 
 	error = loop_validate_file(file, bdev);
 	if (error)
@@ -731,11 +734,13 @@ static int loop_change_fd(struct loop_de
 	fput(old_file);
 	if (lo->lo_flags & LO_FLAGS_PARTSCAN)
 		loop_reread_partitions(lo, bdev);
+	mutex_unlock(&loop_ctl_mutex);
 	return 0;
 
- out_putf:
+out_putf:
 	fput(file);
- out:
+out_unlock:
+	mutex_unlock(&loop_ctl_mutex);
 	return error;
 }
 
@@ -1470,12 +1475,7 @@ static int lo_ioctl(struct block_device
 	case LOOP_SET_FD:
 		return loop_set_fd(lo, mode, bdev, arg);
 	case LOOP_CHANGE_FD:
-		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-		if (err)
-			return err;
-		err = loop_change_fd(lo, bdev, arg);
-		mutex_unlock(&loop_ctl_mutex);
-		break;
+		return loop_change_fd(lo, bdev, arg);
 	case LOOP_CLR_FD:
 		return loop_clr_fd(lo);
 	case LOOP_SET_STATUS:


