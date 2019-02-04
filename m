Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78661C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378AB207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278568;
	bh=+m6ID36Xo54TBaeY6J/SBPPMefOfL1dBzOOLtYDzZxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RCAucCYEWIa1MQUKaF75xM8IEiyItuUFAZEFpid1Q/8/S68xWCNYFX7vurAeeTF8I
	 q6vJhlBrjVBjVMg/b50s2gFgW9w461EOJP3kQ64hOkODZFmBJmfTWygRD020DbWFii
	 lZmDgQuIKzHri1UtqGB6+0DqBZaVGAB7ljMpCkXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfBDKkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbfBDKkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58C362075B;
        Mon,  4 Feb 2019 10:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276835;
        bh=+m6ID36Xo54TBaeY6J/SBPPMefOfL1dBzOOLtYDzZxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0OiMnD51XDqQomnupox+ScWad9YMDBL7/jidRMW7V47nE08ZX4D92KMuQqN/hTDN
         r6HuWNzP0YPKz4jOwzQMf7LBCNvr4WC/G0opCBsMfsKStuRiM5I53PllJ1kR4dvH1K
         jhHPlJ4gsSMRbU9CDWhyOEuHoOpTMI0H1eUmTrMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 31/65] Revert "loop: Fold __loop_release into loop_release"
Date:   Mon,  4 Feb 2019 11:36:24 +0100
Message-Id: <20190204103616.054298690@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 4ee414c3b6021db621901f2697d35774926268f6 which is
commit 967d1dc144b50ad005e5eecdfadfbcfb399ffff6 upstream.

It is not needed in the 4.4.y tree at this time.

Reported-by: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1586,15 +1586,12 @@ out:
 	return err;
 }
 
-static void lo_release(struct gendisk *disk, fmode_t mode)
+static void __lo_release(struct loop_device *lo)
 {
-	struct loop_device *lo;
 	int err;
 
-	mutex_lock(&loop_index_mutex);
-	lo = disk->private_data;
 	if (atomic_dec_return(&lo->lo_refcnt))
-		goto unlock_index;
+		return;
 
 	mutex_lock(&loop_ctl_mutex);
 	if (lo->lo_flags & LO_FLAGS_AUTOCLEAR) {
@@ -1604,7 +1601,7 @@ static void lo_release(struct gendisk *d
 		 */
 		err = loop_clr_fd(lo);
 		if (!err)
-			goto unlock_index;
+			return;
 	} else {
 		/*
 		 * Otherwise keep thread (if running) and config,
@@ -1614,7 +1611,12 @@ static void lo_release(struct gendisk *d
 	}
 
 	mutex_unlock(&loop_ctl_mutex);
-unlock_index:
+}
+
+static void lo_release(struct gendisk *disk, fmode_t mode)
+{
+	mutex_lock(&loop_index_mutex);
+	__lo_release(disk->private_data);
 	mutex_unlock(&loop_index_mutex);
 }
 


