Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFB1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E2121582
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMaFSPgE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7E2121582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406221AbeKTD1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:27:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405390AbeKTD1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:27:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55DA5214E0;
        Mon, 19 Nov 2018 17:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646998;
        bh=q80V4mXW3LpSK4Xojdtt25aVo9bx5DrshGmInRp8VrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMaFSPgEzS4pLpN918YJUexwmc9Enn3OQVyYq3j3nBGQBg8AsV5HgrTIzuE9NkvR0
         qr5bpX4pJXdPOickHfI6iw1BJeNwQVFNcgdsjWp2qdJHbAcBqrVIx7xmfVeUGdbVp5
         F1acWIi8Ep/wYMVzoD/af1ch5pVYUvl5AOz6b+UA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 12/90] swim: fix cleanup on setup error
Date:   Mon, 19 Nov 2018 17:28:54 +0100
Message-Id: <20181119162622.836467807@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit 1448a2a5360ae06f25e2edc61ae070dff5c0beb4 ]

If we fail to allocate the request queue for a disk, we still need to
free that disk, not just the previous ones. Additionally, we need to
cleanup the previous request queues.

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/swim.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -868,8 +868,17 @@ static int swim_floppy_init(struct swim_
 
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
 


