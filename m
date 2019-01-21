Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5D4C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4F920879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078662;
	bh=BAXXkusMzR9ZP5jRnYfm/coPVdWS/tUFSUJKqIA9L3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TJc5tBXJwZS4uEx1M8/TBu4T3nTQsHP/M5jItvRzjuXA6xd79gfHr+gp1ITHljyeq
	 6nwKwQzHovN3HbMVfNTjtZvlQKNo+iNuOJ4PxsxGaKXQh45O+AgPWo3j/NexMw5TRw
	 t+wZVmdbcz1Gd+OI1zzF08WRMk40X9KEHD4LX05o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfAUNvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:51:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730683AbfAUNu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D11CA2063F;
        Mon, 21 Jan 2019 13:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078655;
        bh=BAXXkusMzR9ZP5jRnYfm/coPVdWS/tUFSUJKqIA9L3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsNPhBfC9Q5MALWFQbuZYHIJUB6iFm7kGz30l11S8omMpS5vzp9onPJ9RTBXMgXZW
         MuvDftrwZoF1092oQImmc6lonKpHhcYM5OEGz9Wkofgfd3vdIsZ/FT1ih0/qjROvNR
         Y33AY3AFyNBj4GhcbCOul61BiJ8ymH+H+zB5NwbU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.20 108/111] loop: Get rid of nested acquisition of loop_ctl_mutex
Date:   Mon, 21 Jan 2019 14:43:42 +0100
Message-Id: <20190121122507.021764057@linuxfoundation.org>
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

commit c28445fa06a3a54e06938559b9514c5a7f01c90f upstream.

The nested acquisition of loop_ctl_mutex (->lo_ctl_mutex back then) has
been introduced by commit f028f3b2f987e "loop: fix circular locking in
loop_clr_fd()" to fix lockdep complains about bd_mutex being acquired
after lo_ctl_mutex during partition rereading. Now that these are
properly fixed, let's stop fooling lockdep.

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -681,7 +681,7 @@ static int loop_change_fd(struct loop_de
 	int		error;
 	bool		partscan;
 
-	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
 		return error;
 	error = -ENXIO;
@@ -919,7 +919,7 @@ static int loop_set_fd(struct loop_devic
 	if (!file)
 		goto out;
 
-	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
 		goto out_putf;
 
@@ -1135,7 +1135,7 @@ static int loop_clr_fd(struct loop_devic
 {
 	int err;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	if (lo->lo_state != Lo_bound) {
@@ -1172,7 +1172,7 @@ loop_set_status(struct loop_device *lo,
 	struct block_device *bdev;
 	bool partscan = false;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	if (lo->lo_encrypt_key_size &&
@@ -1277,7 +1277,7 @@ loop_get_status(struct loop_device *lo,
 	struct kstat stat;
 	int ret;
 
-	ret = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
 	if (lo->lo_state != Lo_bound) {
@@ -1466,7 +1466,7 @@ static int lo_simple_ioctl(struct loop_d
 {
 	int err;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	switch (cmd) {


