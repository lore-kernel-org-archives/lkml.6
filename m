Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id PSsLMBV2GVskEwAAmS7hNA
	; Thu, 07 Jun 2018 18:16:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A0FFF608B8; Thu,  7 Jun 2018 18:16:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F031D606FA;
	Thu,  7 Jun 2018 18:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F031D606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936202AbeFGSQg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:16:36 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37938 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935991AbeFGSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:12:57 -0400
Received: by mail-pg0-f68.google.com with SMTP id c9-v6so5129714pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7EoVwEbtmRQe9tZHxZ/fIrP5hkySzViL8ASC3ahAM3w=;
        b=ActblH1V1nlyaha80bK/kY5TX+jzjJQPxvc0oS8Zyd3utghmu9x7uJyexN53Otp32a
         Ir6hkzwvIiiN9A9UN5ULLpqqXSL4KRTx9ecPKMoXEs7IqKWgXt4/oiBCDUNVKaA2hUk9
         VdMDcgRDJRuA+8UexkqJkECmSkTBjD7jgOSK7DDPiqQJbyoUzzSkRFKz2AfSEc+ZXGaw
         4uEGTb19/RBZLFSeV0qpnDrL0GsLi3tPJ+AvFKjwMd2B4Jz+grFZlySMaN2WWM+nihpI
         FkrlYVkiVKzKoNCbIi0O3Dbeaa34VzP3iT9XHkyeJ8BJbc3g1muEA8FR7xj5v7HI7UjY
         kVoA==
X-Gm-Message-State: APt69E1v1GDw4uQyGxpqLsNbhvlXnkarqIgMs6FEz2qrUKiRbHqI+8Kf
        8tEBOprmTmnKmw1+VCIklsdbFA==
X-Google-Smtp-Source: ADUXVKJ3Q4YyhDuyHyoyttEkqMXF7r9STQn27V7E2a9bYLikswwo3qWPDTkohH9uRAZtSHO+rnS9CA==
X-Received: by 2002:a65:644a:: with SMTP id s10-v6mr2431843pgv.360.1528395176115;
        Thu, 07 Jun 2018 11:12:56 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:12:55 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 03/11] PM / devfreq: Don't adjust to user limits in governors
Date: Thu,  7 Jun 2018 11:12:06 -0700
Message-Id: <20180607181214.30338-4-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several governors use the user space limits df->min/max_freq to adjust
the target frequency. This is not necessary, since update_devfreq()
already takes care of this. Instead the governor can request the available
min/max frequency by setting the target frequency to DEVFREQ_MIN/MAX_FREQ
and let update_devfreq() take care of any adjustments.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- squashed "PM / devfreq: Remove redundant frequency adjustment from governors"
  and "PM / devfreq: governors: Return device frequency limits instead of user
  limits"
- updated subject and commit message
- use DEVFREQ_MIN/MAX_FREQ instead of df->scaling_min/max_freq

 drivers/devfreq/governor.h                |  3 +++
 drivers/devfreq/governor_performance.c    |  5 +----
 drivers/devfreq/governor_powersave.c      |  2 +-
 drivers/devfreq/governor_simpleondemand.c | 12 +++---------
 drivers/devfreq/governor_userspace.c      | 16 ++++------------
 5 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index cfc50a61a90d..b81700244ce3 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -25,6 +25,9 @@
 #define DEVFREQ_GOV_SUSPEND			0x4
 #define DEVFREQ_GOV_RESUME			0x5
 
+#define DEVFREQ_MIN_FREQ			0
+#define DEVFREQ_MAX_FREQ			ULONG_MAX
+
 /**
  * struct devfreq_governor - Devfreq policy governor
  * @node:		list node - contains registered devfreq governors
diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index 4d23ecfbd948..ded429fd51be 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -20,10 +20,7 @@ static int devfreq_performance_func(struct devfreq *df,
 	 * target callback should be able to get floor value as
 	 * said in devfreq.h
 	 */
-	if (!df->max_freq)
-		*freq = UINT_MAX;
-	else
-		*freq = df->max_freq;
+	*freq = DEVFREQ_MAX_FREQ;
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index 0c42f23249ef..9e8897f5ac42 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -20,7 +20,7 @@ static int devfreq_powersave_func(struct devfreq *df,
 	 * target callback should be able to get ceiling value as
 	 * said in devfreq.h
 	 */
-	*freq = df->min_freq;
+	*freq = DEVFREQ_MIN_FREQ;
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 28e0f2de7100..c0417f0e081e 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -27,7 +27,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	unsigned int dfso_upthreshold = DFSO_UPTHRESHOLD;
 	unsigned int dfso_downdifferential = DFSO_DOWNDIFFERENCTIAL;
 	struct devfreq_simple_ondemand_data *data = df->data;
-	unsigned long max = (df->max_freq) ? df->max_freq : UINT_MAX;
 
 	err = devfreq_update_stats(df);
 	if (err)
@@ -47,7 +46,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 
 	/* Assume MAX if it is going to be divided by zero */
 	if (stat->total_time == 0) {
-		*freq = max;
+		*freq = DEVFREQ_MAX_FREQ;
 		return 0;
 	}
 
@@ -60,13 +59,13 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	/* Set MAX if it's busy enough */
 	if (stat->busy_time * 100 >
 	    stat->total_time * dfso_upthreshold) {
-		*freq = max;
+		*freq = DEVFREQ_MAX_FREQ;
 		return 0;
 	}
 
 	/* Set MAX if we do not know the initial frequency */
 	if (stat->current_frequency == 0) {
-		*freq = max;
+		*freq = DEVFREQ_MAX_FREQ;
 		return 0;
 	}
 
@@ -85,11 +84,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	b = div_u64(b, (dfso_upthreshold - dfso_downdifferential / 2));
 	*freq = (unsigned long) b;
 
-	if (df->min_freq && *freq < df->min_freq)
-		*freq = df->min_freq;
-	if (df->max_freq && *freq > df->max_freq)
-		*freq = df->max_freq;
-
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 080607c3f34d..378d84c011df 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -26,19 +26,11 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
 {
 	struct userspace_data *data = df->data;
 
-	if (data->valid) {
-		unsigned long adjusted_freq = data->user_frequency;
-
-		if (df->max_freq && adjusted_freq > df->max_freq)
-			adjusted_freq = df->max_freq;
-
-		if (df->min_freq && adjusted_freq < df->min_freq)
-			adjusted_freq = df->min_freq;
-
-		*freq = adjusted_freq;
-	} else {
+	if (data->valid)
+		*freq = data->user_frequency;
+	else
 		*freq = df->previous_freq; /* No user freq specified yet */
-	}
+
 	return 0;
 }
 
-- 
2.18.0.rc1.242.g61856ae69a-goog
