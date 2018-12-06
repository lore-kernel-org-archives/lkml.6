Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9565C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E7C21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E7C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeLFJCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:02:30 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:65318 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbeLFJC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:02:29 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7598CD9DC242AC97C52A;
        Thu,  6 Dec 2018 17:02:27 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB692Hxv071226;
        Thu, 6 Dec 2018 17:02:17 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120617024798-15105640 ;
          Thu, 6 Dec 2018 17:02:47 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Bob Copeland <me@bobcopeland.com>
Cc:     linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] omfs: Use kmemdup instead of duplicating its function
Date:   Thu, 6 Dec 2018 17:02:10 +0800
Message-Id: <20181206090210.39624-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-06 17:02:48,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-06 17:02:06
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB692Hxv071226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup has implemented the function that kmalloc() + memcpy().
We prefer to kmemdup rather than code opened implementation.

This issue was detected with the help of coccinelle.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Bob Copeland <me@bobcopeland.com>
CC: linux-karma-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
---
 fs/omfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index e5258fefcd2b..195c6baa3c8e 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -363,12 +363,11 @@ static int omfs=5Fget=5Fimap(struct super=5Fblock *sb)
 		bh =3D sb=5Fbread(sb, block++);
 		if (!bh)
 			goto nomem=5Ffree;
-		*ptr =3D kmalloc(sb->s=5Fblocksize, GFP=5FKERNEL);
+		*ptr =3D kmemdup(bh->b=5Fdata, sb->s=5Fblocksize, GFP=5FKERNEL);
 		if (!*ptr) {
 			brelse(bh);
 			goto nomem=5Ffree;
 		}
-		memcpy(*ptr, bh->b=5Fdata, sb->s=5Fblocksize);
 		if (count < sb->s=5Fblocksize)
 			memset((void *)*ptr + count, 0xff,
 				sb->s=5Fblocksize - count);
--=20
2.19.1

