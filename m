Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752706AbeERKcE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:32:04 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41672 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeERKb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:31:57 -0400
X-Google-Smtp-Source: AB8JxZoDjYfqlw1Mw1sfEZLrtPeCkPK3p/6U38zWopdmXmNDtTS+kkQ9UAI7Jk8m+uL+2pifybjtUA==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 6/9] PM / Domains: Don't attach devices in genpd with multi PM domains
Date: Fri, 18 May 2018 12:31:27 +0200
Message-Id: <1526639490-12167-7-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power-domain DT property may now contain a list of phandles, which
represents that a device are partitioned across multiple PM domains. This
leads to a new situation in genpd_dev_pm_attach(), as only one PM domain
can be attached per device.

To remain things simple for the most common configuration, when a single PM
domain is used, let's treat the multiple PM domain case as being specific.

In other words, let's change genpd_dev_pm_attach() to check for multiple PM
domains and prevent it from attach any PM domain for this case. Instead,
leave this to be managed separately, from following changes to genpd.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Suggested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 050ce07..4597e1c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2229,10 +2229,10 @@ static void genpd_dev_pm_sync(struct device *dev)
  * attaches the device to retrieved pm_domain ops.
  *
  * Returns 1 on successfully attached PM domain, 0 when the device don't need a
- * PM domain or a negative error code in case of failures. Note that if a
- * power-domain exists for the device, but it cannot be found or turned on,
- * then return -EPROBE_DEFER to ensure that the device is not probed and to
- * re-try again later.
+ * PM domain or when multiple power-domains exists for it, else a negative error
+ * code. Note that if a power-domain exists for the device, but it cannot be
+ * found or turned on, then return -EPROBE_DEFER to ensure that the device is
+ * not probed and to re-try again later.
  */
 int genpd_dev_pm_attach(struct device *dev)
 {
@@ -2243,10 +2243,18 @@ int genpd_dev_pm_attach(struct device *dev)
 	if (!dev->of_node)
 		return 0;
 
+	/*
+	 * Devices with multiple PM domains must be attached separately, as we
+	 * can only attach one PM domain per device.
+	 */
+	if (of_count_phandle_with_args(dev->of_node, "power-domains",
+				       "#power-domain-cells") != 1)
+		return 0;
+
 	ret = of_parse_phandle_with_args(dev->of_node, "power-domains",
 					"#power-domain-cells", 0, &pd_args);
 	if (ret < 0)
-		return 0;
+		return ret;
 
 	mutex_lock(&gpd_list_lock);
 	pd = genpd_get_from_provider(&pd_args);
-- 
2.7.4
