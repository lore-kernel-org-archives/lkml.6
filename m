Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7094EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9E8218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 08:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gasSDXeG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Z2EhZg0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388756AbeLUI5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 03:57:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388686AbeLUI5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 03:57:07 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 376B060A24; Fri, 21 Dec 2018 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382626;
        bh=9YvJ2fsT3jjZ3tYnIgIwk7jIYi0ckWOAZ/uA5o2v6VQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gasSDXeGn7j7G7yilewGYKVtLPjxAmGUquyclvjhhmNeSB3yuT/GlpeUnGiZOQNSO
         tuurANt4y8baQXRyULM0ouLRjeTTBi3br6LtV6NMgb+feY5WFv9HC5wFsoCF8yRKJI
         dmg5lEC9Vge9eixQsfXL5OXbnPzmGJmIMLJ0NEl4=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EF5F8609E2;
        Fri, 21 Dec 2018 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545382624;
        bh=9YvJ2fsT3jjZ3tYnIgIwk7jIYi0ckWOAZ/uA5o2v6VQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z2EhZg0zqVHW88pC50vENdUCwnph9Ct25Tg0wAxMlhFakSiAJ8uAmLxae2R5BhUQ3
         FWgD6AtbxCq4fR9Ug6TNx2iqqyOCWKpURTOCD3wVy1jn9dAQrofFCTFpBq/KQJetoe
         iO/1hs4iZJW1H39zwzLLAJhAni1OasPD9Y0+NWp0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF5F8609E2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v8 08/10] PM / Domains: Add a simple_opp_to_performance_state() helper
Date:   Fri, 21 Dec 2018 14:26:20 +0530
Message-Id: <20181221085622.25573-9-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181221085622.25573-1-rnayak@codeaurora.org>
References: <20181221085622.25573-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have atleast 2 genpd providers, both using a simple
routine to read a performance state value from device tree and
return it, in order to implement the .opp_to_performance_state
callback, add a simple_opp_to_performance_state() helper to do
it, so it can be resued across all such genpd providers which
just need to read the value from DT.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/power/domain.c | 17 +++++++++++++++++
 include/linux/pm_domain.h   |  9 +++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8e554e6a82a2..193872afbe20 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2520,6 +2520,23 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 }
 EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 
+unsigned int simple_opp_to_performance_state(struct generic_pm_domain *genpd,
+					     struct dev_pm_opp *opp,
+					     const char *name)
+{
+	struct device_node *np;
+	unsigned int perf_state = 0;
+
+	np = dev_pm_opp_get_of_node(opp);
+	if (of_property_read_u32(np, name, &perf_state))
+		pr_err("%s: missing %s property\n", __func__, name);
+
+	of_node_put(np);
+
+	return perf_state;
+}
+EXPORT_SYMBOL_GPL(simple_opp_to_performance_state);
+
 /**
  * pm_genpd_opp_to_performance_state - Gets performance state of the genpd from its OPP node.
  *
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 642036952553..7e5777b081ee 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -260,6 +260,9 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 			       struct genpd_power_state **states, int *n);
 unsigned int pm_genpd_opp_to_performance_state(struct device *genpd_dev,
 					       struct dev_pm_opp *opp);
+unsigned int simple_opp_to_performance_state(struct  generic_pm_domain *genpd,
+					     struct dev_pm_opp *opp,
+					     const char *name);
 
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
@@ -306,6 +309,12 @@ pm_genpd_opp_to_performance_state(struct device *genpd_dev,
 	return 0;
 }
 
+unsigned int simple_opp_to_performance_state(struct generic_pm_domain *genpd,
+					     struct dev_pm_opp *opp,
+					     const char *name)
+{
+	return 0;
+}
 static inline int genpd_dev_pm_attach(struct device *dev)
 {
 	return 0;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

