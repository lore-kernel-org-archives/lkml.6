Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B138C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27CC620861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080237;
	bh=bRGq9l31BgMH5n9MokecAAXJguOPfaJJJl3hzfqtG9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IHXBKDrb1b41AquJuI+fUUoAQlIB6Y9m+X69lV3GDLuvLyMpofGQOv2+v2XE4epvy
	 WI8bVC1qQibOOaIQ7FDRXhVzM0Yw653WfcwF9Ltia05ZIzhqYlnh6W/j/24unnxDcM
	 5XErhGbS441FTQKw89rVULXoRakSAtoqlY3NiM0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbfAUORP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbfAUNue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE02C20861;
        Mon, 21 Jan 2019 13:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078634;
        bh=bRGq9l31BgMH5n9MokecAAXJguOPfaJJJl3hzfqtG9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fd7DDY57PeQrd5EO0o8xc2OTEm6OnMN8MmTxUnMqeuDWgLx2ummtA1a7JVKvOSsmB
         cLaQt+5nOQOeudC5R+RVWxOIQ0x9BoswxoE2diDWCj/9dU8y1U3oosxMzAMPPYgsnt
         ybMZv+SQK/ttKcHPhWI4dkWMwt+hPA+VW2sv0A3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.20 101/111] loop: Push loop_ctl_mutex down to loop_set_status()
Date:   Mon, 21 Jan 2019 14:43:35 +0100
Message-Id: <20190121122506.691167911@linuxfoundation.org>
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

commit 550df5fdacff94229cde0ed9b8085155654c1696 upstream.

Push loop_ctl_mutex down to loop_set_status(). We will need this to be
able to call loop_reread_partitions() without loop_ctl_mutex.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1141,46 +1141,55 @@ loop_set_status(struct loop_device *lo,
 	struct loop_func_table *xfer;
 	kuid_t uid = current_uid();
 
+	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	if (err)
+		return err;
 	if (lo->lo_encrypt_key_size &&
 	    !uid_eq(lo->lo_key_owner, uid) &&
-	    !capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
-	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE)
-		return -EINVAL;
+	    !capable(CAP_SYS_ADMIN)) {
+		err = -EPERM;
+		goto out_unlock;
+	}
+	if (lo->lo_state != Lo_bound) {
+		err = -ENXIO;
+		goto out_unlock;
+	}
+	if ((unsigned int) info->lo_encrypt_key_size > LO_KEY_SIZE) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
 
 	/* I/O need to be drained during transfer transition */
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	err = loop_release_xfer(lo);
 	if (err)
-		goto exit;
+		goto out_unfreeze;
 
 	if (info->lo_encrypt_type) {
 		unsigned int type = info->lo_encrypt_type;
 
 		if (type >= MAX_LO_CRYPT) {
 			err = -EINVAL;
-			goto exit;
+			goto out_unfreeze;
 		}
 		xfer = xfer_funcs[type];
 		if (xfer == NULL) {
 			err = -EINVAL;
-			goto exit;
+			goto out_unfreeze;
 		}
 	} else
 		xfer = NULL;
 
 	err = loop_init_xfer(lo, xfer, info);
 	if (err)
-		goto exit;
+		goto out_unfreeze;
 
 	if (lo->lo_offset != info->lo_offset ||
 	    lo->lo_sizelimit != info->lo_sizelimit) {
 		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
 			err = -EFBIG;
-			goto exit;
+			goto out_unfreeze;
 		}
 	}
 
@@ -1212,7 +1221,7 @@ loop_set_status(struct loop_device *lo,
 	/* update dio if lo_offset or transfer is changed */
 	__loop_update_dio(lo, lo->use_dio);
 
- exit:
+out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	if (!err && (info->lo_flags & LO_FLAGS_PARTSCAN) &&
@@ -1221,6 +1230,8 @@ loop_set_status(struct loop_device *lo,
 		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
 		loop_reread_partitions(lo, lo->lo_device);
 	}
+out_unlock:
+	mutex_unlock(&loop_ctl_mutex);
 
 	return err;
 }
@@ -1467,12 +1478,8 @@ static int lo_ioctl(struct block_device
 	case LOOP_SET_STATUS:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-			if (err)
-				return err;
 			err = loop_set_status_old(lo,
 					(struct loop_info __user *)arg);
-			mutex_unlock(&loop_ctl_mutex);
 		}
 		break;
 	case LOOP_GET_STATUS:
@@ -1480,12 +1487,8 @@ static int lo_ioctl(struct block_device
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-			if (err)
-				return err;
 			err = loop_set_status64(lo,
 					(struct loop_info64 __user *) arg);
-			mutex_unlock(&loop_ctl_mutex);
 		}
 		break;
 	case LOOP_GET_STATUS64:
@@ -1630,12 +1633,8 @@ static int lo_compat_ioctl(struct block_
 
 	switch(cmd) {
 	case LOOP_SET_STATUS:
-		err = mutex_lock_killable(&loop_ctl_mutex);
-		if (!err) {
-			err = loop_set_status_compat(lo,
-						     (const struct compat_loop_info __user *)arg);
-			mutex_unlock(&loop_ctl_mutex);
-		}
+		err = loop_set_status_compat(lo,
+			     (const struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_GET_STATUS:
 		err = loop_get_status_compat(lo,


