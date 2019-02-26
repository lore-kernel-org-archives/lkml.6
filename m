Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF74C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0B120C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJhdwSZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfBZOzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 09:55:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41423 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbfBZOyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 09:54:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id z25so11019620ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QFP37LMPbDEXb2WSHVoMAA8Lx3svlyaybruT2DgQlU0=;
        b=fJhdwSZT64oym87C1NPWYsxIEnup9PjcSrF5GkbD0dEkILjToBgGvkqSO1yuzAVcuY
         IwBVw3Zw38so85Mizik5Mbqonnymp5nRCUSAeVjgZe95R69zBRpRgVtL24+ppEzUedoB
         NpydwEpWMQecOd+BSrS93JvO1fV6wtFgLmZWITK7ROpK+jMaic+PXJolJziV/BwlXTzX
         46B54oWIwMLMFkGtSgKTYVr9lZwnOlZciD2cQ2YKRrdsNPOE3vDQUKLzNfiAsaxGEY0K
         d4e3kfGe1XkyNlfUhSKLa0rGM+V8qMLWduf0o4coYslRwFKe7cLZOi2CAdNUg62Of95u
         7oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QFP37LMPbDEXb2WSHVoMAA8Lx3svlyaybruT2DgQlU0=;
        b=jgSjIM0gjSwuwA9IAILI0juSnk5ypD3ZJmb5cFmMFBHqhl+wpY0pp7ITO30PKn5HfZ
         58y+qYcgmeIbrCYaN2H4aN4S1UrFxgDHlq0s9l9/J+huQYGfkkZHh5Cjkm4ryWINyx0u
         Zd3LLu/JnfULoF5+XEZLy7xH13VSC7RhvIR8/vH5bkARZE7qKi+jLBZG54vxb23+yUPB
         M36E+SQ8OgYqa3iB0oHgZD6f6rEeOckfamFXc2WBKgWTfWc7ZoCkfyJf+wK4WqBaM0PW
         6+W5Dtgwj+qH+aJKcon1E09qk7YsY7GJfWTPXhJDK0Vqardi+0+fIUr6FlvQe0sW9Qv+
         3P0g==
X-Gm-Message-State: AHQUAuYm3W6lroxQKctUtrRq77Z+KFmE6uClyE2k1r9K5ElvDqetWUq3
        pSvBs9txT9ncu9J8dvQmJHMQPw==
X-Google-Smtp-Source: AHgI3IZoxyPbTSnljzQM1jRy5kabLjUHxsOiMNs290/aMYRRyMHraw0tJ9QXBiD8tu67oy3ls34hDA==
X-Received: by 2002:a2e:9e03:: with SMTP id e3mr9516998ljk.92.1551192878914;
        Tue, 26 Feb 2019 06:54:38 -0800 (PST)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t11sm2206554ljj.92.2019.02.26.06.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 06:54:38 -0800 (PST)
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
Subject: [PATCH v11 5/8] cpuidle: teo: Convert to tick_nohz_get_next_timer()
Date:   Tue, 26 Feb 2019 15:54:12 +0100
Message-Id: <20190226145415.19411-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226145415.19411-1-ulf.hansson@linaro.org>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org>

Rather than using tick_nohz_get_sleep_length(), let's convert to use the
more flexible tick_nohz_get_next_timer|hrtimer() APIs. This should have no
functional change, but allows following changes to later drop the
tick_nohz_get_sleep_length() API.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
[Ulf: Clarified information in changelog]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v11:
	- New patch.

---
 drivers/cpuidle/governors/teo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index 7d05efdbd3c6..bef1e95c597e 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -244,6 +244,9 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	unsigned int duration_us, count;
 	int max_early_idx, idx, i;
 	ktime_t delta_tick;
+	ktime_t now = ktime_get();
+	ktime_t next_hrtimer = tick_nohz_get_next_hrtimer();
+	ktime_t next_timer = tick_nohz_get_next_timer();
 
 	if (cpu_data->last_state >= 0) {
 		teo_update(drv, dev);
@@ -252,7 +255,8 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 	cpu_data->time_span_ns = local_clock();
 
-	cpu_data->sleep_length_ns = tick_nohz_get_sleep_length(&delta_tick);
+	cpu_data->sleep_length_ns = ktime_sub(next_timer, now);
+	delta_tick = ktime_sub(next_hrtimer, now);
 	duration_us = ktime_to_us(cpu_data->sleep_length_ns);
 
 	count = 0;
-- 
2.17.1

