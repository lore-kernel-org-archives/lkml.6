Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392FBC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEA227040
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEA227040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934332AbeF1HzM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:55:12 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41219 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753532AbeF1HzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:55:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id a17-v6so597035ljd.8;
        Thu, 28 Jun 2018 00:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bq0ri43tkI1v4pJyBVVvjGBURnL+75EpmDcRjTTfbEs=;
        b=nbeBXbIdKJc75XVvOfNcZvz3gsthK2OCgk4dPZ5ZLoul3lIgyjAgwDS6FbheIDmTVT
         hCOZ+B7m0vBAAIWutoh/heDBp3CcyWZcRNHCdMTU4Nw96S+EXcTX3gjkv/iwEGbWhIJt
         VGzORq+ho2Uqp4UxhQIYxVqGJxnWEUWkaWFF0Nzih5cVkyhWgXksGAKtc1Te+uKvJhAM
         8NyJVUOgFiEHHWhN0QgwX8JmoiWuSgRvZX/S8KC8BK2NE1GRc8WAc68DG3EAl+QoP+6O
         bEztdo9K7yyhwTr6dZsaHFsa3hDZrvFc6t2qEPhWHvNnAK9H2qK5scEnZexpnl1nxSXS
         cXYA==
X-Gm-Message-State: APt69E3biHDmmUnWybCiFQAqAoaW/ZAiKFPQDjw7y1yUywO/DVcrZWdu
        CMA3jjEHWX6MJf/OipFcC4o=
X-Google-Smtp-Source: AAOMgpfzXLh+oekNRlle4rOfpxu9xIJAH+TQgh2Mk9QqxyeRT7StJ4fRFXZOkgcEp5bXW3fUwBVUuQ==
X-Received: by 2002:a2e:99c7:: with SMTP id l7-v6mr6717833ljj.148.1530172506417;
        Thu, 28 Jun 2018 00:55:06 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y5-v6sm1165862lfy.94.2018.06.28.00.55.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 00:55:05 -0700 (PDT)
Date:   Thu, 28 Jun 2018 10:54:53 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     linux@armlinux.org.uk, sboyd@codeaurora.org,
        matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH] clk: clkdev - add managed versions of lookup registrations
Message-ID: <20180628075453.GA7793@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devm_clk_hw_register_clkdev, devm_clk_register_clkdev and
devm_clk_release_clkdev as a first styep to clean up drivers which are
leaking clkdev lookups at driver remove.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

While searching for example on how clk drivers release clkdev at exit
I found that many of those don't. Simple grep for clkdev under
drivers/clk suggest that bunch of drivers which call clk_register_clkdev
or clk_hw_register_clkdev never call clkdev_drop. In order to help
cleaning this up I decided to add devm versions of clk_register_clkdev
and clk_hw_register_clkdev. I hope this would allow simply converting
bunch of calls to clk_register_clkdev and clk_hw_register_clkdev into
managed versions without building further clean up logic.

Please review this carefully. I have only performed some simple tests
with my BD71837 driver. And as I have only limited understanding on
clkdev lookups I may have done mistakes. Thanks!

 drivers/clk/clkdev.c   | 165 +++++++++++++++++++++++++++++++++++++++++--------
 include/linux/clkdev.h |   8 +++
 2 files changed, 147 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 7513411140b6..4752a0004a6c 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -390,7 +390,7 @@ void clkdev_drop(struct clk_lookup *cl)
 }
 EXPORT_SYMBOL(clkdev_drop);
 
-static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
+static struct clk_lookup *do_clk_register_clkdev(struct clk_hw *hw,
 						const char *con_id,
 						const char *dev_id, ...)
 {
@@ -404,6 +404,24 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
 	return cl;
 }
 
+static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
+	const char *con_id, const char *dev_id)
+{
+	struct clk_lookup *cl;
+
+	/*
+	 * Since dev_id can be NULL, and NULL is handled specially, we must
+	 * pass it as either a NULL format string, or with "%s".
+	 */
+	if (dev_id)
+		cl = do_clk_register_clkdev(hw, con_id, "%s",
+					   dev_id);
+	else
+		cl = do_clk_register_clkdev(hw, con_id, NULL);
+
+	return cl;
+}
+
 /**
  * clk_register_clkdev - register one clock lookup for a struct clk
  * @clk: struct clk to associate with all clk_lookups
@@ -421,22 +439,18 @@ static struct clk_lookup *__clk_register_clkdev(struct clk_hw *hw,
 int clk_register_clkdev(struct clk *clk, const char *con_id,
 	const char *dev_id)
 {
-	struct clk_lookup *cl;
-
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
+	int rval = 0;
 
-	/*
-	 * Since dev_id can be NULL, and NULL is handled specially, we must
-	 * pass it as either a NULL format string, or with "%s".
-	 */
-	if (dev_id)
-		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, "%s",
-					   dev_id);
-	else
-		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, NULL);
+	if (IS_ERR(clk)) {
+		rval = PTR_ERR(clk);
+	} else {
+		struct clk_lookup *cl;
 
-	return cl ? 0 : -ENOMEM;
+		cl = __clk_register_clkdev(__clk_get_hw(clk), con_id, dev_id);
+		if (!cl)
+			rval = -ENOMEM;
+	}
+	return rval;
 }
 EXPORT_SYMBOL(clk_register_clkdev);
 
@@ -456,21 +470,120 @@ EXPORT_SYMBOL(clk_register_clkdev);
  */
 int clk_hw_register_clkdev(struct clk_hw *hw, const char *con_id,
 	const char *dev_id)
+{
+	int rval = 0;
+
+	if (IS_ERR(hw)) {
+		rval = PTR_ERR(hw);
+	} else {
+		struct clk_lookup *cl;
+
+		cl = __clk_register_clkdev(hw, con_id, dev_id);
+		if (!cl)
+			rval = -ENOMEM;
+	}
+
+	return rval;
+}
+EXPORT_SYMBOL(clk_hw_register_clkdev);
+
+static void devm_clkdev_release(struct device *dev, void *res)
+{
+	clkdev_drop(*(struct clk_lookup **)res);
+}
+
+static int devm_clk_match_clkdev(struct device *dev, void *res, void *data)
+{
+	struct clk_lookup **l = res;
+
+	if (!l || !*l) {
+		WARN_ON(!l || !*l);
+		return 0;
+	}
+
+	return *l == data;
+}
+
+/**
+ * devm_clk_release_clkdev - Resource managed clkdev lookup release
+ * @dev: device this lookup is bound
+ * @con_id: connection ID string on device
+ * @dev_id: format string describing device name
+ *
+ * Drop the clkdev lookup created with devm_clk_hw_register_clkdev or
+ * with devm_clk_register_clkdev. Normally this function will not need to be
+ * called and the resource management code will ensure that the resource is
+ * freed.
+ */
+void devm_clk_release_clkdev(struct device *dev, const char *con_id,
+			     const char *dev_id)
 {
 	struct clk_lookup *cl;
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
+	struct clk_lookup **cl = NULL;
 
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
+	cl = devres_alloc(devm_clkdev_release, sizeof(*cl), GFP_KERNEL);
+	if (cl) {
+		*cl = __clk_register_clkdev(hw, con_id, dev_id);
+		if (*cl)
+			devres_add(dev, cl);
+		else
+			devres_free(cl);
+	}
+	return (cl && *cl) ? 0 : -ENOMEM;
+}
+EXPORT_SYMBOL(devm_clk_hw_register_clkdev);
 
-	/*
-	 * Since dev_id can be NULL, and NULL is handled specially, we must
-	 * pass it as either a NULL format string, or with "%s".
-	 */
-	if (dev_id)
-		cl = __clk_register_clkdev(hw, con_id, "%s", dev_id);
-	else
-		cl = __clk_register_clkdev(hw, con_id, NULL);
-
-	return cl ? 0 : -ENOMEM;
+/**
+ * devm_clk_register_clkdev - managed clk lookup registration for a struct clk
+ * @dev: device this lookup is bound
+ * @clk: struct clk to associate with all clk_lookups
+ * @con_id: connection ID string on device
+ * @dev_id: string describing device name
+ *
+ * con_id or dev_id may be NULL as a wildcard, just as in the rest of
+ * clkdev.
+ *
+ * To make things easier for mass registration, we detect error clks
+ * from a previous clk_register() call, and return the error code for
+ * those.  This is to permit this function to be called immediately
+ * after clk_register().
+ */
+int devm_clk_register_clkdev(struct device *dev, struct clk *clk,
+			     const char *con_id, const char *dev_id)
+{
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	return devm_clk_hw_register_clkdev(dev, __clk_get_hw(clk), con_id,
+					   dev_id);
 }
-EXPORT_SYMBOL(clk_hw_register_clkdev);
+EXPORT_SYMBOL(devm_clk_register_clkdev);
diff --git a/include/linux/clkdev.h b/include/linux/clkdev.h
index 4890ff033220..27ebeae8ae26 100644
--- a/include/linux/clkdev.h
+++ b/include/linux/clkdev.h
@@ -52,4 +52,12 @@ int clk_add_alias(const char *, const char *, const char *, struct device *);
 int clk_register_clkdev(struct clk *, const char *, const char *);
 int clk_hw_register_clkdev(struct clk_hw *, const char *, const char *);
 
+int devm_clk_register_clkdev(struct device *dev, struct clk *clk,
+			     const char *con_id, const char *dev_id);
+int devm_clk_hw_register_clkdev(struct device *dev, struct clk_hw *hw,
+				const char *con_id, const char *dev_id);
+void devm_clk_release_clkdev(struct device *dev, const char *con_id,
+			     const char *dev_id);
+
+
 #endif
-- 
2.14.3

