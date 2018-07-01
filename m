Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B00CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB06625B06
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 18:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB06625B06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeGASmV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 14:42:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60188 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932553AbeGAQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:13:41 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8601E86A;
        Sun,  1 Jul 2018 16:13:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Joakim Tjernlund <joakim.tjernlund@infinera.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 3.18 64/85] mtd: cfi_cmdset_0002: Use right chip in do_ppb_xxlock()
Date:   Sun,  1 Jul 2018 18:02:22 +0200
Message-Id: <20180701153124.921979254@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joakim Tjernlund <joakim.tjernlund@infinera.com>

commit f93aa8c4de307069c270b2d81741961162bead6c upstream.

do_ppb_xxlock() fails to add chip->start when querying for lock status
(and chip_ready test), which caused false status reports.
Fix that by adding adr += chip->start and adjust call sites
accordingly.

Fixes: 1648eaaa1575 ("mtd: cfi_cmdset_0002: Support Persistent Protection Bits (PPB) locking")
Cc: stable@vger.kernel.org
Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/chips/cfi_cmdset_0002.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -2551,8 +2551,9 @@ static int __maybe_unused do_ppb_xxlock(
 	unsigned long timeo;
 	int ret;
 
+	adr += chip->start;
 	mutex_lock(&chip->mutex);
-	ret = get_chip(map, chip, adr + chip->start, FL_LOCKING);
+	ret = get_chip(map, chip, adr, FL_LOCKING);
 	if (ret) {
 		mutex_unlock(&chip->mutex);
 		return ret;
@@ -2570,8 +2571,8 @@ static int __maybe_unused do_ppb_xxlock(
 
 	if (thunk == DO_XXLOCK_ONEBLOCK_LOCK) {
 		chip->state = FL_LOCKING;
-		map_write(map, CMD(0xA0), chip->start + adr);
-		map_write(map, CMD(0x00), chip->start + adr);
+		map_write(map, CMD(0xA0), adr);
+		map_write(map, CMD(0x00), adr);
 	} else if (thunk == DO_XXLOCK_ONEBLOCK_UNLOCK) {
 		/*
 		 * Unlocking of one specific sector is not supported, so we
@@ -2609,7 +2610,7 @@ static int __maybe_unused do_ppb_xxlock(
 	map_write(map, CMD(0x00), chip->start);
 
 	chip->state = FL_READY;
-	put_chip(map, chip, adr + chip->start);
+	put_chip(map, chip, adr);
 	mutex_unlock(&chip->mutex);
 
 	return ret;


