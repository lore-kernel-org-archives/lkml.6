Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0581C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51D721470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZ8hvbTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51D721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJCV1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42353 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeJCV1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id y71-v6so5341627lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOD5x9dibVDZPPRf+HmlB0VLhQ+dq9aywfJobMmjAbY=;
        b=RZ8hvbTQATzJjRDFdCkxhcX5piHn5HTxpCsnq5o90Cm5QmrwYKBxaToPvaD0O1X3Bb
         AcxEUfcmqXX2h9Us8+QrYsjyl3HWR7FVjhoK1muBM3ivgY+vAssmfX6feNbbmzYuJOG2
         xdkoBcB1TkhnFERmGxxp9ix/XP2N2t/i/6H5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOD5x9dibVDZPPRf+HmlB0VLhQ+dq9aywfJobMmjAbY=;
        b=VzGWMHXJZJ/Cc0jM7PuvCkuFy5wo3Fkcvf3f4F3Jeu4G47YdTvC5zHIp5I5cfLvKQy
         VHTC8Qh6GEakQX+HMOiRCxSedA8hmFXbKbazobAtcy/2AuY8eAwo/9dK4QNBkJP8s1dY
         aN3NzqicuY3uGr3F7+2BO/sW7jHLkwpoTlOPlHLyn0cvZ51tHlkAfFZxjgZuj7Mmy70F
         ut1GNuIwBZyg/ViE8qYstrOOWTxbXE1kWSP9OXPXYuDp8P9hQHARQznAM/hsDg6nJjxF
         O857lKwGbPMXBxKJIB3rRxr6wW6Z8OA5GDge4+eWoC7GVeicKbRxK9cDJfG1/6XKOUn5
         vJ3A==
X-Gm-Message-State: ABuFfohetFHzhb5vY97iEmc9qycHYDCiRSaM3PBJSExmuTU2hfeDPKnl
        PstHNl3wEluO2Kn6xSQ7F1pakQ==
X-Google-Smtp-Source: ACcGV61DbPnzSLG0nVWYgX1I5i3G12v3UxOKQEvibV7kGdEUWyHVXws7WQhu9Pzav2u7XCqgP7qPgA==
X-Received: by 2002:a2e:8346:: with SMTP id l6-v6mr1385660ljh.72.1538577521080;
        Wed, 03 Oct 2018 07:38:41 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:40 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 01/11] PM / Domains: Don't treat zero found compatible idle states as an error
Date:   Wed,  3 Oct 2018 16:38:14 +0200
Message-Id: <20181003143824.13059-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of returning -EINVAL from of_genpd_parse_idle_states() in case none
compatible states was found, let's return 0 to indicate success. Assign
also the out-parameter *states to NULL and *n to 0, to indicate to the
caller that zero states have been found/allocated.

This enables the caller of of_genpd_parse_idle_states() to easier act on
the returned error code.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/base/power/domain.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4b5714199490..e1bbddb02871 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2478,8 +2478,8 @@ static int genpd_iterate_idle_states(struct device_node *dn,
  *
  * Returns the device states parsed from the OF node. The memory for the states
  * is allocated by this function and is the responsibility of the caller to
- * free the memory after use. If no domain idle states is found it returns
- * -EINVAL and in case of errors, a negative error code.
+ * free the memory after use. If any or zero compatible domain idle states is
+ * found it returns 0 and in case of errors, a negative error code is returned.
  */
 int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n)
@@ -2488,8 +2488,14 @@ int of_genpd_parse_idle_states(struct device_node *dn,
 	int ret;
 
 	ret = genpd_iterate_idle_states(dn, NULL);
-	if (ret <= 0)
-		return ret < 0 ? ret : -EINVAL;
+	if (ret < 0)
+		return ret;
+
+	if (!ret) {
+		*states = NULL;
+		*n = 0;
+		return 0;
+	}
 
 	st = kcalloc(ret, sizeof(*st), GFP_KERNEL);
 	if (!st)
-- 
2.17.1

