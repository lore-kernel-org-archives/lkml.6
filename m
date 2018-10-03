Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F92C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE1213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fwrq5zIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DE1213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeJCV12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46855 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeJCV10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id 203-v6so5313675ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Az8HN+a97vIgrScBCEqR/rzOTiI9JWpLJgNiF/xNs1Y=;
        b=Fwrq5zIZgGrEsBsxyR54t24qFEqHXkC4DSb+7TXhUtrfB3IWXrdMfuwFYzFi7XS+ud
         Ha8AaviFQc7guk7xMwsdCNQll3VLrH5kZKgOsnkQHvs6/B/eWYplidelM/qkMrzO2BV9
         KWzKRwxQgixw+ofsPAuPI3+F3/iZy0QnSjLRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Az8HN+a97vIgrScBCEqR/rzOTiI9JWpLJgNiF/xNs1Y=;
        b=ixmzDfb+KEZN1MpQyIenZ7Xtq8ry2nkazRjNu/bYuITwRmH88m669I3bUNWAJC1md3
         j4Y+zbHNTdZd13ut6hldZC391b1+pK9Zpr/Rn6EOYNSirFABMGJmKfQzfUmLdnHTEIm0
         hqnMO7JyNpv19JPIE3w4EvcgKngehSEwIvW8jZW2PoNUZFFy1ar/Uu0zajUjqgcQerqk
         tTuyXoUpxO3bZgeIdHlUrBQUS5hMP0ckGtvA1FkjvZuffo5qcwsbHg6fzg11puMP8hdk
         0PO76trGDkU6aMqFMMZ1Y/3qt9fniA4yqeto1H5N1ygFKg6t7R/LO9uzXEVENKQ6HfOL
         zK+Q==
X-Gm-Message-State: ABuFfoigiICs6EjyzXJB8tMTQpjdkCfgu4TrGp6/liKqRxyD7ueIZsTb
        x/vBvmwBQOtf5Dj9Q6d2nNl93Q==
X-Google-Smtp-Source: ACcGV63ZCUlRFuzoFUlWb1bs+KEJI66Yb1IoBIe4epyTsr714kZsnJnvwgbB3Aut6FDAYv3Eilj24g==
X-Received: by 2002:a2e:2d0a:: with SMTP id t10-v6mr1494652ljt.8.1538577524605;
        Wed, 03 Oct 2018 07:38:44 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:44 -0700 (PDT)
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
Subject: [PATCH v9 03/11] PM / Domains: Document flags for genpd
Date:   Wed,  3 Oct 2018 16:38:16 +0200
Message-Id: <20181003143824.13059-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current documented description of the GENPD_FLAG_* flags, are too
simplified, so let's extend them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 776c546d581a..3b5d7280e52e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -17,11 +17,36 @@
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
 
-/* Defines used for the flags field in the struct generic_pm_domain */
-#define GENPD_FLAG_PM_CLK	 (1U << 0) /* PM domain uses PM clk */
-#define GENPD_FLAG_IRQ_SAFE	 (1U << 1) /* PM domain operates in atomic */
-#define GENPD_FLAG_ALWAYS_ON	 (1U << 2) /* PM domain is always powered on */
-#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3) /* Keep devices active if wakeup */
+/*
+ * Flags to control the behaviour of a genpd.
+ *
+ * These flags may be set in the struct generic_pm_domain's flags field by a
+ * genpd backend driver. The flags must be set before it calls pm_genpd_init(),
+ * which initializes a genpd.
+ *
+ * GENPD_FLAG_PM_CLK:		Instructs genpd to use the PM clk framework,
+ *				while powering on/off attached devices.
+ *
+ * GENPD_FLAG_IRQ_SAFE:		This informs genpd that its backend callbacks,
+ *				->power_on|off(), doesn't sleep. Hence, these
+ *				can be invoked from within atomic context, which
+ *				enables genpd to power on/off the PM domain,
+ *				even when pm_runtime_is_irq_safe() returns true,
+ *				for any of its attached devices. Note that, a
+ *				genpd having this flag set, requires its
+ *				masterdomains to also have it set.
+ *
+ * GENPD_FLAG_ALWAYS_ON:	Instructs genpd to always keep the PM domain
+ *				powered on.
+ *
+ * GENPD_FLAG_ACTIVE_WAKEUP:	Instructs genpd to keep the PM domain powered
+ *				on, in case any of its attached devices is used
+ *				in the wakeup path to serve system wakeups.
+ */
+#define GENPD_FLAG_PM_CLK	 (1U << 0)
+#define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
+#define GENPD_FLAG_ALWAYS_ON	 (1U << 2)
+#define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3)
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
-- 
2.17.1

