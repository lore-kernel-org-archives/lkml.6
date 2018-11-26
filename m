Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C842CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734442082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W+O/u9H5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734442082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeKZTDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:03:52 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40398 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeKZTDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:03:52 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so922287plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gdx8Be1U5CqHmPy7KT6mxY75FaEUymFqFA79hpQ5+qU=;
        b=W+O/u9H5QL4XKpVXiNDpb3N8r0vyauWUT53C8Ofi3yxv3arF7alHFp4z0npaEl9b60
         quBlZ2N8irvJNpfCI2iitGZ37gH/eC9NCosz+3CeqKLQECez8SHHbr7bO/gl7wG6gvA6
         Qpmpi4XNDJD/yxsv+6e9lShctUJ06/P1OqylU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gdx8Be1U5CqHmPy7KT6mxY75FaEUymFqFA79hpQ5+qU=;
        b=gV4Y1EIQSXpgGvONEvudQu7xT5zUxEDf0lKBTgKaEUxZR+QUMIgWQehmakX4UhHiJi
         V82nOKmg0oEWFLTRQ0KRDnUTS+LtmEjMbef64SeezYP2g8KMF+2OnVxO94J9AFgd9RRL
         PNmgAIngteYISKugFRIS7BgYsKb+MRCI/EfK86LSaanIU4ktWUBTHY0d1oax5H/M/X7/
         Q3/DFjOM2NCLNMVC8DiPmJr/MS6GYDDGrf9W7pU5cezS0b3X5tZ4SlK1rUxjZYHX6pMB
         menvscBEZQSXkr8VfaVfqwx/MnymsQSXLo9ylsW2KEkNT8RayhkwWbv23a/P5O46qplL
         k+Kw==
X-Gm-Message-State: AA+aEWaMQzOgkJnL6ml2IiHbE82JwhsJwIInI4kWZ0Qu+dScte32H631
        xxGBYKEN2ZZNN4jqXAkJWMAn+w==
X-Google-Smtp-Source: AFSGD/UYUlJAYj0dFHtzdEu77Rv2L07O0k69nn8nJxan9zPgIUNBGOzeuLdD+qUeSoOiQWMZNZskZw==
X-Received: by 2002:a17:902:1745:: with SMTP id i63mr23699544pli.145.1543219832860;
        Mon, 26 Nov 2018 00:10:32 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id s190sm3761340pfb.103.2018.11.26.00.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:10:32 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/5] PM / Domains: Propagate performance state updates
Date:   Mon, 26 Nov 2018 13:40:04 +0530
Message-Id: <5a29ceb2704239a8efb4db2e47ca155a422a6e57.1543219386.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1543219386.git.viresh.kumar@linaro.org>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit updates genpd core to start propagating performance state
updates to master domains that have their set_performance_state()
callback set.

A genpd handles two type of performance states now. The first one is the
performance state requirement put on the genpd by the devices and
sub-domains under it, which is already represented by
genpd->performance_state. The second type, introduced in this commit, is
the performance state requirement(s) put by the genpd on its master
domain(s). There is a separate value required for each master that the
genpd has and so a new field is added to the struct gpd_link
(link->performance_state), which represents the link between a genpd and
its master. The struct gpd_link also got another field
prev_performance_state, which is used by genpd core as a temporary
variable during transitions.

We need to propagate setting performance state while powering-on a genpd
as well, as we ignore performance state requirements from sub-domains
which are powered-off. For this reason _genpd_power_on() also received
the additional parameter, depth, which is used for hierarchical locking
within genpd.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 113 ++++++++++++++++++++++++++++++------
 include/linux/pm_domain.h   |   4 ++
 2 files changed, 98 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d6b389a9f678..206e263abe90 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -239,24 +239,88 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
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
+	unsigned int mstate;
 	int ret;
 
+	/* Propagate to masters of genpd */
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		master = link->master;
+
+		if (!master->set_performance_state)
+			continue;
+
+		if (unlikely(!state)) {
+			mstate = 0;
+		} else {
+			/* Find master's performance state */
+			mstate = dev_pm_opp_xlate_performance_state(genpd->opp_table,
+					master->opp_table, state);
+			if (unlikely(!mstate)) {
+				ret = -EINVAL;
+				goto err;
+			}
+		}
+
+		genpd_lock_nested(master, depth + 1);
+
+		link->prev_performance_state = link->performance_state;
+		link->performance_state = mstate;
+		ret = _genpd_reeval_performance_state(master, mstate, depth + 1);
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
+		mstate = link->prev_performance_state;
+		link->performance_state = mstate;
+
+		if (_genpd_reeval_performance_state(master, mstate, depth + 1)) {
+			pr_err("%s: Failed to roll back to %d performance state\n",
+			       master->name, mstate);
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
@@ -274,18 +338,27 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
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
+	 * Traverse all powered-on subdomains within the domain. This can be
+	 * done without any additional locking as the link->performance_state
+	 * field is protected by the master genpd->lock, which is already taken.
+	 *
+	 * Also note that link->performance_state (subdomain's performance state
+	 * requirement to master domain) is different from
+	 * link->slave->performance_state (current performance state requirement
+	 * of the devices/sub-domains of the subdomain) and so can have a
+	 * different value.
 	 */
+	list_for_each_entry(link, &genpd->master_links, master_node) {
+		if (!genpd_status_on(link->slave))
+			continue;
+
+		if (link->performance_state > state)
+			state = link->performance_state;
+	}
+
+	if (state == genpd->performance_state)
+		return 0;
 
 update_state:
 	if (!genpd_status_on(genpd)) {
@@ -293,7 +366,7 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 		return 0;
 	}
 
-	return _genpd_set_performance_state(genpd, state);
+	return _genpd_set_performance_state(genpd, state, depth);
 }
 
 /**
@@ -337,7 +410,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	prev = gpd_data->performance_state;
 	gpd_data->performance_state = state;
 
-	ret = _genpd_reeval_performance_state(genpd, state);
+	ret = _genpd_reeval_performance_state(genpd, state, 0);
 	if (ret)
 		gpd_data->performance_state = prev;
 
@@ -347,7 +420,8 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
 
-static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
+static int
+_genpd_power_on(struct generic_pm_domain *genpd, bool timed, int depth)
 {
 	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
@@ -368,7 +442,8 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 
 	if (unlikely(genpd->set_performance_state)) {
-		ret = genpd->set_performance_state(genpd, genpd->performance_state);
+		ret = _genpd_set_performance_state(genpd,
+					genpd->performance_state, depth);
 		if (ret) {
 			pr_warn("%s: Failed to set performance state %d (%d)\n",
 				genpd->name, genpd->performance_state, ret);
@@ -558,7 +633,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 		}
 	}
 
-	ret = _genpd_power_on(genpd, true);
+	ret = _genpd_power_on(genpd, true, depth);
 	if (ret)
 		goto err;
 
@@ -963,7 +1038,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 			genpd_unlock(link->master);
 	}
 
-	_genpd_power_on(genpd, false);
+	_genpd_power_on(genpd, false, depth);
 
 	genpd->status = GPD_STATE_ACTIVE;
 }
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

