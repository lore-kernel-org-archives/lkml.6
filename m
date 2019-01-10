Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCF3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D258F2184A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b5kMwvC4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="b5kMwvC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfAJEDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:03:17 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50498 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfAJEDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:03:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E948D60909; Thu, 10 Jan 2019 04:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092994;
        bh=REeYR9klFkvldEk9TtltTL3XpkfwWq0PPbhSV3EtTq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5kMwvC4VjCOrfSgjQrutwxdoZGfK7zX1s49sSl9lBghcI0dIr/xlLPWQoy5A9enz
         oEWaGpFUXe6faMemZCsTN23p8BcuUPimu3zVrhl+SGZQ3h8CHQCVcyik4CvwXNrOUn
         YzMID5CroZdQDC+T6D5JQmJUY9cc7rhVUGpptIrA=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 91C24608D2;
        Thu, 10 Jan 2019 04:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547092994;
        bh=REeYR9klFkvldEk9TtltTL3XpkfwWq0PPbhSV3EtTq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b5kMwvC4VjCOrfSgjQrutwxdoZGfK7zX1s49sSl9lBghcI0dIr/xlLPWQoy5A9enz
         oEWaGpFUXe6faMemZCsTN23p8BcuUPimu3zVrhl+SGZQ3h8CHQCVcyik4CvwXNrOUn
         YzMID5CroZdQDC+T6D5JQmJUY9cc7rhVUGpptIrA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 91C24608D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v11 2/9] OPP: Add support for parsing the 'opp-level' property
Date:   Thu, 10 Jan 2019 09:32:02 +0530
Message-Id: <20190110040209.6028-3-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190110040209.6028-1-rnayak@codeaurora.org>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the OPP bindings are updated to include an optional
'opp-level' property, add support to parse it from device tree
and store it as part of dev_pm_opp structure.
Also add and export an helper 'dev_pm_opp_get_level()' that can be
used to get the level value read from device tree when present.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/opp/core.c     | 18 ++++++++++++++++++
 drivers/opp/of.c       |  2 ++
 drivers/opp/opp.h      |  2 ++
 include/linux/pm_opp.h |  7 +++++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e5507add8f04..90b78a122be9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -130,6 +130,24 @@ unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_freq);
 
+/**
+ * dev_pm_opp_get_level() - Gets the level corresponding to an available opp
+ * @opp:	opp for which level value has to be returned for
+ *
+ * Return: level read from device tree corresponding to the opp, else
+ * return 0.
+ */
+unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
+{
+	if (IS_ERR_OR_NULL(opp) || !opp->available) {
+		pr_err("%s: Invalid parameters\n", __func__);
+		return 0;
+	}
+
+	return opp->level;
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_get_level);
+
 /**
  * dev_pm_opp_is_turbo() - Returns if opp is turbo OPP or not
  * @opp: opp for which turbo mode is being verified
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 06f0f632ec47..1779f2c93291 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -594,6 +594,8 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 		new_opp->rate = (unsigned long)rate;
 	}
 
+	of_property_read_u32(np, "opp-level", &new_opp->level);
+
 	/* Check if the OPP supports hardware's hierarchy of versions or not */
 	if (!_opp_is_supported(dev, opp_table, np)) {
 		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e24d81497375..4458175aa661 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -60,6 +60,7 @@ extern struct list_head opp_tables;
  * @suspend:	true if suspend OPP
  * @pstate: Device's power domain's performance state.
  * @rate:	Frequency in hertz
+ * @level:	Performance level
  * @supplies:	Power supplies voltage/current values
  * @clock_latency_ns: Latency (in nanoseconds) of switching to this OPP's
  *		frequency from any other OPP's frequency.
@@ -80,6 +81,7 @@ struct dev_pm_opp {
 	bool suspend;
 	unsigned int pstate;
 	unsigned long rate;
+	unsigned int level;
 
 	struct dev_pm_opp_supply *supplies;
 
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0a2a88e5a383..473d2c7516f0 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -86,6 +86,8 @@ unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp *opp);
 
 unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp);
 
+unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp);
+
 bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp);
 
 int dev_pm_opp_get_opp_count(struct device *dev);
@@ -157,6 +159,11 @@ static inline unsigned long dev_pm_opp_get_freq(struct dev_pm_opp *opp)
 	return 0;
 }
 
+static inline unsigned int dev_pm_opp_get_level(struct dev_pm_opp *opp)
+{
+	return 0;
+}
+
 static inline bool dev_pm_opp_is_turbo(struct dev_pm_opp *opp)
 {
 	return false;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

