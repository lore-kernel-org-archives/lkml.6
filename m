Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8191FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6A020840
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197916;
	bh=AMgGANp5ajTwGSr+4M0xvSN6myVutqp4kDnjtdXX/zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=10m+18A8ALHhdLh+C27W4u5qkj5XpFffUq9Poq5oKY8K0WXdrKP1rlwu28BR33HpS
	 IlQJbDcNlh5CWI32qAyZ2PePCpB8MceB3AaEr5MAqmpXRSLa0UNuQ9QgjIwATVQSm0
	 xgZ8i9qqrkkLIVg8Phuz4nYMCUgHkWzzIIr99doc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbfBOCby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:31:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:52492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391031AbfBOCM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:27 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D6221934;
        Fri, 15 Feb 2019 02:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196746;
        bh=AMgGANp5ajTwGSr+4M0xvSN6myVutqp4kDnjtdXX/zg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSXc/vIpu+NxO0MywDOSi1rIBOlDYkUMhtjwrqiiW75CatA2yfh9N+KTMg9MKeiyh
         VcC+8kYiusAUEKw0RboNQi63a/s+JBESWKpERIEuhJ91O5nyxgMevt7D6HmRzT+B2D
         /D0bjrn7sjXmFAhsqWWEDZjolb+3ZwxNWj/NVuCI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ernesto=20A=2E=20Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 40/65] direct-io: allow direct writes to empty inodes
Date:   Thu, 14 Feb 2019 21:10:56 -0500
Message-Id: <20190215021121.177674-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

[ Upstream commit 8b9433eb4de3c26a9226c981c283f9f4896ae030 ]

On a DIO_SKIP_HOLES filesystem, the ->get_block() method is currently
not allowed to create blocks for an empty inode.  This confusion comes
from trying to bit shift a negative number, so check the size of the
inode first.

The problem is most visible for hfsplus, because the fallback to
buffered I/O doesn't happen and the write fails with EIO.  This is in
part the fault of the module, because it gives a wrong return value on
->get_block(); that will be fixed in a separate patch.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/direct-io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 199146036093..1abb7634b2d5 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -679,6 +679,7 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
 	unsigned long fs_count;	/* Number of filesystem-sized blocks */
 	int create;
 	unsigned int i_blkbits = sdio->blkbits + sdio->blkfactor;
+	loff_t i_size;
 
 	/*
 	 * If there was a memory error and we've overwritten all the
@@ -708,8 +709,8 @@ static int get_more_blocks(struct dio *dio, struct dio_submit *sdio,
 		 */
 		create = dio->op == REQ_OP_WRITE;
 		if (dio->flags & DIO_SKIP_HOLES) {
-			if (fs_startblk <= ((i_size_read(dio->inode) - 1) >>
-							i_blkbits))
+			i_size = i_size_read(dio->inode);
+			if (i_size && fs_startblk <= (i_size - 1) >> i_blkbits)
 				create = 0;
 		}
 
-- 
2.19.1

