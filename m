Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81C9C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9424C20811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VU1LNQg1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9424C20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbeLNKQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:16:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32856 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbeLNKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:15:59 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so2516759pgu.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GuwS/J0VRMUUsTtu4AOCAiCLWgTA0AmO9JSD70SaiQk=;
        b=VU1LNQg12XoWRQsPmxfL2kqW9a5aUSOuaM2mQcAPorUuaHGO6YvNZVCmjqU9i/eIIt
         fs03GzcarocK5NeZkre3RGce7WeMcgRK0kk7eibnfwWd94CwOM0f1wrqf7d+AERTsp20
         9EoLFoKTwcEyNhvJThmwovtYTS3qutHGRdjTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GuwS/J0VRMUUsTtu4AOCAiCLWgTA0AmO9JSD70SaiQk=;
        b=EJ0BKhvesBgFFbLZ4hmMe9ksnf6wTnhe7+EYpr96v8zWDTauu/udctmBta8/T+E/2K
         F3cq3uVm8Fv6yF+atgAbb4c3D1sOg64Ja8q9HqFbgt30/eRavLRbjK7V9KlNPIRHArvM
         9mwovIA4F54xqZMueAiaOsp4hOeaIpVr4QC44oytEcWylZLm3RHwU37vt1VkYRwzF6Pt
         5D8mzA7wK4QKMVk17wFW3rrgkeHR+kFACuvxYuxhVCXcw7rZLljt/7VSmSW36EXtwxe8
         EI7+gTq4oxzEtd/LgvSf7C7qFB6zVQopq1VCu2WkpsIZ+KgIm77YdBebO7rk75A9BiTg
         1PMQ==
X-Gm-Message-State: AA+aEWYKeKK2cXw9fnV4MII7Mkk4dz9V1HsRkSYV86IMJFyB5zvxgrIC
        Prnbp3j2b/VrfrGUOeX9fd/ik3Grb+A=
X-Google-Smtp-Source: AFSGD/W0mCDLMeH1N1KDnqDvAnn7s7SrtmmEmfIpwJ5rtQND3cc8+wWrqUqluNVBFSs48cCSfiUUbw==
X-Received: by 2002:a65:4142:: with SMTP id x2mr2117023pgp.356.1544782559125;
        Fri, 14 Dec 2018 02:15:59 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id b4sm4870265pgq.65.2018.12.14.02.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:15:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 7/7] PM / Domains: Propagate performance state updates
Date:   Fri, 14 Dec 2018 15:45:33 +0530
Message-Id: <0c7ef1300e212f0ae06ccf10398f8c9453c064a5.1544782279.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544782279.git.viresh.kumar@linaro.org>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a genpd only handles the performance state requirements from
the devices under its control. This commit extends that to also handle
the performance state requirement(s) put on the master genpd by its
sub-domains. There is a separate value required for each master that
the genpd has and so a new field is added to the struct gpd_link
(link->performance_state), which represents the link between a genpd and
its master. The struct gpd_link also got another field
prev_performance_state, which is used by genpd core as a temporary
variable during transitions.

On a call to dev_pm_genpd_set_performance_state(), the genpd core first
updates the performance state of the masters of the device's genpd and
then updates the performance state of the genpd. The masters do the same
and propagate performance state updates to their masters before updating
their own. The performance state transition from genpd to its master is
done with the help of dev_pm_opp_xlate_performance_state(), which looks
at the OPP tables of both the domains to translate the state.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 93 ++++++++++++++++++++++++++++++++-----
 include/linux/pm_domain.h   |  4 ++
 2 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 808ba41b6580..611c0ccbad5f 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -244,6 +244,7 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 {
 	struct generic_pm_domain_data *pd_data;
 	struct pm_domain_data *pdd;
+	struct gpd_link *link;
 
 	/* New requested state is same as Max requested state */
 	if (state == genpd->performance_state)
@@ -262,31 +263,101 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 	}
 
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
 	return state;
 }
 
 static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
-					unsigned int state)
+					unsigned int state, int depth)
 {
-	int ret;
+	struct generic_pm_domain *master;
+	struct gpd_link *link;
+	int master_state, ret;
 
 	if (state == genpd->performance_state)
 		return 0;
 
+	/* Propagate to masters of genpd */
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		master = link->master;
+
+		if (!master->set_performance_state)
+			continue;
+
+		/* Find master's performance state */
+		ret = dev_pm_opp_xlate_performance_state(genpd->opp_table,
+							 master->opp_table,
+							 state);
+		if (unlikely(ret < 0))
+			goto err;
+
+		master_state = ret;
+
+		genpd_lock_nested(master, depth + 1);
+
+		link->prev_performance_state = link->performance_state;
+		link->performance_state = master_state;
+		master_state = _genpd_reeval_performance_state(master,
+						master_state);
+		ret = _genpd_set_performance_state(master, master_state, depth + 1);
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
+		master_state = _genpd_reeval_performance_state(master,
+						master_state);
+		if (_genpd_set_performance_state(master, master_state, depth + 1)) {
+			pr_err("%s: Failed to roll back to %d performance state\n",
+			       master->name, master_state);
+		}
+
+		genpd_unlock(master);
+	}
+
+	return ret;
 }
 
 /**
@@ -331,7 +402,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	gpd_data->performance_state = state;
 
 	state = _genpd_reeval_performance_state(genpd, state);
-	ret = _genpd_set_performance_state(genpd, state);
+	ret = _genpd_set_performance_state(genpd, state, 0);
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

