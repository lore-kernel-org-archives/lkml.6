Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC6DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 960CF2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRWo6nk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960CF2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbeJCV1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46862 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeJCV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so5313979ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NdOVQOgn6QPfKNtGaQ+NXVIYYOcD0EuuWacQGnuhPH8=;
        b=WRWo6nk0nJa1hY05q+tQgr8xYnf2RAMUdfJAU1VKIlIychduM+cr+0DxYEisUldbgH
         +/Rt0QJ+NphPgxHDcGKI/myX65HaEuMqK3zWKyh4M0a9UZFtPkE7T53oOXkcZ4QqMCk6
         1+HW35LznBwGCIspaeGz+RXntF71adUgghmqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NdOVQOgn6QPfKNtGaQ+NXVIYYOcD0EuuWacQGnuhPH8=;
        b=CYmene/TlwfnDBIABE6U20d/EbEnjTD9lYV9oQldy8o+HxogwBiVVObVTeL3tcVDrt
         adqk3pZ4uHA9r/yHHlIRgAntuA2RQWl5uAH/Fe91z0J20WwhpYFgASOG2o1FCDKGYWza
         Wd98+wPJ6P46yygBE4pgJpVCcwjLRUUZVmuzeDozXktt3PM8g+sMEa/lyEFFz8f4F7YI
         TuN64DcJ7FKEXB/hqPqhnFgtGqitS6K/s1khU9IbtTql2L+LIkoyClUdVzz0T9U3bAbI
         SITyUE/MMGzD293wbhzUDsSKf1tME63e4MOz5m0ACCBqG7sZDhiuo+KOvMPXUdHA3dfg
         J/eQ==
X-Gm-Message-State: ABuFfoiU2/tFdN4xT9xU3loPw9E6C+cto6bKJIZzWZckePgdMjbM3Dyp
        MWcCdXdLVxEkztkWnc1GiD4vaw==
X-Google-Smtp-Source: ACcGV63AVZN1e1UHiciRJACevTU85s4dyI3oLi6l675UID00+PW7/sACBRYiDcjYfxt4IYXNSs8MVQ==
X-Received: by 2002:a2e:591d:: with SMTP id n29-v6mr1383472ljb.70.1538577530142;
        Wed, 03 Oct 2018 07:38:50 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:49 -0700 (PDT)
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v9 06/11] cpuidle: dt: Support hierarchical CPU idle states
Date:   Wed,  3 Oct 2018 16:38:19 +0200
Message-Id: <20181003143824.13059-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
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

