Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E67C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBE520C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXbnVH1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfBZOyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:54:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45313 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfBZOyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:54:43 -0500
Received: by mail-lf1-f68.google.com with SMTP id h10so9808632lfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AMYIr19DhL7wC893nIVn3Y+H+G175+i8XlmQ/dWB4wQ=;
        b=WXbnVH1bnHlmFW3O8yFUbl6Uw3ZNLM4we+2msBhbMMZoJTPSnF7TyZVvnUuqKPCXpx
         V1+/lFSM8P0nVXxaNK7jld1v/1f5rPMP1nUihV6qSwvNUskToK5HM7OvZFJZ6QyXD8B/
         X3XdzTBVLG+TGrdb9bpWwV6YdS7dUoi9AEZKmGa1m7AOFq+rqYkZMX4erNtlKmkiu4Ld
         PHX76Ti+FlXmTILcikEJSWJcoTZh/Hu52AVe7t3KkL5eJM1//lF4ZvF0lt+CkXZWNNMO
         ECX5oXpDzSw7kqPYIDSZH4kzNlYhbt4LafqJAdFzNtkcUXJInTkeNx5CDxOTL8gcOmwk
         USXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AMYIr19DhL7wC893nIVn3Y+H+G175+i8XlmQ/dWB4wQ=;
        b=Y3WvjcIkcW4VB7iD/SUCXuuRXfjMDBsQ/KBw/XZ+8zPOd8r6f16pC7zroI+2pGD5gW
         DBINs5FKYbsHa4RSeJb2hNyidJu4gM0Do0R9ggptl03ugsR9tiguA+az9/BM+QajsHN3
         nb4jevDAOuSBmjgHPSZ6oBzK7B6YXXZ527kk3iJ0Qtm9YVW4g34OgtQ/OEM96xDKOBp4
         GqalSi2rKQLYHsPCiousFftQi+FKXf3+CR9fYqhm3QZOHF0IilaJWQGeBIII9l3PY1Tv
         zRg3uTSg9gNCf2tbSGNrrhyEQ7INgj4B6pTXcPQpR4GQDBQXL5JaEji/cTCfWWpKWqAU
         DbaQ==
X-Gm-Message-State: AHQUAuaLDCLj09jsX9Qgj3gGWOn6ftNwifyzR1sKNwqZsO1IRPDWZmXC
        nqLZT7HIGbptjZ5LmammovWwLA==
X-Google-Smtp-Source: AHgI3IaNV91xIKeFyKjyyZRkFvds0amqlzky1w/KDmal/FUD1TWohEu1I+qqz3hzqvkCZV5Je/GfQw==
X-Received: by 2002:a19:9a47:: with SMTP id c68mr7984024lfe.139.1551192881912;
        Tue, 26 Feb 2019 06:54:41 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:54:41 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 7/8] cpuidle: Pre-store next timer/tick before selecting an idle state
Date:   Tue, 26 Feb 2019 15:54:14 +0100
Message-Id: <20190226145415.19411-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A common piece of data used by cpuidle governors, is the information about
when the next timer/tick is going to fire. Rather than having each governor
calling tick_nohz_get_next_timer|hrtimer() separately, let's consolidate
the code by calling these functions before invoking the ->select() callback
of the governor - and store the output data in the struct cpuidle_device.

Besides the consolidation benefit, the purpose of this change is also to
make the information about the next timer/tick, available outside the
cpuidle framework. Following changes that implements a new genpd governor,
makes use of this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 drivers/cpuidle/cpuidle.c        | 2 ++
 drivers/cpuidle/governors/menu.c | 6 ++----
 drivers/cpuidle/governors/teo.c  | 6 ++----
 include/linux/cpuidle.h          | 2 ++
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 7f108309e871..3b148253036b 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -312,6 +312,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 int cpuidle_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		   bool *stop_tick)
 {
+	dev->next_timer = tick_nohz_get_next_timer();
+	dev->next_hrtimer = tick_nohz_get_next_hrtimer();
 	return cpuidle_curr_governor->select(drv, dev, stop_tick);
 }
 
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 95e9122d6047..cdbe434e783d 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -287,8 +287,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned long nr_iowaiters;
 	ktime_t delta_next;
 	ktime_t now = ktime_get();
-	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
-	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
@@ -298,14 +296,14 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	/*
 	 * Compute the duration before the next timer, whatever the origin
 	 */
-	delta_next = ktime_sub(next_timer, now);
+	delta_next = ktime_sub(dev->next_timer, now);
 	data->next_timer_us = ktime_to_us(delta_next);
 
 	/*
 	 * Compute the duration before next hrtimer which is the tick
 	 * or an earliest hrtimer
 	 */
-	delta_next = ktime_sub(next_hrtimer, now);
+	delta_next = ktime_sub(dev->next_hrtimer, now);
 
 	nr_iowaiters = nr_iowait_cpu(dev->cpu);
 	data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index bef1e95c597e..7af9851d9d40 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -245,8 +245,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	int max_early_idx, idx, i;
 	ktime_t delta_tick;
 	ktime_t now = ktime_get();
-	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
-	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (cpu_data->last_state >= 0) {
 		teo_update(drv, dev);
@@ -255,8 +253,8 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	cpu_data->time_span_ns = local_clock();
 
-	cpu_data->sleep_length_ns = ktime_sub(next_timer, now);
-	delta_tick = ktime_sub(next_hrtimer, now);
+	cpu_data->sleep_length_ns = ktime_sub(dev->next_timer, now);
+	delta_tick = ktime_sub(dev->next_hrtimer, now);
 	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
 
 	count = 0;
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 3b39472324a3..81ec924206f0 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -83,6 +83,8 @@ struct cpuidle_device {
 	unsigned int		use_deepest_state:1;
 	unsigned int		poll_time_limit:1;
 	unsigned int		cpu;
+	ktime_t			next_timer;
+	ktime_t			next_hrtimer;
 
 	int			last_residency;
 	struct cpuidle_state_usage	states_usage[CPUIDLE_STATE_MAX];
-- 
2.17.1

