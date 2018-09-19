Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299B9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC0D20867
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7qKUtGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC0D20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbeITEAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:00:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36810 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeITEAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id p5-v6so3305976plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+qw1WHdkun9NT16a0EkMQe8eVOqrEPq24qtM3EnA0WM=;
        b=N7qKUtGRcs8B8Xx/g9uYzFVy1r8dhJsiLpibsY278uGTZ/Argo3cU52+D0Tu52336f
         9P5KRj/dchx8/qRWJ9lhmvRj/SqI/QJaF19LpniElgWN472BjJwdMSor+5GDMNK9RH6v
         VoQzaSlIL7MZK1v3CR48y8VppWW3aOnAbqctk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+qw1WHdkun9NT16a0EkMQe8eVOqrEPq24qtM3EnA0WM=;
        b=omo9Q3PEt6iPUv1dGHR0cUX2Ar9CNNGt3hB6Wc3XtY0x24+PH7Nz4zXvPEOm5RBA0C
         s56rfu9G3jrN7BoTQZPGOsVQQp6W0dYHLyK/+U0q+CGhz31qHc2EyOqZMwo4Dgxi6zPk
         gA8AfQTO7Bg5FOklvVGDYDiTpRIrMOkiFVJCAIFgtGXD+YiYsidGWw2d6OTTqT1JbrNi
         lW0qfCsgr7uVZhooID9Bly5sfUbElcDmULQhL+33WxmWWLmxLv40HV1DDR2Q8qw83Oli
         yqLZ7nj4geWHcDORtA8skislAkN/Ip98qsMCXPsqRFOJIyKO1qCOOwlWlZ7N1+xAic+x
         uKgw==
X-Gm-Message-State: APzg51CBRbAehofawKSie+7dEakWY+kSjLwthBAyiw3hXd/tGQiKvplC
        tNWY+DKpCeUZfXwp5wDxU/+FQw==
X-Google-Smtp-Source: ANB0Vdba+XwunvS/cMsWShRUrMLXr7dovJbWGEbPeNUgfaUgnqugcQFUjt/NfBx/WOVibMBGduknhQ==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr35459595plb.176.1537395649068;
        Wed, 19 Sep 2018 15:20:49 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k26-v6sm39170825pfb.167.2018.09.19.15.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/12] OPP: Pass index to _of_init_opp_table()
Date:   Wed, 19 Sep 2018 15:20:23 -0700
Message-Id: <eb7c8743d6cf489e30091e6656fd4d3306621e9a.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory patch required for the next commit which will
start using OPP table's node pointer in _of_init_opp_table(), which
requires the index in order to read the OPP table's phandle.

This commit adds the index argument in the call chains in order to get
it delivered to _of_init_opp_table().

Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 19 +++++++++++++++----
 drivers/opp/of.c       | 12 +++++++-----
 drivers/opp/opp.h      |  4 ++--
 include/linux/pm_opp.h |  6 ++++++
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 9f8aa31265fe..332748adc262 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -785,7 +785,7 @@ struct opp_device *_add_opp_dev(const struct device *dev,
 	return opp_dev;
 }
 
-static struct opp_table *_allocate_opp_table(struct device *dev)
+static struct opp_table *_allocate_opp_table(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
 	struct opp_device *opp_dev;
@@ -808,7 +808,7 @@ static struct opp_table *_allocate_opp_table(struct device *dev)
 		return NULL;
 	}
 
-	_of_init_opp_table(opp_table, dev);
+	_of_init_opp_table(opp_table, dev, index);
 
 	/* Find clk for the device */
 	opp_table->clk = clk_get(dev, NULL);
@@ -833,7 +833,7 @@ void _get_opp_table_kref(struct opp_table *opp_table)
 	kref_get(&opp_table->kref);
 }
 
-struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
+static struct opp_table *_opp_get_opp_table(struct device *dev, int index)
 {
 	struct opp_table *opp_table;
 
@@ -844,15 +844,26 @@ struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 	if (!IS_ERR(opp_table))
 		goto unlock;
 
-	opp_table = _allocate_opp_table(dev);
+	opp_table = _allocate_opp_table(dev, index);
 
 unlock:
 	mutex_unlock(&opp_table_lock);
 
 	return opp_table;
 }
+
+struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
+{
+	return _opp_get_opp_table(dev, 0);
+}
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_table);
 
+struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev,
+						   int index)
+{
+	return _opp_get_opp_table(dev, index);
+}
+
 static void _opp_table_kref_release(struct kref *kref)
 {
 	struct opp_table *opp_table = container_of(kref, struct opp_table, kref);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 86222586f27b..1a9e1242a2a7 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -52,7 +52,8 @@ static struct opp_table *_managed_opp(const struct device_node *np)
 	return managed_table;
 }
 
-void _of_init_opp_table(struct opp_table *opp_table, struct device *dev)
+void _of_init_opp_table(struct opp_table *opp_table, struct device *dev,
+			int index)
 {
 	struct device_node *np;
 
@@ -378,7 +379,8 @@ static int _opp_add_static_v2(struct opp_table *opp_table, struct device *dev,
 }
 
 /* Initializes OPP tables based on new bindings */
-static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
+static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np,
+				int index)
 {
 	struct device_node *np;
 	struct opp_table *opp_table;
@@ -393,7 +395,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		goto put_opp_table;
 	}
 
-	opp_table = dev_pm_opp_get_opp_table(dev);
+	opp_table = dev_pm_opp_get_opp_table_indexed(dev, index);
 	if (!opp_table)
 		return -ENOMEM;
 
@@ -526,7 +528,7 @@ int dev_pm_opp_of_add_table(struct device *dev)
 		return _of_add_opp_table_v1(dev);
 	}
 
-	ret = _of_add_opp_table_v2(dev, opp_np);
+	ret = _of_add_opp_table_v2(dev, opp_np, 0);
 	of_node_put(opp_np);
 
 	return ret;
@@ -574,7 +576,7 @@ int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 		return -ENODEV;
 	}
 
-	ret = _of_add_opp_table_v2(dev, opp_np);
+	ret = _of_add_opp_table_v2(dev, opp_np, index);
 	of_node_put(opp_np);
 
 	return ret;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 88e9f47aadf1..b235e76fc8cc 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -200,9 +200,9 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of, in
 struct opp_table *_add_opp_table(struct device *dev);
 
 #ifdef CONFIG_OF
-void _of_init_opp_table(struct opp_table *opp_table, struct device *dev);
+void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index);
 #else
-static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev) {}
+static inline void _of_init_opp_table(struct opp_table *opp_table, struct device *dev, int index) {}
 #endif
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 099b31960dec..5d399eeef172 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -79,6 +79,7 @@ struct dev_pm_set_opp_data {
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
+struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index);
 void dev_pm_opp_put_opp_table(struct opp_table *opp_table);
 
 unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
@@ -136,6 +137,11 @@ static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
 	return ERR_PTR(-ENOTSUPP);
 }
 
+static inline struct opp_table *dev_pm_opp_get_opp_table_indexed(struct device *dev, int index)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
 static inline void dev_pm_opp_put_opp_table(struct opp_table *opp_table) {}
 
 static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp)
-- 
2.14.1

