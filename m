Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D243C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D03B620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWsdqXsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D03B620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbeKAIJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbeKAIJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B27412081B;
        Wed, 31 Oct 2018 23:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027346;
        bh=yXBEDLXz5W+koJfcdY9F5kiUrEfoE5WNwRnSDFUQkoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VWsdqXsA/iWEBkTWqXYIEuEXgZNXJNmJQbBA54wqqWjm7nk9PPaRdU0FSwZu3JtYk
         VSX6GG6SnHB5wuwlcO9n3RqLMVhV08jAj01F5woQ7j/w9lmnIqfC9m0s8zKTfEmlWO
         NH2fwgEUjiglQxbN1VmeOdXvAxW2hFW3OjWUAiFA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jack Wang <jinpu.wang@profitbricks.com>, Shaohua Li <shli@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 078/126] md: fix memleak for mempool
Date:   Wed, 31 Oct 2018 19:07:06 -0400
Message-Id: <20181031230754.29029-78-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/md/md.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index e9be5cd9bb96..71665e2c30eb 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5909,14 +5909,6 @@ static void __md_stop(struct mddev *mddev)
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
-- 
2.17.1

