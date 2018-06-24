Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D054C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6BD2535A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 22:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="wqpsa8+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6BD2535A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752502AbeFXWq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 18:46:26 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:56270 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbeFXWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 18:45:03 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5AF1C8448B;
        Mon, 25 Jun 2018 10:45:01 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529880301;
        bh=C3PdnOqV/ztdeq2R845eBsDJK1N+7lLs2VpHns3o1RA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=wqpsa8+hCQ160pFUors+PvrkTvjeXRIyzgHyJdsuDtehhWVdJs6PAHKaFu7GjrnKJ
         BRbCAaZ2qvDYw7M3ZMjv6lMcw3WUwkI1jn+AC5GC8bfStDrPyrKwQ5MUxJLb/XHzHA
         XKxbcy1XokT1EiBFLvfBktcs9lstiXrHFHpsnY64=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b301eec0000>; Mon, 25 Jun 2018 10:45:00 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 8DDC713EE1C;
        Mon, 25 Jun 2018 10:45:04 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 2A7181E2626; Mon, 25 Jun 2018 10:45:01 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH v6 6/6] mtd: rawnand: micron: detect forced on-die ECC
Date:   Mon, 25 Jun 2018 10:44:48 +1200
Message-Id: <20180624224448.21872-7-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624224448.21872-1-chris.packham@alliedtelesis.co.nz>
References: <20180624224448.21872-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Micron NAND chips have on-die ECC forceably enabled. Detect these
based on chip ID as there seems to be no other way of distinguishing
these chips from those that have optional support for on-die ECC.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
Changes in v4:
- New
Changes in v5:
- fail if on-die ECC is mandatory and the current ecc.mode is not
  NAND_ECC_ON_DIE.
Changes in v6:
- Update commit message, add review from Boris

 drivers/mtd/nand/raw/nand_micron.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index f83053562925..35fa6880a799 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -255,6 +255,14 @@ enum {
 	MICRON_ON_DIE_MANDATORY,
 };
 
+/*
+ * These parts are known to have on-die ECC forceably enabled
+ */
+static u8 micron_on_die_ecc[] = {
+	0xd1, /* MT29F1G08ABAFA */
+	0xa1, /* MT29F1G08ABBFA */
+};
+
 /*
  * Try to detect if the NAND support on-die ECC. To do this, we enable
  * the feature, and read back if it has been enabled as expected. We
@@ -269,6 +277,11 @@ static int micron_supports_on_die_ecc(struct nand_chip *chip)
 {
 	u8 feature[ONFI_SUBFEATURE_PARAM_LEN] = { 0, };
 	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(micron_on_die_ecc); i++)
+		if (chip->id.data[1] == micron_on_die_ecc[i])
+			return MICRON_ON_DIE_MANDATORY;
 
 	if (!chip->parameters.onfi.version)
 		return MICRON_ON_DIE_UNSUPPORTED;
@@ -322,7 +335,8 @@ static int micron_nand_init(struct nand_chip *chip)
 
 	ondie = micron_supports_on_die_ecc(chip);
 
-	if (ondie == MICRON_ON_DIE_MANDATORY) {
+	if (ondie == MICRON_ON_DIE_MANDATORY &&
+	    chip->ecc.mode != NAND_ECC_ON_DIE) {
 		pr_err("On-die ECC forcefully enabled, not supported\n");
 		return -EINVAL;
 	}
-- 
2.18.0

