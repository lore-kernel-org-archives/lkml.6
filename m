Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF92C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAB2252A9
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAB2252A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030768AbeGAQdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:33:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35362 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753333AbeGAQdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:33:18 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C819E92B;
        Sun,  1 Jul 2018 16:33:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.14 074/157] mtd: cfi_cmdset_0002: fix SEGV unlocking multiple chips
Date:   Sun,  1 Jul 2018 18:22:26 +0200
Message-Id: <20180701160856.312511620@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
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

From: Joakim Tjernlund <joakim.tjernlund@infinera.com>

commit 5fdfc3dbad099281bf027a353d5786c09408a8e5 upstream.

cfi_ppb_unlock() tries to relock all sectors that were locked before
unlocking the whole chip.
This locking used the chip start address + the FULL offset from the
first flash chip, thereby forming an illegal address. Fix that by using
the chip offset(adr).

Fixes: 1648eaaa1575 ("mtd: cfi_cmdset_0002: Support Persistent Protection Bits (PPB) locking")
Cc: stable@vger.kernel.org
Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/cfi_cmdset_0002.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -2535,7 +2535,7 @@ static int cfi_atmel_unlock(struct mtd_i
 
 struct ppb_lock {
 	struct flchip *chip;
-	loff_t offset;
+	unsigned long adr;
 	int locked;
 };
 
@@ -2671,7 +2671,7 @@ static int __maybe_unused cfi_ppb_unlock
 		 */
 		if ((adr < ofs) || (adr >= (ofs + len))) {
 			sect[sectors].chip = &cfi->chips[chipnum];
-			sect[sectors].offset = offset;
+			sect[sectors].adr = adr;
 			sect[sectors].locked = do_ppb_xxlock(
 				map, &cfi->chips[chipnum], adr, 0,
 				DO_XXLOCK_ONEBLOCK_GETLOCK);
@@ -2715,7 +2715,7 @@ static int __maybe_unused cfi_ppb_unlock
 	 */
 	for (i = 0; i < sectors; i++) {
 		if (sect[i].locked)
-			do_ppb_xxlock(map, sect[i].chip, sect[i].offset, 0,
+			do_ppb_xxlock(map, sect[i].chip, sect[i].adr, 0,
 				      DO_XXLOCK_ONEBLOCK_LOCK);
 	}
 


