Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A8C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC6A2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC6A2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbeLDLfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:35:11 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34854 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeLDLfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:35:10 -0500
Received: by mail-lf1-f66.google.com with SMTP id e26so11701176lfc.2;
        Tue, 04 Dec 2018 03:35:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0RckClGYQ+6fUhKznGresT7KY8caowujFh1vtX39WAg=;
        b=Cfoyrhw/Sjo8DLR3e6Bk7+EJBEsV3RnUg3xurnHafdH+h5f0PVqg25Dh10y+Wsrc60
         LRamfuN+z9ttv2mjDeVxhgjxIFxmOOlJNU4VJz9AsJ+43GEMAd2yGXNtQN/5YHbcBWv7
         xqMCMt8yh/gfTO1TaKp2sO9vW53ajp8kdwz4eRs3tB+NxlaYhHzdHBjuOHtoVSeKjBRF
         0VSnWFFLAo0Ig3Tu+vaV1CovPokjWo/QCGEZJv/Lx8NDTcaiXX/EUW4GA5H1M80py8dP
         yJHtPCd+K3gfiQgxNJ2JyjJnl3SMjhRAPNAM1VcmGPXNg0G5VP/TcQNvfPdJY14OHEts
         yvUA==
X-Gm-Message-State: AA+aEWbNujN5H11Wx9VFC+MUpPGFT8sGmhLjFtnbkb9srWk1rRrx1VyB
        zKe+WAGFvcDZKaOWHqKS2Rg=
X-Google-Smtp-Source: AFSGD/UgenwKc3SIhW9D1jJ9m5flJIPZI+ng3DCVvFo6WFolegTKyZfQr7vyCVs8/MQiK0k8Dg08+g==
X-Received: by 2002:a19:6a13:: with SMTP id u19mr11029739lfu.46.1543923306734;
        Tue, 04 Dec 2018 03:35:06 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f11sm2937781lfi.12.2018.12.04.03.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:35:06 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:34:53 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 03/10] clk: of-provider: look at parent if registered
 device has no provider info
Message-ID: <a40442ad1a2f1d13798ba535eca371845bae9248.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to be usual for MFD devices that the created 'clock sub-device'
do not have own DT node. The clock provider information is usually in the
main device node which is owned by the MFD device. Change the devm variant
of clk of-provider registration to check the parent device node if given
device has no own node or if the node does not contain the #clock-cells
property. In such case use the parent node if it contains the #clock-cells.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 78c90913f987..66dc7c1483d7 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3893,6 +3893,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 
+static int of_is_clk_provider(struct device_node *np)
+{
+	return !!of_find_property(np, "#clock-cells", NULL);
+}
+
 /**
  * devm_of_clk_add_hw_provider() - Managed clk provider node registration
  * @dev: Device acting as the clock provider. Used for DT node and lifetime.
@@ -3901,8 +3906,11 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
  *
  * Returns 0 on success or an errno on failure.
  *
- * Registers clock provider for given device's node. Provider is automatically
- * released at device exit.
+ * Registers clock provider for given device's node. If the device has no DT
+ * node or if the device node lacks of clock provider information (#clock-cells)
+ * then the parent device's node is scanned for this information. If parent node
+ * has the #clock-cells then it is used in registration. Provider is
+ * automatically released at device exit.
  */
 int devm_of_clk_add_hw_provider(struct device *dev,
 			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
@@ -3912,12 +3920,17 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 	struct device_node **ptr, *np;
 	int ret;
 
+	np = dev->of_node;
+
+	if (!of_is_clk_provider(dev->of_node))
+		if (of_is_clk_provider(dev->parent->of_node))
+			np = dev->parent->of_node;
+
 	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
 			   GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 
-	np = dev->of_node;
 	ret = of_clk_add_hw_provider(np, get, data);
 	if (!ret) {
 		*ptr = np;
@@ -3968,9 +3981,15 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
 void devm_of_clk_del_provider(struct device *dev)
 {
 	int ret;
+	struct device_node *np;
+
+	np = dev->of_node;
 
+	if (!of_is_clk_provider(dev->of_node))
+		if (of_is_clk_provider(dev->parent->of_node))
+			np = dev->parent->of_node;
 	ret = devres_release(dev, devm_of_clk_release_provider,
-			     devm_clk_provider_match, dev->of_node);
+			     devm_clk_provider_match, np);
 
 	WARN_ON(ret);
 }
-- 
2.14.3
