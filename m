Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B29C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1674C20879
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692944;
	bh=RRfUTAtFYlIwypqvSX8FrsMI/yrjhrcU6/CN06YBnok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ny/7cSnqJTBbica60hgZYLbSvNuFrPXhFqNohJNdv+lo+FEs0+bA2NSTs8LOvuDTd
	 jbHof1DYbzgHGLAqM6KyzLSWvuHCGjlfVVGoh/ZuOGCnRxNagja/4x05ggK8YEYsWM
	 MqQGbzOjEC7XrZ3R5cinOn3wYKtHT+WTrn42nLow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389590AbfA1Q2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:28:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388335AbfA1Q2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:28:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F532175B;
        Mon, 28 Jan 2019 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692882;
        bh=RRfUTAtFYlIwypqvSX8FrsMI/yrjhrcU6/CN06YBnok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoQ7Jd93vyAmdjX2gVOSn6eZLl5JCkqLyy2oGpphGuKzNn9lk9mhgftXZp6o7BN0k
         4F03cmsZoHlP1Z+TzKE+kTneLeLr9X2DXCGeETVCzALMJe+zLZV6kM0dYCW/ubpfTb
         vUA9RXuBUKOyY3IJTTulU2MAJNjZWN8+OpILcUho=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <jiangqi903@gmail.com>,
        Jun Piao <piaojun@huawei.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 55/61] ocfs2: don't clear bh uptodate for block read
Date:   Mon, 28 Jan 2019 11:26:17 -0500
Message-Id: <20190128162623.59854-55-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128162623.59854-1-sashal@kernel.org>
References: <20190128162623.59854-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junxiao Bi <junxiao.bi@oracle.com>

[ Upstream commit 70306d9dce75abde855cefaf32b3f71eed8602a3 ]

For sync io read in ocfs2_read_blocks_sync(), first clear bh uptodate flag
and submit the io, second wait io done, last check whether bh uptodate, if
not return io error.

If two sync io for the same bh were issued, it could be the first io done
and set uptodate flag, but just before check that flag, the second io came
in and cleared uptodate, then ocfs2_read_blocks_sync() for the first io
will return IO error.

Indeed it's not necessary to clear uptodate flag, as the io end handler
end_buffer_read_sync() will set or clear it based on io succeed or failed.

The following message was found from a nfs server but the underlying
storage returned no error.

[4106438.567376] (nfsd,7146,3):ocfs2_get_suballoc_slot_bit:2780 ERROR: read block 1238823695 failed -5
[4106438.567569] (nfsd,7146,3):ocfs2_get_suballoc_slot_bit:2812 ERROR: status = -5
[4106438.567611] (nfsd,7146,3):ocfs2_test_inode_bit:2894 ERROR: get alloc slot and bit failed -5
[4106438.567643] (nfsd,7146,3):ocfs2_test_inode_bit:2932 ERROR: status = -5
[4106438.567675] (nfsd,7146,3):ocfs2_get_dentry:94 ERROR: test inode bit failed -5

Same issue in non sync read ocfs2_read_blocks(), fixed it as well.

Link: http://lkml.kernel.org/r/20181121020023.3034-4-junxiao.bi@oracle.com
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Changwei Ge <ge.changwei@h3c.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Mark Fasheh <mfasheh@versity.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/buffer_head_io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index d6eab71abe1f..30d65259bc61 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -146,7 +146,6 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 			BUG();
 		}
 
-		clear_buffer_uptodate(bh);
 		get_bh(bh); /* for end_buffer_read_sync() */
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(READ, bh);
@@ -300,7 +299,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 				continue;
 			}
 
-			clear_buffer_uptodate(bh);
 			get_bh(bh); /* for end_buffer_read_sync() */
 			if (validate)
 				set_buffer_needs_validate(bh);
-- 
2.19.1

