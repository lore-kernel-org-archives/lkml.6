Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 398AFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB95208D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 05:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0LO6+Rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFB95208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752601AbeFNFXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 01:23:42 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36694 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751493AbeFNFXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 01:23:40 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so2854776plp.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 22:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=riQdcz6+FOz8WRGOM+lvtaahJNw9AF7mKMiTRAgGwYE=;
        b=A0LO6+Rj6awRHUsiZyCwfyM6oDmWvXsIV4PDutDV9+l3zdcyim+0h2mRTD22dkHPRx
         wqnBx8zbpz5mr7w3GTMaxUinsdqYLGldQGy3fOyR0gKK0aEJZzK+K298S+4SVcthAGhC
         GjMbsree5YQc2pEw9RjmsDSPYxHuGETzKTb04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=riQdcz6+FOz8WRGOM+lvtaahJNw9AF7mKMiTRAgGwYE=;
        b=Hfiaf85/6jr9TRpfITi15e8Z+JNHzDaM9fjEy/eVfVhzSnjg8EzO6YiC/ZAxhBzbfe
         imvHh2WsKNRQwr/HAg+U6nMiSE5UvfVkJu4cNOF4/+5n6qmRpR4BngbcvX0m8CMkR69Z
         pd22VDLEpipPfIlccZZeniF9t2EanzyhXfub0yNR6Ltv+YsOvfvwYhY5p92Wtc2BSysL
         kD457MHkwW9vsWkRzVSBUQsTUgszP64JRpczuVF5eEoA0bIo6VBVdOXgbnw1kM4kX7Ck
         xJxc7kx56fbvxkxKVV+VNBWHHF2mp1KgO/U2pbjpyjR7GhVQK+cuT6DRi+WmkzjoGPLs
         yvrg==
X-Gm-Message-State: APt69E1pxXx4fqSg+dZ6cf0nj8/VAW4vgaZ0b0AHPMxNZ4hizoTjTCKu
        kXK6Fm0P0vg01EJLlL1BBFVAYw==
X-Google-Smtp-Source: ADUXVKIlpP/BGX+QJzD2qUi8FJ44FthGPllWwGipulXv+8gQ1YAheYYxiNcbHAxRq6iOv/JRfAL9Tg==
X-Received: by 2002:a17:902:264:: with SMTP id 91-v6mr1243922plc.341.1528953820297;
        Wed, 13 Jun 2018 22:23:40 -0700 (PDT)
Received: from localhost ([223.226.91.101])
        by smtp.gmail.com with ESMTPSA id m21-v6sm4970891pgv.27.2018.06.13.22.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 22:23:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PM / Domains: Rename opp_node to np
Date:   Thu, 14 Jun 2018 10:53:33 +0530
Message-Id: <b90f44d35e8e0fa9c81b3a88d05449a580be5567.1528953706.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT node passed here isn't necessarily an OPP node, as this routine
can also be used for cases where the "required-opps" property is present
directly in the device's node. Rename it.

This also removes a stale comment.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/domain.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

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
-- 
2.18.0.rc1.242.g61856ae69a2c

