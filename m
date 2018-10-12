Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7C6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5BB2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBAA+tT9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5BB2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbeJLSoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:44:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38665 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbeJLSoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:44:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id f29-v6so6040247pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=akQeUpsf7fkn8621Db/E2werSvh2FTMXzqxwQvFVpBE=;
        b=WBAA+tT98s2CgT/WkXpszZlqtqAppwvmI8+XNAJXW9xjFpM4rp7i3xiRBZUgf/WqkW
         uBhmw4n0KxkZeG1xcyDqDLyg6WeJit6/aIBrdXlrktTRx+1/uZRK6g7fJiLG2o15vpfi
         SCZH1LOy1R1LlCFg2UX8BmzAXYk4Soeg9YF1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=akQeUpsf7fkn8621Db/E2werSvh2FTMXzqxwQvFVpBE=;
        b=dO4qF3to/MH8ptGPt28KMmRhJ+rtNpWSaqrgMWW7D8SLaw4/Wmtrb2u42NeuYgpl/L
         eR4ppyNFsxmWlfNBngpXe7FA6LtiS9XErd6L6L9obydqcdOrUEPUiRXDYJLcYGG4ceDx
         7Q/vKp2CNTkbVip3l2Ok18TZmKMJJs6Dgjr5k2sCisvR3pV3dfQxbHGreU96zNVsRU/5
         ElcFeKeHTnSS1pJNnznUp7SkXzOdPwGTqlOx/cchd2DSIOfxYWNqX0j/hjK/86SVSa60
         NIXZ6ZV3zWcBthj5+D314efpQeGU4y55a1X5U5JPvQxP1Vxj2urq49fL29U48+ttROAv
         NmhA==
X-Gm-Message-State: ABuFfoiwLQhgmju+dinmdgwRShB1Kfneurkx+DsD9e/quFm7Oq2nJE2m
        qw3VSVSG2cjZBkrAADeksAbR5g==
X-Google-Smtp-Source: ACcGV62IlhULmq+FeMlIXY/Sm1G7G+C3lMDWE6C74xVNzCKw3+JJbl/UA7vNlEV1dKRg85ck+H4XxQ==
X-Received: by 2002:a65:45c9:: with SMTP id m9-v6mr5046699pgr.212.1539342731845;
        Fri, 12 Oct 2018 04:12:11 -0700 (PDT)
Received: from localhost ([122.171.67.41])
        by smtp.gmail.com with ESMTPSA id v83-v6sm4510860pfa.103.2018.10.12.04.12.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 04:12:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 9/9] OPP: Remove of_dev_pm_opp_find_required_opp()
Date:   Fri, 12 Oct 2018 16:41:17 +0530
Message-Id: <c4104405e6a84cbf58f427f65fbc041d3c880544.1539341929.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1539341929.git.viresh.kumar@linaro.org>
References: <cover.1539341929.git.viresh.kumar@linaro.org>
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
index b059d833f920..623f651f9e11 100644
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
index f440e625f1fd..fdd87a21dac4 100644
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
2.18.0.rc1.242.g61856ae69a2c

