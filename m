Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCA7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FA9208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vzXGqi8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FA9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbeKTDO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:14:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:14:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0F2E206BA;
        Mon, 19 Nov 2018 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646214;
        bh=uj6pLK1qYw7JPUtti5S2gFliIK+lGbEuwDEG/MFbkBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzXGqi8JETqr0nM6obcgWp4XvVovHdX+j2APezqnrHh7Q66Fr6Hr2EDOd9m3aJLpo
         PcqIayvUjcE9AWm6zlbj5Yz9HLb3qhl0E7Vwc3i2t+6JM1gCaeTqIFGAORJrpN3YT2
         Gw6YekA6hWo35hqWK0KF23vQz8I8fKEcXJZxHbgo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.14 032/124] fuse: fix blocked_waitq wakeup
Date:   Mon, 19 Nov 2018 17:28:06 +0100
Message-Id: <20181119162619.815851268@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

commit 908a572b80f6e9577b45e81b3dfe2e22111286b8 upstream.

Using waitqueue_active() is racy.  Make sure we issue a wake_up()
unconditionally after storing into fc->blocked.  After that it's okay to
optimize with waitqueue_active() since the first wake up provides the
necessary barrier for all waiters, not the just the woken one.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 3c18ef8117f0 ("fuse: optimize wake_up")
Cc: <stable@vger.kernel.org> # v3.10
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/fuse/dev.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -384,12 +384,19 @@ static void request_end(struct fuse_conn
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		spin_lock(&fc->lock);
 		clear_bit(FR_BACKGROUND, &req->flags);
-		if (fc->num_background == fc->max_background)
+		if (fc->num_background == fc->max_background) {
 			fc->blocked = 0;
-
-		/* Wake up next waiter, if any */
-		if (!fc->blocked && waitqueue_active(&fc->blocked_waitq))
 			wake_up(&fc->blocked_waitq);
+		} else if (!fc->blocked) {
+			/*
+			 * Wake up next waiter, if any.  It's okay to use
+			 * waitqueue_active(), as we've already synced up
+			 * fc->blocked with waiters with the wake_up() call
+			 * above.
+			 */
+			if (waitqueue_active(&fc->blocked_waitq))
+				wake_up(&fc->blocked_waitq);
+		}
 
 		if (fc->num_background == fc->congestion_threshold && fc->sb) {
 			clear_bdi_congested(fc->sb->s_bdi, BLK_RW_SYNC);


