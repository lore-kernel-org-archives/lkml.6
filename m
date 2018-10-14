Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48E8C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7739720890
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7739720890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeJNXPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:15:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36300 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbeJNXME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:04 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cW-FC; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000Ve-8S; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Chinner" <dchinner@redhat.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Tejun Heo" <tj@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
        "Jan Kara" <jack@suse.cz>,
        "syzbot" <syzbot+9873874c735f2892e7e9@syzkaller.appspotmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.24504917@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 258/366] bdi: Fix oops in wb_workfn()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit b8b784958eccbf8f51ebeee65282ca3fd59ea391 upstream.

Syzbot has reported that it can hit a NULL pointer dereference in
wb_workfn() due to wb->bdi->dev being NULL. This indicates that
wb_workfn() was called for an already unregistered bdi which should not
happen as wb_shutdown() called from bdi_unregister() should make sure
all pending writeback works are completed before bdi is unregistered.
Except that wb_workfn() itself can requeue the work with:

	mod_delayed_work(bdi_wq, &wb->dwork, 0);

and if this happens while wb_shutdown() is waiting in:

	flush_delayed_work(&wb->dwork);

the dwork can get executed after wb_shutdown() has finished and
bdi_unregister() has cleared wb->bdi->dev.

Make wb_workfn() use wakeup_wb() for requeueing the work which takes all
the necessary precautions against racing with bdi unregistration.

CC: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: Tejun Heo <tj@kernel.org>
Fixes: 839a8e8660b6777e7fe4e80af1a048aebe2b5977
Reported-by: syzbot <syzbot+9873874c735f2892e7e9@syzkaller.appspotmail.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[bwh: Backported to 3.16:
 - Use bdi_wakeup_thread() instead of wb_wakeup()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/fs-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1071,7 +1071,7 @@ void bdi_writeback_workfn(struct work_st
 	}
 
 	if (!list_empty(&bdi->work_list))
-		mod_delayed_work(bdi_wq, &wb->dwork, 0);
+		bdi_wakeup_thread(bdi);
 	else if (wb_has_dirty_io(wb) && dirty_writeback_interval)
 		bdi_wakeup_thread_delayed(bdi);
 

