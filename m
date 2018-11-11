Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00A7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB010215EA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB010215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbeKLG15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:27:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49614 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730012AbeKLFsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:09 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000l4-Bp; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsQ-0001Ue-KL; Sun, 11 Nov 2018 19:58:34 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Boris Brezillon" <boris.brezillon@bootlin.com>,
        "Tokunori Ikegami" <ikegami@allied-telesis.co.jp>,
        linux-mtd@lists.infradead.org,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "Boris Brezillon" <boris.brezillon@free-electrons.com>,
        "Chris Packham" <chris.packham@alliedtelesis.co.nz>,
        "Brian Norris" <computersforpeace@gmail.com>,
        "Cyrille Pitchen" <cyrille.pitchen@wedev4u.fr>,
        "Joakim Tjernlund" <Joakim.Tjernlund@infinera.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Richard Weinberger" <richard@nod.at>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.591656605@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 098/366] mtd: cfi_cmdset_0002: Change erase functions
 to retry for error
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

From: Tokunori Ikegami <ikegami@allied-telesis.co.jp>

commit 45f75b8a919a4255f52df454f1ffdee0e42443b2 upstream.

For the word write functions it is retried for error.
But it is not implemented to retry for the erase functions.
To make sure for the erase functions change to retry as same.

This is needed to prevent the flash erase error caused only once.
It was caused by the error case of chip_good() in the do_erase_oneblock().
Also it was confirmed on the MACRONIX flash device MX29GL512FHT2I-11G.
But the error issue behavior is not able to reproduce at this moment.
The flash controller is parallel Flash interface integrated on BCM53003.

Signed-off-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Reviewed-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc: linux-mtd@lists.infradead.org
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/mtd/chips/cfi_cmdset_0002.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -1900,6 +1900,7 @@ static int __xipram do_erase_chip(struct
 	unsigned long int adr;
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
+	int retry_cnt = 0;
 
 	adr = cfi->addr_unlock1;
 
@@ -1917,6 +1918,7 @@ static int __xipram do_erase_chip(struct
 	ENABLE_VPP(map);
 	xip_disable(map, chip, adr);
 
+ retry:
 	cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi, cfi->device_type, NULL);
 	cfi_send_gen_cmd(0x55, cfi->addr_unlock2, chip->start, map, cfi, cfi->device_type, NULL);
 	cfi_send_gen_cmd(0x80, cfi->addr_unlock1, chip->start, map, cfi, cfi->device_type, NULL);
@@ -1971,6 +1973,9 @@ static int __xipram do_erase_chip(struct
 		map_write( map, CMD(0xF0), chip->start );
 		/* FIXME - should have reset delay before continuing */
 
+		if (++retry_cnt <= MAX_RETRIES)
+			goto retry;
+
 		ret = -EIO;
 	}
 
@@ -1990,6 +1995,7 @@ static int __xipram do_erase_oneblock(st
 	unsigned long timeo = jiffies + HZ;
 	DECLARE_WAITQUEUE(wait, current);
 	int ret = 0;
+	int retry_cnt = 0;
 
 	adr += chip->start;
 
@@ -2007,6 +2013,7 @@ static int __xipram do_erase_oneblock(st
 	ENABLE_VPP(map);
 	xip_disable(map, chip, adr);
 
+ retry:
 	cfi_send_gen_cmd(0xAA, cfi->addr_unlock1, chip->start, map, cfi, cfi->device_type, NULL);
 	cfi_send_gen_cmd(0x55, cfi->addr_unlock2, chip->start, map, cfi, cfi->device_type, NULL);
 	cfi_send_gen_cmd(0x80, cfi->addr_unlock1, chip->start, map, cfi, cfi->device_type, NULL);
@@ -2064,6 +2071,9 @@ static int __xipram do_erase_oneblock(st
 		map_write( map, CMD(0xF0), chip->start );
 		/* FIXME - should have reset delay before continuing */
 
+		if (++retry_cnt <= MAX_RETRIES)
+			goto retry;
+
 		ret = -EIO;
 	}
 

