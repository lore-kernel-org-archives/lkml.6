Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72F2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C83F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="n3NMzp/V";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bxYowwo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C83F2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeLKJuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:50:25 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:48912 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeLKJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:50:24 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3DC7D60B7E; Tue, 11 Dec 2018 09:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544521823;
        bh=8J6o5GFaGuB+vwvtTAe6kkisMe8sCWDlRJ75Q1KoJak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n3NMzp/VHcTkOpdDizMIKAWQtRiSjhMY94ylyZjxVS2Q5bvMQygeVn+PvoGGvX/mE
         2611sKRdrL1ioyV7CmaVJf1U/fUzLiqFFzTIrXIK4NxWkeJ2HNy3BrssBtNUcZAJYj
         jsTVwfjUvr4ZnIMeqg9YGTSPM9PECdEl//m+j73w=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D687560C5F;
        Tue, 11 Dec 2018 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1544521820;
        bh=8J6o5GFaGuB+vwvtTAe6kkisMe8sCWDlRJ75Q1KoJak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxYowwo4rVdYPH1WD2sP024GE/eAjf+EOjB6/IIYfC/tqIM26WdVofaYNsFKqNcfg
         kmgKTUgInXbSKNXsFrhYACdqOsFbYWuw8UfZWYuBjDjVDJJiyTnUcq6m5bW5TgQT5B
         fVfxiUF59+9aM6CRANnkJgFfxjpIJIpe5aVk8qGw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D687560C5F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v6 08/10] PM / Domains: Add a simple_opp_to_performance_state() helper
Date:   Tue, 11 Dec 2018 15:19:36 +0530
Message-Id: <20181211094938.25086-9-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181211094938.25086-1-rnayak@codeaurora.org>
References: <20181211094938.25086-1-rnayak@codeaurora.org>
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

