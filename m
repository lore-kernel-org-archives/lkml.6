Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeDXTqs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:46:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45921 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeDXTqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:46:43 -0400
X-Google-Smtp-Source: AB8JxZog3mlli55FQNa7Ga2mrgrMUwffKruvu3JLhxbD70mhILAWDaC7zw4xtA9gj9mfW52vMAJL3g==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PM / devfreq: Drop custom MIN/MAX macros
Date: Tue, 24 Apr 2018 12:46:39 -0700
Message-Id: <20180424194639.22804-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the custom MIN/MAX macros in favour of the standard min/max from
kernel.h

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fe2af6aa88fc..2067cd229ce3 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -28,9 +28,6 @@
 #include <linux/of.h>
 #include "governor.h"
 
-#define MAX(a,b)	((a > b) ? a : b)
-#define MIN(a,b)	((a < b) ? a : b)
-
 static struct class *devfreq_class;
 
 /*
@@ -280,8 +277,8 @@ int update_devfreq(struct devfreq *devfreq)
 	 * max_freq
 	 * min_freq
 	 */
-	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
-	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
+	max_freq = min(devfreq->scaling_max_freq, devfreq->max_freq);
+	min_freq = max(devfreq->scaling_min_freq, devfreq->min_freq);
 
 	if (min_freq && freq < min_freq) {
 		freq = min_freq;
@@ -1149,7 +1146,7 @@ static ssize_t min_freq_show(struct device *dev, struct device_attribute *attr,
 {
 	struct devfreq *df = to_devfreq(dev);
 
-	return sprintf(buf, "%lu\n", MAX(df->scaling_min_freq, df->min_freq));
+	return sprintf(buf, "%lu\n", max(df->scaling_min_freq, df->min_freq));
 }
 
 static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
@@ -1185,7 +1182,7 @@ static ssize_t max_freq_show(struct device *dev, struct device_attribute *attr,
 {
 	struct devfreq *df = to_devfreq(dev);
 
-	return sprintf(buf, "%lu\n", MIN(df->scaling_max_freq, df->max_freq));
+	return sprintf(buf, "%lu\n", min(df->scaling_max_freq, df->max_freq));
 }
 static DEVICE_ATTR_RW(max_freq);
 
-- 
2.16.2
