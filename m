Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753036AbeDLLOp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:14:45 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39665 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752990AbeDLLOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:14:43 -0400
X-Google-Smtp-Source: AIpwx4/kN3Zg2iIgfZ3XjIm1cwk0RfPJetxKc63A1N0ZfQcHynNv8b1DqqOStnQesU8Bl4L01LJeDw==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 02/26] PM / Domains: Deal with multiple states but no governor in genpd
Date: Thu, 12 Apr 2018 13:14:07 +0200
Message-Id: <1523531671-27491-3-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
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
---
 drivers/base/power/domain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c2ef944..9aff79d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -466,6 +466,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			return -EAGAIN;
 	}
 
+	/* Default to shallowest state. */
+	if (!genpd->gov)
+		genpd->state_idx = 0;
+
 	if (genpd->power_off) {
 		int ret;
 
@@ -1694,6 +1698,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		ret = genpd_set_default_power_state(genpd);
 		if (ret)
 			return ret;
+	} else if (!gov) {
+		pr_warn("%s : no governor for states\n", genpd->name);
 	}
 
 	mutex_lock(&gpd_list_lock);
-- 
2.7.4
