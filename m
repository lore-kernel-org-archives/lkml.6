Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EA4C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D56720661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="h7q9Dxv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D56720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756132AbeFSFbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:31:49 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:46081 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755940AbeFSFbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:31:44 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BDCA684484;
        Tue, 19 Jun 2018 17:31:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529386302;
        bh=+QxjOAv90xsLZbmQ3FloDXnrjuTHlR0rdZo/AYI8UJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h7q9Dxv8qE4jZiUguX5yQv7iKG8g/XF6uc7Tm5hZvUnB5OH0nJ23mQBaPz1c3mINh
         G6flPgPzHZh3axKivRfPdEHCIoF67CUjG9sj4wbTYLgvoikhHgRvtwWwhvSVFAqvBE
         3bkRFttp89J6LDCrZBQyWpnts+altO9iBJahJ62M=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b28953f0000>; Tue, 19 Jun 2018 17:31:43 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 9160213EEAD;
        Tue, 19 Jun 2018 17:31:45 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 779F91E2626; Tue, 19 Jun 2018 17:31:42 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Richard Weinberger <richard@nod.at>,
        Marek Vasut <marek.vasut@gmail.com>
Subject: [RFC PATCH v2 4/6] mtd: rawnand: marvell: Support page size of 2048 with 8-bit ECC
Date:   Tue, 19 Jun 2018 17:31:23 +1200
Message-Id: <20180619053125.16792-5-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
References: <20180619053125.16792-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MT29F1G08ABAFAWP-ITE:F chip has 2048 byte pages and requires a
minimum ECC strength of 8-bits. Allow for this combination of
requirements using the marvell_nand controller.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
I've tried to follow the recommended AN-379 from Marvell. They do seem
to have information that covers this particular set of chip
requirements.

As discussed I don't think my particular configuration will be supported
with this change due to the conflict with the on-die ECC. But this may
be useful for others so I've left it in.

Changes in v2:
- update as suggested by miquel

 drivers/mtd/nand/raw/marvell_nand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index ba6889bbe802..96aee8ffd408 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -217,6 +217,7 @@ static const struct marvell_hw_ecc_layout marvell_nfc_layouts[] = {
 	MARVELL_LAYOUT(  512,   512,  1,  1,  1,  512,  8,  8,  0,  0,  0),
 	MARVELL_LAYOUT( 2048,   512,  1,  1,  1, 2048, 40, 24,  0,  0,  0),
 	MARVELL_LAYOUT( 2048,   512,  4,  1,  1, 2048, 32, 30,  0,  0,  0),
+	MARVELL_LAYOUT( 2048,   512,  8,  2,  1, 1024, 0, 30,  1024,  32,  30),
 	MARVELL_LAYOUT( 4096,   512,  4,  2,  2, 2048, 32, 30,  0,  0,  0),
 	MARVELL_LAYOUT( 4096,   512,  8,  5,  4, 1024,  0, 30,  0, 64, 30),
 };
-- 
2.17.1

