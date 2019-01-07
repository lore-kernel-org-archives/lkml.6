Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F3AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3932070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864954;
	bh=bJhpL+vMbhQfLB4We2y5Hrr3KueG7/Q0q0pNEoupGhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZZhBlWSIwSVlVvSCYRZ2XmzLv+/2Cxthz0q1YIQl4B4c74DcIpj2346Y0s0i8P9YM
	 P+76QHl313pq+2uJgW1kGT/hVQ+jXvMM1qW2/m7FKaneLklLTYu3VzMrn5HUtlhnve
	 KD8b5iDmqdpdJGH0NzDVv3A73xASLdMlkCKKBQ9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfAGMmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:42:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:58174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727767AbfAGMm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3442070C;
        Mon,  7 Jan 2019 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864948;
        bh=bJhpL+vMbhQfLB4We2y5Hrr3KueG7/Q0q0pNEoupGhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzReoezP3FDroNFMn9IJgy/XodeQ8iS/GoAC7GQpux4om0tjmgWFeJ9ivX7kRWvvU
         E9aDy59iCSOKBqiNUaaKXnlKqb65T3EvyzJ+9YxZbVo6B8wSkaPUc0iap6Z8baa20I
         CujOD6o4jannG/45QhW93J8A0SmHMOwzOfq75mig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.20 106/145] f2fs: fix missing unlock(sbi->gc_mutex)
Date:   Mon,  7 Jan 2019 13:32:23 +0100
Message-Id: <20190107104451.120257789@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 8f31b4665c14fe19593601a250275e58c7ad0ef1 upstream.

This fixes missing unlock call.

Cc: <stable@vger.kernel.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/super.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1457,19 +1457,16 @@ static int f2fs_disable_checkpoint(struc
 
 	sbi->sb->s_flags |= SB_ACTIVE;
 
-	mutex_lock(&sbi->gc_mutex);
 	f2fs_update_time(sbi, DISABLE_TIME);
 
 	while (!f2fs_time_over(sbi, DISABLE_TIME)) {
+		mutex_lock(&sbi->gc_mutex);
 		err = f2fs_gc(sbi, true, false, NULL_SEGNO);
 		if (err == -ENODATA)
 			break;
-		if (err && err != -EAGAIN) {
-			mutex_unlock(&sbi->gc_mutex);
+		if (err && err != -EAGAIN)
 			return err;
-		}
 	}
-	mutex_unlock(&sbi->gc_mutex);
 
 	err = sync_filesystem(sbi->sb);
 	if (err)


