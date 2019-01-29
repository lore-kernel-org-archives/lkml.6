Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DB4C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E68C2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jUKaesuM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfA2Bzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:55:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45185 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbfA2Bzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:55:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so8031746pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVULfzxWVElJMCwq1wy/pfgTajaNanG7YoLpOBVV2Xo=;
        b=jUKaesuMBcYZs2+V6aDk92VljfYqtRok693G/qZFfl7LLib7eOX9EsdPkuvDmPwBD9
         0p+lqTRD9sHxAwAsOyUz7Jp3//WGeHbP4N3NWVWRZ5e2d42FCl6C+HvXkmf5prgHUOzr
         ZWIjSdzdaHege2yn2EYC65iy3/es1opNulvLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVULfzxWVElJMCwq1wy/pfgTajaNanG7YoLpOBVV2Xo=;
        b=ILe+4p21171voJsjAAdRvgj6ySI+Fl/oMo6KlgrbElsN04EWnX0Rz/6L2v0tq7vORA
         5WXPUHt515Rh+w+D0/aiJk90Jg/4LRviwEx8uCK9+z0yUipwTPTS5t7dip0fmzlg5Cxv
         Zg1mYg7EVecZj0HY43KDv8FYseDJStwCqDfK2fKb2uQ1EDQuE1OE6cE48Uu92mTPTIOC
         F10m90mItlgGKyCKNi8U0xd5CC1JnO7h7R4O6eProCglI7GlWN/AhqBy2JQiINANm/xj
         1FRyM6CcGgLSh+/A+6SF3Kh98hqcFWZlqpe8IQ4F5YC2GJxlPlnjCINYdKZSNKxJ70+h
         rtjg==
X-Gm-Message-State: AJcUukdSzMIAAFhYfYEqe31nFP6lUxztUCXPxQ4oIg2LXeVDEyyq192S
        wGgvCYo0bFmzRPqBqB8VLcQlubuzERPUfA==
X-Google-Smtp-Source: ALg8bN4/xhmNqo5oaO4yiUUgEZkYF+UDzSOc37IkGAuSgTn9HIiVfMbpXgm91YkxZlFAgB94vBt5AQ==
X-Received: by 2002:a63:86c1:: with SMTP id x184mr21780233pgd.305.1548726950808;
        Mon, 28 Jan 2019 17:55:50 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g15sm142911530pfj.131.2019.01.28.17.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:55:49 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [RFC/PATCH 1/5] OPP: Don't overwrite rounded clk rate
Date:   Mon, 28 Jan 2019 17:55:43 -0800
Message-Id: <20190129015547.213276-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129015547.213276-1-swboyd@chromium.org>
References: <20190129015547.213276-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing this allows us to call this API with any rate requested and have
it not need to match in the OPP table. Instead, we'll round the rate up
to the nearest OPP that we see so that we can get the voltage or level
that's required for that OPP. This supports users of OPP that want to
specify the 'fmax' tables of a device instead of every single frequency
that they need. And for devices that required the exact frequency, we
can rely on the clk framework to round the rate to the nearest supported
frequency instead of the OPP framework to do so.

Note that this may affect drivers that don't want the clk framework to
do rounding, but instead want the OPP table to do the rounding for them.
Do we have that case? Should we add some flag to the OPP table to
indicate this and then not have that flag set when there isn't an OPP
table for the device and also introduce a property like 'opp-use-clk' to
tell the table that it should use the clk APIs to round rates instead of
OPP?

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/opp/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index e06a0ab05ad6..b6516d623c5a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -704,7 +704,7 @@ static int _set_required_opps(struct device *dev,
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	struct opp_table *opp_table;
-	unsigned long freq, old_freq;
+	unsigned long freq, opp_freq, old_freq, old_opp_freq;
 	struct dev_pm_opp *old_opp, *opp;
 	struct clk *clk;
 	int ret;
@@ -743,13 +743,15 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 		goto put_opp_table;
 	}
 
-	old_opp = _find_freq_ceil(opp_table, &old_freq);
+	old_opp_freq = old_freq;
+	old_opp = _find_freq_ceil(opp_table, &old_opp_freq);
 	if (IS_ERR(old_opp)) {
 		dev_err(dev, "%s: failed to find current OPP for freq %lu (%ld)\n",
 			__func__, old_freq, PTR_ERR(old_opp));
 	}
 
-	opp = _find_freq_ceil(opp_table, &freq);
+	opp_freq = freq;
+	opp = _find_freq_ceil(opp_table, &opp_freq);
 	if (IS_ERR(opp)) {
 		ret = PTR_ERR(opp);
 		dev_err(dev, "%s: failed to find OPP for freq %lu (%d)\n",
-- 
Sent by a computer through tubes

