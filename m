Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C2C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055F0214F1
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055F0214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbeKLFsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:48:40 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51390 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729587AbeKLFsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:38 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsz-0000tu-0e; Sun, 11 Nov 2018 19:59:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0001ae-0K; Sun, 11 Nov 2018 19:58:37 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Joakim Tjernlund" <joakim.tjernlund@infinera.com>,
        "Boris Brezillon" <boris.brezillon@bootlin.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.536895723@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 162/366] mtd: cfi_cmdset_0002: fix SEGV unlocking
 multiple chips
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Tjernlund <joakim.tjernlund@infinera.com>

commit 5fdfc3dbad099281bf027a353d5786c09408a8e5 upstream.

cfi_ppb_unlock() tries to relock all sectors that were locked before
unlocking the whole chip.
This locking used the chip start address + the FULL offset from the
first flash chip, thereby forming an illegal address. Fix that by using
the chip offset(adr).

Fixes: 1648eaaa1575 ("mtd: cfi_cmdset_0002: Support Persistent Protection Bits (PPB) locking")
Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/chips/cfi_cmdset_0002.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -2206,7 +2206,7 @@ static int cfi_atmel_unlock(struct mtd_i
 
 struct ppb_lock {
 	struct flchip *chip;
-	loff_t offset;
+	unsigned long adr;
 	int locked;
 };
 
@@ -2342,7 +2342,7 @@ static int __maybe_unused cfi_ppb_unlock
 		 */
 		if ((adr < ofs) || (adr >= (ofs + len))) {
 			sect[sectors].chip = &cfi->chips[chipnum];
-			sect[sectors].offset = offset;
+			sect[sectors].adr = adr;
 			sect[sectors].locked = do_ppb_xxlock(
 				map, &cfi->chips[chipnum], adr, 0,
 				DO_XXLOCK_ONEBLOCK_GETLOCK);
@@ -2386,7 +2386,7 @@ static int __maybe_unused cfi_ppb_unlock
 	 */
 	for (i = 0; i < sectors; i++) {
 		if (sect[i].locked)
-			do_ppb_xxlock(map, sect[i].chip, sect[i].offset, 0,
+			do_ppb_xxlock(map, sect[i].chip, sect[i].adr, 0,
 				      DO_XXLOCK_ONEBLOCK_LOCK);
 	}
 

