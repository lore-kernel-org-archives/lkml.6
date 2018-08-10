Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992D2C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CCF223B8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWWvcSlU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CCF223B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeHJFQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:16:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbeHJFQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:16:48 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EC69223B7;
        Fri, 10 Aug 2018 02:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533869340;
        bh=GZE9ZWQmJZqHgtiwUMPIzo8VxL5Ix0IlCb+ULNaTcRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MWWvcSlUmicNzJ4X51C6E9ffeI02vZiUqvpygtKW30PKUKVeovT11V2C4UbOQGlqX
         NTe65O0BYpycvEUKOW3U9xoayI1Xplt2oL2q4Ay8EnaEz7WsHumKVMW/4hLT/YQgfb
         qsSgt/R/IRF8nyczXLQUxzOFYQoJVuMvE+iYFjnE=
Date:   Thu, 9 Aug 2018 19:48:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH v2] f2fs: fix performance issue observed with
 multi-thread sequential read
Message-ID: <20180810024859.GA48219@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180810023758.46974-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810023758.46974-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts the commit - "b93f771 - f2fs: remove writepages lock"
to fix the drop in sequential read throughput.

Test: ./tiotest -t 32 -d /data/tio_tmp -f 32 -b 524288 -k 1 -k 3 -L
device: UFS

Before -
read throughput: 185 MB/s
total read requests: 85177 (of these ~80000 are 4KB size requests).
total write requests: 2546 (of these ~2208 requests are written in 512KB).

After -
read throughput: 758 MB/s
total read requests: 2417 (of these ~2042 are 512KB reads).
total write requests: 2701 (of these ~2034 requests are written in 512KB).

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v1:
 - quick code fix

 fs/f2fs/data.c  | 14 ++++++++++++--
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/super.c |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 45f043ee48bd..6da143a27b3a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2132,6 +2132,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct blk_plug plug;
 	int ret;
+	bool locked = false;
 
 	/* deal with chardevs and other special file */
 	if (!mapping->a_ops->writepage)
@@ -2157,15 +2158,24 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	trace_f2fs_writepages(mapping->host, wbc, DATA);
 
 	/* to avoid spliting IOs due to mixed WB_SYNC_ALL and WB_SYNC_NONE */
-	if (wbc->sync_mode == WB_SYNC_ALL)
+	if (wbc->sync_mode == WB_SYNC_ALL) {
 		atomic_inc(&sbi->wb_sync_req[DATA]);
-	else if (atomic_read(&sbi->wb_sync_req[DATA]))
+		goto writepages_lock;
+	} else if (atomic_read(&sbi->wb_sync_req[DATA])) {
 		goto skip_write;
+	} else {
+writepages_lock:
+		mutex_lock(&sbi->writepages);
+		locked = true;
+	}
 
 	blk_start_plug(&plug);
 	ret = f2fs_write_cache_pages(mapping, wbc, io_type);
 	blk_finish_plug(&plug);
 
+	if (locked)
+		mutex_unlock(&sbi->writepages);
+
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		atomic_dec(&sbi->wb_sync_req[DATA]);
 	/*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b1c127d8383b..29bbc55cbc0b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1133,6 +1133,7 @@ struct f2fs_sb_info {
 	struct rw_semaphore sb_lock;		/* lock for raw super block */
 	int valid_super_block;			/* valid super block no */
 	unsigned long s_flag;				/* flags for sbi */
+	struct mutex writepages;		/* mutex for writepages() */
 
 #ifdef CONFIG_BLK_DEV_ZONED
 	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index be41dbd7b261..53d70b64fea1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2842,6 +2842,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	/* init f2fs-specific super block info */
 	sbi->valid_super_block = valid_super_block;
 	mutex_init(&sbi->gc_mutex);
+	mutex_init(&sbi->writepages);
 	mutex_init(&sbi->cp_mutex);
 	init_rwsem(&sbi->node_write);
 	init_rwsem(&sbi->node_change);
-- 
2.17.0.441.gb46fe60e1d-goog

