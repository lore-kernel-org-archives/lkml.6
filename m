Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA66C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B4320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuZKqg5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B4320846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbeFTRWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:22:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:46745 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754365AbeFTRWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:40 -0400
Received: by mail-lf0-f67.google.com with SMTP id u5-v6so436434lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BZqpdm4C3crCBCfotBf9OcWNkhZg/AfpeooWj+mQ4ng=;
        b=HuZKqg5POieJbocrPk9ygoclVSJQuhhEuFrRfV+4xXpfR9GYqCiSTE7nQU8vuMEqZW
         2DiX2fjdAa8dUMsMo+P9lNOfJ3Md1XR4lvfQZ7nNwEMUtR2o5XTyDvE0MaVgEzKdmEGU
         9OB3SEj3oB8gI4wqYtPMvfL0CoiyoZnb2ShpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BZqpdm4C3crCBCfotBf9OcWNkhZg/AfpeooWj+mQ4ng=;
        b=N/3XfdL/ISEYBmwqQC/lzySDVD0u4Weug9/l68iIGqbwXt6pk102MQilq7lCDSyE9I
         sYvdNmp4FsvzFRZ4fXZFZ5Ta57YjBZ7tZbKnuxCgYKeQ3194jneJhAXMCQOxisAaflDF
         zkjq4vPXsbzpunHjtb9cg75RhAf1JgTwuRmyeTRwfuXEFtWcJBB9/xusFNbDziyyhm9Y
         lzMVGiKIedcFm4bI3LQcy2xaubZ7wTb9/HXVKWDY/kKQCWi0XyV7le6Vzu0XvJ9fw6Mn
         kd/lZzfd/EkWagfUtR/lcomd1Oxr5Nge8aMZXaNxhx1WTIZPFIt1JeNLWS/i0f5wPcqD
         jB8w==
X-Gm-Message-State: APt69E3RuMRnas+H2D8jBnNbwHKjwRAtNl5a0Yczf673/WBBeBZkmRxc
        AF7sujd3x79hsaiYodYMBFN9LA==
X-Google-Smtp-Source: ADUXVKK38wCwZLwB7I+7b8fn114FAubC4FEf9GTEb8eTjTSMDF6qQC6hOxWLaufsFg64ot3ikFni4w==
X-Received: by 2002:a19:20c1:: with SMTP id g184-v6mr14014452lfg.96.1529515359346;
        Wed, 20 Jun 2018 10:22:39 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:38 -0700 (PDT)
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
Subject: [PATCH v8 02/26] PM / Domains: Deal with multiple states but no governor in genpd
Date:   Wed, 20 Jun 2018 19:22:02 +0200
Message-Id: <20180620172226.15012-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A caller of pm_genpd_init() that provides some states for the genpd via the
->states pointer in the struct generic_pm_domain, should also provide a
governor. This because it's the job of the governor to pick a state that
satisfies the constraints.

Therefore, let's print a warning to inform the user about such bogus
configuration and avoid to bail out, by instead picking the shallowest
state before genpd invokes the ->power_off() callback.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/base/power/domain.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 62969c3d5d04..21d298e1820b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -467,6 +467,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool one_dev_on,
 			return -EAGAIN;
 	}
 
+	/* Default to shallowest state. */
+	if (!genpd->gov)
+		genpd->state_idx = 0;
+
 	if (genpd->power_off) {
 		int ret;
 
@@ -1687,6 +1691,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 		ret = genpd_set_default_power_state(genpd);
 		if (ret)
 			return ret;
+	} else if (!gov) {
+		pr_warn("%s : no governor for states\n", genpd->name);
 	}
 
 	device_initialize(&genpd->dev);
-- 
2.17.1

