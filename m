Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A4C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47D8247DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47D8247DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753526AbeGCXra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:47:30 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45092 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753419AbeGCXr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:27 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so1637035pgv.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZLfPgwe4IW/U6Ua97tDCBa45lu3AEGJAaBihktA8OM4=;
        b=phf6Zc1FSMA3RD1IejTldBDhAoRxTChvSr9uWtDPJ2iBBNIKvSKiiOcjUg0H30Ga3r
         czVY08PXp6uTBsGT0YSy5eLMLRHYoZZIgACAcyIlBhK7NZ45pN71jOpffISKVP+R3IAH
         8CIt0Oea25JY/NXh3eCf5cBPVkZDEJNVsQQfBKOM0PkTAV3F8ql2oXnxHCfWJEkW1IM5
         G6mQ6z5ZpWb2H7uB/I0q21mWw3i06kDyqEl4EvO8abp4EHi+SnSTG5aWyt3uZLlS8Nz0
         FhIYa/mSsguQ+tJD9fXiSXlfyooz25W2XiyTU2w/d2W0nI1qOGCl+RMrFEEoPRQz9lpR
         N5Ag==
X-Gm-Message-State: APt69E14yD23iF+F6roGcdeMk1mHSb+BRH+t5+vyshMO6uvJhhnlj/mr
        UENZ38wkQyTnz3awrikGpLF4rQ==
X-Google-Smtp-Source: AAOMgperqMYbgbNfBa0dyBl0biI326xgnBotZne1keHCTiVYm+Rh9tWYH2BW92YvFJdKxMr1rGsnnQ==
X-Received: by 2002:a62:c918:: with SMTP id k24-v6mr31633124pfg.160.1530661646669;
        Tue, 03 Jul 2018 16:47:26 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:25 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 03/12] PM / devfreq: Don't adjust to user limits in governors
Date:   Tue,  3 Jul 2018 16:46:56 -0700
Message-Id: <20180703234705.227473-4-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
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
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v5:
- none

Changes in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- squashed "PM / devfreq: Remove redundant frequency adjustment from governors"
  and "PM / devfreq: governors: Return device frequency limits instead of user
  limits"
- updated subject and commit message
- use DEVFREQ_MIN/MAX_FREQ instead of df->scaling_min/max_freq
---
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
2.18.0.203.gfac676dfb9-goog

