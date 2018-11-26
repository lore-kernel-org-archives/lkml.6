Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B88C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 192412082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqCnAYXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192412082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbeKZTDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:03:46 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36950 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZTDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:03:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so13505858plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++v3XXRbpVHJuX8RyfyvTaqYBFuAGN2iIxtK4ZIufKQ=;
        b=OqCnAYXKYFFxfcDQdBH/amjiIdW1xiVkdUh5+TDq0nVt9fP81udsrShE6qgoYxrwMp
         2xugRb01JUUZscmyv1RXtbtDgFPCAkqtkojuuUFABQCSFiNSFyLJRpx9C5OFaOjXNGTI
         ll3/aURzt7SHZ90gSqCftbJxZFMeoqR8V9nIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++v3XXRbpVHJuX8RyfyvTaqYBFuAGN2iIxtK4ZIufKQ=;
        b=XPgDaLHrqqebP84oYCJKdGsgtA+EPnHQ0xx5iOAz2PLH3UxaKNNZpb2IjpGQ0y7VR+
         rwz4MYkvQAI3MdSPPtNsYdNnCORaR1mCXdrtyy7v7mTtXHS7MMkYZxRioRmWGPJmgb3s
         Bcr4RbB1CYH5qplZlw2MnNk76c7NRq2iQQnmqh8Llo7wWTWPigEOhxHfCKfhPfoaxY5o
         N0QWag3UuUhOMGtORSVEQppTug4vT3i8J5wI3vwyhRuJp225y+4dpCFHYeYGtDKRp7MH
         aFwMqAI68BREwkd2mJu8gkYU2S9oUDgm8T/Q0uGaZuG3XwvGiH0mGP9lXNhji8GQf7N9
         7+vQ==
X-Gm-Message-State: AA+aEWZ43RwC7vZicf5lyDpS3vlCIWe2L32E3mvHshg4FQsOG+WOinYx
        hVTlglMwJjGQVAIag8KB0zA8UA==
X-Google-Smtp-Source: AFSGD/VF3xeN+bhr9ztcq4G0NNdUJli3M+sGfHm5SYiLIw39XJh7bjpMK65hLSDjBPuF6zL+eZACgw==
X-Received: by 2002:a17:902:f091:: with SMTP id go17mr27154879plb.235.1543219826521;
        Mon, 26 Nov 2018 00:10:26 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id 6sm89302753pfv.30.2018.11.26.00.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:10:25 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/5] PM / Domains: Save OPP table pointer in genpd
Date:   Mon, 26 Nov 2018 13:40:02 +0530
Message-Id: <f95b514f7b3b3ab6ac00c9871e91513c9c3a09a3.1543219386.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1543219386.git.viresh.kumar@linaro.org>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will need these going forward in hotpath, i.e. from within
dev_pm_genpd_set_performance_state().

Lets fetch and save them while the OPP tables are added.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 23 +++++++++++++++++++++--
 include/linux/pm_domain.h   |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8e554e6a82a2..0d928359b880 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1907,12 +1907,21 @@ int of_genpd_add_provider_simple(struct device_node *np,
 				ret);
 			goto unlock;
 		}
+
+		/*
+		 * Save table for faster processing while setting performance
+		 * state.
+		 */
+		genpd->opp_table = dev_pm_opp_get_opp_table(&genpd->dev);
+		WARN_ON(!genpd->opp_table);
 	}
 
 	ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
 	if (ret) {
-		if (genpd->set_performance_state)
+		if (genpd->set_performance_state) {
+			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
+		}
 
 		goto unlock;
 	}
@@ -1965,6 +1974,13 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 					i, ret);
 				goto error;
 			}
+
+			/*
+			 * Save table for faster processing while setting
+			 * performance state.
+			 */
+			genpd->opp_table = dev_pm_opp_get_opp_table_indexed(&genpd->dev, i);
+			WARN_ON(!genpd->opp_table);
 		}
 
 		genpd->provider = &np->fwnode;
@@ -1989,8 +2005,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		genpd->provider = NULL;
 		genpd->has_provider = false;
 
-		if (genpd->set_performance_state)
+		if (genpd->set_performance_state) {
+			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
+		}
 	}
 
 	mutex_unlock(&gpd_list_lock);
@@ -2024,6 +2042,7 @@ void of_genpd_del_provider(struct device_node *np)
 					if (!gpd->set_performance_state)
 						continue;
 
+					dev_pm_opp_put_opp_table(gpd->opp_table);
 					dev_pm_opp_of_remove_table(&gpd->dev);
 				}
 			}
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 642036952553..9ad101362aef 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -73,6 +73,7 @@ struct genpd_power_state {
 
 struct genpd_lock_ops;
 struct dev_pm_opp;
+struct opp_table;
 
 struct generic_pm_domain {
 	struct device dev;
@@ -94,6 +95,7 @@ struct generic_pm_domain {
 	unsigned int performance_state;	/* Aggregated max performance state */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
+	struct opp_table *opp_table;	/* OPP table of the genpd */
 	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
 						 struct dev_pm_opp *opp);
 	int (*set_performance_state)(struct generic_pm_domain *genpd,
-- 
2.19.1.568.g152ad8e3369a

