Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA119C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C0720873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFTdFL04"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfANKVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52397 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfANKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id m1so8296304wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=9SBw2Z8hokpAYRi9yYWIqHgwrnBSoCdeIR1YxJHRWTA=;
        b=RFTdFL04O0QYIhX0JBnUjQGAz3APxexoATMRsqvN4V8qZZgP+ccNCDl2usSW0Yp29y
         Nb5EVStf6xppuRlyc1Jov52MVq+vpMsi7C9J2BqcCfgcFJYb2kRtynQc1LyfZDLD/C0V
         bwJOnezzKErTQq8dgddkCsY5zpP8pCyaO5phY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9SBw2Z8hokpAYRi9yYWIqHgwrnBSoCdeIR1YxJHRWTA=;
        b=B0qobJZ6sB5DFkHT0eXR39qfpGyotfE9DTdTC5zcgnFcNCX3X4JVCM6UM5o664Rcj8
         8Y/3LYPoM609PCdftOm19RYzZhtBiKe3CHaJtaz3Qv0ORHlJrIL6xlSwqHOfqrXzZHEZ
         fhvo2kdr3HapcsFRFHWd9ZF2yTIXxM5i6ndthvHPGD5eg1L6jsVPcosh70xiuK+2FIdt
         wBJ6P+iTzcKpWCTeDJDq91ap1W8gFaWhDlUuz5s8dgKpe98XjZwVmswa/0PH54qpxyIH
         MR97550HmXAsUH6G1qBWYyyEF9EURRsqfUIqhxwcHNJjxGJvWr8P2hwpXYcYjWYqHWKg
         i2Ig==
X-Gm-Message-State: AJcUukezRAKAWsgaYjR6/3Bm5ihn+zJiUazsBw8fUtvA198ky7C3UQFE
        PDDCFO/n8w5w7ymUHXuM1ocdwZrmoy8=
X-Google-Smtp-Source: ALg8bN6G6klT2ZY5A1/WibAL7ZNVVxAHhcPpHOtgGC/X8+p0l9Jx/vnS0cO3VxjzdXwQFgbd7E+2eg==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr11292507wmk.149.1547461291120;
        Mon, 14 Jan 2019 02:21:31 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id x81sm27364850wmg.17.2019.01.14.02.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:21:30 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v2 2/9] drivers: thermal: of-thermal: Print name of device node with error
Date:   Mon, 14 Jan 2019 15:51:04 +0530
Message-Id: <f7c145e6d5164c3386f0a325a4cdcc726362f6db.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it easier to debug devicetree definition in case of errors.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/of-thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a1e47d..08c3ccbdacf8 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay-passive property\n");
+		pr_err("%pOFn: missing polling-delay-passive property\n", np->name);
 		goto free_tz;
 	}
 	tz->passive_delay = prop;
 
 	ret = of_property_read_u32(np, "polling-delay", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay property\n");
+		pr_err("%pOFn: missing polling-delay property\n", np->name);
 		goto free_tz;
 	}
 	tz->polling_delay = prop;
-- 
2.17.1

