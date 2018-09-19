Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656ADECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133CF20867
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikzmAEGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133CF20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbeITEBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:01:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44557 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732890AbeITEBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:01:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so3296202plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=rxiJu/KT0VOL6VfChRrYVDga8+0QfxrCXpVuzdXnBO4=;
        b=ikzmAEGB42Zj3XDq48lFhnbEIA+c4LuNJVaQsujEHiXSx6BS3+oapROn/ZkNBKiMsm
         wL4GwkY2G66JLWmNNyTaeOCduCVoUZmepJKZnaevA7P+ckL6+5JviKqvH9Zx+I9CsaJi
         hdOJHWpo9kSX+XGRMIkbSJyIAzaYlAjN9Ktm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=rxiJu/KT0VOL6VfChRrYVDga8+0QfxrCXpVuzdXnBO4=;
        b=ZpUK5MO3ntm4WLVzKCKsIh7zRwEgPpBWI5F4w29MmJjH/fI9UORgAy/Yc1EoL44bU+
         Re0GoK3406kcE0RX3iq8lcFBbaOFywK3tO9XvFuBeulrx8zik9ZkhZ/lISlFL7mcxeIi
         ENB0VJtZl0BYIu5sn8m+kYZqyxV+23VHprCbGzuvYMfopMONNEujvAHLuA2KPsW8wApN
         /18PNg6/YdT7ylK+ptEYrz4SWemKHAoivgAlbByp8wLvaSXNVeCrUpeOuyj6zaShWbpp
         8pGOAhmrraYRSMJtHaSMuBm46DSzZwJ0WpdXEnJe2ausxSPWYhwLUqxq6EEd4F16LXrE
         el1w==
X-Gm-Message-State: APzg51AHQbdedceSzGTILpJtKVsAa8ckjQ+jMj3FXAJEJ2UemaHvYFAv
        NJLcalAEli1OWD19NY4ku1bPrw==
X-Google-Smtp-Source: ANB0Vdb1TvlsFQtZY6IiAI98YjFGq2CzW61mBkfyyMzKE/e+pYkZ2uKkBNe+evlmoAZbtbSHpHLPkg==
X-Received: by 2002:a17:902:8a92:: with SMTP id p18-v6mr36016518plo.148.1537395660158;
        Wed, 19 Sep 2018 15:21:00 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id w81-v6sm41086185pfk.92.2018.09.19.15.20.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:59 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/12] OPP: Prevent creating multiple OPP tables for devices sharing OPP nodes
Date:   Wed, 19 Sep 2018 15:20:30 -0700
Message-Id: <faf830f8d0612a2fa03144f09c9243f4c292400f.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When two or more devices are sharing their clock and voltage rails, they
share the same OPP table. But there are some corner cases where the OPP
core incorrectly creates separate OPP tables for them.

For example, CPU 0 and 1 share clock/voltage rails. The platform
specific code calls dev_pm_opp_set_regulators() for CPU0 and the OPP
core creates an OPP table for it (the individual OPPs aren't initialized
as of now). The same is repeated for CPU1 then. Because
_opp_get_opp_table() doesn't compare DT node pointers currently, it
fails to find the link between CPU0 and CPU1 and so creates a new OPP
table.

Fix this by calling _managed_opp() from _opp_get_opp_table().
_managed_opp() gain an additional argument (index) to get the right node
pointer. This resulted in simplifying code in _of_add_opp_table_v2() as
well.

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 25 ++++++++++++++++++++++---
 drivers/opp/of.c   | 35 +++++++++++++----------------------
 drivers/opp/opp.h  |  2 ++
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index d3e33fd32694..aaef20cf4df2 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -759,8 +759,8 @@ static void _remove_opp_dev(struct opp_device *opp_dev,
 	kfree(opp_dev);
 }
 
-struct opp_device *_add_opp_dev(const struct device *dev,
-				struct opp_table *opp_table)
+struct opp_device *_add_opp_dev_unlocked(const struct device *dev,
+					 struct opp_table *opp_table)
 {
 	struct opp_device *opp_dev;
 	int ret;
@@ -772,7 +772,6 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	/* Initialize opp-dev */
 	opp_dev->dev = dev;
 
-	mutex_lock(&opp_table->lock);
 	list_add(&opp_dev->node, &opp_table->dev_list);
 
 	/* Create debugfs entries for the opp_table */
@@ -780,6 +779,17 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
 			__func__, ret);
+
+	return opp_dev;
+}
+
+struct opp_device *_add_opp_dev(const struct device *dev,
+				struct opp_table *opp_table)
+{
+	struct opp_device *opp_dev;
+
+	mutex_lock(&opp_table->lock);
+	opp_dev = _add_opp_dev_unlocked(dev, opp_table);
 	mutex_unlock(&opp_table->lock);
 
 	return opp_dev;
@@ -844,6 +854,15 @@ static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 	if (!IS_ERR(opp_table))
 		goto unlock;
 
+	opp_table = _managed_opp(dev, index);
+	if (opp_table) {
+		if (!_add_opp_dev_unlocked(dev, opp_table)) {
+			dev_pm_opp_put_opp_table(opp_table);
+			opp_table = NULL;
+		}
+		goto unlock;
+	}
+
 	opp_table = _allocate_opp_table(dev, index);
 
 unlock:
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ae0436eaa911..1ddef52c27fd 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -41,11 +41,14 @@ struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_opp_desc_node);
 
-static struct opp_table *_managed_opp(const struct device_node *np)
+struct opp_table *_managed_opp(struct device *dev, int index)
 {
 	struct opp_table *opp_table, *managed_table = NULL;
+	struct device_node *np;
 
-	mutex_lock(&opp_table_lock);
+	np = _opp_of_get_opp_desc_node(dev->of_node, index);
+	if (!np)
+		return NULL;
 
 	list_for_each_entry(opp_table, &opp_tables, node) {
 		if (opp_table->np == np) {
@@ -65,7 +68,7 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 		}
 	}
 
-	mutex_unlock(&opp_table_lock);
+	of_node_put(np);
 
 	return managed_table;
 }
@@ -401,30 +404,19 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 {
 	struct device_node *np;
 	struct opp_table *opp_table;
-	int ret = 0, count = 0, pstate_count = 0;
+	int ret, count = 0, pstate_count = 0;
 	struct dev_pm_opp *opp;
 
-	opp_table = _managed_opp(opp_np);
-	if (opp_table) {
-		/* OPPs are already managed */
-		if (!_add_opp_dev(dev, opp_table)) {
-			ret = -ENOMEM;
-			goto put_opp_table;
-		}
-
-		if (opp_table->parsed_static_opps) {
-			kref_get(&opp_table->list_kref);
-			return 0;
-		}
-
-		goto initialize_static_opps;
-	}
-
 	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
 	if (!opp_table)
 		return -ENOMEM;
 
-initialize_static_opps:
+	/* OPP table is already initialized for the device */
+	if (opp_table->parsed_static_opps) {
+		kref_get(&opp_table->list_kref);
+		return 0;
+	}
+
 	kref_init(&opp_table->list_kref);
 
 	/* We have opp-table node now, iterate over it and add OPPs */
@@ -466,7 +458,6 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
 
 put_list_kref:
 	_put_opp_list_kref(opp_table);
-put_opp_table:
 	dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index f9fbb7553fc4..9c6544b4f4f9 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -206,8 +206,10 @@ void _put_opp_list_kref(struct opp_table *opp_table);
 
 #ifdef CONFIG_OF
 void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
+struct opp_table *_managed_opp(struct device *dev, int index);
 #else
 static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
+static inline struct opp_table *_managed_opp(struct device *dev, int index) { return NULL; }
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.14.1

