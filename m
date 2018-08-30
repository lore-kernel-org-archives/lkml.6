Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B29C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B2E205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B2E205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeH3QRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:17:02 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43774 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeH3QRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:17:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id h64-v6so6975666lfi.10;
        Thu, 30 Aug 2018 05:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1MedcM4V+7dGcKaRYYIgXvFYAsYq2HqE222toUzVIdE=;
        b=PLYUGOc+7Quwijg2i8zDIhdG3VlSNUM7Xbz5KCEMoXHKb2n6c+TfJ0S6to8b6CtAhN
         s3gwlq1mR0s0cjkQxeEFgmko5A7j7Wj7Q49DwtdsWw1IfyOfL1PeYRHdWI/PLr+gAlnb
         EW4jDzQsURMTLqnfs5JyXU6BXmtECqUIQTNRLRSOhHf9a0ls8L4e9leBEfCy2WudX5xV
         OWPiXUnOJ39ryXKjuUaRr30xj1wSfBAQI9EB+GE6fR4VVjGQ+oj8FIKM5juUhfJNCmU5
         NoO1jq2ESu6yQbIcZaz7VOlApTQQ3YyaVbs3A4HJg3nZW0lFMKuPA17rSU2cQCP86Aaa
         sCuQ==
X-Gm-Message-State: APzg51DC/EoTZmke9Xw7Y8V6wi9Iy5mm9/vXwOIUglj8E5wox0/oi2Wj
        yqhc0h1YqYmP5pVHIifL2pU=
X-Google-Smtp-Source: ANB0VdYGWDOJRPvFkMw/Oymf6jH8vl4/MW+OnyraQ/eTyIeSTSm1iUwDQCeeatpHwieFSysd704zgQ==
X-Received: by 2002:a19:7118:: with SMTP id m24-v6mr6022572lfc.6.1535631308928;
        Thu, 30 Aug 2018 05:15:08 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b68-v6sm1224845ljb.62.2018.08.30.05.15.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 05:15:08 -0700 (PDT)
Date:   Thu, 30 Aug 2018 15:14:56 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     corbet@lwn.net, mturquette@baylibre.com, sboyd@kernel.org,
        linux@armlinux.org.uk, andrew.smirnov@gmail.com, robh@kernel.org,
        sre@kernel.org, linux@roeck-us.net, sjhuang@iluvatar.ai,
        matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH 1/2] clk: clkdev/of_clk - add managed lookup and provider
 registrations
Message-ID: <c066e49c13eff1405d142b100da6dcd1ae09530a.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1535630942.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With MFD devices the clk properties may be contained in MFD (parent) node.
Current devm_of_clk_add_hw_provider assumes the clk is bound to MFD subdevice
not to MFD device (parent). Add devm_of_clk_add_hw_provider_parent to tackle
this issue.

Also clkdev registration lacks of managed registration functions and it seems
quite many drivers do not drop clkdev lookups at exit. Add
devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
releasing at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 Documentation/driver-model/devres.txt |   3 +
 drivers/clk/clk.c                     |  28 ++++++--
 drivers/clk/clkdev.c                  | 122 ++++++++++++++++++++++++++--------
 include/linux/clk-provider.h          |   4 ++
 include/linux/clkdev.h                |   4 ++
 5 files changed, 129 insertions(+), 32 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 15720cd17958..20dac9ffd3e0 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -238,6 +238,9 @@ CLOCK
   devm_clk_put()
   devm_clk_hw_register()
   devm_of_clk_add_hw_provider()
+  devm_of_clk_add_parent_hw_provider()
+  devm_clk_hw_register_clkdev()
+  devm_clk_release_clkdev()
 
 DMA
   dmaenginem_async_device_register()
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d31055ae6ec6..fd0bc6421269 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3798,12 +3798,12 @@ static void devm_of_clk_release_provider(struct device *dev, void *res)
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
@@ -3811,10 +3811,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 	if (!ptr)
 		return -ENOMEM;
 
-	np = dev->of_node;
-	ret = of_clk_add_hw_provider(np, get, data);
+	*ptr = of_node;
+	ret = of_clk_add_hw_provider(of_node, get, data);
 	if (!ret) {
-		*ptr = np;
 		devres_add(dev, ptr);
 	} else {
 		devres_free(ptr);
@@ -3822,8 +3821,25 @@ int devm_of_clk_add_hw_provider(struct device *dev,
 
 	return ret;
 }
+int devm_of_clk_add_hw_provider(struct device *dev,
+			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
+					      void *data),
+			void *data)
+{
+	return __devm_of_clk_add_hw_provider(dev, get, dev->of_node, data);
+}
 EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);
 
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
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..f6100b6e06fd 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -401,6 +401,25 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
 	return cl;
 }
 
+static int do_clk_register_clkdev(struct clk_hw *hw,
+	struct clk_lookup **cl, const char *con_id, const char *dev_id)
+{
+
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	/*
+	 * Since dev_id can be NULL, and NULL is handled specially, we must
+	 * pass it as either a NULL format string, or with "%s".
+	 */
+	if (dev_id)
+		*cl = __clk_register_clkdev(hw, con_id, "%s",
+					   dev_id);
+	else
+		*cl = __clk_register_clkdev(hw, con_id, NULL);
+
+	return *cl ? 0 : -ENOMEM;
+}
+
 /**
  * clk_register_clkdev - register one clock lookup for a struct clk
  * @clk: struct clk to associate with all clk_lookups
@@ -420,20 +439,10 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
 {
 	struct clk_lookup *cl;
 
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	/*
-	 * Since dev_id can be NULL, and NULL is handled specially, we must
-	 * pass it as either a NULL format string, or with "%s".
-	 */
-	if (dev_id)
-		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, "%s",
-					   dev_id);
-	else
-		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, NULL);
-
-	return cl ? 0 : -ENOMEM;
+	if (!IS_ERR(clk))
+		return do_clk_register_clkdev(__clk_get_hw(clk), &cl, con_id,
+					      dev_id);
+	return PTR_ERR(clk);
 }
 EXPORT_SYMBOL(clk_register_clkdev);
 
@@ -456,18 +465,79 @@ int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
 {
 	struct clk_lookup *cl;
 
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
+	return do_clk_register_clkdev(hw, &cl, con_id, dev_id);
+}
+EXPORT_SYMBOL(clk_hw_register_clkdev);
 
-	/*
-	 * Since dev_id can be NULL, and NULL is handled specially, we must
-	 * pass it as either a NULL format string, or with "%s".
-	 */
-	if (dev_id)
-		cl = __clk_register_clkdev(hw, con_id, "%s", dev_id);
-	else
-		cl = __clk_register_clkdev(hw, con_id, NULL);
+static void devm_clkdev_release(struct device *dev, void *res)
+{
+	clkdev_drop(*(struct clk_lookup **)res);
+}
 
-	return cl ? 0 : -ENOMEM;
+static int devm_clk_match_clkdev(struct device *dev, void *res, void *data)
+{
+	struct clk_lookup **l = res;
+
+	if (!l || !*l) {
+		WARN_ON(!l || !*l);
+		return 0;
+	}
+	return *l == data;
 }
-EXPORT_SYMBOL(clk_hw_register_clkdev);
+
+/**
+ * devm_clk_release_clkdev - Resource managed clkdev lookup release
+ * @dev: device this lookup is bound
+ * @con_id: connection ID string on device
+ * @dev_id: format string describing device name
+ *
+ * Drop the clkdev lookup created with devm_clk_hw_register_clkdev.
+ * Normally this function will not need to be called and the resource
+ * management code will ensure that the resource is freed.
+ */
+void devm_clk_release_clkdev(struct device *dev, const char *con_id,
+			     const char *dev_id)
+{
+	struct clk_lookup *cl;
+	int rval;
+
+	cl = clk_find(dev_id, con_id);
+	WARN_ON(!cl);
+	rval = devres_release(dev, devm_clkdev_release,
+			      &devm_clk_match_clkdev, cl);
+	WARN_ON(rval);
+}
+EXPORT_SYMBOL(devm_clk_release_clkdev);
+
+/**
+ * devm_clk_hw_register_clkdev - managed clk lookup registration for clk_hw
+ * @dev: device this lookup is bound
+ * @hw: struct clk_hw to associate with all clk_lookups
+ * @con_id: connection ID string on device
+ * @dev_id: format string describing device name
+ *
+ * con_id or dev_id may be NULL as a wildcard, just as in the rest of
+ * clkdev.
+ *
+ * To make things easier for mass registration, we detect error clk_hws
+ * from a previous clk_hw_register_*() call, and return the error code for
+ * those.  This is to permit this function to be called immediately
+ * after clk_hw_register_*().
+ */
+int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
+				const char *con_id, const char *dev_id)
+{
+	int rval = -ENOMEM;
+	struct clk_lookup **cl;
+
+	cl = devres_alloc(devm_clkdev_release, sizeof(*cl), GFP_KERNEL);
+	if (cl) {
+		rval = do_clk_register_clkdev(hw, cl, con_id, dev_id);
+		if (!rval)
+			devres_add(dev, cl);
+		else
+			devres_free(cl);
+	}
+	return rval;
+}
+EXPORT_SYMBOL(devm_clk_hw_register_clkdev);
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa70a38d..94f9bae6490a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -909,6 +909,10 @@ int devm_of_clk_add_hw_provider(struct device *dev,
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
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 4890ff033220..ccb32af5848b 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -52,4 +52,8 @@ int clk_add_alias(const char *, const char *, const char *, struct device *);
 int clk_register_clkdev(struct clk *, const char *, const char *);
 int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
 
+int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
+				const char *con_id, const char *dev_id);
+void devm_clk_release_clkdev(struct device *dev, const char *con_id,
+			     const char *dev_id);
 #endif
-- 
2.14.3

