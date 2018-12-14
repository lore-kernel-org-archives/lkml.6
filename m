Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1113DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA74B2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HQrMDzUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA74B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbeLNKPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:15:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35170 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbeLNKPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:15:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so2541962plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5kLi4xuwk7dpMQcurWuHvhYASg5acLmavueiEtTxTk=;
        b=HQrMDzUqh3MUYQIsDHDucLjzhFpViI0N/rtfVw4d1bhzFgHCKawj+qxQCgLU/kTnPM
         Iagdiv7rUyhq4WsM3jCFOcO4FGkEdyRWtKoUXL9p/Fvq7f2PLGQSqdoe+w3qAOJpvduE
         bEKyAoYUWI8pFOLmUCpZZV/d87yuWc6Izqo4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5kLi4xuwk7dpMQcurWuHvhYASg5acLmavueiEtTxTk=;
        b=A+fEVWNOIrBHR2c9eyNO1XyNQV9Hgg/YDZpcQHQZh+wLTaqGN+y2aLuoCoeJbBKqHI
         Uddvtiu88wbEQIk/VH9OarH7MkilO1ZYnPLdUSPsDpRL4w2dluPUhU2ezntqx1lpz7yh
         ufvwbVtMPN9kIF6/ZbrQuv00kbdHisywMAA98s0P+k79uFhBSRhCPJk0A68zYQb6benG
         px8Bx/UO1fb5uJNgilFrTMRprgz8ES0kMtwIP2zQ8NLGOheP7Vz+gltITMmaTCVvBxOW
         BpXPivsnbpCwf1WLSg8VEXsrSPc5Ul+HsDWmBqbJOJAwlb9ZPi17wvV9bn9w3bQUO9H0
         K0vQ==
X-Gm-Message-State: AA+aEWYhXWbG+0GHipVqSUsFBVNRKxASODC5utlKE3H2qa0DBVkYKg++
        piBGkegfi3Yvo2+CZigeaRH11A==
X-Google-Smtp-Source: AFSGD/UDvhbg1OycFTg9wu1XyHuLfFhVFbus9c/P2VwjmxbbJ3gLL21I8CKgmOGCWC9+cykpljnLEQ==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr2237750pls.71.1544782541779;
        Fri, 14 Dec 2018 02:15:41 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id p24sm6290090pfk.155.2018.12.14.02.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:15:41 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/7] PM / Domains: Make genpd performance states orthogonal to the idlestates
Date:   Fri, 14 Dec 2018 15:45:27 +0530
Message-Id: <48a7fc66faec9ac5c157b0cadcdaeb07bfe78781.1544782279.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544782279.git.viresh.kumar@linaro.org>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
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

