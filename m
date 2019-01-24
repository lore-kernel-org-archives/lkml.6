Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40204C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0A9218D2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357874;
	bh=rt3Yfs4yYJxpHF6bXA5QWXgoY+2WXs7vRwzRIGzSlZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=spvA7umeLudYIUUKzjInS7dVsiPz4yanPb3Kr3pGiswFTkRZNagXj2+C/zOno02S5
	 KQBCFQGhoM+I+b+ucw4aqmoMl3KaZB56htDf20VilbIdd69kS27nwV10Uht9/bx7j4
	 5zGZGjn+xreZAM4PmlY/sQV3q/6dbHKfEeDUwY0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbfAXTYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729596AbfAXTYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC47721902;
        Thu, 24 Jan 2019 19:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357870;
        bh=rt3Yfs4yYJxpHF6bXA5QWXgoY+2WXs7vRwzRIGzSlZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5drIixWC5tcB/NAzYIkfv69HFWwoKcbZhv8BEMQP97c3zwncPMUwQzzTHnd68GmR
         kBPe1XFQu5wayHsTjvtPLztsajAoEtqp+nz5Ovj/mP9s678+BZ5rdPpexUIOc7Kzm9
         4VZxr1YlIIZPqm8pRvx71O4mWA+/Kf5u2YNFvLeA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 4.4 018/104] f2fs: detect wrong layout
Date:   Thu, 24 Jan 2019 20:19:07 +0100
Message-Id: <20190124190156.882115643@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 2040fce83fe17763b07c97c1f691da2bb85e4135 upstream.

Previous mkfs.f2fs allows small partition inappropriately, so f2fs should detect
that as well.

Refer this in f2fs-tools.

mkfs.f2fs: detect small partition by overprovision ratio and # of segments

Reported-and-Tested-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.h |    2 ++
 fs/f2fs/super.c   |   11 +++++++++++
 2 files changed, 13 insertions(+)

--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -17,6 +17,8 @@
 
 #define DEF_RECLAIM_PREFREE_SEGMENTS	5	/* 5% over total segments */
 
+#define F2FS_MIN_SEGMENTS	9 /* SB + 2 (CP + SIT + NAT) + SSA + MAIN */
+
 /* L: Logical segment # in volume, R: Relative segment # in main area */
 #define GET_L2R_SEGNO(free_i, segno)	(segno - free_i->start_segno)
 #define GET_R2L_SEGNO(free_i, segno)	(segno + free_i->start_segno)
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1078,6 +1078,7 @@ int sanity_check_ckpt(struct f2fs_sb_inf
 	unsigned int total, fsmeta;
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	unsigned int ovp_segments, reserved_segments;
 	unsigned int main_segs, blocks_per_seg;
 	unsigned int sit_segs, nat_segs;
 	unsigned int sit_bitmap_size, nat_bitmap_size;
@@ -1096,6 +1097,16 @@ int sanity_check_ckpt(struct f2fs_sb_inf
 	if (unlikely(fsmeta >= total))
 		return 1;
 
+	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
+	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
+
+	if (unlikely(fsmeta < F2FS_MIN_SEGMENTS ||
+			ovp_segments == 0 || reserved_segments == 0)) {
+		f2fs_msg(sbi->sb, KERN_ERR,
+			"Wrong layout: check mkfs.f2fs version");
+		return 1;
+	}
+
 	main_segs = le32_to_cpu(raw_super->segment_count_main);
 	blocks_per_seg = sbi->blocks_per_seg;
 


