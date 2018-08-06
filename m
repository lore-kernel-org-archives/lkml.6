Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6757C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA26208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 22:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2N6qSTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA26208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbeHGAlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 20:41:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35199 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbeHGAk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 20:40:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id f18-v6so10225814lfc.2;
        Mon, 06 Aug 2018 15:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FDaMkIad0o9QzNTv2EARYdjQpGULA5HnpcmySlWm3i8=;
        b=O2N6qSTD6wcYUO5uf/sAtdsjHk+jMRgROxM64BeLFfqEax+Sd2rSsUJXBLoACFBcfU
         vpNekW03thHx+TO+4dBbmDjf2ARNzjZJ8OwQ2JmymgK+1PhoIzxi4XFh9k23tXNkeVvg
         R/uUcHgx02mbIEzP04Oerc0v2PIDWffK6wANRL7q1ngph2ViEoL9LEDoA7W496FeGGWy
         fDEOFe7qBJJOAxK5zUlkF+1u2agqRzLDQjvJ1yRepsL8yKJFWV99oaF+DF47sTpWYxgX
         BhOrFttIAwOnfZYjZuWzM/h2xNhw20WJknDy/Yd3cYox7qeKVDQ+D6qNwpfoF+0FY7d4
         Dgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FDaMkIad0o9QzNTv2EARYdjQpGULA5HnpcmySlWm3i8=;
        b=XCqM7J3M8OFMENwt9BO2WoX1MyR0fXST2ovOBJ16Bx/PwoJsOZTdMgRz0TywB0PuVm
         fYB8L3mkq+TVh6ui+Cq4hb9krNoHGvAs/CVgxd2ueoYRBZxQmTGX+PcbQ+R0LHgu3dbV
         Xk3FtuUt3TsewjfGxHeXnQDZocMOS0y34pLZWCWHFSytMKpjkDPCDCEL74ydPR2xUOnA
         QjIGMny081zM79t8Tydcvr3DXdTmunEZSTwNoh/kmc8q/uOnt1DRY6pB2U6JO9AJE7yV
         bbLH7Z/dqGzIoI0Q1SsYhveJG5GSvYyoHlSwuh91RpU2PPJQodawc1VqFjJ6Ttu5vtSY
         jweQ==
X-Gm-Message-State: AOUpUlGGSRtgx2XtVq6kI/o/0EhEmz2hQgu324HV1nGMCIakn5l+Rwo+
        oUqe+VJEwM1dtMQyEUxpKvU=
X-Google-Smtp-Source: AAOMgpciX3+0nE/8mArhut1MLp5m3pxfDitwVhtDsHuy0YeZFQlZ9DyC70LgedcTWPE5Cjl89pXqDA==
X-Received: by 2002:a19:b24e:: with SMTP id b75-v6mr11741465lff.11.1533594583186;
        Mon, 06 Aug 2018 15:29:43 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2438561ljc.67.2018.08.06.15.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 15:29:42 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH v2 11/12] mtd: rawnand: ams-delta: Use GPIO API bitmap extension
Date:   Tue,  7 Aug 2018 00:29:17 +0200
Message-Id: <20180806222918.12644-12-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180806222918.12644-1-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to address the driver performance issues by replacing traditional
get/set array function calls with their bitmap based equivalents.

As long as fast bitmap processing path is not implemented in the new
API extension, performance of the driver remains unchanged.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/mtd/nand/raw/ams-delta.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 30c461138195..7b08b2c441d3 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -78,15 +78,9 @@ static void ams_delta_write_commit(struct ams_delta_nand *priv)
 
 static void ams_delta_write_next_byte(struct ams_delta_nand *priv, u_char byte)
 {
-	struct gpio_descs *data_gpiods = priv->data_gpiods;
 	unsigned long bits = byte;
-	int i, value_array[data_gpiods->ndescs];
-
-	for (i = 0; i < data_gpiods->ndescs; i++)
-		value_array[i] = test_bit(i, &bits);
 
-	gpiod_set_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
-				  value_array);
+	gpiod_set_raw_array_bitmap(priv->data_gpiods, &bits);
 
 	ams_delta_write_commit(priv);
 }
@@ -106,22 +100,15 @@ static void ams_delta_write_first_byte(struct ams_delta_nand *priv, u_char byte)
 
 static u_char ams_delta_read_next_byte(struct ams_delta_nand *priv)
 {
-	struct gpio_descs *data_gpiods = priv->data_gpiods;
-	unsigned long bits = 0;
-	int i, value_array[data_gpiods->ndescs];
+	unsigned long bits;
 
 	gpiod_set_value(priv->gpiod_nre, 0);
 	ndelay(40);
 
-	gpiod_get_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
-				  value_array);
+	gpiod_get_raw_array_bitmap(priv->data_gpiods, &bits);
 
 	gpiod_set_value(priv->gpiod_nre, 1);
 
-	for (i = 0; i < data_gpiods->ndescs; i++)
-		if (value_array[i])
-			__set_bit(i, &bits);
-
 	return bits;
 }
 
-- 
2.16.4

