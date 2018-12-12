Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1843C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962E82086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEnLiF31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962E82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbeLLK5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:57:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45287 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeLLK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:57:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so8434817plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5kLi4xuwk7dpMQcurWuHvhYASg5acLmavueiEtTxTk=;
        b=fEnLiF31ENthjSEay6GYdC4yQO4wtTnRTh0ZrBobbwmNGml2sASHWOMsN43O5t4bQ0
         FU/o2D4z0RGFUZozFNk2gIMWbECLMXgRaO9jK6mCiQhW4Jyfd10gVeVKx8gKe8jrniBe
         UBnsXVP5+R19EZ9szMeWR3kw5gJiWfEx86Gco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5kLi4xuwk7dpMQcurWuHvhYASg5acLmavueiEtTxTk=;
        b=f8jiR3gThGxVEr77mn/uWGGv416VS0L54yTOmApoykw+PSqN6HzU3izfgFMK1ZO8gp
         SCuCBtAiXxxH3bA6+nbzUqXBU2kg4jsiA1FyXrYamYNdS/7/c1YIHXdUIAh3NhMySbun
         Yn0Yny+RFDBQ2WNBdIyTi/N9FJmmVutcGhaISkE1MJPqiOotFfwyb1H4TcnBzJ9pb5on
         3bg/r60b53PYKiFobAtqLbWwOXVfErGSMIU17NCKceC2I8NnqsyB14sVS8bQgSbFZ/L3
         uqQzozgkDGGZyR5yJousPo0OrooI28mS2r8MVG9swzNlPjYqGSpvdRNjh/pNZ2QYTOLd
         jXKQ==
X-Gm-Message-State: AA+aEWY367WYhqTttxPi2GiAsV8GvHU8QJaPWql5hvWJhWiFb2YjzY2K
        dDYSJ3dvuXZFbgsyf+mY/J79WQ==
X-Google-Smtp-Source: AFSGD/VhUKOXd23cjCXLzs5MlNYmc7H7lLyOHHaphafBRuOf/SybAHAkYDFe2BTukDne6agpOesCRg==
X-Received: by 2002:a17:902:1682:: with SMTP id h2mr19339386plh.243.1544612269932;
        Wed, 12 Dec 2018 02:57:49 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id u8sm23413177pfl.16.2018.12.12.02.57.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 02:57:49 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/6] PM / Domains: Make genpd performance states orthogonal to the idlestates
Date:   Wed, 12 Dec 2018 16:27:24 +0530
Message-Id: <48a7fc66faec9ac5c157b0cadcdaeb07bfe78781.1544611890.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544611890.git.viresh.kumar@linaro.org>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ulf Hansson <ulf.hansson@linaro.org>

It's quite questionable whether genpd internally should care about if the
corresponding PM domain for a device is powered on, as to allow setting a
new performance state for it. The assumptions creates an unnecessary
limitation at this point, for both consumers and providers, but more
importantly it also makes the code more complicated.

Therefore, let's simplify the code to allow setting a performance state, by
invoking the ->set_performance_state() callback, no matter whether the PM
domain is powered on or off.

Do note, this change means genpd providers needs to restore the performance
state themselves during power on, via the ->power_on() callback. Moreover,
they may also need to check that the PM domain is powered on, from their
->set_performance_state() callback, before deciding to update the state.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8e554e6a82a2..4a4e39d12354 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -311,12 +311,10 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state)
 	 */
 
 update_state:
-	if (genpd_status_on(genpd)) {
-		ret = genpd->set_performance_state(genpd, state);
-		if (ret) {
-			gpd_data->performance_state = prev;
-			goto unlock;
-		}
+	ret = genpd->set_performance_state(genpd, state);
+	if (ret) {
+		gpd_data->performance_state = prev;
+		goto unlock;
 	}
 
 	genpd->performance_state = state;
@@ -347,15 +345,6 @@ static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
 		return ret;
 
 	elapsed_ns = ktime_to_ns(ktime_sub(ktime_get(), time_start));
-
-	if (unlikely(genpd->set_performance_state)) {
-		ret = genpd->set_performance_state(genpd, genpd->performance_state);
-		if (ret) {
-			pr_warn("%s: Failed to set performance state %d (%d)\n",
-				genpd->name, genpd->performance_state, ret);
-		}
-	}
-
 	if (elapsed_ns <= genpd->states[state_idx].power_on_latency_ns)
 		return ret;
 
-- 
2.19.1.568.g152ad8e3369a

