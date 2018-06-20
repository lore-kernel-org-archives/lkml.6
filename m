Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE616C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DB520836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EF2bvCWY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DB520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932845AbeFTR3U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:29:20 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35053 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754226AbeFTRWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:38 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so490945lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ta+r1yNZdCXimBKhBsWVqn0620vMogcKiWR1qFWwX9o=;
        b=EF2bvCWY87O7+fzTccjACc8uQ+tS6c1h47qU0WCLNE9BXDGDpA92Y+fa8fUNP0zlAn
         e1WjcPxKWKGFzqbDnJ1+i7Td/Zun5dmHEFYKseWWNCltTJu/QpSgKmKyjEwsnVloN5Ed
         URm3HgPUxaZXrnYKuvDuBJW2EHSlMzaWcJp+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ta+r1yNZdCXimBKhBsWVqn0620vMogcKiWR1qFWwX9o=;
        b=t+Kl3GU1C3ASYANK5sottcI8CrwXv0l2nVDFmbEAZ4lfkXWriaqC7iizV4RBfYN+wj
         0KXMdbtlVKLsG4i173Rf1rmSb6heNdW5UJP5ir50VL80tDRaEPCJYR2lbQmWG3MNxj8r
         beOebThPsMNK+O+ZZmk7d0O78llQIhIIWymT9fWTycYBkXMvgcRkR8qpkym8Uji/lTdi
         Zwn05X0+9bIwMzB5NzS+u/s5Gsno8t1ZBq+LY4keszrXjN3EcIEnpbQC7k52RY5p1+rs
         5/xWbNPr3OGeyEiDBB6l+ClurK5EngA137FnZxEVqFDrPY1ftHZcMyg9XvcdHw/bkJbw
         6ZvQ==
X-Gm-Message-State: APt69E3lmiqtX83qOFnOz74GuaYy4moeCXpzINV8BTX/WHZ6/uhjWwp9
        7Cg1vFoJDLN/Y8n/cr3P2iR9hg==
X-Google-Smtp-Source: ADUXVKJyxlvSIFg+/7EwbEUN34YH+vPDjyjo+9LB6G2f5ADATsPe/le1yelWM3DGCZZIG5bc1+t24g==
X-Received: by 2002:a2e:750d:: with SMTP id q13-v6mr14482924ljc.56.1529515357131;
        Wed, 20 Jun 2018 10:22:37 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 01/26] PM / Domains: Don't treat zero found compatible idle states as an error
Date:   Wed, 20 Jun 2018 19:22:01 +0200
Message-Id: <20180620172226.15012-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
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
index 4925af5c4cf0..62969c3d5d04 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2452,8 +2452,8 @@ static int genpd_iterate_idle_states(struct device_node *dn,
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
@@ -2462,8 +2462,14 @@ int of_genpd_parse_idle_states(struct device_node *dn,
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

