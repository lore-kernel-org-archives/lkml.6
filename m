Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BAFC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54232580A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B54232580A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965813AbeGAR77 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:59:59 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34770 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030387AbeGAQa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:30:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A065ACD;
        Sun,  1 Jul 2018 16:30:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Joshua Miller <joshmiller@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 030/157] fuse: fix congested state leak on aborted connections
Date:   Sun,  1 Jul 2018 18:21:42 +0200
Message-Id: <20180701160853.845542816@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 8a301eb16d99983a4961f884690ec97b92e7dcfe upstream.

If a connection gets aborted while congested, FUSE can leave
nr_wb_congested[] stuck until reboot causing wait_iff_congested() to
wait spuriously which can lead to severe performance degradation.

The leak is caused by gating congestion state clearing with
fc->connected test in request_end().  This was added way back in 2009
by 26c3679101db ("fuse: destroy bdi on umount").  While the commit
description doesn't explain why the test was added, it most likely was
to avoid dereferencing bdi after it got destroyed.

Since then, bdi lifetime rules have changed many times and now we're
always guaranteed to have access to the bdi while the superblock is
alive (fc->sb).

Drop fc->connected conditional to avoid leaking congestion states.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Joshua Miller <joshmiller@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: stable@vger.kernel.org # v2.6.29+
Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -381,8 +381,7 @@ static void request_end(struct fuse_conn
 		if (!fc->blocked && waitqueue_active(&fc->blocked_waitq))
 			wake_up(&fc->blocked_waitq);
 
-		if (fc->num_background == fc->congestion_threshold &&
-		    fc->connected && fc->sb) {
+		if (fc->num_background == fc->congestion_threshold && fc->sb) {
 			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_SYNC);
 			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_ASYNC);
 		}


