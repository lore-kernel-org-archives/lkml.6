Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D82C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9165920989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079356;
	bh=EqleEmAB6Iv+yxeVZSRrZ0ZCWAIcTJ51XrAETnfBNR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Re+bOHQ9cCsc1BDYSkCIce+U7bJmcj6nFdVVl20Y6KsccNXVG94t7Rl/DWbajf+XY
	 WpqsJSvcNZuPLHLBv3et+7xrENlqoey6eLu/EB93ngZKbbvKvZV1KLYFfUNzSaWM0t
	 kQSbQVs6cD2ObvVm2IVLpaS1UNlVSLui4jN6qj+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbfAUOCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:02:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732820AbfAUOCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:02:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5F32089F;
        Mon, 21 Jan 2019 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079351;
        bh=EqleEmAB6Iv+yxeVZSRrZ0ZCWAIcTJ51XrAETnfBNR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OY1Q7/h2jC7qtmAiZjSxqTA3iDAB3EXLDmXy6svvB4TtO0N60C0dBFlLjsvacpuyW
         +orOh7G9U3ZmNq1PPGG6oHXDVyXIoM6xgMv9Br9DC9nRR8y5pupL6x+9q2xdyZgTt/
         lCGsmH3q9/+KRYpPhJFY8eMJTTP/F4LxmD3GJnrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 95/99] loop: Get rid of nested acquisition of loop_ctl_mutex
Date:   Mon, 21 Jan 2019 14:49:27 +0100
Message-Id: <20190121134919.547083403@linuxfoundation.org>
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
@@ -682,7 +682,7 @@ static int loop_change_fd(struct loop_de
 	int		error;
 	bool		partscan;
 
-	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
 		return error;
 	error = -ENXIO;
@@ -920,7 +920,7 @@ static int loop_set_fd(struct loop_devic
 	if (!file)
 		goto out;
 
-	error = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	error = mutex_lock_killable(&loop_ctl_mutex);
 	if (error)
 		goto out_putf;
 
@@ -1136,7 +1136,7 @@ static int loop_clr_fd(struct loop_devic
 {
 	int err;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	if (lo->lo_state != Lo_bound) {
@@ -1173,7 +1173,7 @@ loop_set_status(struct loop_device *lo,
 	struct block_device *bdev;
 	bool partscan = false;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	if (lo->lo_encrypt_key_size &&
@@ -1278,7 +1278,7 @@ loop_get_status(struct loop_device *lo,
 	struct kstat stat;
 	int ret;
 
-	ret = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
 	if (lo->lo_state != Lo_bound) {
@@ -1467,7 +1467,7 @@ static int lo_simple_ioctl(struct loop_d
 {
 	int err;
 
-	err = mutex_lock_killable_nested(&loop_ctl_mutex, 1);
+	err = mutex_lock_killable(&loop_ctl_mutex);
 	if (err)
 		return err;
 	switch (cmd) {


