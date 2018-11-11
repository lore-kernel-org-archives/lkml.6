Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DF8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 851C42080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851C42080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbeKLFzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:24 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51874 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbeKLFzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:24 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsz-0000oJ-Gq; Sun, 11 Nov 2018 19:59:09 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001aY-Vy; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Boris Brezillon" <boris.brezillon@bootlin.com>,
        "Joakim Tjernlund" <joakim.tjernlund@infinera.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.475063224@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 161/366] mtd: cfi_cmdset_0002: Use right chip in
 do_ppb_xxlock()
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

commit f93aa8c4de307069c270b2d81741961162bead6c upstream.

do_ppb_xxlock() fails to add chip->start when querying for lock status
(and chip_ready test), which caused false status reports.
Fix that by adding adr += chip->start and adjust call sites
accordingly.

Fixes: 1648eaaa1575 ("mtd: cfi_cmdset_0002: Support Persistent Protection Bits (PPB) locking")
Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/chips/cfi_cmdset_0002.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -2224,8 +2224,9 @@ static int __maybe_unused do_ppb_xxlock(
 	unsigned long timeo;
 	int ret;
 
+	adr += chip->start;
 	mutex_lock(&chip->mutex);
-	ret = get_chip(map, chip, adr + chip->start, FL_LOCKING);
+	ret = get_chip(map, chip, adr, FL_LOCKING);
 	if (ret) {
 		mutex_unlock(&chip->mutex);
 		return ret;
@@ -2243,8 +2244,8 @@ static int __maybe_unused do_ppb_xxlock(
 
 	if (thunk == DO_XXLOCK_ONEBLOCK_LOCK) {
 		chip->state = FL_LOCKING;
-		map_write(map, CMD(0xA0), chip->start + adr);
-		map_write(map, CMD(0x00), chip->start + adr);
+		map_write(map, CMD(0xA0), adr);
+		map_write(map, CMD(0x00), adr);
 	} else if (thunk == DO_XXLOCK_ONEBLOCK_UNLOCK) {
 		/*
 		 * Unlocking of one specific sector is not supported, so we
@@ -2282,7 +2283,7 @@ static int __maybe_unused do_ppb_xxlock(
 	map_write(map, CMD(0x00), chip->start);
 
 	chip->state = FL_READY;
-	put_chip(map, chip, adr + chip->start);
+	put_chip(map, chip, adr);
 	mutex_unlock(&chip->mutex);
 
 	return ret;

