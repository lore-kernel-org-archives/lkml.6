Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A7ECDE48
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF3020831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NY/MiQxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF3020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJYOZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:25:01 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45335 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeJYOZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:25:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id s3-v6so3469445pga.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0W5YPpjNuuimwED1mEbhATYnLae0KPefqUWaYo854Dw=;
        b=NY/MiQxP42NnC4FTCCfe6hCoTHxKDld8m7IfnNiMgjIdTSGtH9wRdwybRkxkzM0VsF
         57jcemcVi7fiDxbpSJ0dlJX40QFTaaUs+7uVcRloCP9sq6tY+/A4YxjdK4OQJcPhYOtJ
         W9cgSde6E5VxMimAr6GzkGjFcc0M0DgzGbGF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0W5YPpjNuuimwED1mEbhATYnLae0KPefqUWaYo854Dw=;
        b=WUOg4aLfv9PtZ+WHyoXKxz5N96ShvWQdNPfKtF/NCatoInWK1p7pQxqV6rVCFyxGic
         8WX84l9iZ8TKatbt6EVFNLpdkjdvUeXJnvPe1t8tWrgNlVB0u0pyiS4wgICYC5QnN6SP
         f0ANQPQE2uWNCXVaFGyE3xa1kw1uPziEugBpPz12VY4gmSoCzLEf36SuPLuT7l04AEFw
         kU3y6tTryhWb+L2uEa60rXZa2SBjJQTwBi0YyeZSSEp9BESCw4gAs39aK4eK1cL4qexA
         yeN2zNtN5VYlEAlxoJ8R9E5lCKti91roQXg3qpjc0XOQTdoXqS530aT1ApuZO9ckNJ1/
         4+FA==
X-Gm-Message-State: AGRZ1gK8wis7OPjGyr2FAJtX/s7JrBdZuZTxzSygBUAEKI7j3P/yNxKF
        5RZlt2bjN0LbiCnR5B4OEHzvyQ==
X-Google-Smtp-Source: AJdET5efroHH70+cxU0pZaQ14V4goXMZUv0Q8kkr0ZgAoHnO/WI4eGWFozCxT8OaxstORZNGbrv3ug==
X-Received: by 2002:a62:250:: with SMTP id 77-v6mr235091pfc.16.1540446829661;
        Wed, 24 Oct 2018 22:53:49 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id 72-v6sm14968758pfr.115.2018.10.24.22.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 22:53:49 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 10/10] OPP: Remove of_dev_pm_opp_find_required_opp()
Date:   Thu, 25 Oct 2018 11:22:47 +0530
Message-Id: <db0789a3048dd659ce8bf3f0fafb1c1dcf392791.1540446493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 0755ee307b1a..da31874c7fe9 100644
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
index 889bb347fbd9..2b2c3fd985ab 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -313,7 +313,6 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask);
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
-struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev, struct device_node *np);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
 unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
 #else
@@ -350,10 +349,6 @@ static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device
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
2.19.1.568.g152ad8e3369a

