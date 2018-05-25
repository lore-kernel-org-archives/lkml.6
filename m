Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030256AbeEYUbZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:31:25 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43586 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968398AbeEYUbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:31:22 -0400
X-Google-Smtp-Source: AB8JxZo7u5tmL7HOKb+Jwr1nz7imy7O7oVLI79Im6I1arVnAnB27Gca3aUEo2YPBVl5m7fDylms5XQ==
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
Subject: [PATCH 05/11] PM / devfreq: governors: Return device frequency limits instead of user limits
Date: Fri, 25 May 2018 13:30:37 -0700
Message-Id: <20180525203043.249193-6-mka@chromium.org>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180525203043.249193-1-mka@chromium.org>
References: <20180525203043.249193-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The performance, powersave and simpleondemand governors can return
df->min/max_freq, which are the user defined frequency limits.
update_devfreq() already takes care of adjusting the target frequency
with the user limits if necessary, therefore we can return
df->scaling_min/max_freq instead, which is the min/max frequency
supported by the device at a given time (depending on the
enabled/disabled OPPs)

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/devfreq/governor_performance.c    | 2 +-
 drivers/devfreq/governor_powersave.c      | 2 +-
 drivers/devfreq/governor_simpleondemand.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/devfreq/governor_performance.c b/drivers/devfreq/governor_performance.c
index 1c990cb45098..a8e3478b3c43 100644
--- a/drivers/devfreq/governor_performance.c
+++ b/drivers/devfreq/governor_performance.c
@@ -20,7 +20,7 @@ static int devfreq_performance_func(struct devfreq *df,
 	 * target callback should be able to get floor value as
 	 * said in devfreq.h
 	 */
-	*freq = df->max_freq;
+	*freq = df->scaling_max_freq;
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_powersave.c b/drivers/devfreq/governor_powersave.c
index 0c42f23249ef..8696efd32e5a 100644
--- a/drivers/devfreq/governor_powersave.c
+++ b/drivers/devfreq/governor_powersave.c
@@ -20,7 +20,7 @@ static int devfreq_powersave_func(struct devfreq *df,
 	 * target callback should be able to get ceiling value as
 	 * said in devfreq.h
 	 */
-	*freq = df->min_freq;
+	*freq = df->scaling_min_freq;
 	return 0;
 }
 
diff --git a/drivers/devfreq/governor_simpleondemand.c b/drivers/devfreq/governor_simpleondemand.c
index 3da7554b4837..805fee09c754 100644
--- a/drivers/devfreq/governor_simpleondemand.c
+++ b/drivers/devfreq/governor_simpleondemand.c
@@ -46,7 +46,7 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 
 	/* Assume MAX if it is going to be divided by zero */
 	if (stat->total_time == 0) {
-		*freq = df->max_freq;
+		*freq = df->scaling_max_freq;
 		return 0;
 	}
 
@@ -59,13 +59,13 @@ static int devfreq_simple_ondemand_func(struct devfreq *df,
 	/* Set MAX if it's busy enough */
 	if (stat->busy_time * 100 >
 	    stat->total_time * dfso_upthreshold) {
-		*freq = df->max_freq;
+		*freq = df->scaling_max_freq;
 		return 0;
 	}
 
 	/* Set MAX if we do not know the initial frequency */
 	if (stat->current_frequency == 0) {
-		*freq = df->max_freq;
+		*freq = df->scaling_max_freq;
 		return 0;
 	}
 
-- 
2.17.0.921.gf22659ad46-goog
