Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E66DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5F62173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q0hHgTI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfAJABN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:01:13 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43244 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfAJABM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:01:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so9433018wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=4x5l+fpo+33i9L7joXlzfDhb4Fal6Vwhvi1SJC2mPM0=;
        b=Q0hHgTI9oRbwCDbgueOgWqaXLR/07CIuKCCK9dEoeb7PVbtO3WnGbrmUiwyn5Gsyl7
         u1WR60YCUbxqDfBfVMwEsEmYG2nxUbHRFwRKKSFwDtLkcZyL0pndeHlrQpu5czuaSJAP
         fCV1H6W/n/S+KFsI2mzYytLquIghvr/T/PiCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=4x5l+fpo+33i9L7joXlzfDhb4Fal6Vwhvi1SJC2mPM0=;
        b=QLeMZBcfdHkWsMSo8lsVBWTYkbe34WT4enN+3W9aw8XhGEuwgwwdyAH1pscUPUcSOk
         9+rh9t05+NauXiTSZAGh6xiGt35dm7T72GLMo4/0DMdl/VMzDVLuSsQtdS8ZBWtMx9jj
         qNYWYdanc9yU8PdKFipZnJRzoDofafa/esi8/iA1OAoYDnolnsDcpCGEqsNwXG1ycKdj
         TCvtqqar3cXwEl1woIEBHQhCmPd2O994vvccr3kaxgMN1Ju40+J+kvXFmd9nX5zbAHVe
         20ZrpCi7QgHBp9DGnnAzdIwVTVRCTSLO20/Vz4wn+YqtUHq38HoJEaw4fKXEGZ8ZYBNR
         bFVA==
X-Gm-Message-State: AJcUuke7TqsKfzyxVdhnsNHFgnigakNpVnaFoSrbwZ59rEZjIGeX0nMp
        ow7yDF0Fx90itn0GqWGqq79jvnfAG0s=
X-Google-Smtp-Source: ALg8bN4b2HEqk2HWDepIaZv9eFsitZuJhZqHY7K7zS8GfQNzPHWcWKRKw+F3fFqNjUdkIz/W0ETcDQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr6590534wrm.328.1547078470466;
        Wed, 09 Jan 2019 16:01:10 -0800 (PST)
Received: from localhost ([49.248.171.190])
        by smtp.gmail.com with ESMTPSA id l20sm123597548wrb.93.2019.01.09.16.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:01:09 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH v1 1/7] drivers: thermal: of-thermal: Print name of device node with error
Date:   Thu, 10 Jan 2019 05:30:50 +0530
Message-Id: <52c46a3a4fd1674295d9c2577be87d73ce545044.1547078153.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/of-thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index 4bfdb4a1e47d..5ca2a6b370ea 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -867,14 +867,14 @@ __init *thermal_of_build_thermal_zone(struct device_node *np)
 
 	ret = of_property_read_u32(np, "polling-delay-passive", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay-passive property\n");
+		pr_err("%s: missing polling-delay-passive property\n", np->name);
 		goto free_tz;
 	}
 	tz->passive_delay = prop;
 
 	ret = of_property_read_u32(np, "polling-delay", &prop);
 	if (ret < 0) {
-		pr_err("missing polling-delay property\n");
+		pr_err("%s: missing polling-delay property\n", np->name);
 		goto free_tz;
 	}
 	tz->polling_delay = prop;
-- 
2.17.1

