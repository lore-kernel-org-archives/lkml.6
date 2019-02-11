Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5123EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D501222A5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899477;
	bh=uO1QIxzPb1MOP6fmvJgQVvB2VNbUQrjzid8/NdAvC0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZTGDcWsRDbfmuZD4KyEz4Rg+iqcWAY4JpRU/VeAynuMj/pfWSfrpt1SsT7ptuDWsI
	 NnOrO6AVOEweuxok0uqIKnGZYuS8CcZY58rtvE37CTUj6I3nFKJS6TM6ZYi2lsu71O
	 BOpNPhQSeITMscCO5mHZgR9rqEvCaU+CmEUNmQ88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbfBKPhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:37:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388156AbfBKOur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:50:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217072081B;
        Mon, 11 Feb 2019 14:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896645;
        bh=uO1QIxzPb1MOP6fmvJgQVvB2VNbUQrjzid8/NdAvC0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yzx/BYYyrGQB5q2QchB8FgbgbmyDKuiYAyOuuKb8GMn/RUfQb504stXv/pSA7r8LS
         7+MPdsXpuXTRX7YDb5TQ/MSeToQhwE2TO/nW3X3VTy9kl/EvzFLl89V+pwsHQV1itU
         tWg9xiRG+oHqyBy+qR9UBbvUMKYTBqJeFJXvxmMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Yiwen Jiang <jiangyiwen@huawei.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <jiangqi903@gmail.com>,
        Jun Piao <piaojun@huawei.com>,
        Mark Fasheh <mfasheh@versity.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 226/313] ocfs2: dont clear bh uptodate for block read
Date:   Mon, 11 Feb 2019 15:18:26 +0100
Message-Id: <20190211141908.458897168@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 1d098c3c00e0..9f8250df99f1 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -152,7 +152,6 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 #endif
 		}
 
-		clear_buffer_uptodate(bh);
 		get_bh(bh); /* for end_buffer_read_sync() */
 		bh->b_end_io = end_buffer_read_sync;
 		submit_bh(REQ_OP_READ, 0, bh);
@@ -306,7 +305,6 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u64 block, int nr,
 				continue;
 			}
 
-			clear_buffer_uptodate(bh);
 			get_bh(bh); /* for end_buffer_read_sync() */
 			if (validate)
 				set_buffer_needs_validate(bh);
-- 
2.19.1



