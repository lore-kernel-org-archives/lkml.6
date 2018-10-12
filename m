Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1B0C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91192086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 16:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW5yjW2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91192086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeJMAAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:00:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36803 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbeJMAAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:00:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so14084498wrw.3;
        Fri, 12 Oct 2018 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vykvvw6z8KbAShDoVOxsMwloQTTl5qXhoxhjAjE5d9g=;
        b=SW5yjW2tEaz8ZRidld3eD8NjfVzgHQ2zZVrFnomqu9BFeMBMyZJUFY6SIXWmHaYLxv
         HZ1Ni2YxY/hUUhBSuWuwt5HVXx8JS67OE7Vwk9gan0n671FWoi9fVQz0Y7SanQvwU1et
         C+wnkzy07upy+c2jzQQRaebnhWoCHl6cKKCSEyrP6Zuszxlkrf4fo/dFX3TAtxj15Urn
         LjokB7mTlI2K10lqOpqTeNWU2n29sCqtkN+pd12R1vzuTcdB5iofmMEmsqYLNKHjiH6C
         /gUDZrjmrzW56QGuuTqy3Ht7d0waHa92g6UT7TVZLZSxz/8cg3qFUBWZef8J9Df48qK/
         lSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=vykvvw6z8KbAShDoVOxsMwloQTTl5qXhoxhjAjE5d9g=;
        b=fCc3Nj8KQT4aOmUp8k6dzK9n1ly+sbrVtmzwc5E6nueWXFTrmv3HaUUaAq09n5q23R
         nFGkOlw4WQltyguPPzmeMxL4OL3r59YfxR/p7DZPF93RvzBSo+RFzO+zWUMkPTJ5rZH9
         b3RUkyo+f6oQWh7n5u3ZsZKLdg1bMznrXB15Pewa7Q14EoPu+E8FG1se+ls0OBi7iPUH
         BykU1l7/2Em9fMU6S4zK9+dSiGB8v7uWZGmfPNIHFY5AvegN5xXE8Zz7YVCMXd5NtvvC
         BbirMLrZsUjZ5BpvwZiHUNB85VSZiUt2+DsKqlqmX4ak3evGWFjtPK18hT79ZQR90hu5
         C8uw==
X-Gm-Message-State: ABuFfohnwIuwfD6VnhvFbaRwmplquZxr8mdMhRwtlP0gNwnZQ+BhRtKC
        V6AwIsm7H7HSeCuLmqEAI+M=
X-Google-Smtp-Source: ACcGV61x0fa6UCmycpq05UXgdsZ+okuw+mzhgZNv1Nn2nput+CBbvgs68nZq3aQPxC/gsx+U0FE7pg==
X-Received: by 2002:adf:fe0f:: with SMTP id n15-v6mr5628051wrr.71.1539361613746;
        Fri, 12 Oct 2018 09:26:53 -0700 (PDT)
Received: from Sarah.corp.lairdtech.com ([109.174.151.67])
        by smtp.gmail.com with ESMTPSA id t198-v6sm1736842wmd.9.2018.10.12.09.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 09:26:52 -0700 (PDT)
From:   Ben Whitten <ben.whitten@gmail.com>
X-Google-Original-From: Ben Whitten <ben.whitten@lairdtech.com>
To:     afaerber@suse.de
Cc:     starnight@g.ncu.edu.tw, hasnain.virk@arm.com,
        netdev@vger.kernel.org, liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 lora-next 4/5] net: lora: sx125x: convert to regmap fields
Date:   Fri, 12 Oct 2018 17:26:05 +0100
Message-Id: <1539361567-3602-5-git-send-email-ben.whitten@lairdtech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Whitten <ben.whitten@gmail.com>

We convert to using regmap fields to allow regmap to take care of read
modify writes and bit shifting for ofset fields.

Signed-off-by: Ben Whitten <ben.whitten@gmail.com>
---
 drivers/net/lora/sx125x.c | 59 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/net/lora/sx125x.c b/drivers/net/lora/sx125x.c
index dc13d1a..36b61b1 100644
--- a/drivers/net/lora/sx125x.c
+++ b/drivers/net/lora/sx125x.c
@@ -25,11 +25,25 @@
 
 #include "sx125x.h"
 
-#define REG_CLK_SELECT_TX_DAC_CLK_SELECT_CLK_IN	BIT(0)
-#define REG_CLK_SELECT_CLK_OUT			BIT(1)
+enum sx125x_fields {
+	F_CLK_OUT,
+	F_TX_DAC_CLK_SEL,
+	F_SX1257_XOSC_GM_STARTUP,
+	F_SX1257_XOSC_DISABLE_CORE,
+};
+
+static const struct reg_field sx125x_regmap_fields[] = {
+	/* CLK_SELECT */
+	[F_CLK_OUT]        = REG_FIELD(SX125X_CLK_SELECT, 1, 1),
+	[F_TX_DAC_CLK_SEL] = REG_FIELD(SX125X_CLK_SELECT, 0, 0),
+	/* XOSC */ /* TODO maybe make this dynamic */
+	[F_SX1257_XOSC_GM_STARTUP]  = REG_FIELD(SX1257_XOSC, 0, 3),
+	[F_SX1257_XOSC_DISABLE_CORE]  = REG_FIELD(SX1257_XOSC, 5, 5),
+};
 
 struct sx125x_priv {
 	struct regmap		*regmap;
+	struct regmap_field     *regmap_fields[ARRAY_SIZE(sx125x_regmap_fields)];
 };
 
 static struct regmap_config __maybe_unused sx125x_regmap_config = {
@@ -44,11 +58,18 @@ static struct regmap_config __maybe_unused sx125x_regmap_config = {
 	.max_register = SX125X_MAX_REGISTER,
 };
 
+static int sx125x_field_write(struct sx125x_priv *priv,
+		enum sx125x_fields field_id, u8 val)
+{
+	return regmap_field_write(priv->regmap_fields[field_id], val);
+}
+
 static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap *regmap, unsigned int radio)
 {
 	struct sx125x_priv *priv;
 	unsigned int val;
 	int ret;
+	int i;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -56,6 +77,18 @@ static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap
 
 	dev_set_drvdata(dev, priv);
 	priv->regmap = regmap;
+	for (i = 0; i < ARRAY_SIZE(sx125x_regmap_fields); i++) {
+		const struct reg_field *reg_fields = sx125x_regmap_fields;
+
+		priv->regmap_fields[i] = devm_regmap_field_alloc(dev,
+				priv->regmap,
+				reg_fields[i]);
+		if (IS_ERR(priv->regmap_fields[i])) {
+			ret = PTR_ERR(priv->regmap_fields[i]);
+			dev_err(dev, "Cannot allocate regmap field: %d\n", ret);
+			return ret;
+		}
+	}
 
 	if (true) {
 		ret = regmap_read(priv->regmap, SX1255_VERSION, &val);
@@ -66,24 +99,34 @@ static int __maybe_unused sx125x_regmap_probe(struct device *dev, struct regmap
 		dev_info(dev, "SX125x version: %02x\n", val);
 	}
 
-	val = REG_CLK_SELECT_TX_DAC_CLK_SELECT_CLK_IN;
 	if (radio == 1) { /* HACK */
-		val |= REG_CLK_SELECT_CLK_OUT;
+		ret = sx125x_field_write(priv, F_CLK_OUT, 1);
+		if (ret) {
+			dev_err(dev, "enabling clock output failed\n");
+			return ret;
+		}
+
 		dev_info(dev, "enabling clock output\n");
 	}
 
-	ret = regmap_write(priv->regmap, SX125X_CLK_SELECT, val);
+	ret = sx125x_field_write(priv, F_TX_DAC_CLK_SEL, 1);
 	if (ret) {
-		dev_err(dev, "clk write failed\n");
+		dev_err(dev, "clock select failed\n");
 		return ret;
 	}
 
 	dev_dbg(dev, "clk written\n");
 
 	if (true) {
-		ret = regmap_write(priv->regmap, SX1257_XOSC, 13 + 2 * 16);
+		ret = sx125x_field_write(priv, F_SX1257_XOSC_DISABLE_CORE, 1);
+		if (ret) {
+			dev_err(dev, "xosc disable failed\n");
+			return ret;
+		}
+
+		ret = sx125x_field_write(priv, F_SX1257_XOSC_GM_STARTUP, 13);
 		if (ret) {
-			dev_err(dev, "xosc write failed\n");
+			dev_err(dev, "xosc startup adjust failed\n");
 			return ret;
 		}
 	}
-- 
2.7.4

