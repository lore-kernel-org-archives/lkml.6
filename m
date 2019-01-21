Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39D9C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36CA2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078657;
	bh=xBjduPOz16xQhYaAE4btfiJQxGmAdlN2uDd0iEm2Egw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VmOeZEla63vlGtkt5w0ySk4liGvBsJ2Cnu+wkHUobciKQ3D0wJN0ZmGiXuPwFYLMS
	 8OjAj2aELmiJH4VGrfCwgTD4AKw7uclicjzeJ+dqMvQgAhyR/qJzpwv8v8TawKtO1u
	 ksP0yGdXgbWj+olQeUlcJwUKbMtgYhob6x8OJbaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfAUNu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730668AbfAUNuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A64A2063F;
        Mon, 21 Jan 2019 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078652;
        bh=xBjduPOz16xQhYaAE4btfiJQxGmAdlN2uDd0iEm2Egw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkcsqvsClcRtHZz3NiVDeMa869+eGQQaRfNFkeMps6Gk9BCuSEXYtUYZ2R8+DV2o8
         sEFn+W5XwhSabAV1WuOxIzrc2pY4nr1nqoUQi5Fx3XtZgybq8A/PUafK92WDr4RtBh
         YlffKei1o7qxGW7sKN/6Gi4l9q41OhTll/fSK5t8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.20 107/111] loop: Avoid circular locking dependency between loop_ctl_mutex and bd_mutex
Date:   Mon, 21 Jan 2019 14:43:41 +0100
Message-Id: <20190121122506.972806750@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 1dded9acf6dc9a34cd27fcf8815507e4e65b3c4f upstream.

Code in loop_change_fd() drops reference to the old file (and also the
new file in a failure case) under loop_ctl_mutex. Similarly to a
situation in loop_set_fd() this can create a circular locking dependency
if this was the last reference holding the file open. Delay dropping of
the file reference until we have released loop_ctl_mutex.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -677,7 +677,7 @@ static int loop_validate_file(struct fil
 static int loop_change_fd(struct loop_device *lo, struct block_device *bdev,
 			  unsigned int arg)
 {
-	struct file	*file, *old_file;
+	struct file	*file = NULL, *old_file;
 	int		error;
 	bool		partscan;
 
@@ -686,21 +686,21 @@ static int loop_change_fd(struct loop_de
 		return error;
 	error = -ENXIO;
 	if (lo->lo_state != Lo_bound)
-		goto out_unlock;
+		goto out_err;
 
 	/* the loop device has to be read-only */
 	error = -EINVAL;
 	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY))
-		goto out_unlock;
+		goto out_err;
 
 	error = -EBADF;
 	file = fget(arg);
 	if (!file)
-		goto out_unlock;
+		goto out_err;
 
 	error = loop_validate_file(file, bdev);
 	if (error)
-		goto out_putf;
+		goto out_err;
 
 	old_file = lo->lo_backing_file;
 
@@ -708,7 +708,7 @@ static int loop_change_fd(struct loop_de
 
 	/* size of the new backing store needs to be the same */
 	if (get_loop_size(lo, file) != get_loop_size(lo, old_file))
-		goto out_putf;
+		goto out_err;
 
 	/* and ... switch */
 	blk_mq_freeze_queue(lo->lo_queue);
@@ -719,18 +719,22 @@ static int loop_change_fd(struct loop_de
 			     lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue);
-
-	fput(old_file);
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
 	mutex_unlock(&loop_ctl_mutex);
+	/*
+	 * We must drop file reference outside of loop_ctl_mutex as dropping
+	 * the file ref can take bd_mutex which creates circular locking
+	 * dependency.
+	 */
+	fput(old_file);
 	if (partscan)
 		loop_reread_partitions(lo, bdev);
 	return 0;
 
-out_putf:
-	fput(file);
-out_unlock:
+out_err:
 	mutex_unlock(&loop_ctl_mutex);
+	if (file)
+		fput(file);
 	return error;
 }
 


