Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA66C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C5927B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 06:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ce8hkccx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C5927B1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeF2GUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 02:20:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36694 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754309AbeF2GUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 02:20:05 -0400
Received: by mail-pg0-f65.google.com with SMTP id m19-v6so6452pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 23:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b7P0x4OPyLm2pT3XAYOXCOfkFYVojybdEOu/Rewxw1o=;
        b=ce8hkccx/nIS0ZS90LwxVOBNjolNhOA05dHPgxThIzEHOBiW3Z3b9ii11t2m2Rqyq/
         wq1QWsKE1uJbXbi5LNfH/jAHF2/NM9imAvtMgvej3PQOAhveciiIoxpF5dXshpa4cndY
         mObrjyJmc3dTH7dROZqnrZWrN2Fyb/n58l/yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b7P0x4OPyLm2pT3XAYOXCOfkFYVojybdEOu/Rewxw1o=;
        b=K/7dqebYCAgy07HzTnfPU8KMroWr5JerSVS97WiCVhcOj3r4Pus9cvaBHmKmdM5HLh
         3D91jZfxQ/vBiayW+oPk955cMAgW9y/Ray48mawjjcFZrrB5mHe+96J4y/JFZ4XqauxL
         thNh7SIRgR9ej0tM8fhZhH6WPEXnmDbPUCeC2XEZ/M5sDeb4zhs79gQReGcJ/vY/uNc3
         +XWZ/It4DoM3hoHT3zQPz7jU6e9EBOh3bai2HYJ0hOUNylfSIxKTOWRmZ1+0C2VTY00u
         lU90Cc3wOW43T+dNV22sAcUA/nsMP1Wp3oHf+05no42wrIqGNWCbu/N0ZIbGgcZm18T5
         2b9A==
X-Gm-Message-State: APt69E0cpbG8iX1VAXeKHMDVDp2PMXnUB0nLOqp8cerQxPArqb7uDj1h
        mRSvERLKA5YfBenifL+cH4X/LiMPo6w=
X-Google-Smtp-Source: AAOMgpctP+BYPVf4tSk+L8ut1ABdaHVMNk+vJdtkjinpizYmdCw3NWlDiyhjLfhfjo46ZlaVE+3MAw==
X-Received: by 2002:aa7:808f:: with SMTP id v15-v6mr13221389pff.38.1530253204809;
        Thu, 28 Jun 2018 23:20:04 -0700 (PDT)
Received: from localhost ([122.172.117.17])
        by smtp.gmail.com with ESMTPSA id m7-v6sm13232046pgr.5.2018.06.28.23.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 23:20:04 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] OPP: Separate out custom OPP handler specific code
Date:   Fri, 29 Jun 2018 11:49:33 +0530
Message-Id: <152adbb18a6d7129327a0f320cf8c60e5434dead.1530252803.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1530252803.git.viresh.kumar@linaro.org>
References: <cover.1530252803.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a separate routine to take care of custom set_opp() handler
specific stuff.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 67 +++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 31ff03dbeb83..c0c657fdbf33 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -630,6 +630,34 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
 	return ret;
 }
 
+static int _set_opp_custom(const struct opp_table *opp_table,
+			   struct device *dev, unsigned long old_freq,
+			   unsigned long freq,
+			   struct dev_pm_opp_supply *old_supply,
+			   struct dev_pm_opp_supply *new_supply)
+{
+	struct dev_pm_set_opp_data *data;
+	int size;
+
+	data = opp_table->set_opp_data;
+	data->regulators = opp_table->regulators;
+	data->regulator_count = opp_table->regulator_count;
+	data->clk = opp_table->clk;
+	data->dev = dev;
+
+	data->old_opp.rate = old_freq;
+	size = sizeof(*old_supply) * opp_table->regulator_count;
+	if (IS_ERR(old_supply))
+		memset(data->old_opp.supplies, 0, size);
+	else
+		memcpy(data->old_opp.supplies, old_supply, size);
+
+	data->new_opp.rate = freq;
+	memcpy(data->new_opp.supplies, new_supply, size);
+
+	return opp_table->set_opp(data);
+}
+
 /**
  * dev_pm_opp_set_rate() - Configure new OPP based on frequency
  * @dev:	 device for which we do this operation
@@ -644,7 +672,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	unsigned long freq, old_freq;
 	struct dev_pm_opp *old_opp, *opp;
 	struct clk *clk;
-	int ret, size;
+	int ret;
 
 	if (unlikely(!target_freq)) {
 		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
@@ -697,8 +725,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	dev_dbg(dev, "%s: switching OPP: %lu Hz --> %lu Hz\n", __func__,
 		old_freq, freq);
 
-	/* Only frequency scaling */
-	if (!opp_table->regulators) {
+	if (opp_table->set_opp) {
+		ret = _set_opp_custom(opp_table, dev, old_freq, freq,
+				      IS_ERR(old_opp) ? NULL : old_opp->supplies,
+				      opp->supplies);
+	} else if (opp_table->regulators) {
+		ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
+						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
+						 opp->supplies);
+	} else {
+		/* Only frequency scaling */
+
 		/*
 		 * We don't support devices with both regulator and
 		 * domain performance-state for now.
@@ -709,30 +746,6 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 						      opp->pstate);
 		else
 			ret = _generic_set_opp_clk_only(dev, clk, old_freq, freq);
-	} else if (!opp_table->set_opp) {
-		ret = _generic_set_opp_regulator(opp_table, dev, old_freq, freq,
-						 IS_ERR(old_opp) ? NULL : old_opp->supplies,
-						 opp->supplies);
-	} else {
-		struct dev_pm_set_opp_data *data;
-
-		data = opp_table->set_opp_data;
-		data->regulators = opp_table->regulators;
-		data->regulator_count = opp_table->regulator_count;
-		data->clk = clk;
-		data->dev = dev;
-
-		data->old_opp.rate = old_freq;
-		size = sizeof(*opp->supplies) * opp_table->regulator_count;
-		if (IS_ERR(old_opp))
-			memset(data->old_opp.supplies, 0, size);
-		else
-			memcpy(data->old_opp.supplies, old_opp->supplies, size);
-
-		data->new_opp.rate = freq;
-		memcpy(data->new_opp.supplies, opp->supplies, size);
-
-		ret = opp_table->set_opp(data);
 	}
 
 	dev_pm_opp_put(opp);
-- 
2.18.0.rc1.242.g61856ae69a2c

