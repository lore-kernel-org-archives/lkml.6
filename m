Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1B5208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1B5208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbeK0Sl4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:41:56 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:45838 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbeK0Sl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:41:56 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 34ACA67A5AB;
        Tue, 27 Nov 2018 08:44:53 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 27 Nov
 2018 08:44:52 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 27 Nov 2018 08:44:52 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Thread-Topic: [PATCH] mtd: nand: Fix memory allocation in nanddev_bbt_init()
Thread-Index: AQHUhiUV+bbi1IymHUOKrtHQUP0AvQ==
Date:   Tue, 27 Nov 2018 07:44:52 +0000
Message-ID: <1543304637-27308-1-git-send-email-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.43]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 34ACA67A5AB.AF014
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the size of the buffer allocated to store the in-memory BBT.
This bug was previously hidden by a different bug, that was fixed in
d098093ba06e.

Fixes: 9c3736a3de21 ("mtd: nand: Add core infrastructure to deal with NAND devices")
Cc: <stable@vger.kernel.org>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/bbt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
index 56cde38..c12497f 100644
--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -27,7 +27,8 @@ int nanddev_bbt_init(struct nand_device *nand)
 	unsigned int nwords = DIV_ROUND_UP(nblocks * bits_per_block,
 					   BITS_PER_LONG);
 
-	nand->bbt.cache = kzalloc(nwords, GFP_KERNEL);
+	nand->bbt.cache = kzalloc(nwords * (BITS_PER_LONG / BITS_PER_BYTE),
+				  GFP_KERNEL);
 	if (!nand->bbt.cache)
 		return -ENOMEM;
 
-- 
2.7.4
