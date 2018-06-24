Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C627C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A546252E1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 19:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="G+pcoQ35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A546252E1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeFXTWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 15:22:38 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:36130 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbeFXTWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 15:22:35 -0400
Received: from trochilidae.lan (unknown [IPv6:2a02:169:34d6:10::3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 5F3EC5C10FE;
        Sun, 24 Jun 2018 21:22:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1529868153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:content-type:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sam56dJzffh/HgwJOXi79xAsu0HRMYX5+/Q/e7SsbuA=;
        b=G+pcoQ359khnjB7ds2Yf6KfKRxqkeweVX9aXphiOgDGrpePY+h9x5YDYslA20N3alNJec0
        xBIM2yEXeVLbb2Xm9QnAQp2F9Jp1Tn1G4v2qgwAVxH+IZJxjemaB9KAv72quEUUTKWjfRm
        B1ljP8VL8Giwn9KyoZFbbeb3AVd+UFo=
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
Subject: [PATCH v7 1/6] mtd: rawnand: add Reed-Solomon error correction algorithm
Date:   Sun, 24 Jun 2018 21:22:25 +0200
Message-Id: <20180624192230.4674-2-stefan@agner.ch>
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

Add Reed-Solomon (RS) to the enumeration of ECC algorithms.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/nand.txt | 2 +-
 drivers/mtd/nand/raw/nand_base.c               | 1 +
 include/linux/mtd/rawnand.h                    | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
index 8bb11d809429d..eaef8c657aa5c 100644
--- a/Documentation/devicetree/bindings/mtd/nand.txt
+++ b/Documentation/devicetree/bindings/mtd/nand.txt
@@ -25,7 +25,7 @@ Optional NAND chip properties:
 		  Deprecated values:
 		  "soft_bch": use "soft" and nand-ecc-algo instead
 - nand-ecc-algo: string, algorithm of NAND ECC.
-		 Supported values are: "hamming", "bch".
+		 Valid values are: "hamming", "bch", "rs".
 - nand-bus-width : 8 or 16 bus width if not present 8
 - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
 
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 10c4f9919850c..47e9cb9063da4 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5777,6 +5777,7 @@ static int of_get_nand_ecc_mode(struct device_node *np)
 static const char * const nand_ecc_algos[] = {
 	[NAND_ECC_HAMMING]	= "hamming",
 	[NAND_ECC_BCH]		= "bch",
+	[NAND_ECC_RS]		= "rs",
 };
 
 static int of_get_nand_ecc_algo(struct device_node *np)
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 3e8ec3b8a39c7..2d9cb7acbc3d8 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -121,6 +121,7 @@ enum nand_ecc_algo {
 	NAND_ECC_UNKNOWN,
 	NAND_ECC_HAMMING,
 	NAND_ECC_BCH,
+	NAND_ECC_RS,
 };
 
 /*
-- 
2.17.1

