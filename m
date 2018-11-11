Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B78C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BB42077B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH4zjfI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BB42077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbeKLIUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388413AbeKLIUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:14 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581DE216FD;
        Sun, 11 Nov 2018 22:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975417;
        bh=27JdIfrD6Xs0rDBUM7pOqIimtUTilsaOfDz2AHZE0lU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JH4zjfI9LBc7z4M34pSnOdBFxAeHlcSExO/TgHieuOf/BJcGCdWX8B2iZWSquq0R+
         g12Mn7XhWinAVID0EJIs3GG0Gyk56nZsqjZ63+PaMNi/2VZAxct23m7bLGtGbYAKES
         wfrB5EoLuhPegdX2sxr1O+xKAfdVeDBGEL8wwr4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jack Wang <jinpu.wang@profitbricks.com>,
        Xiao Ni <xni@redhat.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 139/350] md: fix memleak for mempool
Date:   Sun, 11 Nov 2018 14:20:03 -0800
Message-Id: <20181111221713.864954585@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Wang <jinpu.wang@profitbricks.com>

[ Upstream commit 6aaa58c994277647f8b05ffef3b9b225a2d08f36 ]

I noticed kmemleak report memory leak when run create/stop
md in a loop, backtrace:
[<000000001ca975e7>] mempool_create_node+0x86/0xd0
[<0000000095576bcd>] md_run+0x1057/0x1410 [md_mod]
[<000000007b45c5fc>] do_md_run+0x15/0x130 [md_mod]
[<000000001ede9ec0>] md_ioctl+0x1f49/0x25d0 [md_mod]
[<000000004142cacf>] blkdev_ioctl+0x680/0xd00

The root cause is we alloc mddev->flush_pool and
mddev->flush_bio_pool in md_run, but from do_md_stop
will not call into md_stop but __md_stop, move the
mempool_destroy to __md_stop fixes the problem for me.

The bug was introduced in 5a409b4f56d5, the fixes should go to
4.18+

Fixes: 5a409b4f56d5 ("MD: fix lock contention for flush bios")
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/md.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5909,14 +5909,6 @@ static void __md_stop(struct mddev *mdde
 		mddev->to_remove = &md_redundancy_group;
 	module_put(pers->owner);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-}
-
-void md_stop(struct mddev *mddev)
-{
-	/* stop the array and free an attached data structures.
-	 * This is called from dm-raid
-	 */
-	__md_stop(mddev);
 	if (mddev->flush_bio_pool) {
 		mempool_destroy(mddev->flush_bio_pool);
 		mddev->flush_bio_pool = NULL;
@@ -5925,6 +5917,14 @@ void md_stop(struct mddev *mddev)
 		mempool_destroy(mddev->flush_pool);
 		mddev->flush_pool = NULL;
 	}
+}
+
+void md_stop(struct mddev *mddev)
+{
+	/* stop the array and free an attached data structures.
+	 * This is called from dm-raid
+	 */
+	__md_stop(mddev);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
 }


