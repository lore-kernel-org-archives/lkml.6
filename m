Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8584FC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C3C252E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="APs8WIf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C3C252E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeFXTWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 15:22:39 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36156 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbeFXTWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 15:22:35 -0400
Received: from trochilidae.lan (unknown [IPv6:2a02:169:34d6:10::3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 7878E5C1261;
        Sun, 24 Jun 2018 21:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529868153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S63NkXwQVl33idNQHAtaRdcC+s/xskq6Tn0rTZ69+lM=;
        b=APs8WIf/w5yhQ85iUTseBmsVppsx7j3ef9ZEm9lSkHvOFXVECXjina+jS24klmfz8VvAsM
        DgYfIr2XAdgAPhKxvK6Dh1WJGorqkBvgVLc+xwHbnXk9io12tYEiGJ8HCow2oDi0gN7Cvi
        gS2zbhdrjo/Dmjxqy1Nf+5kXg+KDKA0=
From:   Stefan Agner <stefan@agner.ch>
To:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com
Cc:     dev@lynxeye.de, miquel.raynal@bootlin.com, richard@nod.at,
        marcel@ziswiler.com, krzk@kernel.org, digetx@gmail.com,
        benjamin.lindqvist@endian.se, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, mirza.krak@gmail.com,
        gaireg@gaireg.de, linux-mtd@lists.infradead.org,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH v7 2/6] mtd: rawnand: add an option to specify NAND chip as a boot device
Date:   Sun, 24 Jun 2018 21:22:26 +0200
Message-Id: <20180624192230.4674-3-stefan@agner.ch>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624192230.4674-1-stefan@agner.ch>
References: <20180624192230.4674-1-stefan@agner.ch>
X-Spamd-Result: default: False [-2.10 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[24];
         BAYES_HAM(-3.00)[100.00%];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         MID_CONTAINS_FROM(1.00)[];
         ASN(0.00)[asn:13030, ipnet:2a02:169::/32, country:CH];
         RCVD_TLS_ALL(0.00)[];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to define a NAND chip as a boot device. This can be helpful
for the selection of the ECC algorithm and strength in case the boot
ROM supports only a subset of controller provided options.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 Documentation/devicetree/bindings/mtd/nand.txt | 4 ++++
 drivers/mtd/nand/raw/nand_base.c               | 3 +++
 include/linux/mtd/rawnand.h                    | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
index eaef8c657aa5c..e949c778e9837 100644
--- a/Documentation/devicetree/bindings/mtd/nand.txt
+++ b/Documentation/devicetree/bindings/mtd/nand.txt
@@ -43,6 +43,10 @@ Optional NAND chip properties:
 		     This is particularly useful when only the in-band area is
 		     used by the upper layers, and you want to make your NAND
 		     as reliable as possible.
+- nand-is-boot-medium: Whether the NAND chip is a boot medium. Drivers might use
+		       this information to select ECC algorithms supported by
+		       the boot ROM or similar restrictions.
+
 - nand-rb: shall contain the native Ready/Busy ids.
 
 The ECC strength and ECC step size properties define the correction capability
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 47e9cb9063da4..e70bf328c64e4 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5859,6 +5859,9 @@ static int nand_dt_init(struct nand_chip *chip)
 	if (of_get_nand_bus_width(dn) == 16)
 		chip->options |= NAND_BUSWIDTH_16;
 
+	if (of_property_read_bool(dn, "nand-is-boot-medium"))
+		chip->options |= NAND_IS_BOOT_MEDIUM;
+
 	if (of_get_nand_on_flash_bbt(dn))
 		chip->bbt_options |= NAND_BBT_USE_FLASH;
 
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 2d9cb7acbc3d8..80aeeca03f36b 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -219,6 +219,12 @@ enum nand_ecc_algo {
  */
 #define NAND_WAIT_TCCS		0x00200000
 
+/*
+ * Whether the NAND chip is a boot medium. Drivers might use this information
+ * to select ECC algorithms supported by the boot ROM or similar restrictions.
+ */
+#define NAND_IS_BOOT_MEDIUM	0x00400000
+
 /* Options set by nand scan */
 /* Nand scan has allocated controller struct */
 #define NAND_CONTROLLER_ALLOC	0x80000000
-- 
2.17.1

