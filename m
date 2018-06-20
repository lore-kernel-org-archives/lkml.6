Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66AEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9201420652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8/mzRnK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9201420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754147AbeFTGPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:15:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:47081 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeFTGPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:15:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id 30-v6so1155827pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sz6tTIZvvI590FAOm6WLnM84e5bFQiD4UNljdabVAC4=;
        b=N8/mzRnKOiEEEjPRY0BkxtMP0Vi+U9I9xCxk8PH2AwXwizKCZ47TXr4DPERdt9mPvj
         CcQF4L7kP6L9v+9rL461IvgVJ7tbe+ahCp+d5qoPj6wSTlCStzIcm5v6r98/kmMpXo2W
         7jnp7UnoWA3S2jwPWDv+Usumql53+z2cXMAKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sz6tTIZvvI590FAOm6WLnM84e5bFQiD4UNljdabVAC4=;
        b=ssDWMAmN+UXZN+pO50//BoIWb/9i3goqqQoFHQ6HomoN5boQ9mOht6+2N3NcCw9mLX
         dn5bZ0nnYSIFR+Hd01RbeCUcy4iq6Vgzbzr3vnf0WL5IJ2hcC3cHiOGcCGqXZUL9VHK0
         xmcgLOdud6b2QSmxmqUQxyG4NDeU1YHsbXFvXCCZdm/WlImgc1yKn7maErwBF2ofqPuD
         GAZyiDgXXg2TdzTRk1yFgoUsUvHuIGkKxg2dZ758IvQXofiLasfHYvPto9l03IllML91
         LnpQ9J253Vob8jDIUP1fqfwMG+6Ubo/nSC8Rsb+mjPpYXSpdo7MoR3Z+F4LpQeQPq58a
         lQ9A==
X-Gm-Message-State: APt69E2U8ccuVUXdfH8ToNOGmVmfLupIFBRYtNAtzWpPkf9pDPvEhnyn
        YzSxO/JsfvtJLZ/siNw+7FvXfg==
X-Google-Smtp-Source: ADUXVKLuqDmrmxdh6Tsj+Ub8AI+vg2qPIMnhMGLjaB59lVUWIGi6Jf4kR4B0qZXK8sza9EO/7MMtOg==
X-Received: by 2002:a17:902:b40f:: with SMTP id x15-v6mr22365817plr.270.1529475343199;
        Tue, 19 Jun 2018 23:15:43 -0700 (PDT)
Received: from localhost ([122.171.103.96])
        by smtp.gmail.com with ESMTPSA id z82-v6sm2564663pfk.30.2018.06.19.23.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 23:15:41 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] PM / Domains: Rename opp_node to np
Date:   Wed, 20 Jun 2018 11:45:37 +0530
Message-Id: <7511c9837569aec34c56e0a40364f2f3c16563b6.1529475153.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <3d3687c030535189885d84c57dbffb034c4461c2.1528953706.git.viresh.kumar@linaro.org>
References: <3d3687c030535189885d84c57dbffb034c4461c2.1528953706.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT node passed here isn't necessarily an OPP node, as this routine
can also be used for cases where the "required-opps" property is present
directly in the device's node. Rename it.

This also removes a stale comment.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Updated variable name in header file as well.
- Because it was a very small change, I added Ulf's Ack as well.

 drivers/base/power/domain.c | 7 +++----
 include/linux/pm_domain.h   | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4925af5c4cf0..c298de8a8308 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2487,10 +2487,9 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
  * power domain corresponding to a DT node's "required-opps" property.
  *
  * @dev: Device for which the performance-state needs to be found.
- * @opp_node: DT node where the "required-opps" property is present. This can be
+ * @np: DT node where the "required-opps" property is present. This can be
  *	the device node itself (if it doesn't have an OPP table) or a node
  *	within the OPP table of a device (if device has an OPP table).
- * @state: Pointer to return performance state.
  *
  * Returns performance state corresponding to the "required-opps" property of
  * a DT node. This calls platform specific genpd->opp_to_performance_state()
@@ -2499,7 +2498,7 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
  * Returns performance state on success and 0 on failure.
  */
 unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-					       struct device_node *opp_node)
+					       struct device_node *np)
 {
 	struct generic_pm_domain *genpd;
 	struct dev_pm_opp *opp;
@@ -2514,7 +2513,7 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 
 	genpd_lock(genpd);
 
-	opp = of_dev_pm_opp_find_required_opp(&genpd->dev, opp_node);
+	opp = of_dev_pm_opp_find_required_opp(&genpd->dev, np);
 	if (IS_ERR(opp)) {
 		dev_err(dev, "Failed to find required OPP: %ld\n",
 			PTR_ERR(opp));
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 9206a4fef9ac..e1d18ce3a310 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -234,7 +234,7 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
 int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
 unsigned int of_genpd_opp_to_performance_state(struct device *dev,
-				struct device_node *opp_node);
+				struct device_node *np);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -274,7 +274,7 @@ static inline int of_genpd_parse_idle_states(struct device_node *dn,
 
 static inline unsigned int
 of_genpd_opp_to_performance_state(struct device *dev,
-				  struct device_node *opp_node)
+				  struct device_node *np)
 {
 	return -ENODEV;
 }
-- 
2.18.0.rc1.242.g61856ae69a2c

