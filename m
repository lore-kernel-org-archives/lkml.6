Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684ECC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275FF21738
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SJQaG4pL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfA2B4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:56:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40342 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfA2Bzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:55:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so8892619pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i6Ukre4J8kw+qIeAmw1qZ7CnmonboLU8CoIx+jx7WtU=;
        b=SJQaG4pLHgn/wwoU7A6H/p5DK4ALlI1mOrTuXBTXYPaWCosnys8PLB8WzhJXMMDlAM
         hB4EknTLzPBeuUM+kLdUdMkZzUXnYSkHYRy2K9anlFHV8atrAowTiAOZI7dhK1xc+gGA
         vOOzRXlLhKe+ECdR2k7WiPh6BXSqVSnTzZXsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i6Ukre4J8kw+qIeAmw1qZ7CnmonboLU8CoIx+jx7WtU=;
        b=A33qUrNOmPCNGOk6HgumKBu+WvL4pEla9795P9X1gcXDUZJL8cZXPQ66TJuesNQWms
         Qy+WeveUyO61WxEb2zbio+nn9Bag6f2IoCQlNBPCRyZTL+obXLauNvyhMl5Xe29qTraf
         OWQf4KzmakU6WN2GFPG71dYfy43+mZcloped0opy81DttKERYoqYiWxZX4HyXos8C9EN
         kXuNaKSI2QGsyVABGz68EhoA9q+aUQ4/F+hjKktgr3qSe8yOJsa9dwdzc5yB21lVv0Rq
         VG0V85DoX//IUeCTthS6R6WU5Ngx2Nn6zVwsI7ZLUyqc+g7KpGc4HbaXnV8JzI+YoWIm
         Vc9w==
X-Gm-Message-State: AJcUukeODBOf+/ef2msTnfCFDuNZADA+eaNQ+g9H16hVaXxHVxvi6aKw
        c6gxtKFJrX8CveOP7IrWyP1OVsOzFpmCqw==
X-Google-Smtp-Source: ALg8bN6jbvvJhCUvVVA0umN3QOZTVDuA0rd7YCFeOVu4SxWDXbYWzHQfQv86Zfyn7D4eJ6ecouYc2w==
X-Received: by 2002:a63:165e:: with SMTP id 30mr21997482pgw.103.1548726951973;
        Mon, 28 Jan 2019 17:55:51 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g15sm142911530pfj.131.2019.01.28.17.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:55:51 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [RFC/PATCH 2/5] OPP: Make dev_pm_opp_set_rate() with freq=0 as valid
Date:   Mon, 28 Jan 2019 17:55:44 -0800
Message-Id: <20190129015547.213276-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129015547.213276-1-swboyd@chromium.org>
References: <20190129015547.213276-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

For devices with performance state, we use dev_pm_opp_set_rate()
to set the appropriate clk rate and the performance state.
We do need a way to *remove* the performance state vote when
we idle the device and turn the clocks off. Use dev_pm_opp_set_rate()
with freq=0 to achieve this.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/opp/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index b6516d623c5a..ac5099c237de 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -709,18 +709,24 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 	struct clk *clk;
 	int ret;
 
-	if (unlikely(!target_freq)) {
-		dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
-			target_freq);
-		return -EINVAL;
-	}
-
 	opp_table = _find_opp_table(dev);
 	if (IS_ERR(opp_table)) {
 		dev_err(dev, "%s: device opp doesn't exist\n", __func__);
 		return PTR_ERR(opp_table);
 	}
 
+	if (unlikely(!target_freq)) {
+		if (opp_table->required_opp_tables) {
+			/* drop the performance state vote */
+			dev_pm_genpd_set_performance_state(dev, 0);
+			return 0;
+		} else {
+			dev_err(dev, "%s: Invalid target frequency %lu\n", __func__,
+				target_freq);
+			return -EINVAL;
+		}
+	}
+
 	clk = opp_table->clk;
 	if (IS_ERR(clk)) {
 		dev_err(dev, "%s: No clock available for the device\n",
-- 
Sent by a computer through tubes

