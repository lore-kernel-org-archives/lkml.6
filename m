Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E8C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF85A224F1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NI840kbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF85A224F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934189AbeFUWnD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:43:03 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39499 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934080AbeFUWms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:42:48 -0400
Received: by mail-lf0-f68.google.com with SMTP id t2-v6so6617815lfd.6;
        Thu, 21 Jun 2018 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c9NV9dOMTYPsP4/sX7FCRBR0qzAOJybNywIA8RFbuZI=;
        b=NI840kbNGt/QIKBzM6pTijHAIqIJQP38yFSGVYJD0I1qZNTNDycpZKcWqt0clxOQjc
         5GRSTCTCBlS26Vd5zvxifJlr8E/OLnxYSJk5+OE0ZueigmLNaoKJIDz5jIQRrbZ7nSMM
         k41qQJc12LCGK+PmX94wBBhDGwP5rybvYxlNw3E+s77DvhXIIppsZPlJBv+wYgkrMuxo
         NtNJoCoPYHntqffsQ9WUz8Gry3NWaJIVsxvJszm90IwsNUE/ZlMkQlT1RWlwFGKNB0dx
         ahzgmzHgT4TmLpcV4bd4TGOeBzkFmHijXeSnxEfR38zDib8vJSS4nYHOBmbz3kgHFO2G
         Ibuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c9NV9dOMTYPsP4/sX7FCRBR0qzAOJybNywIA8RFbuZI=;
        b=DZo0BJYbZmypwlEDu/htyOZKH+E7Pn+G3wEc0knjjRsg/c4o81de/WOUKwFHM8eSp5
         6ffA7wk1HP8dvMpmQp50ORNUUeJliU9fbLebYLR5XetE8nuVV6QDDg/uNejZi10R4iFf
         lIkxvdeIoUk5Vj6Kegl3ZeDB2wK2ROs9P8XOQA/NjavMc1VHp3jNyZDWZSlSWdZIAIBf
         ptvc3NnNHcJevbFoOerdLw2L9JYuRMfDPCjAwBnl5yqXWDtKc2beBkUfe2PgcezohMs4
         OvcMptNSZ6v3cGm3xF4kEdgMGzkI6RU1cqvsn4Hb4Jm+s1FWL3BIx89GhMTDa2Z4lNL8
         7NrQ==
X-Gm-Message-State: APt69E2+898t2ZZAYC+Pzk2/uss+sev0BpsdxOrFAZwwYf6/LFeAbm9c
        4I7aazmmFmbhin6aEpuh1+o=
X-Google-Smtp-Source: ADUXVKKJlcPgfOizcSlOVj+xNWy1eTgjtc/fVWMrtM/nouhy/8ipBGDJyX/5PFE86fLdjmNBCBqkzA==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr17800119ljc.56.1529620966225;
        Thu, 21 Jun 2018 15:42:46 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1046153lje.18.2018.06.21.15.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 15:42:45 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S . Miller " <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 10/10] Input: ams_delta_serio: Get FIQ buffer from platform_data
Date:   Fri, 22 Jun 2018 00:41:28 +0200
Message-Id: <20180621224128.17623-10-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180621224128.17623-1-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exporting the FIQ buffer symbol to be used in
ams-delta-serio driver, pass it to the driver as platform_data.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: rebased on v4.18-rc1, no conflicts

 arch/arm/mach-omap1/ams-delta-fiq.c         |  6 +++---
 arch/arm/mach-omap1/board-ams-delta.c       |  8 ++++++++
 drivers/input/serio/ams_delta_serio.c       | 20 +++++++++++++-------
 include/linux/platform_data/ams-delta-fiq.h |  4 ----
 4 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 82ca4246a5e4..b0dc7ddf5877 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -40,8 +40,7 @@ static struct fiq_handler fh = {
  * keystrokes received from the qwerty keyboard.  See
  * <linux/platform_data/ams-delta-fiq.h> for details of offsets.
  */
-unsigned int fiq_buffer[1024];
-EXPORT_SYMBOL(fiq_buffer);
+static unsigned int fiq_buffer[1024];
 
 static struct irq_chip *irq_chip;
 static struct irq_data *irq_data[16];
@@ -203,9 +202,10 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip,
 	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
 	omap_writel(val, OMAP_IH1_BASE + offset);
 
-	/* Initialize serio device IRQ resource */
+	/* Initialize serio device IRQ resource and platform_data */
 	serio->resource[0].start = gpiod_to_irq(clk);
 	serio->resource[0].end = serio->resource[0].start;
+	serio->dev.platform_data = fiq_buffer;
 
 	/*
 	 * Since FIQ handler performs handling of GPIO registers for
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 84177ba3e39a..772892487827 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -520,6 +520,14 @@ static struct resource ams_delta_serio_resources[] = {
 static struct platform_device ams_delta_serio_device = {
 	.name		= "ams-delta-serio",
 	.id		= PLATFORM_DEVID_NONE,
+	.dev		= {
+		/*
+		 * Initialize .platform_data explicitly with NULL to
+		 * indicate it is going to be used.  It will be replaced
+		 * with FIQ buffer address as soon as FIQ is initialized.
+		 */
+		.platform_data = NULL,
+	},
 	.num_resources	= ARRAY_SIZE(ams_delta_serio_resources),
 	.resource	= ams_delta_serio_resources,
 };
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index c1f8226f172e..f8663d7891f2 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
 struct ams_delta_serio {
 	struct serio *serio;
 	struct regulator *vcc;
+	unsigned int *fiq_buffer;
 };
 
 static int check_data(struct serio *serio, int data)
@@ -66,22 +67,23 @@ static int check_data(struct serio *serio, int data)
 static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 {
 	struct ams_delta_serio *priv = dev_id;
-	int *circ_buff = &fiq_buffer[FIQ_CIRC_BUFF];
+	int *circ_buff = &priv->fiq_buffer[FIQ_CIRC_BUFF];
 	int data, dfl;
 	u8 scancode;
 
-	fiq_buffer[FIQ_IRQ_PEND] = 0;
+	priv->fiq_buffer[FIQ_IRQ_PEND] = 0;
 
 	/*
 	 * Read data from the circular buffer, check it
 	 * and then pass it on the serio
 	 */
-	while (fiq_buffer[FIQ_KEYS_CNT] > 0) {
+	while (priv->fiq_buffer[FIQ_KEYS_CNT] > 0) {
 
-		data = circ_buff[fiq_buffer[FIQ_HEAD_OFFSET]++];
-		fiq_buffer[FIQ_KEYS_CNT]--;
-		if (fiq_buffer[FIQ_HEAD_OFFSET] == fiq_buffer[FIQ_BUF_LEN])
-			fiq_buffer[FIQ_HEAD_OFFSET] = 0;
+		data = circ_buff[priv->fiq_buffer[FIQ_HEAD_OFFSET]++];
+		priv->fiq_buffer[FIQ_KEYS_CNT]--;
+		if (priv->fiq_buffer[FIQ_HEAD_OFFSET] ==
+		    priv->fiq_buffer[FIQ_BUF_LEN])
+			priv->fiq_buffer[FIQ_HEAD_OFFSET] = 0;
 
 		dfl = check_data(priv->serio, data);
 		scancode = (u8) (data >> 1) & 0xFF;
@@ -116,6 +118,10 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->fiq_buffer = pdev->dev.platform_data;
+	if (!priv->fiq_buffer)
+		return -EINVAL;
+
 	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
 	if (IS_ERR(priv->vcc)) {
 		err = PTR_ERR(priv->vcc);
diff --git a/include/linux/platform_data/ams-delta-fiq.h b/include/linux/platform_data/ams-delta-fiq.h
index dc0f835ea918..cf4589ccb720 100644
--- a/include/linux/platform_data/ams-delta-fiq.h
+++ b/include/linux/platform_data/ams-delta-fiq.h
@@ -55,8 +55,4 @@
 
 #define FIQ_CIRC_BUFF		30      /*Start of circular buffer */
 
-#ifndef __ASSEMBLER__
-extern unsigned int fiq_buffer[];
-#endif
-
 #endif
-- 
2.16.4

