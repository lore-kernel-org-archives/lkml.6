Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F103C7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2F620645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B2F620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbeJNXar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:30:47 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37369 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728546AbeJNXar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:30:47 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLv-0004cU-K0; Sun, 14 Oct 2018 16:30:47 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLV-0000Qr-41; Sun, 14 Oct 2018 16:30:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Boris Brezillon" <boris.brezillon@bootlin.com>,
        "Joakim Tjernlund" <joakim.tjernlund@infinera.com>,
        "Joakim Tjernlund" <joakim.tjernlund@transmode.se>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.793173208@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 208/366] mtd: cfi: cmdset_0001: Do not allow
 read/write to suspend erase block.
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Tjernlund <joakim.tjernlund@transmode.se>

commit 6510bbc88e3258631831ade49033537081950605 upstream.

Currently it is possible to read and/or write to suspend EB's.
Writing /dev/mtdX or /dev/mtdblockX from several processes may
break the flash state machine.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Reviewed-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/chips/cfi_cmdset_0001.c | 16 +++++++++++-----
 include/linux/mtd/flashchip.h       |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -825,21 +825,25 @@ static int chip_ready (struct map_info *
 		     (mode == FL_WRITING && (cfip->SuspendCmdSupport & 1))))
 			goto sleep;
 
+		/* Do not allow suspend iff read/write to EB address */
+		if ((adr & chip->in_progress_block_mask) ==
+		    chip->in_progress_block_addr)
+			goto sleep;
 
 		/* Erase suspend */
-		map_write(map, CMD(0xB0), adr);
+		map_write(map, CMD(0xB0), chip->in_progress_block_addr);
 
 		/* If the flash has finished erasing, then 'erase suspend'
 		 * appears to make some (28F320) flash devices switch to
 		 * 'read' mode.  Make sure that we switch to 'read status'
 		 * mode so we get the right data. --rmk
 		 */
-		map_write(map, CMD(0x70), adr);
+		map_write(map, CMD(0x70), chip->in_progress_block_addr);
 		chip->oldstate = FL_ERASING;
 		chip->state = FL_ERASE_SUSPENDING;
 		chip->erase_suspended = 1;
 		for (;;) {
-			status = map_read(map, adr);
+			status = map_read(map, chip->in_progress_block_addr);
 			if (map_word_andequal(map, status, status_OK, status_OK))
 			        break;
 
@@ -1035,8 +1039,8 @@ static void put_chip(struct map_info *ma
 		   sending the 0x70 (Read Status) command to an erasing
 		   chip and expecting it to be ignored, that's what we
 		   do. */
-		map_write(map, CMD(0xd0), adr);
-		map_write(map, CMD(0x70), adr);
+		map_write(map, CMD(0xd0), chip->in_progress_block_addr);
+		map_write(map, CMD(0x70), chip->in_progress_block_addr);
 		chip->oldstate = FL_READY;
 		chip->state = FL_ERASING;
 		break;
@@ -1927,6 +1931,8 @@ static int __xipram do_erase_oneblock(st
 	map_write(map, CMD(0xD0), adr);
 	chip->state = FL_ERASING;
 	chip->erase_suspended = 0;
+	chip->in_progress_block_addr = adr;
+	chip->in_progress_block_mask = ~(len - 1);
 
 	ret = INVAL_CACHE_AND_WAIT(map, chip, adr,
 				   adr, len,
--- a/include/linux/mtd/flashchip.h
+++ b/include/linux/mtd/flashchip.h
@@ -85,6 +85,7 @@ struct flchip {
 	unsigned int write_suspended:1;
 	unsigned int erase_suspended:1;
 	unsigned long in_progress_block_addr;
+	unsigned long in_progress_block_mask;
 
 	struct mutex mutex;
 	wait_queue_head_t wq; /* Wait on here when we're waiting for the chip

