Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC6CECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A47D20661
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTncU+Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A47D20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeGSAhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:37:17 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34776 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeGSAhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:37:16 -0400
Received: by mail-lj1-f196.google.com with SMTP id f8-v6so5622305ljk.1;
        Wed, 18 Jul 2018 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tuXV8yjyIbVo5qy73WEEP0gq4g/1G2BM5l5izBZJp5g=;
        b=YTncU+Cz8fjHOX08nGx7QM80rift7Gmp3oX57oDpQyWa4hDQHX6HQKsEbGlnd00B2M
         7ABB5biLs2rGzkhD43gkE1jXtBWCeog2LR3clFOEs8cocxK5H3ihEBVENEIj+eRcJd13
         QHm48x6hP1pDd8LFIv2bvA5rJyS5yARt9dqXukX/QofPtmTxki+1MZxOUM4OJaglc71r
         XZP7PtPQFRo7hXcATcdrHIMaFoRqsayIdF701KpF7ADFda8UL2uQ+EK0RH1pX9OBMaD0
         rrqmc6SHJSsxvoAq9GbzIj/rGy+mIB5ap6eVY7yXnMiu0NlQwg364DyeRXoIrXNvx6Lh
         zPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tuXV8yjyIbVo5qy73WEEP0gq4g/1G2BM5l5izBZJp5g=;
        b=jEizSyoi4OhF/yLiyY77g6cJSWRaKS9iWmpGk9SA8tzM+4hPXgl1wTr/eOxJ5fNaDs
         BBedoIwl7xrJU8DLqmI0phgl2kA5pgonBdPfFB72zX99YSz/4grLwSpHl1ai/4umjIRL
         iQmdM4UvN/P49foOjSa5vv79257mt5AvVrkfA1WhdVUB7JBPxYn2vJipfU+e0WvpStUR
         RgrjEWo1T/ks2L8DGP/yKHEXm0ErZPHPy2Dm40Myx2LtPt6p+KnQgmd1qeOF1dzblPVY
         qT0drXnXNzDgZAQS9KlU8QIqOUtfy2wc3eMLsCYYNSEaQg58cUD3ta8+kojmP7fqhxqc
         n2wg==
X-Gm-Message-State: AOUpUlFEFl4eblEabOOyLkXQwx9BiK38MaGLMsXXzzBC37L0Oe2KutME
        w1k1q9CzrzQFFOFcLnDT1Z4=
X-Google-Smtp-Source: AAOMgpfi8/ThuJr6oRvAx3cLTBl4r4J2waP3hDMNsu66Ab/VO3PfLwL/2W1dMxW5wnEnbm/o6XEBgQ==
X-Received: by 2002:a2e:2f19:: with SMTP id v25-v6mr5777018ljv.113.1531958215494;
        Wed, 18 Jul 2018 16:56:55 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h7-v6sm826584ljk.27.2018.07.18.16.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:56:54 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 4/8] mtd: rawnand: ams-delta: Optimize pointer resolution on read/write
Date:   Thu, 19 Jul 2018 01:57:06 +0200
Message-Id: <20180718235710.18242-5-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Further optimize processing speed of read/write callback functions by
resolving private structure pointer only once per callback and passing
it to all subfunctions instead of mtd_info.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 44 +++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index dfefcd79b420..d7e4c9dbef67 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -72,10 +72,9 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct nand_chip *this = &priv->nand_chip;
 
 	writew(byte, this->IO_ADDR_W);
 	gpiod_set_value(priv->gpiod_nwe, 0);
@@ -83,21 +82,18 @@ static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_first_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	void __iomem *io_base = priv->io_base;
 
 	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 
-	ams_delta_write_next_byte(mtd, byte);
+	ams_delta_write_next_byte(priv, byte);
 }
 
-static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
+static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	struct nand_chip *this = &priv->nand_chip;
 	u_char res;
 
 	gpiod_set_value(priv->gpiod_nre, 0);
@@ -108,36 +104,46 @@ static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
 	return res;
 }
 
-static u_char ams_delta_read_byte(struct mtd_info *mtd)
+static u_char ams_delta_read_first_byte(struct ams_delta_nand *priv)
 {
-	struct nand_chip *this = mtd_to_nand(mtd);
-	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	void __iomem *io_base = priv->io_base;
 
 	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 
-	return ams_delta_read_next_byte(mtd);
+	return ams_delta_read_next_byte(priv);
+}
+
+static u_char ams_delta_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+
+	return ams_delta_read_first_byte(priv);
 }
 
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 				int len)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
 	if (len > 0)
-		ams_delta_write_byte(mtd, buf[0]);
+		ams_delta_write_first_byte(priv, buf[0]);
 	for (i = 1; i < len; i++)
-		ams_delta_write_next_byte(mtd, buf[i]);
+		ams_delta_write_next_byte(priv, buf[i]);
 }
 
 static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	int i;
 
 	if (len > 0)
-		buf[0] = ams_delta_read_byte(mtd);
+		buf[0] = ams_delta_read_first_byte(priv);
 	for (i = 1; i < len; i++)
-		buf[i] = ams_delta_read_next_byte(mtd);
+		buf[i] = ams_delta_read_next_byte(priv);
 }
 
 /*
@@ -161,7 +167,7 @@ static void ams_delta_hwcontrol(struct mtd_info *mtd, int cmd,
 	}
 
 	if (cmd != NAND_CMD_NONE)
-		ams_delta_write_byte(mtd, cmd);
+		ams_delta_write_first_byte(priv, cmd);
 }
 
 static int ams_delta_nand_ready(struct mtd_info *mtd)
-- 
2.16.4

