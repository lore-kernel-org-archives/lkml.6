Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353CDC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E54B320836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ccLWxAWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54B320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeFTRXK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:23:10 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44038 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754573AbeFTRXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:06 -0400
Received: by mail-lf0-f66.google.com with SMTP id p23-v6so445729lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3WUKn2dvevp+IRdH7T6aKSOygQUa+Gx75wLOTzgVKrQ=;
        b=ccLWxAWKyM1XsPYFwBoyd1FnFJHtFSEKE0BrB3Mz5q7D5iS6hvFeiT/fgp33GKSrIz
         Gxj57mbMomjqk9vP9cNzlryga3fRrwsq5ynCb8/ACNT1wds3dTiZq6fS5nI0FwmGJaNN
         Dhc9dmqJto0CMZfqD2+biLfLs6O3t7oDPBPn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3WUKn2dvevp+IRdH7T6aKSOygQUa+Gx75wLOTzgVKrQ=;
        b=KauugXIzuOq24ucYuG6Tasz5BohoG9uNBQ/9xHDhhbCkBSmDqBwQjUhuvJ2E3BDOkj
         zBYRWurSknreBONiM6KjgicQHHLY1F+B/b16AUfML7VKesjuQRJjxwzPOldiY+WwnnWI
         P637PFtH2+U/ulCa6KJrEVHJiE0MmxYKaRSycw6EXw1dL8KY3IxWE92HBLIjYtb9WcPP
         UP26yxJsY6jj0/nTJ7aTzMKedyOdhUqEzor+LolGzV7ds4sD18+a8W10hP8j/isszaFb
         FA0vKMTFqhC5/iqNpXzt2LT426SRjy9ICslE83089ua90acEDpxsKMByIxbP7dbIWZx2
         3rcw==
X-Gm-Message-State: APt69E19Fq9t7QbM/vD3mqfH4as+LRWFccOqab0ql5hRnYHcFJlJjlp9
        a+mJg7Qoke7VYXP5XTw/8Pj7Lg==
X-Google-Smtp-Source: ADUXVKKz2Nd7fbMf9oDBOr3m4O64LNkWcMuCIRlWwRXw9QVs6dydR1O2ZmpjNZUXKxJwzp8CW+wBLw==
X-Received: by 2002:a2e:2bcb:: with SMTP id r72-v6mr15489218ljr.133.1529515384517;
        Wed, 20 Jun 2018 10:23:04 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:03 -0700 (PDT)
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
Subject: [PATCH v8 16/26] drivers: firmware: psci: Support hierarchical CPU idle states
Date:   Wed, 20 Jun 2018 19:22:16 +0200
Message-Id: <20180620172226.15012-17-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Currently CPU's idle states are represented in a flattened model, via the
"cpu-idle-states" binding from within the CPU's device nodes.

Support the hierarchical layout, simply by converting to calling the new OF
helper, of_get_cpu_state_node().

Cc: Lina Iyer <ilina@codeaurora.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 9788bfc1cf8b..256b4edbb20a 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -294,8 +294,7 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	struct device_node *state_node;
 
 	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
+	while ((state_node = of_get_cpu_state_node(cpu_node, count))) {
 		count++;
 		of_node_put(state_node);
 	}
@@ -308,7 +307,7 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_get_cpu_state_node(cpu_node, i);
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
-- 
2.17.1

