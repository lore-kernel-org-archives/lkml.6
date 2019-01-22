Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F28BC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6532B2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfAVLXg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:23:36 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:53502 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfAVLXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:23:35 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id B87BF67BC80;
        Tue, 22 Jan 2019 12:23:32 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Tue, 22 Jan
 2019 12:23:32 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%5]) with mapi id
 15.01.1466.003; Tue, 22 Jan 2019 12:23:32 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Schrempf Frieder" <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v2 3/4] mtd: rawnand: ESMT: Also use the last page for bad
 block markers
Thread-Topic: [PATCH v2 3/4] mtd: rawnand: ESMT: Also use the last page for
 bad block markers
Thread-Index: AQHUskToRFdifTqxu0S57aTRv0y72w==
Date:   Tue, 22 Jan 2019 11:23:32 +0000
Message-ID: <20190122112258.20042-4-frieder.schrempf@kontron.de>
References: <20190122112258.20042-1-frieder.schrempf@kontron.de>
In-Reply-To: <20190122112258.20042-1-frieder.schrempf@kontron.de>
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
X-SnT-MailScanner-ID: B87BF67BC80.AEB9A
X-SnT-MailScanner: Found to be clean
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, boris.brezillon@bootlin.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

It is known that some ESMT SLC NANDs have been shipped
with the factory bad block markers in the first or last page
of the block, instead of the first or second page. To be on
the safe side, let's check all three locations.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/mtd/nand/raw/nand_esmt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_esmt.c b/drivers/mtd/nand/raw/nand_esmt.c
index 99a8092969a7..b37e0b5af5ae 100644
--- a/drivers/mtd/nand/raw/nand_esmt.c
+++ b/drivers/mtd/nand/raw/nand_esmt.c
@@ -36,7 +36,14 @@ static void esmt_nand_decode_id(struct nand_chip *chip)
 static int esmt_nand_init(struct nand_chip *chip)
 {
 	if (nand_is_slc(chip))
-		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE;
+		/*
+		 * It is known that some ESMT SLC NANDs have been shipped
+		 * with the factory bad block markers in the first or last page
+		 * of the block, instead of the first or second page. To be on
+		 * the safe side, let's check all three locations.
+		 */
+		chip->options |= NAND_BBM_FIRSTPAGE | NAND_BBM_SECONDPAGE |
+				 NAND_BBM_LASTPAGE;
 
 	return 0;
 }
-- 
2.17.1
