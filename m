Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA752C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9759920836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bxj+tfnA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9759920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933120AbeFTR1E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:27:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40140 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932341AbeFTRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:58 -0400
Received: by mail-lf0-f68.google.com with SMTP id q11-v6so468542lfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NdOVQOgn6QPfKNtGaQ+NXVIYYOcD0EuuWacQGnuhPH8=;
        b=bxj+tfnAw37NyvY0WdDlwmR2qXNymUJepXFf+P3xWNtcQLIdfTA+QUNwlDOT2aL4rE
         GM7+CwE+5ixNl5W/l0aEM1mbXWeu+Vk9TD9OsYNRI+UuBLq/aSS1tuUsnhji8QuIIg9x
         fQxj0s8Q9sigqbWr3o/w0fUPJax0r2uKeKneM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NdOVQOgn6QPfKNtGaQ+NXVIYYOcD0EuuWacQGnuhPH8=;
        b=rjnvrI7qbyRFo/CdpYE8rO3FMTiUjLJlBOyc9g4e6OSIxGkkGiOCVkVVfvf8zjyEJf
         ZFKySijHRr7vbX2qW1Xk0KHFTtzwEV2pLFesb48Ec580YT+Ow42kZUy05xiGBT/Qqs/L
         SLzuDDfGcxrXX3SmzheDZV6aqH+nta/kwua/itfeV1XLswKgAbX7Gx1Cvk8v71Fsjnv2
         PUTKoXWZYJ7B9X24fchZVN8zR2kyCxI4WanPkwyn68rNBvxpj95BU0AvNDkBsgb+ReGU
         Y4uvjg3tbtKGwp3k7NFhW6qZJklaXkFAb1QKUsg8hIJj5ALDlycIGSYpdpRnjphsgBYe
         nluA==
X-Gm-Message-State: APt69E0I/7G5yFwy8pUn79EmOgpAH2H4BO8iRfHMV4m0QF+ZMDsOOyb8
        3XA3ZV3lka3RuvFJdNGT4yLvig==
X-Google-Smtp-Source: ADUXVKIfkA/aSkeTaO/Pmjg5O3hQYTz9idt4WA0jxR0DWKMwuZP8qg8sQLr7vhpNjIsL3Unx82VCbA==
X-Received: by 2002:a2e:1710:: with SMTP id l16-v6mr15565951lje.74.1529515376747;
        Wed, 20 Jun 2018 10:22:56 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:56 -0700 (PDT)
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
Subject: [PATCH v8 12/26] cpuidle: dt: Support hierarchical CPU idle states
Date:   Wed, 20 Jun 2018 19:22:12 +0200
Message-Id: <20180620172226.15012-13-ulf.hansson@linaro.org>
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

Support the hierarchical layout during parsing and validating of the CPU's
idle states. This is simply done by calling the new OF helper,
of_get_cpu_state_node().

Cc: Lina Iyer <ilina@codeaurora.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/dt_idle_states.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/dt_idle_states.c b/drivers/cpuidle/dt_idle_states.c
index 53342b7f1010..13f9b7cd32d1 100644
--- a/drivers/cpuidle/dt_idle_states.c
+++ b/drivers/cpuidle/dt_idle_states.c
@@ -118,8 +118,7 @@ static bool idle_state_valid(struct device_node *state_node, unsigned int idx,
 	for (cpu = cpumask_next(cpumask_first(cpumask), cpumask);
 	     cpu < nr_cpu_ids; cpu = cpumask_next(cpu, cpumask)) {
 		cpu_node = of_cpu_device_node_get(cpu);
-		curr_state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-						   idx);
+		curr_state_node = of_get_cpu_state_node(cpu_node, idx);
 		if (state_node != curr_state_node)
 			valid = false;
 
@@ -176,7 +175,7 @@ int dt_init_idle_driver(struct cpuidle_driver *drv,
 	cpu_node = of_cpu_device_node_get(cpumask_first(cpumask));
 
 	for (i = 0; ; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_get_cpu_state_node(cpu_node, i);
 		if (!state_node)
 			break;
 
-- 
2.17.1

