Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3ACFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0534217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545099333;
	bh=fTjhWobUM/ewQh075zk2ex08pRQShUCBjdLoabrYb38=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BY06lq9ks8vmjK9+GWoSi5+vB+52L86xCQEt64EXETxlTd7HEb/8R2zE2oASr1b4I
	 hbZDy09Vsh7UyYtlg4VyBH7hm3jPhatuyxouxZ/KUWyQzcuHsF6bPbgfPNZdvLEtUL
	 ZdiyeUcOsazBS/A0ValRD9GwiV2bvP8K6pSGO9bE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbeLRCPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbeLRCPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:15:32 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E2D42080D;
        Tue, 18 Dec 2018 02:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545099331;
        bh=fTjhWobUM/ewQh075zk2ex08pRQShUCBjdLoabrYb38=;
        h=From:To:Cc:Subject:Date:From;
        b=0v28BLp4Cbn33FfyC4eYr9/+F70tESv5wEo+a2VgUnJ3JjYb5tXX2Lnr+B4tNP5NC
         YUkptwy5ESIxqMHjUDtTjYk+9QUbJkve7oDzHaNNZ7B4Uq0F4SLsBQYcToPcffsSkq
         TaTQXU2ny020q6IwGPVq6abT2arw17D0yadpWAUQ=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] f2fs: fix missing unlock(sbi->gc_mutex)
Date:   Mon, 17 Dec 2018 18:15:30 -0800
Message-Id: <20181218021530.78323-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes missing unlock call.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b79677639108..2689a2cb56cc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1462,6 +1462,9 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
 		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
+
+		/* f2fs_gc guarantees unlock gc_mutex */
+		mutex_lock(&sbi->gc_mutex);
 		if (err == -ENODATA)
 			break;
 		if (err && err != -EAGAIN) {
-- 
2.19.0.605.g01d371f741-goog

