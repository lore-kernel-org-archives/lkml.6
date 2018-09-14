Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BFBC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D8C20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D8C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeINMwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:52:35 -0400
Received: from www.osadl.org ([62.245.132.105]:39177 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbeINMwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:52:34 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w8E7dBPR016836;
        Fri, 14 Sep 2018 09:39:11 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] dm integrity: drop excess unlikely() from BUG_ON()
Date:   Fri, 14 Sep 2018 09:37:03 +0200
Message-Id: <1536910623-18013-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 include/asm-generic/bug.h defines BUG_ON(condition) as
do { if (unlikely(condition)) BUG(); } while (0).
So BUG_ON already provides unlikely() on the condition thus 
there is no point in having BUG_ON(unlikely(condition)),
thus simply drop the excess unlikely().

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Found during code review

Patch was compile tested with: x86_64_defconfig + SCSI_LOWLEVEL=y,
DM_INTEGRITY=y
(with warnings from sparse and smatch - not related to the proposed
 change though)

Patch is against 4.19-rc3 (localversion-next is next-20180913)

 drivers/md/dm-integrity.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 89ccb64..8574e73 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1948,7 +1948,8 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned write_start,
 
 			if (journal_entry_is_unused(je))
 				continue;
-			BUG_ON(unlikely(journal_entry_is_inprogress(je)) && !from_replay);
+			BUG_ON(journal_entry_is_inprogress(je) &&
+			       !from_replay);
 			sec = journal_entry_get_sector(je);
 			if (unlikely(from_replay)) {
 				if (unlikely(sec & (unsigned)(ic->sectors_per_block - 1))) {
@@ -1963,7 +1964,8 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned write_start,
 				sector_t sec2, area2, offset2;
 				if (journal_entry_is_unused(je2))
 					break;
-				BUG_ON(unlikely(journal_entry_is_inprogress(je2)) && !from_replay);
+				BUG_ON(journal_entry_is_inprogress(je2) &&
+				       !from_replay);
 				sec2 = journal_entry_get_sector(je2);
 				get_area_and_offset(ic, sec2, &area2, &offset2);
 				if (area2 != area || offset2 != offset + ((k - j) << ic->sb->log2_sectors_per_block))
-- 
2.1.4

