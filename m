Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F5AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C37F20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C37F20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732681AbeHAT5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:57:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49812 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405750AbeHATIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:35 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D7BE1397;
        Wed,  1 Aug 2018 17:14:44 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Yunlei He <heyunlei@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 057/246] f2fs: fix to dont trigger writeback during recovery
Date:   Wed,  1 Aug 2018 18:49:27 +0200
Message-Id: <20180801165014.439877217@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 64c74a7ab505ea40d1b3e5d02735ecab08ae1b14 ]

- f2fs_fill_super
 - recover_fsync_data
  - recover_data
   - del_fsync_inode
    - iput
     - iput_final
      - write_inode_now
       - f2fs_write_inode
        - f2fs_balance_fs
         - f2fs_balance_fs_bg
          - sync_dirty_inodes

With data_flush mount option, during recovery, in order to avoid entering
above writeback flow, let's detect recovery status and do skip in
f2fs_balance_fs_bg.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -435,6 +435,9 @@ void f2fs_balance_fs(struct f2fs_sb_info
 
 void f2fs_balance_fs_bg(struct f2fs_sb_info *sbi)
 {
+	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
+		return;
+
 	/* try to shrink extent cache when there is no enough memory */
 	if (!available_free_memory(sbi, EXTENT_CACHE))
 		f2fs_shrink_extent_tree(sbi, EXTENT_CACHE_SHRINK_NUMBER);


