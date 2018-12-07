Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FE0C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C3A208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 11:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C3A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbeLGLJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 06:09:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45908 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbeLGLJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 06:09:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so2697798lfa.12;
        Fri, 07 Dec 2018 03:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XpsSi0+yUp3jaVjKpWoYffPxMgxENs/oMkn95BNj54M=;
        b=QvsGsP/aO+Iig6nHt8iOp5l/V5stGJD2Zt5ytriYg01yPh18SLvqSfQknfLiZuhkth
         bgMyrDdIs0ViaSqcAc3CQB/AbpN4fAG5ql0CZQEkNBgddNxoRsY+1TsqWXG7DSWpLiAj
         2ZVgXKK7/hiKrFd55wDwggF2kBMmIEEDqr9Qd4Nc1SUCRsZ8YLdml3PCEsXkylu8G7UF
         f/m2PCJgTR8cVX6gbQbz9MPXfjiJwG8UyDZaE7S9UualMMY3e+Aah1So4nrVVoDT8eEH
         SVRVhZYA5ix1QOvoVxGScaokPrGHg7Th2btCBnptUBiZjpfQMbPzO8H8MhfTmNURZWLS
         cXyA==
X-Gm-Message-State: AA+aEWYpckeFS4kjyL2lhLaN1EufHkfazOHuoQj/PsaeOvVnLOANTyls
        RvnMxfP4vIYleZIlbN0W/bA=
X-Google-Smtp-Source: AFSGD/WhQp0STFv63bRo7DIho34LywT8ZBOhkrooIuEVt9GeMiSR0LpaxIDo5OkKHUZJzheGTqn+Qw==
X-Received: by 2002:a19:e601:: with SMTP id d1mr1098451lfh.71.1544180989196;
        Fri, 07 Dec 2018 03:09:49 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi. [84.253.205.125])
        by smtp.gmail.com with ESMTPSA id s24sm542384lfc.30.2018.12.07.03.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 03:09:48 -0800 (PST)
Date:   Fri, 7 Dec 2018 13:09:39 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        corbet@lwn.net, cw00.choi@samsung.com, krzk@kernel.org,
        b.zolnierkie@samsung.com, mturquette@baylibre.com,
        sboyd@kernel.org, linux@armlinux.org.uk, pombredanne@nexb.com,
        sre@kernel.org, vkoul@kernel.org, linux@roeck-us.net, pavel@ucw.cz,
        sjhuang@iluvatar.ai, andrew.smirnov@gmail.com,
        djkurtz@chromium.org, akshu.agrawal@amd.com,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v7 1/3] clkdev: add managed clkdev lookup registration
Message-ID: <eee936f2d49c17bf13f3fa355de5045e71f6cde3.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clkdev registration lacks of managed registration functions and it
seems few drivers do not drop clkdev lookups at exit. Add
devm_clk_hw_register_clkdev and devm_clk_release_clkdev to ease lookup
releasing at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 Documentation/driver-model/devres.txt |   1 +
 drivers/clk/clkdev.c                  | 111 +++++++++++++++++++++++++++-------
 include/linux/clkdev.h                |   4 ++
 3 files changed, 93 insertions(+), 23 deletions(-)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index 43681ca0837f..dbf14326243b 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -238,6 +238,7 @@ CLOCK
   devm_clk_put()
   devm_clk_hw_register()
   devm_of_clk_add_hw_provider()
+  devm_clk_hw_register_clkdev()
 
 DMA
   dmaenginem_async_device_register()
diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..4621f8a91fc0 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -401,6 +401,23 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
 	return cl;
 }
 
+static int do_clk_register_clkdev(struct clk_hw *hw,
+	struct clk_lookup **cl, const char *con_id, const char *dev_id)
+{
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	/*
+	 * Since dev_id can be NULL, and NULL is handled specially, we must
+	 * pass it as either a NULL format string, or with "%s".
+	 */
+	if (dev_id)
+		*cl = __clk_register_clkdev(hw, con_id, "%s", dev_id);
+	else
+		*cl = __clk_register_clkdev(hw, con_id, NULL);
+
+	return *cl ? 0 : -ENOMEM;
+}
+
 /**
  * clk_register_clkdev - register one clock lookup for a struct clk
  * @clk: struct clk to associate with all clk_lookups
@@ -423,17 +440,8 @@ int clk_register_clkdev(struct clk *clk, const char *con_id,
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
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
+	return do_clk_register_clkdev(__clk_get_hw(clk), &cl, con_id,
+					      dev_id);
 }
 EXPORT_SYMBOL(clk_register_clkdev);
 
@@ -456,18 +464,75 @@ int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
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
+			      devm_clk_match_clkdev, cl);
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
