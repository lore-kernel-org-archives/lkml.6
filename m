Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65817C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E02520811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jLZVNYXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E02520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeLNKP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:15:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34376 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbeLNKPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:15:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so2637398pfg.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=88unu+wr5jKW9r3TtHtSlTHkq7xupIQjYSmWeaTu8BE=;
        b=jLZVNYXPI8sRndhzeySNVUXvkyvSG49GfBR/xdeF0n3/NHg6+M/EExbHnlCNgjqPz7
         8hRFRtD9qzcoDO6pChiptapv7mwFljOBo3jh9X+o8n+yKKexkqvQ1MynFB4KGlY39doT
         T94oOcFY21nPgyZY/zFogY9VzEpRSYvuPabGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=88unu+wr5jKW9r3TtHtSlTHkq7xupIQjYSmWeaTu8BE=;
        b=FGhuUK3IPmPLC9eVX49x3fnssT1KLnFtI15XkuRldlOJCoeMlGSrHTLNFQA16nezHk
         jmobp6jsu9ZIXwCiwjtKL6N4nDdrU+P92T7874zb4xIC//WJkntOBS52tK6nhJZ1gGMO
         NBX9Wv3zlXpa/eE3ivW0S0eTIY17uqgHPBLUDi03nDUJaVLbCxVYapX9QUFeeIUYGHGE
         B6DaHCuXTvE7I3a1fuEL8JfKBFEPEHrme0KUhjQI4Tnq218aeG69e8tel+A0GH0tEGeN
         GVECRZ7TSqbhF1+WRv71cBJgVIb2qyV7U3WLeXYV1D594zZMvj4Hoom9LRigANKCcujf
         asWQ==
X-Gm-Message-State: AA+aEWZMIAjtf76gh/K0cxfs+tQVqXJDnoWrp3mX0LyS6ARUGamtzNtw
        HGp6zPV/ipJIRv145unbsDwnwA==
X-Google-Smtp-Source: AFSGD/VPjTk8TiXZ4p9d5IR/oT5FxJ0SXPUel4+K1pIrJp/ZMeQJuKgiGkqf3k+W4rcNf9JxMr0COQ==
X-Received: by 2002:a63:fd0a:: with SMTP id d10mr2208487pgh.164.1544782553378;
        Fri, 14 Dec 2018 02:15:53 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id t24sm5697214pfh.21.2018.12.14.02.15.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:15:52 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 5/7] PM / Domains: Save OPP table pointer in genpd
Date:   Fri, 14 Dec 2018 15:45:31 +0530
Message-Id: <5603371d1ad204a7314a3618d362d583b555f6b6.1544782279.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544782279.git.viresh.kumar@linaro.org>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
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

