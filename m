Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0291DC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B71214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080224;
	bh=xNs6CjLslVpddPXwywXaeiETLRukd9pKjJlfDb3RaNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hCdJeu0b5/VTAqSkWMgcDZ3llUSf4K7EjHJRUmwow3TPGMXEcTe1dfqb5XzlYOWjS
	 Jc6TpsNrr4ANAF/b+p5jX5c53h8rI5SnPIjURA5UVCmt79NySddUsMOTlJ8/Y0uGPE
	 /ehdB/grBMXapHbwHSznb9twieJgqA/o11MEQumI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbfAUNuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:50:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730586AbfAUNuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E84C2063F;
        Mon, 21 Jan 2019 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078636;
        bh=xNs6CjLslVpddPXwywXaeiETLRukd9pKjJlfDb3RaNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edKLL1NEzt9ONb9ScFM4XH6iwNU3ebEvHKB6OvHW4JHANh98Ta3LeVgkBp1S4D3MI
         IoZgjj+4vlv4/WE0TJ0+Ao4fNS/j5a4dZWiy+Jd0TDUdPHhnMIp1P5NnWdwsHM7X01
         ar6mA9uixJpFEnrHdbcgVfuBNX1BFWd1WBFZNZeU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.20 102/111] loop: Push loop_ctl_mutex down to loop_set_fd()
Date:   Mon, 21 Jan 2019 14:43:36 +0100
Message-Id: <20190121122506.734440877@linuxfoundation.org>
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

commit 757ecf40b7e029529768eb5f9562d5eeb3002106 upstream.

Push lo_ctl_mutex down to loop_set_fd(). We will need this to be able to
call loop_reread_partitions() without lo_ctl_mutex.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -918,13 +918,17 @@ static int loop_set_fd(struct loop_devic
 	if (!file)
 		goto out;
 
+	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	if (error)
+		goto out_putf;
+
 	error = -EBUSY;
 	if (lo->lo_state != Lo_unbound)
-		goto out_putf;
+		goto out_unlock;
 
 	error = loop_validate_file(file, bdev);
 	if (error)
-		goto out_putf;
+		goto out_unlock;
 
 	mapping = file->f_mapping;
 	inode = mapping->host;
@@ -936,10 +940,10 @@ static int loop_set_fd(struct loop_devic
 	error = -EFBIG;
 	size = get_loop_size(lo, file);
 	if ((loff_t)(sector_t)size != size)
-		goto out_putf;
+		goto out_unlock;
 	error = loop_prepare_queue(lo);
 	if (error)
-		goto out_putf;
+		goto out_unlock;
 
 	error = 0;
 
@@ -978,11 +982,14 @@ static int loop_set_fd(struct loop_devic
 	 * put /dev/loopXX inode. Later in __loop_clr_fd() we bdput(bdev).
 	 */
 	bdgrab(bdev);
+	mutex_unlock(&loop_ctl_mutex);
 	return 0;
 
- out_putf:
+out_unlock:
+	mutex_unlock(&loop_ctl_mutex);
+out_putf:
 	fput(file);
- out:
+out:
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	return error;
@@ -1460,12 +1467,7 @@ static int lo_ioctl(struct block_device
 
 	switch (cmd) {
 	case LOOP_SET_FD:
-		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
-		if (err)
-			return err;
-		err = loop_set_fd(lo, mode, bdev, arg);
-		mutex_unlock(&loop_ctl_mutex);
-		break;
+		return loop_set_fd(lo, mode, bdev, arg);
 	case LOOP_CHANGE_FD:
 		err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
 		if (err)


