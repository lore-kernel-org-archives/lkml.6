Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B486C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4AE2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545175351;
	bh=oBkqXTf95ZFidO1yuRUBfm28piVET2XRgGpJYmkkQ+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t+KjkAAQaH1Il7RAkxyGMI02tD20NCM6LyY6uSIufPjvBQxgC3mTPmZ5MRGasplrK
	 k/j708epj/uLvVaGPvcZtiBuZ8CNaCtjfyhWsiCNDoQPfgXlwPz9eRUAu5NqB/LAk9
	 rYd84XjG40PwP/Bf2DcCUhQT+DeeVagNg+w0BdqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbeLRXWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:22:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbeLRXWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:22:30 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFDE217D9;
        Tue, 18 Dec 2018 23:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545175349;
        bh=oBkqXTf95ZFidO1yuRUBfm28piVET2XRgGpJYmkkQ+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQNRWSd6QdB9+qq9sjtqQb6TaF5mK9NK/14072thXxxvuQIOZTMAkHvTTxZ2I251n
         y0hjmTJoV7a6sc2FXIStcA5nW0Ec6Mu9R5pSuYi0vnDmbFekyya46zlYbTb7dnQn+T
         5OCUQhKaZklfYwxgxh19w4ss+yN/iimtu30fE3T8=
Date:   Tue, 18 Dec 2018 15:22:28 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix missing unlock(sbi->gc_mutex)
Message-ID: <20181218232228.GE31062@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181218021530.78323-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218021530.78323-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes missing unlock call.

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

v1 -> v2:
 - clean up

 fs/f2fs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index b79677639108..cec7ef27b389 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1457,19 +1457,16 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
 
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
-- 
2.19.0.605.g01d371f741-goog

