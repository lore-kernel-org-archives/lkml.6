Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD598C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E362086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O1nD1RQ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E362086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeLLK6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:58:02 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43877 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeLLK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:58:01 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so8164712pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88unu+wr5jKW9r3TtHtSlTHkq7xupIQjYSmWeaTu8BE=;
        b=O1nD1RQ6wqsp1qr0IUDtT04iphzs5fMjIeu+3J1eDmQ0bbiv046og7u0wiaNLj4PVV
         F/44HnYNiv15OL6axGl+G8oh53E6UGcjiaVEqECFj5KInABoyEOdKdIqkn+KZJhqB3AV
         c93FNJsp8t8MgD0qxSqZGinupFU2akEU4b8t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88unu+wr5jKW9r3TtHtSlTHkq7xupIQjYSmWeaTu8BE=;
        b=q08nNJHoDj4uYz6qXMWj/khqX+yZA83dKIxdf/Oso/26E7TKmuXaCvwTQrMND50J/m
         tqj9KBA6DnNkkSQ4HxyUlX0saWXgwbRXXmOOl7wyiuz9gj2Ib1s2WRMrvOBBvN+bFFMc
         0UTFLv8QTSAlcQPTz0U2tm2VAKbJQinuxSGLUY95OQaMZNjW8D813TJ4kEAU8JgT98EK
         v5im1CUzGvRQcwr2YMRrDRKsTIyBeVXcPpmQhXK8oNh2GjJ+wRKnjxya76ipvgHcEZor
         AmULys6nebI/WoTx23YFYXxkXs9FUSXFr39L19sfsVB8MOrqyNTI3IUv4jbqNqkAS203
         xhew==
X-Gm-Message-State: AA+aEWYncSHqsCnRtgMUMG36XuqNoEMYQy3a7OIZZkNGjzjezoC1B/Xd
        znyLyGLX/4ou27jbuX9UNwyULw==
X-Google-Smtp-Source: AFSGD/UZyxGeikF45ZYHml042aRpbSXb40bsXdte1HNnU9bh6ntwgTTZbCuguCSxc03eSFYIF1y9YQ==
X-Received: by 2002:a62:cd44:: with SMTP id o65mr19677416pfg.222.1544612279473;
        Wed, 12 Dec 2018 02:57:59 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id y6sm32795503pfd.104.2018.12.12.02.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 02:57:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/6] PM / Domains: Save OPP table pointer in genpd
Date:   Wed, 12 Dec 2018 16:27:27 +0530
Message-Id: <6fd6a8a689cd86eaae5a64be958870795e88cdb1.1544611890.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544611890.git.viresh.kumar@linaro.org>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_genpd_set_performance_state() will be required to call
dev_pm_opp_xlate_performance_state() going forward to translate from
performance state of a sub-domain to performance state of its master.
And dev_pm_opp_xlate_performance_state() needs pointers to the OPP
tables of both genpd and its master.

Lets fetch and save them while the OPP tables are added. Fetching the
OPP tables should never fail as we just added the OPP tables and so add
a WARN_ON() for such a bug instead of full error paths.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 23 +++++++++++++++++++++--
 include/linux/pm_domain.h   |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4a4e39d12354..1e98c637e069 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1896,12 +1896,21 @@ int of_genpd_add_provider_simple(struct device_node *np,
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
@@ -1954,6 +1963,13 @@ int of_genpd_add_provider_onecell(struct device_node *np,
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
@@ -1978,8 +1994,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 		genpd->provider = NULL;
 		genpd->has_provider = false;
 
-		if (genpd->set_performance_state)
+		if (genpd->set_performance_state) {
+			dev_pm_opp_put_opp_table(genpd->opp_table);
 			dev_pm_opp_of_remove_table(&genpd->dev);
+		}
 	}
 
 	mutex_unlock(&gpd_list_lock);
@@ -2013,6 +2031,7 @@ void of_genpd_del_provider(struct device_node *np)
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

