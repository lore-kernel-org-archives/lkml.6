Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C7ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A154C2146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A154C2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732298AbeIREkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:40:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeIREkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:40:31 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 29DB4CAC;
        Mon, 17 Sep 2018 23:10:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 082/158] f2fs: fix to detect looped node chain correctly
Date:   Tue, 18 Sep 2018 00:41:52 +0200
Message-Id: <20180917211715.007385336@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
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

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 82902c06bd17dbf6e8184299842ca5c68880970f ]

Below dmesg was printed when testing generic/388 of fstest:

F2FS-fs (zram1): find_fsync_dnodes: detect looped node chain, blkaddr:526615, next:526616
F2FS-fs (zram1): Cannot recover all fsync data errno=-22
F2FS-fs (zram1): Mounted with checkpoint version = 22300d0e
F2FS-fs (zram1): find_fsync_dnodes: detect looped node chain, blkaddr:526615, next:526616
F2FS-fs (zram1): Cannot recover all fsync data errno=-22

The reason is that we initialize free_blocks with free blocks of
filesystem, so if filesystem is full, free_blocks can be zero,
below condition will be true, so that, it will fail recovery.

if (++loop_cnt >= free_blocks ||
	blkaddr == next_blkaddr_of_node(page))

To fix this issue, initialize free_blocks with correct value which
includes over-privision blocks.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/recovery.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -241,8 +241,8 @@ static int find_fsync_dnodes(struct f2fs
 	struct page *page = NULL;
 	block_t blkaddr;
 	unsigned int loop_cnt = 0;
-	unsigned int free_blocks = sbi->user_block_count -
-					valid_user_blocks(sbi);
+	unsigned int free_blocks = MAIN_SEGS(sbi) * sbi->blocks_per_seg -
+						valid_user_blocks(sbi);
 	int err = 0;
 
 	/* get node pages in the current segment */


