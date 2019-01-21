Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09011C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD77F2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079467;
	bh=oUI+KXvCuIs4SwvDvhca4GNDrNxrLbcCP0MdtfspWiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0R1FkbOpTsRqMGA1OSMfGzkMD9G/zUrlo8mVRbPsWU2oE9ai1c12k46CR1h1Q137e
	 MJyYbZkPfLChxo0BaIETkJeSBTan+gbsT0m5dLj5Aj2D57Nbww6xIetLe1uUaoX1SO
	 ZTD1vf7FLpt++cg8qU4tk0hAifZ7wa4vk+8KOBFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfAUOE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731717AbfAUOCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214B62089F;
        Mon, 21 Jan 2019 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079328;
        bh=oUI+KXvCuIs4SwvDvhca4GNDrNxrLbcCP0MdtfspWiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zsgB4M03+nbFAVlKtC5n6LMZHetwyNTtGYM6Pa76SZClugSatV1CVLSYCzh6dwtYV
         qWGzSFBEfb/yyLoNT3vdYgUJG7vuSJ0l5OpVeD1b2oZfDLSPQrrF3FsOmuXbYoGXnx
         JQvCdUiRtrHfNffoxHf5nse3SdmsVO6IPXaFNLs0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 87/99] loop: Push loop_ctl_mutex down to loop_get_status()
Date:   Mon, 21 Jan 2019 14:49:19 +0100
Message-Id: <20190121134917.476496759@linuxfoundation.org>
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

commit 4a5ce9ba5877e4640200d84a735361306ad1a1b8 upstream.

Push loop_ctl_mutex down to loop_get_status() to avoid the unusual
convention that the function gets called with loop_ctl_mutex held and
releases it.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1233,6 +1233,9 @@ loop_get_status(struct loop_device *lo,
 	struct kstat stat;
 	int ret;
 
+	ret = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	if (ret)
+		return ret;
 	if (lo->lo_state != Lo_bound) {
 		mutex_unlock(&loop_ctl_mutex);
 		return -ENXIO;
@@ -1347,10 +1350,8 @@ loop_get_status_old(struct loop_device *
 	struct loop_info64 info64;
 	int err;
 
-	if (!arg) {
-		mutex_unlock(&loop_ctl_mutex);
+	if (!arg)
 		return -EINVAL;
-	}
 	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_old(&info64, &info);
@@ -1365,10 +1366,8 @@ loop_get_status64(struct loop_device *lo
 	struct loop_info64 info64;
 	int err;
 
-	if (!arg) {
-		mutex_unlock(&loop_ctl_mutex);
+	if (!arg)
 		return -EINVAL;
-	}
 	err = loop_get_status(lo, &info64);
 	if (!err && copy_to_user(arg, &info64, sizeof(info64)))
 		err = -EFAULT;
@@ -1478,12 +1477,7 @@ static int lo_ioctl(struct block_device
 		}
 		break;
 	case LOOP_GET_STATUS:
-		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-		if (err)
-			return err;
-		err = loop_get_status_old(lo, (struct loop_info __user *) arg);
-		/* loop_get_status() unlocks loop_ctl_mutex */
-		break;
+		return loop_get_status_old(lo, (struct loop_info __user *) arg);
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
@@ -1496,12 +1490,7 @@ static int lo_ioctl(struct block_device
 		}
 		break;
 	case LOOP_GET_STATUS64:
-		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-		if (err)
-			return err;
-		err = loop_get_status64(lo, (struct loop_info64 __user *) arg);
-		/* loop_get_status() unlocks loop_ctl_mutex */
-		break;
+		return loop_get_status64(lo, (struct loop_info64 __user *) arg);
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
 	case LOOP_SET_BLOCK_SIZE:
@@ -1626,10 +1615,8 @@ loop_get_status_compat(struct loop_devic
 	struct loop_info64 info64;
 	int err;
 
-	if (!arg) {
-		mutex_unlock(&loop_ctl_mutex);
+	if (!arg)
 		return -EINVAL;
-	}
 	err = loop_get_status(lo, &info64);
 	if (!err)
 		err = loop_info64_to_compat(&info64, arg);
@@ -1652,12 +1639,8 @@ static int lo_compat_ioctl(struct block_
 		}
 		break;
 	case LOOP_GET_STATUS:
-		err = mutex_lock_killable(&loop_ctl_mutex);
-		if (!err) {
-			err = loop_get_status_compat(lo,
-						     (struct compat_loop_info __user *)arg);
-			/* loop_get_status() unlocks loop_ctl_mutex */
-		}
+		err = loop_get_status_compat(lo,
+				     (struct compat_loop_info __user *)arg);
 		break;
 	case LOOP_SET_CAPACITY:
 	case LOOP_CLR_FD:


