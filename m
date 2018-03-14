Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752136AbeCNRIw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:08:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46363 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCNQ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:59:05 -0400
X-Google-Smtp-Source: AG47ELs3eF+sBpGB/98M1eL8koIYYSgfJ8k9SzJ/PsYUCz/rGNZvzdFkTJJ6vff7P+ksq/Ou7ZusOg==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
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
Subject: [PATCH v6 01/25] PM / Domains: Don't treat zero found compatible idle states as an error
Date: Wed, 14 Mar 2018 17:58:11 +0100
Message-Id: <1521046715-30683-2-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of returning -EINVAL from of_genpd_parse_idle_states() in case none
compatible states was found, let's return 0 to indicate success. Assign
also the out-parameter *states to NULL and *n to 0, to indicate to the
caller that zero states have been found/allocated.

This enables the caller of of_genpd_parse_idle_states() to easier act on
the returned error code.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 1ea0e25..c2ef944 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2331,8 +2331,8 @@ static int genpd_iterate_idle_states(struct device_node *dn,
  *
  * Returns the device states parsed from the OF node. The memory for the states
  * is allocated by this function and is the responsibility of the caller to
- * free the memory after use. If no domain idle states is found it returns
- * -EINVAL and in case of errors, a negative error code.
+ * free the memory after use. If any or zero compatible domain idle states is
+ * found it returns 0 and in case of errors, a negative error code is returned.
  */
 int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n)
@@ -2341,8 +2341,14 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 	int ret;
 
 	ret = genpd_iterate_idle_states(dn, NULL);
-	if (ret <= 0)
-		return ret < 0 ? ret : -EINVAL;
+	if (ret < 0)
+		return ret;
+
+	if (!ret) {
+		*states = NULL;
+		*n = 0;
+		return 0;
+	}
 
 	st = kcalloc(ret, sizeof(*st), GFP_KERNEL);
 	if (!st)
-- 
2.7.4
