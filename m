Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751777AbeE3KJT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 06:09:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42097 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeE3KJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 06:09:15 -0400
X-Google-Smtp-Source: ADUXVKISVY9mTXrd41twsbQfSAbUzWYFN4rzDV0jU1f4sUf1f8OGq8GG24oyNlc8V3VPH3HjHsHOIg==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] OPP: Allow same OPP table to be used for multiple genpd
Date: Wed, 30 May 2018 15:39:02 +0530
Message-Id: <8a352fd8787cefcb19c25ca1390301f874797b9c.1527674939.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP binding says:

	Property: operating-points-v2

	...

	This can contain more than one phandle for power domain
	providers that provide multiple power domains. That is, one
	phandle for each power domain. If only one phandle is available,
	then the same OPP table will be used for all power domains
	provided by the power domain provider.

But the OPP core isn't allowing the same OPP table to be used for
multiple domains. Update dev_pm_opp_of_add_table_indexed() to allow
that.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/opp/of.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 6d15f05bfc28..7af0ddec936b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -554,11 +554,24 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index)
 {
 	struct device_node *opp_np;
-	int ret;
+	int ret, count;
 
+again:
 	opp_np = _opp_of_get_opp_desc_node(dev->of_node, index);
-	if (!opp_np)
+	if (!opp_np) {
+		/*
+		 * If only one phandle is present, then the same OPP table
+		 * applies for all index requests.
+		 */
+		count = of_count_phandle_with_args(dev->of_node,
+						   "operating-points-v2", NULL);
+		if (count == 1 && index) {
+			index = 0;
+			goto again;
+		}
+
 		return -ENODEV;
+	}
 
 	ret = _of_add_opp_table_v2(dev, opp_np);
 	of_node_put(opp_np);
-- 
2.15.0.194.g9af6a3dea062
