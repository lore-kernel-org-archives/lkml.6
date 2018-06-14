Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 93F1CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A97208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A97208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755462AbeFNTr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:47:29 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41618 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936080AbeFNTrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:47:25 -0400
Received: by mail-pl0-f68.google.com with SMTP id w8-v6so2581783ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lXfcYdgNocp+IdSV4lMW7l++kFYsGUhu5QyPKBsoKVM=;
        b=eHvC4QVXOXJoRCWMbDNdq2jFdtyERXKhZgTxOWH7TsKHmDJSARhSK5NG1lfXAvkER3
         jzMZE/6f6yO1DNHEz0b3JOWvBjkQFoX4qLqRrUtll6zk/zTTbUzrXHGr/MVG1tjTe/4I
         wuBvaGvcjs9kxq2BJ7hW3QFNzJ0ZLYuxwUeT5A6ju3+XfJxgdA7glDslC63cp0IzwMNI
         LBytyrVbTq3gk+OGIgxOL08/NM8jhKnbTjsgt1kU+d1K3JdfbjfxPIncvW7ZT/2MpSmU
         YeWzgQjmPHfYD3V3WTcq1qnse8HqSoeB283uJrmsrJa33BM+l9R31qgc/t/sglmeReM1
         rGtg==
X-Gm-Message-State: APt69E3St+fBcMVAMuSnxvG88h0YyV4DRtLLTq9NH9ut/OFto9wcWuji
        EOuKylqU2TItIj41n5bihCxKQA==
X-Google-Smtp-Source: ADUXVKJo+9UvHLCdqyxTBirsWf7mBjWCcjvePzT/P9oqqqY9pBZGpskVVn93vLaIkC9Sv+WTBUSkZw==
X-Received: by 2002:a17:902:d90f:: with SMTP id c15-v6mr4421415plz.65.1529005644156;
        Thu, 14 Jun 2018 12:47:24 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s28-v6sm9955506pfg.89.2018.06.14.12.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:47:22 -0700 (PDT)
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
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 03/12] PM / devfreq: Don't adjust to user limits in governors
Date:   Thu, 14 Jun 2018 12:47:03 -0700
Message-Id: <20180614194712.102134-4-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
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
Changes in v3:
- none

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

