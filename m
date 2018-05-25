Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030434AbeEYUdH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:33:07 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37362 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968404AbeEYUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:31:21 -0400
X-Google-Smtp-Source: AB8JxZpMfx0sLQBcnk6YWE/T8fb+mPoki7zIgqJOp+sqNV8cXAX5CJ0PfFMRbU7fAp5N7C792LtahA==
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 04/11] PM / devfreq: Remove redundant frequency adjustment from governors
Date: Fri, 25 May 2018 13:30:36 -0700
Message-Id: <20180525203043.249193-5-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180525203043.249193-1-mka@chromium.org>
References: <20180525203043.249193-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The userspace and simpleondemand governor determine a target frequency and
then adjust it according to the df->min/max_freq limits that might have
been set by user space. This adjustment is redundant, it is done in
update_devfreq() for any governor, right after returning from
governor->get_target_freq().

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/governor_simpleondemand.c |  5 -----
 drivers/devfreq/governor_userspace.c      | 16 ++++------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 278964783fa6..3da7554b4837 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -84,11 +84,6 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
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
2.17.0.921.gf22659ad46-goog
