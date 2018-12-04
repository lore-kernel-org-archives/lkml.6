Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E05DC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AF120666
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AF120666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeLDLdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:33:20 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33358 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeLDLdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:33:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id v1-v6so14582842ljd.0;
        Tue, 04 Dec 2018 03:33:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XpsSi0+yUp3jaVjKpWoYffPxMgxENs/oMkn95BNj54M=;
        b=CD9y504UVSHnNp2Y4t+at9ItaMhcBklL073pbn+EyT1w8H4UfAPaPrELnG5vA1lp/Z
         6WxuNeZMH6//0iTaAudVEAVTo4zrHiOM8foV2dA9D1Q0K/fWSKVEbl86Zgw+MC+hHEDf
         hy5kxLp91TkNB3rw4niBLGdumKivOF/6wC9hFqNMopCZIfb+pW2Gud+sV6/FpSQIkycj
         3xS//C/ZtDmtcp480OoCrWbQzYNy9byg/NbUF46YpuSz6DC09BGu8DicBB3+p9SsL7Os
         78B8uNW38sz0Mw5DDeBYPvBKuUg0VvSaTheAS1HWvoqAncvexF+wiIqwcUEhit/11xEm
         8iIw==
X-Gm-Message-State: AA+aEWbuGhixT6iFlYhgXuSIaVvvlu1Q2E71YecuHPwZKgqGISwT9T64
        bwTPvek468M1Ck7qZXGgcJI=
X-Google-Smtp-Source: AFSGD/WPkBvSBuMZP3N2oL0/t5DVoibuBAbwXir6P0FkHm8sgEfBuH5XYSGFdlWjDq5IHDTVmojpIg==
X-Received: by 2002:a2e:4c0a:: with SMTP id z10-v6mr12482029lja.85.1543923194867;
        Tue, 04 Dec 2018 03:33:14 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k11-v6sm3067694ljk.40.2018.12.04.03.33.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:33:14 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:33:01 +0200
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
Subject: [PATCH v6 01/10] clkdev: add managed clkdev lookup registration
Message-ID: <5a1ce8dabda1994a050ed0b9095b3df1c4c2895f.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
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
