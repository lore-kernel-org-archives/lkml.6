Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC9C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB98B21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WF/uDC6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB98B21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbeK3ExV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37763 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbeK3ExV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:21 -0500
Received: by mail-lf1-f66.google.com with SMTP id p17so2118295lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2OFzyl7DYqM+TKMo2yE9Sged+x4IOY1BMaINc0irzbk=;
        b=WF/uDC6cto89UDdfBnGrf81NlzZ26+j7fWxzr3FcUZ6bWkeWgWVSaZuoeSFwtlCJcl
         ngNYcGXO/yOYk1SP4DlEzNaHgCCudJxCxzVB9V/lGel5iAWprOmMJl3y0UydtSlM96+S
         vrGMzuCnis/xZHu8BwGfiah6JjJ2lyvNiNMLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2OFzyl7DYqM+TKMo2yE9Sged+x4IOY1BMaINc0irzbk=;
        b=FVe/HghN8Fx34yFVtLTNg5MesfvfuM3J2+TFY34o9DIB9lVYciU9pBp3PRg0mTZnMb
         ddcn6eynsItdM05BSjN4KQEwhYdbWhYMPdheJ4aUOmPjdccIzIqWUS6y/yCqQayQJHDM
         Cur1kL5y9S86ElLNPKrrUHnspMNfZICQ8MEz6FkpsEgC4Qr6vcA9NYptgLdiTj5Euoeg
         xEYzUB5PA9vwu3/ps8/vOt/S5mNLXW/rQHVLAsT+ex/X5O4oY7WpprwX5pHsblGnHLiN
         YM8iRcrY8/WbkIXMS710P+y3NaD06zBldfkiF7duE3VMyKFsxDXsLCI62cZqqqKJigpE
         xS0w==
X-Gm-Message-State: AA+aEWaqURy3BrttE0MvbGJL86nuE/KEyUUFCsTdnV9IIYiOz8A6XK2x
        lFAYNcLMdx+JW6YgW4UL5ZJ/ow==
X-Google-Smtp-Source: AFSGD/WcONLGmNXYECO9oNRUxrjzh2zAGhw9wIqkXq80q8IdpwQYFhZTN3X/sVmIELfDUDxcx4LF2Q==
X-Received: by 2002:a19:2c92:: with SMTP id s140mr1622412lfs.42.1543513630200;
        Thu, 29 Nov 2018 09:47:10 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:09 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 01/27] PM / Domains: Add generic data pointer to genpd_power_state struct
Date:   Thu, 29 Nov 2018 18:46:34 +0100
Message-Id: <20181129174700.16585-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add a data pointer to the genpd_power_state struct, to allow a genpd
backend driver to store per state specific data. In order to introduce the
pointer, we also need to adopt how genpd frees the allocated data for the
default genpd_power_state struct, that it may allocate at pm_genpd_init().

More precisely, let's use an internal genpd flag to understand when the
states needs to be freed by genpd. When freeing the states data in
genpd_remove(), let's also clear the corresponding genpd->states pointer
and reset the genpd->state_count. In this way, a genpd backend driver
becomes aware of when there is state specific data for it to free.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Update the patch allow backend drivers to free the states specific
	  data during genpd removal. Due to this added complexity, I decided to
	  keep the patch separate, rather than fold it into the patch that makes
	  use of the new void pointer, which was suggested by Rafael.
	- Claim authorship of the patch as lots of changes has been done since
	  the original pick up from Lina Iyer.

---
 drivers/base/power/domain.c | 8 ++++++--
 include/linux/pm_domain.h   | 3 ++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7f38a92b444a..e27b91d36a2a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1620,7 +1620,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
 
 	genpd->states = state;
 	genpd->state_count = 1;
-	genpd->free = state;
+	genpd->free_state = true;
 
 	return 0;
 }
@@ -1736,7 +1736,11 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
-	kfree(genpd->free);
+	if (genpd->free_state) {
+		kfree(genpd->states);
+		genpd->states = NULL;
+		genpd->state_count = 0;
+	}
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
 
 	return 0;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3b5d7280e52e..f9e09bd4152c 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -69,6 +69,7 @@ struct genpd_power_state {
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
+	void *data;
 };
 
 struct genpd_lock_ops;
@@ -110,7 +111,7 @@ struct generic_pm_domain {
 	struct genpd_power_state *states;
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
-	void *free; /* Free the state that was allocated for default */
+	bool free_state; /* Free the state that was allocated for default */
 	ktime_t on_time;
 	ktime_t accounting_time;
 	const struct genpd_lock_ops *lock_ops;
-- 
2.17.1

