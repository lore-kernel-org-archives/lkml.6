Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FF4C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771F6206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HJmItfsL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Nt8mtts7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfAIJEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:04:44 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfAIJEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:04:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5EEB46098D; Wed,  9 Jan 2019 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547024682;
        bh=K3SebIwLaCXCoPXqUOD2HGdbd6uQ2szuuu2ntRo+k7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJmItfsLRYlWAd4mPxaIzjyaMDSadNHXj86z9GZMwETNfrdZIlqYnVsFjH/yRWqe1
         Gq0J3PAYOsWDPqdUcmULQ2yzYRcjR9a0tF3B3ziThthkFznTJcE9vV03lB8pd+NAIt
         bp3nKBf0yWZ4CdtHNuqvQS4J2pPKZWcn6Y3KUlSY=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40BC7608FF;
        Wed,  9 Jan 2019 09:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547024680;
        bh=K3SebIwLaCXCoPXqUOD2HGdbd6uQ2szuuu2ntRo+k7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nt8mtts7liC4+HZonk/laiHQ9XIFP5lNJ5AEk36VbbZSpi/FoM8Nx7jEgh6dLKzeF
         AAqD1bEgsXjdCIl7O9JSdGedvCV8Aoevz4sLriO2GfN+lCGrogkJCLLa7QEA44PQ04
         U4sHSFCMyy+9m7MHWxnQcgbkJ+AIKZfJkFreqRrg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40BC7608FF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v10 2/9] OPP: Add support for parsing the 'opp-level' property
Date:   Wed,  9 Jan 2019 14:34:13 +0530
Message-Id: <20190109090420.8100-3-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190109090420.8100-1-rnayak@codeaurora.org>
References: <20190109090420.8100-1-rnayak@codeaurora.org>
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
 drivers/opp/of.c       |  5 ++++-
 drivers/opp/opp.h      |  2 ++
 include/linux/pm_opp.h |  7 +++++++
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e5507add8f04..738b1783aa65 100644
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
+ * return 0
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
index 06f0f632ec47..8274d3ba2c5b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -568,7 +568,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 {
 	struct dev_pm_opp *new_opp;
 	u64 rate = 0;
-	u32 val;
+	u32 val, level = 0;
 	int ret;
 	bool rate_not_available = false;
 
@@ -594,6 +594,9 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 		new_opp->rate = (unsigned long)rate;
 	}
 
+	if (!of_property_read_u32(np, "opp-level", &level))
+		new_opp->level = level;
+
 	/* Check if the OPP supports hardware's hierarchy of versions or not */
 	if (!_opp_is_supported(dev, opp_table, np)) {
 		dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index e24d81497375..5accdd96867d 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -60,6 +60,7 @@ extern struct list_head opp_tables;
  * @suspend:	true if suspend OPP
  * @pstate: Device's power domain's performance state.
  * @rate:	Frequency in hertz
+ * @level:	level value to be comminucated to remote power manager
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

