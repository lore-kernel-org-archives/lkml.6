Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63823C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A57C20878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A57C20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeLCMT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:19:29 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46039 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:19:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so11126665ljd.12;
        Mon, 03 Dec 2018 04:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VuiEaW0Oj53yp3q4uxN2C3Fqx50TMkjVvsBbGOjHZUY=;
        b=p+a9KN07rlsH7xqyVQpQHhYcO+vL9ATVT69fkFQMES90aHXI7YybK2cRZvnASqVnuu
         tL29iGGRG9bF8WWjymK6hzPc59mZ3nvXbOL7ABe3XgIy+ry9TzaFuk1IJHya3HIah9xR
         NALJpPXXhdMnDL0NGZxUeeIlD5BzqE6EgR1MP+MTq/E/M+Mgn2qXAdgVYcv6L3df7NA8
         9xPCyUzHDj7SfXvf58bw1wTutiuXiSMt4qqM4imAsF5UjIPejb+JB1reM2KNRLsiqWDA
         wgLMsTVNLV70OtDE2DUZS2mMIkIrLfjRRm0Xo5shbiKPal+xRTiEYXcSubpVk/AyS8JO
         vWuA==
X-Gm-Message-State: AA+aEWaKHOOKQ4irTsSEN/7zNwTOubyg6O97pbbOMSVn8pO2NiBzSzUG
        sfLZFQ/7ubovKmGugFvoHl8=
X-Google-Smtp-Source: AFSGD/XA0By5ECSehpqZO8rpWGHa5fzid7ZDNrkXSvC063FdQgEuCV198/ybPvKkV2wyFX5cxcZkuQ==
X-Received: by 2002:a2e:9b52:: with SMTP id o18-v6mr9879341ljj.108.1543839517681;
        Mon, 03 Dec 2018 04:18:37 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h85-v6sm2478439ljf.68.2018.12.03.04.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 04:18:37 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:18:24 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, lee.jones@linaro.org,
        pombredanne@nexb.com, sjhuang@iluvatar.ai, akshu.agrawal@amd.com,
        djkurtz@chromium.org, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/9] clk: of_clk - add managed provider registrations
Message-ID: <72d98b6f8deca66d4182c37669ec4421977922b3.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MFD devices the clk properties may be contained in MFD (parent) DT
node. Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD
subdevice not to MFD device (parent). Add
devm_of_clk_add_hw_provider_parent to tackle this issue.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 Documentation/driver-model/devres.txt |  1 +
 drivers/clk/clk.c                     | 65 ++++++++++++++++++++++++++++++-----
 include/linux/clk-provider.h          | 11 ++++++
 3 files changed, 68 insertions(+), 9 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index dbf14326243b..97c9c575b2af 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -238,6 +238,7 @@ CLOCK
   devm_clk_put()
   devm_clk_hw_register()
   devm_of_clk_add_hw_provider()
+  devm_of_clk_add_parent_hw_provider()
   devm_clk_hw_register_clkdev()
 
 DMA
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index af011974d4ec..30beb60bd8f9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3893,12 +3893,12 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
 	of_clk_del_provider(*(struct device_node **)res);
 }
 
-int devm_of_clk_add_hw_provider(struct device *dev,
+static int __devm_of_clk_add_hw_provider(struct device *dev,
 			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 					      void *data),
-			void *data)
+			struct device_node *of_node, void *data)
 {
-	struct device_node **ptr, *np;
+	struct device_node **ptr;
 	int ret;
 
 	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
@@ -3906,19 +3906,62 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 	if (!ptr)
 		return -ENOMEM;
 
-	np = dev->of_node;
-	ret = of_clk_add_hw_provider(np, get, data);
-	if (!ret) {
-		*ptr = np;
+	*ptr = of_node;
+	ret = of_clk_add_hw_provider(of_node, get, data);
+	if (!ret)
 		devres_add(dev, ptr);
-	} else {
+	else
 		devres_free(ptr);
-	}
 
 	return ret;
 }
+
+/**
+ * devm_of_clk_add_hw_provider() - Managed clk provider node registration
+ * @dev: Device acting as the clock provider. Used for DT node and lifetime.
+ * @get: callback for decoding clk_hw
+ * @data: context pointer for @get callback.
+ *
+ * Returns 0 on success or an errno on failure.
+ *
+ * Registers clock provider for given device's node. Provider is automatically
+ * released at device exit.
+ */
+int devm_of_clk_add_hw_provider(struct device *dev,
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+					      void *data),
+			void *data)
+{
+	return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, data);
+}
 EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
 
+/**
+ * devm_of_clk_add_parent_hw_provider() - Managed clk provider node registration
+ * @dev: Device acting as the clock provider. Provider's DT node is parent node.
+ * @get: callback for decoding clk_hw
+ * @data: context pointer for @get callback.
+ *
+ * Returns 0 on success or an errno on failure.
+ *
+ * Registers clock provider for given device's parent node. Usable in cases
+ * where it really is the parent node that contains the provider information.
+ * Typical use-cases are MFD devices where the MFD sub-device is handling
+ * actual clock HW but the MFD node (parent) is containing the clock
+ * information.
+ *
+ * Provider is automatically released at device exit.
+ */
+int devm_of_clk_add_parent_hw_provider(struct device *dev,
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+					      void *data),
+			void *data)
+{
+	return __devm_of_clk_add_hw_provider(dev, get, dev->parent->of_node,
+					     data);
+}
+EXPORT_SYMBOL_GPL(devm_of_clk_add_parent_hw_provider);
+
 /**
  * of_clk_del_provider() - Remove a previously registered clock provider
  * @np: Device node pointer associated with clock provider
@@ -3950,6 +3993,10 @@ static int devm_clk_provider_match(struct device *dev, void *res, void *data)
 	return *np == data;
 }
 
+/**
+ * devm_of_clk_del_provider() - Remove clock provider registered using devm
+ * @dev: Device to whose lifetime the clock provider was bound
+ */
 void devm_of_clk_del_provider(struct device *dev)
 {
 	int ret;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 60c51871b04b..a6663f084cf1 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -916,6 +916,10 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
 						 void *data),
 			   void *data);
+int devm_of_clk_add_parent_hw_provider(struct device *dev,
+			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+						 void *data),
+			   void *data);
 void of_clk_del_provider(struct device_node *np);
 void devm_of_clk_del_provider(struct device *dev);
 struct clk *of_clk_src_simple_get(struct of_phandle_args *clkspec,
@@ -953,6 +957,13 @@ static inline int devm_of_clk_add_hw_provider(struct device *dev,
 {
 	return 0;
 }
+static inline int devm_of_clk_add_parent_hw_provider(struct device *dev,
+			   struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+						 void *data),
+			   void *data)
+{
+	return 0;
+}
 static inline void of_clk_del_provider(struct device_node *np) {}
 static inline void devm_of_clk_del_provider(struct device *dev) {}
 static inline struct clk *of_clk_src_simple_get(
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
