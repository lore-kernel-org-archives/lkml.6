Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35E2C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857FA27B39
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JyTGrJWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857FA27B39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933617AbeF2GUi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:20:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45596 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754883AbeF2GUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:20:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id bi1-v6so3956329plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EkwPwO0lER5EARerditu2y59jlVuf9fgSDG7a5KSRuc=;
        b=JyTGrJWG0kjcQ/TxaLHFrKvcTPh6fGRmY/j4pIYClJJhp8Nwh0xRdDT/tkod4z0JHu
         sZ00GEMH0J/E/eBo1Afx3CR5fK4flgM8wBPWXW43eWOhuTYQ6i7FtG2iL/zZF21dIRpK
         VWgHRdds3k1iZnv0fkYAviFjrcRsAUG0STxcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EkwPwO0lER5EARerditu2y59jlVuf9fgSDG7a5KSRuc=;
        b=GVallkmC2SThd0vnXF2zw77p0OHSczvvjLPn5OlUm2z9NoaTscLRzl/s0dtkKTydRL
         JK5SPp/R2PEBDaIkA8ulDfJ0g3gN7PLWjszJlPfJ5CnT/5lMCqggX/y9FedZ8qGp9Cgf
         ntgN0AA3eE46GvriN0E59F94zBPZCISD1ptylcf4fTuyUmzrGJKnyYaBbGuEX5smrVil
         yGGy7yoDuRnQQi4ZAdOC8iXg5rKJc7X7VmXbgKilUDm+5EtYMRN+7GBGyq2pCqAHhEEY
         O7xbkBfkHPv41iDX6Yna8OG45TWfsbzp+oXtGT3xWuYc1F/paZ7NY4uQOe0sKv+adcw5
         gsWQ==
X-Gm-Message-State: APt69E1l2dptQZ2F3gECUOlH2iTq7uRevKTGmMrH8ehAD5qJAZe6ZZG/
        Ro/A9fzJOp6VbLYR+mkS/JInAg==
X-Google-Smtp-Source: AAOMgpdfQ2RGIlE3GuLJDYEsnlz7DAszzbLQlEvMpDi7XVVgZeOc1XD8K9S6iHK1ivAdo+bGL3QyYA==
X-Received: by 2002:a17:902:b612:: with SMTP id b18-v6mr8759553pls.131.1530253225134;
        Thu, 28 Jun 2018 23:20:25 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id g136-v6sm143660pfb.23.2018.06.28.23.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:20:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] OPP: Remove of_dev_pm_opp_find_required_opp()
Date:   Fri, 29 Jun 2018 11:49:40 +0530
Message-Id: <b7843b9941743f1b3462ada4b485a5f94038da09.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This isn't used anymore, remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c       | 54 ------------------------------------------
 include/linux/pm_opp.h |  5 ----
 2 files changed, 59 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 80fdeab4364a..722b3142f4c6 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1013,60 +1013,6 @@ unsigned int of_get_required_opp_performance_state(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(of_get_required_opp_performance_state);
 
-/**
- * of_dev_pm_opp_find_required_opp() - Search for required OPP.
- * @dev: The device whose OPP node is referenced by the 'np' DT node.
- * @np: Node that contains the "required-opps" property.
- *
- * Returns the OPP of the device 'dev', whose phandle is present in the "np"
- * node. Although the "required-opps" property supports having multiple
- * phandles, this helper routine only parses the very first phandle in the list.
- *
- * Return: Matching opp, else returns ERR_PTR in case of error and should be
- * handled using IS_ERR.
- *
- * The callers are required to call dev_pm_opp_put() for the returned OPP after
- * use.
- */
-struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev,
-						   struct device_node *np)
-{
-	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ENODEV);
-	struct device_node *required_np;
-	struct opp_table *opp_table;
-
-	opp_table = _find_opp_table(dev);
-	if (IS_ERR(opp_table))
-		return ERR_CAST(opp_table);
-
-	required_np = of_parse_phandle(np, "required-opps", 0);
-	if (unlikely(!required_np)) {
-		dev_err(dev, "Unable to parse required-opps\n");
-		goto put_opp_table;
-	}
-
-	mutex_lock(&opp_table->lock);
-
-	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
-		if (temp_opp->available && temp_opp->np == required_np) {
-			opp = temp_opp;
-
-			/* Increment the reference count of OPP */
-			dev_pm_opp_get(opp);
-			break;
-		}
-	}
-
-	mutex_unlock(&opp_table->lock);
-
-	of_node_put(required_np);
-put_opp_table:
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return opp;
-}
-EXPORT_SYMBOL_GPL(of_dev_pm_opp_find_required_opp);
-
 /**
  * dev_pm_opp_get_of_node() - Gets the DT node corresponding to an opp
  * @opp:	opp for which DT node has to be returned for
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 6d6b1febe068..fadf6d1bdef5 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -307,7 +307,6 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
-struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
 #else
@@ -344,10 +343,6 @@ static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device
 	return NULL;
 }
 
-static inline struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np)
-{
-	return NULL;
-}
 static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
-- 
2.18.0.rc1.242.g61856ae69a2c

