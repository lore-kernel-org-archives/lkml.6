Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 418F620659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1N08G6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfANKWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:22:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40425 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfANKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:22:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id f188so8212169wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Wu/tmpT7BDXo4oTQUwIjofVpVoXKP/NrUVRomzzYDk8=;
        b=Z1N08G6opSL2YIWhjPthqe3mvAA4GZbBv2gowuWMVignQnnwPM4OtQrPGFKjt4ykXb
         E/LzT9mAttHZw2pS7F1UL4raKcuvwlI7KsrllyKU55Twem4025TdkuTL3C8P46o2jfNP
         hj8Jd88FQRY8AOg3H71Ro7UAKEaY73RUPWxaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Wu/tmpT7BDXo4oTQUwIjofVpVoXKP/NrUVRomzzYDk8=;
        b=XT26WkCNy7xZN4ZSEP4dVJ2Nd1kkL4KM+3A6Ete2L0+TzSzQg+iXNRxC1qhakDDtMY
         wJBhtvOkd5TpUu221EaZqavqMqvr2sSr0cLYE41wSQh0f1X+T0kz3AE46CIhs6sdWHM1
         Mn0VxGEiFbHJXCgSdbwTbqlsOsbK87hDPpnfN4Qx/jtV5X/6Jh+rQMMi8BjWJHqOCtMg
         orR23YvMY0k3dwVd3gTsylj2V6cUnKwuMt/uoz40HnqKOwSiHmrKq4b7kMKkDtQjCcS1
         WJVt1dkVOT8b84/cuKH04BxMeRjIy0BB+7QN1PNv7RW3QFr3YHKXgakc7v5EjIdvOhpR
         QdrA==
X-Gm-Message-State: AJcUukfo9693l/eJWF3mh3eZSwQaJnOyQBXWBu/WTCNqeDg+St5D+MWT
        eeJ5c4SJxFyRoHjwkFBIrWis87SUd7Q=
X-Google-Smtp-Source: ALg8bN6El3lLYFz8Pk1H3n6lW7ctd/mEMwD34o2/U9BGIlxE/Pjv5wis19psEacp8YU+6U24yG+eSw==
X-Received: by 2002:a7b:c34c:: with SMTP id l12mr11046788wmj.147.1547461332650;
        Mon, 14 Jan 2019 02:22:12 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id k15sm105513691wru.8.2019.01.14.02.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:22:11 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org (open list:THERMAL/CPU_COOLING)
Subject: [PATCH v2 9/9] thermal: cpu_cooling: Clarify error message
Date:   Mon, 14 Jan 2019 15:51:11 +0530
Message-Id: <2de2d178380525191d99d6c3619ad8c45efdbab4.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clear that it is a failure if the cpufreq driver was unable to
register as a cooling device. Makes it easier to find in logs and
grepping for words like fail, err, warn.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd23245f778..6fff16113628 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -774,7 +774,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 
 		cdev = __cpufreq_cooling_register(np, policy, capacitance);
 		if (IS_ERR(cdev)) {
-			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
+			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
 			       policy->cpu, PTR_ERR(cdev));
 			cdev = NULL;
 		}
-- 
2.17.1

