Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E3BECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D9620831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 05:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hUXeVMx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D9620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeJYOYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:24:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46931 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeJYOYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:24:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id a5-v6so2585532pgt.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 22:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v6vTXca6A3jKCvhjLn/Zkg1XwrbNhbzSf4hVfEVdJtU=;
        b=hUXeVMx2vJv4cDWT3aDqmKMh8MrnV1gvyYapkFPqtEb8Pip/4mZFIbSVilElNRNIp6
         tp4qNVM1kQMIIShXmui4NV4yxUcpCllUnLAhy8J+h5rgIoavfKoT73/wVVY0wDDt05+u
         XKVhwjFGgfPcUKXSI5cz5s879uMPHZ7kTA5uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v6vTXca6A3jKCvhjLn/Zkg1XwrbNhbzSf4hVfEVdJtU=;
        b=i4w79uLM22SJ8BzFLXeUWkqKrgst4vfflTQtXbr+OzNxDbY0iwD3X5ZWMN3MgEbK9V
         HK2GezgDqjvXKGI+92g/RYAZNHDRrKAk1tJigzXjoq3T14CgPe5F1v6vZcl1n0PpDYor
         nuv9bDzeRlQ2T7xtmB9rXKySXV03aUEdBZiLCncDISc+IYoNI2dYo6mDSG8BOl2i80Ws
         HAsEEwfanINMDy7X2uCluhzZMjMo/q17UXKL3WB8J8ExyiGsLidPvHts8nNV4aEECRq7
         lmp36h6bR6roP+bl+hALeadmp2xARPDV4dfFcYRLzSTznSdwKPriTacg4g0gvzywAPJ8
         9ITg==
X-Gm-Message-State: AGRZ1gII2kSxaL479CUnDzul0A2b6zLN+8irzy/l8O4SrEG8vSzm/0x+
        gxL8hRnUYMQ4ZTlBtHBE6wtyEg==
X-Google-Smtp-Source: AJdET5feprQcIvXzJ7hzZe/9bjU9Y6n6swqOu8YUwO1iNu2yTQDd+73lymL933jiJ/aQz/2bv9U1yw==
X-Received: by 2002:a62:9015:: with SMTP id a21-v6mr203519pfe.49.1540446805510;
        Wed, 24 Oct 2018 22:53:25 -0700 (PDT)
Received: from localhost ([122.172.217.9])
        by smtp.gmail.com with ESMTPSA id z14-v6sm8826137pfi.4.2018.10.24.22.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 22:53:24 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        rnayak@codeaurora.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 03/10] OPP: Separate out custom OPP handler specific code
Date:   Thu, 25 Oct 2018 11:22:40 +0530
Message-Id: <2b94b3d1454a5e5da9e1a984a1a87cc852b44213.1540446493.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1540446493.git.viresh.kumar@linaro.org>
References: <cover.1540446493.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a separate routine to take care of custom set_opp() handler
specific stuff.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 67 +++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c2df4e4fc14..ebb3b648e0fd 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -635,6 +635,34 @@ static int _generic_set_opp_regulator(const struct opp_table *opp_table,
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
@@ -649,7 +677,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	unsigned long freq, old_freq;
 	struct dev_pm_opp *old_opp, *opp;
 	struct clk *clk;
-	int ret, size;
+	int ret;
 
 	if (unlikely(!target_freq)) {
 		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
@@ -702,8 +730,17 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
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
@@ -714,30 +751,6 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
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
2.19.1.568.g152ad8e3369a

