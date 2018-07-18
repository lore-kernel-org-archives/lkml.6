Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFB2ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5A820661
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlQ8aKoT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5A820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbeGSAhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 20:37:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35189 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbeGSAhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 20:37:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10-v6so5614943ljg.2;
        Wed, 18 Jul 2018 16:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VKtzv6TOj+8k36A4MDjg5sQH4gRDQK6SCJGZCkc9hP0=;
        b=IlQ8aKoTG92ptQvIf3jEjtVkJm/f7dDAK06k7LNuIo4S1ply/FeieAXN856rW0EmPd
         s8DwFpAXD1Cndyn1hJNSrOMoNQoTJHJdTec1yCJLjrNeMlF3kv/pv/sIbtsYrQzM5/ek
         2B9wAmZDnJdz235Ia/bdKaCDOdfBA6ruSeMR5e3ORA5cMFLE75bCV5shLwuslfJ/kpzZ
         QWr6GHn6pG2uz6DwE38gAJBMpWRe6DIme1Hd7+PpPkqYQgUZOo83O6wAHB0BKWsfsw2+
         m3aiaEj52zyOcViF7bv0sd9uEWAgaDqkalGlW+0T0bT07oYPmKyF26lsD2i6zK+XYnLI
         5yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VKtzv6TOj+8k36A4MDjg5sQH4gRDQK6SCJGZCkc9hP0=;
        b=RQlCIxkRDJOBepWX1AUAs7oQMQGNzUyUTqmMWiAtkJcIwpFPQTdxhZPb7JHBFqXLN9
         /dZ7Q5WtWi5JAq5egqbWflPi/gzsbbq61aNNla5FMukGpSLIh2pnje51c3nKxPrACjGF
         A2QfrtjjlNGU/Z1eNjFUgkGCihUJnciQfGHUxvFM1FI0j2Sw691x1bN020jnm0cHGszD
         79DIdW+tn+WtE8m+ol3U6O106LLUhyRkr63T39vBAJCx6Yqc1cnoFGaZruCQdfaPD6t7
         ee8cXJEh7rlq2t5XRAJZbMZlL9+Ld5f2Vy4aH8OOGluxGrsvqCy+vhj/Xpqsukd67s5S
         dWiw==
X-Gm-Message-State: AOUpUlFUnB+AaVnW45YFgOgqm0YYUEENru/3u3DI5HMYlXh9sQEZL80f
        ilGh/0ZqS1FYSnBHKvFCNdk=
X-Google-Smtp-Source: AAOMgpdV+jeLkKtfMNm+5scBHPY+2ss7Yi6o/0FDjVB6jI+mZI2VdgeE4wxDMqyBSHOWBmpDC0zgUg==
X-Received: by 2002:a2e:4d51:: with SMTP id a78-v6mr5761383ljb.106.1531958213971;
        Wed, 18 Jul 2018 16:56:53 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id h7-v6sm826584ljk.27.2018.07.18.16.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 16:56:53 -0700 (PDT)
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
Subject: [RFC PATCH 3/8] mtd: rawnand: ams-delta: Set port direction once per transfer
Date:   Thu, 19 Jul 2018 01:57:05 +0200
Message-Id: <20180718235710.18242-4-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In its current shape, the driver sets data port direction before each
byte read/write operation, even during multi-byte transfers.  Optimize
that by setting the port direction only on first byte of each transfer.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 42 ++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 6ac38e9cfa1a..dfefcd79b420 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -72,50 +72,72 @@ static const struct mtd_partition partition_info[] = {
 	  .size		=  3 * SZ_256K },
 };
 
-static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
+static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
 {
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
-	void __iomem *io_base = priv->io_base;
 
-	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
 	writew(byte, this->IO_ADDR_W);
 	gpiod_set_value(priv->gpiod_nwe, 0);
 	ndelay(40);
 	gpiod_set_value(priv->gpiod_nwe, 1);
 }
 
-static u_char ams_delta_read_byte(struct mtd_info *mtd)
+static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
 {
-	u_char res;
 	struct nand_chip *this = mtd_to_nand(mtd);
 	struct ams_delta_nand *priv = nand_get_controller_data(this);
 	void __iomem *io_base = priv->io_base;
 
+	writew(0, io_base + OMAP_MPUIO_IO_CNTL);
+
+	ams_delta_write_next_byte(mtd, byte);
+}
+
+static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	u_char res;
+
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
-	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
 	res = readw(this->IO_ADDR_R);
 	gpiod_set_value(priv->gpiod_nre, 1);
 
 	return res;
 }
 
+static u_char ams_delta_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *this = mtd_to_nand(mtd);
+	struct ams_delta_nand *priv = nand_get_controller_data(this);
+	void __iomem *io_base = priv->io_base;
+
+	writew(~0, io_base + OMAP_MPUIO_IO_CNTL);
+
+	return ams_delta_read_next_byte(mtd);
+}
+
 static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
 				int len)
 {
 	int i;
 
-	for (i=0; i<len; i++)
-		ams_delta_write_byte(mtd, buf[i]);
+	if (len > 0)
+		ams_delta_write_byte(mtd, buf[0]);
+	for (i = 1; i < len; i++)
+		ams_delta_write_next_byte(mtd, buf[i]);
 }
 
 static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
 {
 	int i;
 
-	for (i=0; i<len; i++)
-		buf[i] = ams_delta_read_byte(mtd);
+	if (len > 0)
+		buf[0] = ams_delta_read_byte(mtd);
+	for (i = 1; i < len; i++)
+		buf[i] = ams_delta_read_next_byte(mtd);
 }
 
 /*
-- 
2.16.4

