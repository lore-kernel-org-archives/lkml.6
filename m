Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577DEC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1447720839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+iqgxNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1447720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeLLK6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:58:09 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34136 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeLLK6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:58:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so8456103plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6OdClubF4RfL9e05GmhHLx7Ei4hstJaBiTl97uuPI8=;
        b=h+iqgxNa/x6wXA7miuOUX5zrFMVjNFZHOu6qUD0o9RpqbtK3QJ9oiEDppegHtytORq
         +BGsVThazgEY3qtWaySy/zDbYm19yrGzsdaGz9FLAVUr7yr4kDHkxsnrbkFw37ugvk2i
         /uLGZPIpanZscY37gu7l2Hcdh8uxyXQ9tOSc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6OdClubF4RfL9e05GmhHLx7Ei4hstJaBiTl97uuPI8=;
        b=DArA1Dkm1DHya4qdfmOrcixbFKS/13UVHWsarZUIW2Cawhx8EcKhABDe8N+fJDE2zR
         bMqssk1DeOP/27Cf2kzZOnGJtQznaU1qxoywGMxdUY8Vz0b9OFTDK6RFgm/Jv9bVksji
         rs36iWKmKf+7B++8FHcdHU5ADn4FLyhHr3DxEocXsmUIjLyPYXOAWjwr9Uy5QohYjXba
         P5Kfq+vLekVvc0HqJbY7nDDSENQW0Z8VNQHEbr9NbMUeRLRUjro7M/89aNGbVakMIWW/
         v0ALi+xQxXQJxsEY6p6pUmrAn5ePM6VR77B5pmsnQk+cDOx3h8tJ8kMgowzGoAC/Rqrf
         eFFQ==
X-Gm-Message-State: AA+aEWZCpRK+O8GKLipl/EOEMYT9Zs86yzw1a/f4PYaEdGuDqalukinZ
        wSpVBUC8XC33r/+5C6IMNO1EqA==
X-Google-Smtp-Source: AFSGD/Wg5MGoKCFRCowogPXSmxgLcyW0Wh6r6zTmwaQVGEMiMmwjuz4Cw6KfZ0EuxrwXc19ylLaSfQ==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr19893330plb.335.1544612286046;
        Wed, 12 Dec 2018 02:58:06 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id 69sm31751751pgg.86.2018.12.12.02.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 02:58:05 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 6/6] PM / Domains: Propagate performance state updates
Date:   Wed, 12 Dec 2018 16:27:29 +0530
Message-Id: <d138bd45d0eacc11ff90e27f83d8b47d692877ef.1544611890.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544611890.git.viresh.kumar@linaro.org>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates genpd core to start propagating performance state
updates to master domains that have their set_performance_state()
callback set.

Currently a genpd only handles the performance state requirements from
the devices under its control. This commit extends that to also handle
the performance state requirement(s) put on the master genpd by its
sub-domains. There is a separate value required for each master that
the genpd has and so a new field is added to the struct gpd_link
(link->performance_state), which represents the link between a genpd and
its master. The struct gpd_link also got another field
prev_performance_state, which is used by genpd core as a temporary
variable during transitions.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 105 ++++++++++++++++++++++++++++++------
 include/linux/pm_domain.h   |   4 ++
 2 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 32ecbefbd191..5e0479b2e976 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -239,24 +239,90 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 #endif
 
+static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
+					   unsigned int state, int depth);
+
 static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
-					unsigned int state)
+					unsigned int state, int depth)
 {
+	struct generic_pm_domain *master;
+	struct gpd_link *link;
+	unsigned int master_state;
 	int ret;
 
+	/* Propagate to masters of genpd */
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		master = link->master;
+
+		if (!master->set_performance_state)
+			continue;
+
+		if (unlikely(!state)) {
+			master_state = 0;
+		} else {
+			/* Find master's performance state */
+			master_state = dev_pm_opp_xlate_performance_state(genpd->opp_table,
+						master->opp_table, state);
+			if (unlikely(!master_state)) {
+				ret = -EINVAL;
+				goto err;
+			}
+		}
+
+		genpd_lock_nested(master, depth + 1);
+
+		link->prev_performance_state = link->performance_state;
+		link->performance_state = master_state;
+		ret = _genpd_reeval_performance_state(master, master_state,
+						      depth + 1);
+		if (ret)
+			link->performance_state = link->prev_performance_state;
+
+		genpd_unlock(master);
+
+		if (ret)
+			goto err;
+	}
+
 	ret = genpd->set_performance_state(genpd, state);
 	if (ret)
-		return ret;
+		goto err;
 
 	genpd->performance_state = state;
 	return 0;
+
+err:
+	/* Encountered an error, lets rollback */
+	list_for_each_entry_continue_reverse(link, &genpd->slave_links,
+					     slave_node) {
+		master = link->master;
+
+		if (!master->set_performance_state)
+			continue;
+
+		genpd_lock_nested(master, depth + 1);
+
+		master_state = link->prev_performance_state;
+		link->performance_state = master_state;
+
+		if (_genpd_reeval_performance_state(master, master_state,
+						    depth + 1)) {
+			pr_err("%s: Failed to roll back to %d performance state\n",
+			       master->name, master_state);
+		}
+
+		genpd_unlock(master);
+	}
+
+	return ret;
 }
 
 static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
-					   unsigned int state)
+					   unsigned int state, int depth)
 {
 	struct generic_pm_domain_data *pd_data;
 	struct pm_domain_data *pdd;
+	struct gpd_link *link;
 
 	/* New requested state is same as Max requested state */
 	if (state == genpd->performance_state)
@@ -274,21 +340,30 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 			state = pd_data->performance_state;
 	}
 
-	if (state == genpd->performance_state)
-		return 0;
-
 	/*
-	 * We aren't propagating performance state changes of a subdomain to its
-	 * masters as we don't have hardware that needs it. Over that, the
-	 * performance states of subdomain and its masters may not have
-	 * one-to-one mapping and would require additional information. We can
-	 * get back to this once we have hardware that needs it. For that
-	 * reason, we don't have to consider performance state of the subdomains
-	 * of genpd here.
+	 * Traverse all sub-domains within the domain. This can be
+	 * done without any additional locking as the link->performance_state
+	 * field is protected by the master genpd->lock, which is already taken.
+	 *
+	 * Also note that link->performance_state (subdomain's performance state
+	 * requirement to master domain) is different from
+	 * link->slave->performance_state (current performance state requirement
+	 * of the devices/sub-domains of the subdomain) and so can have a
+	 * different value.
+	 *
+	 * Note that we also take vote from powered-off sub-domains into account
+	 * as the same is done for devices right now.
 	 */
+	list_for_each_entry(link, &genpd->master_links, master_node) {
+		if (link->performance_state > state)
+			state = link->performance_state;
+	}
+
+	if (state == genpd->performance_state)
+		return 0;
 
 update_state:
-	return _genpd_set_performance_state(genpd, state);
+	return _genpd_set_performance_state(genpd, state, depth);
 }
 
 /**
@@ -332,7 +407,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	prev = gpd_data->performance_state;
 	gpd_data->performance_state = state;
 
-	ret = _genpd_reeval_performance_state(genpd, state);
+	ret = _genpd_reeval_performance_state(genpd, state, 0);
 	if (ret)
 		gpd_data->performance_state = prev;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9ad101362aef..dd364abb649a 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -136,6 +136,10 @@ struct gpd_link {
 	struct list_head master_node;
 	struct generic_pm_domain *slave;
 	struct list_head slave_node;
+
+	/* Sub-domain's per-master domain performance state */
+	unsigned int performance_state;
+	unsigned int prev_performance_state;
 };
 
 struct gpd_timing_data {
-- 
2.19.1.568.g152ad8e3369a

