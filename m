Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892F0C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BEA2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WC3vY87l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BEA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLCIuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:50:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42483 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLCIup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:50:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so5397254pga.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1uH9MxkuXbcZplIw2PhRu0J/rnKp74L6usGhPd7FOU0=;
        b=WC3vY87lKBVZi7eIxbE5F2hEVZZumszQ22ibYQzI1aRIcq9qPlMAykfWpQiBagMoQc
         MRyXaeBsrM53mHZtvC2O4RpsPFGvcNK+w5NG355Hvq3FLDlxW4i23y3PL3l/lh167Irq
         UGQiIT7mbo7UuXywj/Uu4gYJWEZNnZcAZwOrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1uH9MxkuXbcZplIw2PhRu0J/rnKp74L6usGhPd7FOU0=;
        b=KEIYdpzF8rthZWKhBBTnt9Zs77d0V6Bpi3zCr/GokAMyiGQ6GneQOqxvzZ2tIJd06T
         mGk4cfv6XxOBVl7CqwXoljDScx8vsebxU4G8p/Uk3N1Z6EHdXZkFuxA+lph4TyeKawHD
         QIqAwQo50kD9sNskFbr4saFKr1t3KNvcwUnvRLpB9q6/2MUGOS+X4x+HcyO3zNQ5YPgB
         wFPkydeWbfrGSpAUnfpOtXx3U/i5aF9MAUOiJzCcq/xf8lRgu5ZC3YTEMR7rRoYQqKN5
         kSOdNZcE7fA5g6M+v3iiygFkz0D/Wv69fb6TpvOSUivvsKWGr42NbHuhRPAJvHLZmPxB
         s8/Q==
X-Gm-Message-State: AA+aEWYLkS5VV2lTu/okof+FO9Pxrljt93HXeMhF+5KuRGIaFt2lFOMc
        n5T9YiueN87/aXUVxvByyDvaig==
X-Google-Smtp-Source: AFSGD/UEHFH9musf+u+IP/mze0FfmlLsVsSEPgguagvmWy+E669qjIgi2KxRc8Gq1V7K1KIZ7qr1CA==
X-Received: by 2002:a63:2c0e:: with SMTP id s14mr12752893pgs.132.1543827039820;
        Mon, 03 Dec 2018 00:50:39 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id 134sm14722657pgb.78.2018.12.03.00.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 00:50:38 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:20:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 5/5] PM / Domains: Propagate performance state updates
Message-ID: <20181203085036.et2rfzxi6cbivv3j@vireshk-i7>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
 <5a29ceb2704239a8efb4db2e47ca155a422a6e57.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFpp1iPQ08QQjoi9b4RGUo2Zw_L_vjy8xtnSpg34gn--eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFpp1iPQ08QQjoi9b4RGUo2Zw_L_vjy8xtnSpg34gn--eA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-18, 10:44, Ulf Hansson wrote:
> On Mon, 26 Nov 2018 at 09:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
> > +                                          unsigned int state, int depth);
> > +
> 
> I don't like forward declarations like these, as in most cases it
> means that the code can be re-worked and improved.
> 
> However, because of the recursiveness code in genpd, I understand that
> it may be needed for some cases. Anyway, please have look and see if
> you can rid of it.

I tried, but I couldn't figure out a way to avoid this thing because of
recursion. Even if I break some of the parts out to another routine, then also
the dependency stays as is.

Below is the new diff after making all the changes you suggested.

-- 
viresh

-------------------------8<-------------------------
Subject: [PATCH] PM / Domains: Propagate performance state updates

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

We need to propagate setting performance state while powering-on a genpd
as well, as we ignore performance state requirements from sub-domains
which are powered-off. For this reason _genpd_power_on() also received
the additional parameter, depth, which is used for hierarchical locking
within genpd.

We can't take the genpd lock sometimes when _genpd_power_on() is called
from genpd_sync_power_on() and to take care of that several routine got
an additional parameter use_lock. This parameter is always set to true
if the call isn't initiated from genpd_sync_power_on(), else it receives
the use_lock parameter of genpd_sync_power_on() as is.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 122 ++++++++++++++++++++++++++++++------
 include/linux/pm_domain.h   |   4 ++
 2 files changed, 107 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index d6b389a9f678..165a04646657 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -239,24 +239,97 @@ static void genpd_update_accounting(struct generic_pm_domain *genpd)
 static inline void genpd_update_accounting(struct generic_pm_domain *genpd) {}
 #endif
 
+static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
+					   unsigned int state, int depth,
+					   bool use_lock);
+
 static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
-					unsigned int state)
+					unsigned int state, int depth,
+					bool use_lock)
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
+		if (use_lock)
+			genpd_lock_nested(master, depth + 1);
+
+		link->prev_performance_state = link->performance_state;
+		link->performance_state = master_state;
+		ret = _genpd_reeval_performance_state(master, master_state,
+						      depth + 1, use_lock);
+		if (ret)
+			link->performance_state = link->prev_performance_state;
+
+		if (use_lock)
+			genpd_unlock(master);
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
+		if (use_lock)
+			genpd_lock_nested(master, depth + 1);
+
+		master_state = link->prev_performance_state;
+		link->performance_state = master_state;
+
+		if (_genpd_reeval_performance_state(master, master_state,
+						    depth + 1, use_lock)) {
+			pr_err("%s: Failed to roll back to %d performance state\n",
+			       master->name, master_state);
+		}
+
+		if (use_lock)
+			genpd_unlock(master);
+	}
+
+	return ret;
 }
 
 static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
-					   unsigned int state)
+					   unsigned int state, int depth,
+					   bool use_lock)
 {
 	struct generic_pm_domain_data *pd_data;
 	struct pm_domain_data *pdd;
+	struct gpd_link *link;
 
 	/* New requested state is same as Max requested state */
 	if (state == genpd->performance_state)
@@ -274,18 +347,27 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
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
@@ -293,7 +375,7 @@ static int _genpd_reeval_performance_state(struct generic_pm_domain *genpd,
 		return 0;
 	}
 
-	return _genpd_set_performance_state(genpd, state);
+	return _genpd_set_performance_state(genpd, state, depth, use_lock);
 }
 
 /**
@@ -337,7 +419,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	prev = gpd_data->performance_state;
 	gpd_data->performance_state = state;
 
-	ret = _genpd_reeval_performance_state(genpd, state);
+	ret = _genpd_reeval_performance_state(genpd, state, 0, true);
 	if (ret)
 		gpd_data->performance_state = prev;
 
@@ -347,7 +429,8 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 }
 EXPORT_SYMBOL_GPL(dev_pm_genpd_set_performance_state);
 
-static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
+static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed,
+			   int depth, bool use_lock)
 {
 	unsigned int state_idx = genpd->state_idx;
 	ktime_t time_start;
@@ -368,7 +451,8 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
 
 	if (unlikely(genpd->set_performance_state)) {
-		ret = genpd->set_performance_state(genpd, genpd->performance_state);
+		ret = _genpd_set_performance_state(genpd,
+				genpd->performance_state, depth, use_lock);
 		if (ret) {
 			pr_warn("%s: Failed to set performance state %d (%d)\n",
 				genpd->name, genpd->performance_state, ret);
@@ -558,7 +642,7 @@ static int genpd_power_on(struct generic_pm_domain *genpd, unsigned int depth)
 		}
 	}
 
-	ret = _genpd_power_on(genpd, true);
+	ret = _genpd_power_on(genpd, true, depth, true);
 	if (ret)
 		goto err;
 
@@ -963,7 +1047,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
 			genpd_unlock(link->master);
 	}
 
-	_genpd_power_on(genpd, false);
+	_genpd_power_on(genpd, false, depth, use_lock);
 
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
