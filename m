Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC8ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9BE2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsoKAnUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9BE2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbeKEPzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:55:24 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39900 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbeKEPzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:55:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so3941888pla.6
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 22:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++v3XXRbpVHJuX8RyfyvTaqYBFuAGN2iIxtK4ZIufKQ=;
        b=bsoKAnUs+j9TMTBQiNfz11G8VWYBM+z6/t3fMiHdrKu1VTmHha1XLRO7mN6d0iSqTR
         UcklcFwRcjxJCN1buo21Thb8oHsVenu+WKDhTHAqg0YXPo3aI5cZMZrqnrSkB/r7fGR9
         XjNoSn71TgZ6arMdToxGrwhQSoKRg44gjubtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++v3XXRbpVHJuX8RyfyvTaqYBFuAGN2iIxtK4ZIufKQ=;
        b=m4FA2V2T8HUjj/6E+xBq4jT+FxYsikeuTzd4haqBONxlrlQw/LqPCsRHpkvCr2wdEQ
         sPsIWqO2TigrDAIatEPDr9P7kN93dFFlSCNp29Xu3UCRXKcKIPlQaIDTEVw8IorGOiTr
         uxI2wc8dRBAKXcplF1JuMpDYL8FfuTjKvE35+dkZq1952R+qpzhsrTwv6VSAo9bg1jJg
         OF0MDaintX6ty0ZODeKADNbMuC1kRcT5m4+DtwZy/Ho12Q49VJf6QMyix6upi4E1f1B0
         g+qbZI2iTGz7hhvLd5IeUA9ZczvX5ZDZf/Mnp5j2THfxt8byDTN9RHPjeL99sCW/qdir
         1CiQ==
X-Gm-Message-State: AGRZ1gLBsWALI1RcBhyLQrMfE6EeUJKgPRA5LtY2wkSovowNc6W2xG/2
        EHBYCLBCgMrvxv1EUI+8hl/j/w==
X-Google-Smtp-Source: AJdET5dENUA8iN+hFZz1FYFR+p/IzCU8NFHI/i3DF/Hv+uqySqlxMGDauq7fuolYB+3dAQ9xrd2RFg==
X-Received: by 2002:a17:902:7c0b:: with SMTP id x11-v6mr20640642pll.60.1541399836850;
        Sun, 04 Nov 2018 22:37:16 -0800 (PST)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id o83-v6sm30019326pfa.90.2018.11.04.22.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 22:37:16 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] PM / Domains: Save OPP table pointer in genpd
Date:   Mon,  5 Nov 2018 12:06:44 +0530
Message-Id: <d708cd29d5534a488c0384041800ed4828ce7bbd.1541399301.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1541399301.git.viresh.kumar@linaro.org>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
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

