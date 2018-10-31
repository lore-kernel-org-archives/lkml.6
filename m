Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7717BECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FB82081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qh01TvEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FB82081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbeKAIIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729500AbeKAIIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:08:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3463220821;
        Wed, 31 Oct 2018 23:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027280;
        bh=nH/00+aBMSpJ37rlZrcLUeAkO7BWS4+oo7lO45Cnxhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qh01TvEyLdj3ZagGkXJnV8nuMesksJSOje12nYifdA0i8AGyJdn1P+rGZqh9Txg2s
         63nlGXPUqk2w/OmAXy8DkOFb+i3iKGaraHkonDjLLi/ugK2UirncRSHZaeaSaQiFfc
         CPnlYX1YwQhSTqkNaJWMgHoHPXeLuALxJ8xfXnSg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 006/126] swim: fix cleanup on setup error
Date:   Wed, 31 Oct 2018 19:05:54 -0400
Message-Id: <20181031230754.29029-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit 1448a2a5360ae06f25e2edc61ae070dff5c0beb4 ]

If we fail to allocate the request queue for a disk, we still need to
free that disk, not just the previous ones. Additionally, we need to
cleanup the previous request queues.

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/swim.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 0e31884a9519..cbe909c51847 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -887,8 +887,17 @@ static int swim_floppy_init(struct swim_priv *swd)
 
 exit_put_disks:
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-	while (drive--)
-		put_disk(swd->unit[drive].disk);
+	do {
+		struct gendisk *disk = swd->unit[drive].disk;
+
+		if (disk) {
+			if (disk->queue) {
+				blk_cleanup_queue(disk->queue);
+				disk->queue = NULL;
+			}
+			put_disk(disk);
+		}
+	} while (drive--);
 	return err;
 }
 
-- 
2.17.1

