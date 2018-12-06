Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F24DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0248D20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107811;
	bh=ZyVUMUtMessVDXwLerp9tzthSEROM2RC4V3U7KX3WKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2MjwFTtcjk0GJB8C/z6TwHoTsD5aZ4Rb5CdlYXSLcuHEeLu1zYrslqoFBaBj1hbcg
	 ThMS7tGQmaFQ+JGsQLVs9Mfvs89DpWI6WabFQVz8S3TPylW9iqvsdhHjpzHWQvj2in
	 q4gkWmXbNuR2h8zLOeMckJa4dSU/pv6geSYYm1go=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0248D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbeLFOrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:47:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbeLFOrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:47:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2077E214DE;
        Thu,  6 Dec 2018 14:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107644;
        bh=ZyVUMUtMessVDXwLerp9tzthSEROM2RC4V3U7KX3WKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jx6jrlF8ugkXs8Ix9FAL89z31JiGHFtzT+YhwEK2wr68GhBFnINxae5343ROx2wg3
         mWGappXfFQqKRSgoD+c761jVZ2RxAT3RXCTYKdfV/RnElGgCCtac3fcHWOEfCPEkpf
         SU4XovRCr4RgvlBcKHfU9oKzA4W+59/8Y9b7SRZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 085/101] f2fs: detect wrong layout
Date:   Thu,  6 Dec 2018 15:39:24 +0100
Message-Id: <20181206143017.598273794@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 2040fce83fe17763b07c97c1f691da2bb85e4135 upstream.

Previous mkfs.f2fs allows small partition inappropriately, so f2fs should detect
that as well.

Refer this in f2fs-tools.

mkfs.f2fs: detect small partition by overprovision ratio and # of segments

Reported-and-Tested-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.9: adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.h |    2 ++
 fs/f2fs/super.c   |   11 +++++++++++
 2 files changed, 13 insertions(+)

--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -18,6 +18,8 @@
 #define DEF_RECLAIM_PREFREE_SEGMENTS	5	/* 5% over total segments */
 #define DEF_MAX_RECLAIM_PREFREE_SEGMENTS	4096	/* 8GB in maximum */
 
+#define F2FS_MIN_SEGMENTS	9 /* SB + 2 (CP + SIT + NAT) + SSA + MAIN */
+
 /* L: Logical segment # in volume, R: Relative segment # in main area */
 #define GET_L2R_SEGNO(free_i, segno)	(segno - free_i->start_segno)
 #define GET_R2L_SEGNO(free_i, segno)	(segno + free_i->start_segno)
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1424,6 +1424,7 @@ int sanity_check_ckpt(struct f2fs_sb_inf
 	unsigned int total, fsmeta;
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	unsigned int ovp_segments, reserved_segments;
 	unsigned int main_segs, blocks_per_seg;
 	unsigned int sit_segs, nat_segs;
 	unsigned int sit_bitmap_size, nat_bitmap_size;
@@ -1442,6 +1443,16 @@ int sanity_check_ckpt(struct f2fs_sb_inf
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
 


