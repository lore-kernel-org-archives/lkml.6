Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDEAC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E5221470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DwRFYkao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E5221470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeJCV12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44760 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJCV1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id v6-v6so5334414ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kJSeKBUogM0CddiVrJB+tVbUEkpCSyoWfL42ruK06nI=;
        b=DwRFYkaoZ6lC+9pxBSR4zeinWa7QO2knEkf2vgyEZ51boEFWR8kOhlNQrxpBY0F/Bv
         9rFf56a4v0+He2NkyQVaeO2FF/UBKU51JdN7abJuUVv0q1eopsLZsVq4lBHVf+zDLYUt
         azaa9ZQZe93Cgh/u0+FgfbwSmdE4bBOgwxbvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kJSeKBUogM0CddiVrJB+tVbUEkpCSyoWfL42ruK06nI=;
        b=lJ7ytCwBH55wUyELScJ7Wf86EVxRLOp71S5lagvvZqVcSVjiv1kCkc42Ik/HhlHjO/
         GMwNxwitaie53Qo1Ropl/YUtUHiaSbBs+Wq0g8JjlEaJM6RyA1jOPg+RSwfL4wfE0pJU
         WcnOZ2ZqvjhluolOS8T+ZqpsQQgAqv2rpLYbFcWH7TdGxH3p2IEF37sPpG2z/VsD1sUp
         isQmVubUxWYXpFkV/VfShzawG51GDJUKXjX+ew3pEgehjy3Rz07oO6bU1MJMq8ZB3zdq
         dClDCNiKw76f4p6tIBvxT/9cRYdlVDPRSCY+ZZ4SnwiGECnSlCFXUCqLMsMSRKyldU+9
         /e0w==
X-Gm-Message-State: ABuFfogAWKBMCRI2rP+CQXluTNnBY54aS5ACGbAZ4gpbP7Thl5MAvvAS
        N+0GE8GiMoCY2tKBRyCpPFh4KQ==
X-Google-Smtp-Source: ACcGV6370bjHoVakbi2zeNv/IgWVUeb5Wz40qgaKOiXCLbCfIn0ouaVWSqOVrCfjNlpSIpy+kZ3erg==
X-Received: by 2002:a2e:9993:: with SMTP id w19-v6mr1327092lji.165.1538577522876;
        Wed, 03 Oct 2018 07:38:42 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 02/11] PM / Domains: Deal with multiple states but no governor in genpd
Date:   Wed,  3 Oct 2018 16:38:15 +0200
Message-Id: <20181003143824.13059-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A caller of pm_genpd_init() that provides some states for the genpd via the
->states pointer in the struct generic_pm_domain, should also provide a
governor. This because it's the job of the governor to pick a state that
satisfies the constraints.

Therefore, let's print a warning to inform the user about such bogus
configuration and avoid to bail out, by instead picking the shallowest
state before genpd invokes the ->power_off() callback.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/base/power/domain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e1bbddb02871..7f38a92b444a 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -467,6 +467,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			return -EAGAIN;
 	}
 
+	/* Default to shallowest state. */
+	if (!genpd->gov)
+		genpd->state_idx = 0;
+
 	if (genpd->power_off) {
 		int ret;
 
@@ -1687,6 +1691,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		ret = genpd_set_default_power_state(genpd);
 		if (ret)
 			return ret;
+	} else if (!gov) {
+		pr_warn("%s : no governor for states\n", genpd->name);
 	}
 
 	device_initialize(&genpd->dev);
-- 
2.17.1

