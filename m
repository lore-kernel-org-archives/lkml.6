Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933251AbeE2KFr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:05:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39703 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933161AbeE2KEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:04:39 -0400
X-Google-Smtp-Source: ADUXVKJK3dwOGTKFXDCJ5cCyWrUDOuFQ26iIEK3p1ZsbUBz4yn4KPAjlTTTzBDQDPwalUGToKncNBQ==
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
Subject: [PATCH v2 6/9] PM / Domains: Don't attach devices in genpd with multi PM domains
Date: Tue, 29 May 2018 12:04:18 +0200
Message-Id: <20180529100421.31022-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529100421.31022-1-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power-domain DT property may now contain a list of PM domain
specifiers, which represents that a device are partitioned across multiple
PM domains. This leads to a new situation in genpd_dev_pm_attach(), as only
one PM domain can be attached per device.

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

Changes in v2:
	- Minor update to changelog to mention "PM domain specifiers" rather
	than a "list of phandles".

---
 drivers/base/power/domain.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7ebf7993273a..12a20f21974d 100644
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
2.17.0
