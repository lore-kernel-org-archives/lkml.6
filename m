Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4A8C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F06217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360893;
	bh=uos25sKReOK7ZKviXFjjwu786milcxPRVA0ATrrM6yE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lx1yykL9kbXYZWKjg2T1sv8tTEp21fwDhczrAXHIpe5ZTI4+l4KjeOBzX3e4+Kyez
	 VOjRFaIyiPXlSo4ZI5bUCz7v5I2JI1BwSRL1F8LRSSGbtP+apgpTpsjmExSGgZ918O
	 UlHb0cxzPJ4IsuiyFh0XQC/MKc8q/m5hQajogndE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfAXTYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbfAXTYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADF9F217D7;
        Thu, 24 Jan 2019 19:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357890;
        bh=uos25sKReOK7ZKviXFjjwu786milcxPRVA0ATrrM6yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2oausEnud7vOvUyfCgDgrTpQ8JmZpvQ2O8XrvmmjghXgBBawcz6BgFoBQ83LAouOQ
         Tewdlu5YQk48LTIHKIrXv2byny8MaJ2Y+bbglz4ymWrBvqL8UYETYRnqc1sSadBOM1
         /fm2qcFe/9I+yNLRoXmTCtB010hnNmxuLvOoJGUc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Greg KH <greg@kroah.com>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 024/104] f2fs: enhance sanity_check_raw_super() to avoid potential overflow
Date:   Thu, 24 Jan 2019 20:19:13 +0100
Message-Id: <20190124190157.693844935@linuxfoundation.org>
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

commit 0cfe75c5b011994651a4ca6d74f20aa997bfc69a upstream.

In order to avoid the below overflow issue, we should have checked the
boundaries in superblock before reaching out to allocation. As Linus suggested,
the right place should be sanity_check_raw_super().

Dr Silvio Cesare of InfoSect reported:

There are integer overflows with using the cp_payload superblock field in the
f2fs filesystem potentially leading to memory corruption.

include/linux/f2fs_fs.h

struct f2fs_super_block {
...
        __le32 cp_payload;

fs/f2fs/f2fs.h

typedef u32 block_t;    /*
                         * should not change u32, since it is the on-disk block
                         * address format, __le32.
                         */
...

static inline block_t __cp_payload(struct f2fs_sb_info *sbi)
{
        return le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
}

fs/f2fs/checkpoint.c

        block_t start_blk, orphan_blocks, i, j;
...
        start_blk = __start_cp_addr(sbi) + 1 + __cp_payload(sbi);
        orphan_blocks = __start_sum_addr(sbi) - 1 - __cp_payload(sbi);

+++ integer overflows

...
        unsigned int cp_blks = 1 + __cp_payload(sbi);
...
        sbi->ckpt = kzalloc(cp_blks * blk_size, GFP_KERNEL);

+++ integer overflow leading to incorrect heap allocation.

        int cp_payload_blks = __cp_payload(sbi);
...
        ckpt->cp_pack_start_sum = cpu_to_le32(1 + cp_payload_blks +
                        orphan_blocks);

+++ sign bug and integer overflow

...
        for (i = 1; i < 1 + cp_payload_blks; i++)

+++ integer overflow

...

      sbi->max_orphans = (sbi->blocks_per_seg - F2FS_CP_PACKS -
                        NR_CURSEG_TYPE - __cp_payload(sbi)) *
                                F2FS_ORPHANS_PER_BLOCK;

+++ integer overflow

Reported-by: Greg KH <greg@kroah.com>
Reported-by: Silvio Cesare <silvio.cesare@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.4:
 - No hot file extension support
 - Adjust context]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/super.c |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 7 deletions(-)

--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -994,6 +994,8 @@ static inline bool sanity_check_area_bou
 static int sanity_check_raw_super(struct super_block *sb,
 			struct f2fs_super_block *raw_super)
 {
+	block_t segment_count, segs_per_sec, secs_per_zone;
+	block_t total_sections, blocks_per_seg;
 	unsigned int blocksize;
 
 	if (F2FS_SUPER_MAGIC != le32_to_cpu(raw_super->magic)) {
@@ -1047,6 +1049,68 @@ static int sanity_check_raw_super(struct
 		return 1;
 	}
 
+	segment_count = le32_to_cpu(raw_super->segment_count);
+	segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
+	secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
+	total_sections = le32_to_cpu(raw_super->section_count);
+
+	/* blocks_per_seg should be 512, given the above check */
+	blocks_per_seg = 1 << le32_to_cpu(raw_super->log_blocks_per_seg);
+
+	if (segment_count > F2FS_MAX_SEGMENT ||
+				segment_count < F2FS_MIN_SEGMENTS) {
+		f2fs_msg(sb, KERN_INFO,
+			"Invalid segment count (%u)",
+			segment_count);
+		return 1;
+	}
+
+	if (total_sections > segment_count ||
+			total_sections < F2FS_MIN_SEGMENTS ||
+			segs_per_sec > segment_count || !segs_per_sec) {
+		f2fs_msg(sb, KERN_INFO,
+			"Invalid segment/section count (%u, %u x %u)",
+			segment_count, total_sections, segs_per_sec);
+		return 1;
+	}
+
+	if ((segment_count / segs_per_sec) < total_sections) {
+		f2fs_msg(sb, KERN_INFO,
+			"Small segment_count (%u < %u * %u)",
+			segment_count, segs_per_sec, total_sections);
+		return 1;
+	}
+
+	if (segment_count > (le32_to_cpu(raw_super->block_count) >> 9)) {
+		f2fs_msg(sb, KERN_INFO,
+			"Wrong segment_count / block_count (%u > %u)",
+			segment_count, le32_to_cpu(raw_super->block_count));
+		return 1;
+	}
+
+	if (secs_per_zone > total_sections) {
+		f2fs_msg(sb, KERN_INFO,
+			"Wrong secs_per_zone (%u > %u)",
+			secs_per_zone, total_sections);
+		return 1;
+	}
+	if (le32_to_cpu(raw_super->extension_count) > F2FS_MAX_EXTENSION) {
+		f2fs_msg(sb, KERN_INFO,
+			"Corrupted extension count (%u > %u)",
+			le32_to_cpu(raw_super->extension_count),
+			F2FS_MAX_EXTENSION);
+		return 1;
+	}
+
+	if (le32_to_cpu(raw_super->cp_payload) >
+				(blocks_per_seg - F2FS_CP_PACKS)) {
+		f2fs_msg(sb, KERN_INFO,
+			"Insane cp_payload (%u > %u)",
+			le32_to_cpu(raw_super->cp_payload),
+			blocks_per_seg - F2FS_CP_PACKS);
+		return 1;
+	}
+
 	/* check reserved ino info */
 	if (le32_to_cpu(raw_super->node_ino) != 1 ||
 		le32_to_cpu(raw_super->meta_ino) != 2 ||
@@ -1059,13 +1123,6 @@ static int sanity_check_raw_super(struct
 		return 1;
 	}
 
-	if (le32_to_cpu(raw_super->segment_count) > F2FS_MAX_SEGMENT) {
-		f2fs_msg(sb, KERN_INFO,
-			"Invalid segment count (%u)",
-			le32_to_cpu(raw_super->segment_count));
-		return 1;
-	}
-
 	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
 	if (sanity_check_area_boundary(sb, raw_super))
 		return 1;


