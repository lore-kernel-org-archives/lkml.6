Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18788C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6C720861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080203;
	bh=7tbCnHWATkhPa98WT36bcE6R+wjoeH0VqDR+kE3Ya5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hCWkwh+4r5Ui5VL/J93m45tlAaKvYjqoVV2bkVr9epZGCXX97iCmYbuw1q0uo9axG
	 fAHgm2MMr+GFw4c215gy/0IcfBMB0V30HVEvvhAGZzPHoVzB55I1ctVq9i9zTLaK8u
	 LZTclXLniAIw5j1zGltptC8e5GiNwj6tLqXY0qUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730953AbfAUOQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:16:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729313AbfAUNu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:50:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634592063F;
        Mon, 21 Jan 2019 13:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078658;
        bh=7tbCnHWATkhPa98WT36bcE6R+wjoeH0VqDR+kE3Ya5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjJWC1qu4NfKxjPZ1c9PM/QvOMWbgeNR/jRmZ4Wz/IGbTZzlNVunMpNNz2wxtvch1
         YTGYQc2IO7NCfW02oSUkIhEtX2B+ewBIAUKXU6S6Bwy7mUsmdjEix/yOmYf9f6iKXz
         1EJuth3f1Y/StA63AHTSadJy5EXwWYKAzD2PWmKI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.20 109/111] loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()
Date:   Mon, 21 Jan 2019 14:43:43 +0100
Message-Id: <20190121122507.074297753@linuxfoundation.org>
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

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 628bd85947091830a8c4872adfd5ed1d515a9cf2 upstream.

Commit 0a42e99b58a20883 ("loop: Get rid of loop_index_mutex") forgot to
remove mutex_unlock(&loop_ctl_mutex) from loop_control_ioctl() when
replacing loop_index_mutex with loop_ctl_mutex.

Fixes: 0a42e99b58a20883 ("loop: Get rid of loop_index_mutex")
Reported-by: syzbot <syzbot+c0138741c2290fc5e63f@syzkaller.appspotmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/loop.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2074,12 +2074,10 @@ static long loop_control_ioctl(struct fi
 			break;
 		if (lo->lo_state != Lo_unbound) {
 			ret = -EBUSY;
-			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		if (atomic_read(&lo->lo_refcnt) > 0) {
 			ret = -EBUSY;
-			mutex_unlock(&loop_ctl_mutex);
 			break;
 		}
 		lo->lo_disk->private_data = NULL;


