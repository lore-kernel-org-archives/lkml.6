Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEF1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD508217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276836;
	bh=wZZFVLfsqTizts0APeWVA5nwzwIUgrV5KjTq66JVGe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D7zDSCkiDJJptqMQDa4VbqWs5/6z2A/xNQ17qyyfJh+xpp0xcjcGMKN7psB+SJvEX
	 3f4LxfOR4n5IQx7/KYDUS2nVGNz/VheehiioTej5Gl5erXkJbeoTYd7fTwoqW5uAiI
	 N/v0QdewPLURM59xggqlCX6tLBziXPzNE1ILVKa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfBDKkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:40:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbfBDKka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:40:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6889B2087C;
        Mon,  4 Feb 2019 10:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276829;
        bh=wZZFVLfsqTizts0APeWVA5nwzwIUgrV5KjTq66JVGe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vbqocXcCRziKIyXjvvwKkYqGfHN7OYYenmPRcUs0AKTFJ4iW0r94bhYi/Q1Skhthr
         E/SdYdH98/iJnpq4zmsbdGrkWQTspfXvYmfwgbFf2W6O3RpdZPr9QuHuqEJswU/A7h
         Z/GJ3jsqFFyyE3RW/jzv+SPvv4MZ0dRQeamMlkaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ming Lei <ming.lei@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 29/65] Revert "loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()"
Date:   Mon,  4 Feb 2019 11:36:22 +0100
Message-Id: <20190204103615.638138495@linuxfoundation.org>
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

This reverts commit 9ec298cc874d08020f45791a8396e1593c3278c1 which is
commit 628bd85947091830a8c4872adfd5ed1d515a9cf2 upstream.

It is not needed in the 4.4.y tree at this point in time.

Reported-by: Jan Kara <jack@suse.cz>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1936,10 +1936,12 @@ static long loop_control_ioctl(struct fi
 			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
+			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
+			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;


