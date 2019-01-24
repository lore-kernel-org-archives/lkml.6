Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A630C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2083C218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548357861;
	bh=4cgeGGF4S4hahsg+q8cIJFLfXq5SH8Dfo4MSVMRKQKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iWE134U7WpoINKPiWmJKh7oHT9ckI+H9ksWJlYyM0uHAyYE0frVQkz7SKGgE0V4z4
	 Ica5UdXzK2Ljn/nZ/ChGSMCKFsanzn+hKnCLYW7y7XJTxPG8NmT1i1hcyCMB/lX4q5
	 aB+//menoiBNw5eiLN7d54wfoLcOyCsOVlED5yYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfAXTYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:24:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729546AbfAXTYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:24:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98035218FE;
        Thu, 24 Jan 2019 19:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357857;
        bh=4cgeGGF4S4hahsg+q8cIJFLfXq5SH8Dfo4MSVMRKQKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zW00VC8Gff0Ym60dJbCicK4fZTJ03tdYS38xW4r5s63ws1Prd/uMNC6ACbSfJXNSt
         qu0ZwUO25JKSP4frFxyBWfOjJV9F2HX+pVsysD00+hwntV5AGB6oeqYhXXE0aOU+2a
         ktX5hJ5PBF8IZXaBUdU0vmW+uFX34xRR6X2lUNV0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 013/104] f2fs: avoid unneeded loop in build_sit_entries
Date:   Thu, 24 Jan 2019 20:19:02 +0100
Message-Id: <20190124190156.334017387@linuxfoundation.org>
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

From: Chao Yu <yuchao0@huawei.com>

commit d600af236da51d9e3b90d21a23f95b820bd02e2f upstream.

When building each sit entry in cache, firstly, we will load it from
sit page, and then check all entries in sit journal, if there is one
updated entry in journal, cover cached entry with the journaled one.

Actually, most of check operation is unneeded since we only need
to update cached entries with journaled entries in batch, so
changing the flow as below for more efficient:
1. load all sit entries into cache from sit pages;
2. update sit entries with journal.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
[bwh: Backported to 4.4:
 - Keep using curseg->curseg_mutex for serialisation
 - Use sum instead of journal
 - Don't add f2fs_discard_en() condition]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/segment.c |   44 ++++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2145,22 +2145,11 @@ static void build_sit_entries(struct f2f
 			struct f2fs_sit_entry sit;
 			struct page *page;
 
-			mutex_lock(&curseg->curseg_mutex);
-			for (i = 0; i < sits_in_cursum(sum); i++) {
-				if (le32_to_cpu(segno_in_journal(sum, i))
-								== start) {
-					sit = sit_in_journal(sum, i);
-					mutex_unlock(&curseg->curseg_mutex);
-					goto got_it;
-				}
-			}
-			mutex_unlock(&curseg->curseg_mutex);
-
 			page = get_current_sit_page(sbi, start);
 			sit_blk = (struct f2fs_sit_block *)page_address(page);
 			sit = sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, start)];
 			f2fs_put_page(page, 1);
-got_it:
+
 			check_block_count(sbi, start, &sit);
 			seg_info_from_raw_sit(se, &sit);
 
@@ -2168,13 +2157,36 @@ got_it:
 			memcpy(se->discard_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
 			sbi->discard_blks += sbi->blocks_per_seg - se->valid_blocks;
 
-			if (sbi->segs_per_sec > 1) {
-				struct sec_entry *e = get_sec_entry(sbi, start);
-				e->valid_blocks += se->valid_blocks;
-			}
+			if (sbi->segs_per_sec > 1)
+				get_sec_entry(sbi, start)->valid_blocks +=
+							se->valid_blocks;
 		}
 		start_blk += readed;
 	} while (start_blk < sit_blk_cnt);
+
+	mutex_lock(&curseg->curseg_mutex);
+	for (i = 0; i < sits_in_cursum(sum); i++) {
+		struct f2fs_sit_entry sit;
+		struct seg_entry *se;
+		unsigned int old_valid_blocks;
+
+		start = le32_to_cpu(segno_in_journal(sum, i));
+		se = &sit_i->sentries[start];
+		sit = sit_in_journal(sum, i);
+
+		old_valid_blocks = se->valid_blocks;
+
+		check_block_count(sbi, start, &sit);
+		seg_info_from_raw_sit(se, &sit);
+
+		memcpy(se->discard_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
+		sbi->discard_blks += old_valid_blocks - se->valid_blocks;
+
+		if (sbi->segs_per_sec > 1)
+			get_sec_entry(sbi, start)->valid_blocks +=
+				se->valid_blocks - old_valid_blocks;
+	}
+	mutex_unlock(&curseg->curseg_mutex);
 }
 
 static void init_free_segmap(struct f2fs_sb_info *sbi)


