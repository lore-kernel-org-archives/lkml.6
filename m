Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FhQxHpx1GVtDDgAAmS7hNA
	; Thu, 07 Jun 2018 18:13:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AE7086074D; Thu,  7 Jun 2018 18:13:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1DF5E605A2;
	Thu,  7 Jun 2018 18:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1DF5E605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936066AbeFGSM7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:12:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35894 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934260AbeFGSMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:12:55 -0400
Received: by mail-pf0-f193.google.com with SMTP id a12-v6so5306616pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E1TTi1m2UewF1bqfFu4ZuPLrGPvQd9yZwooLHvznvZU=;
        b=oCbi5hlrjFWlmxsZZnKh3mNV9aSijtlq8kG4+UEn6OMRSj1WU5oriQlESIXHbGSEgb
         kty50zZP0xdu+NV2VUKZbVtzfy6DLsP7l+AkIc8FtrOxyQXIFCSB/HFCrKAHehISsjz6
         gqn548sRFZEk6QBxGchmrxDUPuBgHCNlbX4YphsYjEG7Ndv+z+cElVGW1HPdkAIYW+n5
         B8EJNTLNk+ReDlRf5jNEhq64UXib9IMw62PYzs+ApnLYWAO2eZG2NLI+pOFKbTnA55BX
         pdGQbCYB5afGvyAFgjLT/1aCrV5mRBUiup2pj7YRm3GumaQURulSMvjYuWqv9cA9LBEE
         Extw==
X-Gm-Message-State: APt69E32FE1OOgSbFcgsOqCpAhgoYOS2xeNdsyXff/HYGjNP+zUBugyO
        bA5SYRQZbl7AoiT3gccQRHNvhw==
X-Google-Smtp-Source: ADUXVKLaTQlzFJ9hM8NxwYX19/aSq1CXHONb4xpzG3F5Gzrzpcj9AWLTj0SMU4gLxVisP2VSlYKryg==
X-Received: by 2002:a65:468e:: with SMTP id h14-v6mr2385567pgr.89.1528395174586;
        Thu, 07 Jun 2018 11:12:54 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:12:53 -0700 (PDT)
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
Subject: [PATCH v2 02/11] PM / devfreq: Fix handling of min/max_freq == 0
Date: Thu,  7 Jun 2018 11:12:05 -0700
Message-Id: <20180607181214.30338-3-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding the
devfreq device") initializes df->min/max_freq with the min/max OPP when
the device is added. Later commit f1d981eaecf8 ("PM / devfreq: Use the
available min/max frequency") adds df->scaling_min/max_freq and the
following to the frequency adjustment code:

  max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);

With the current handling of min/max_freq this is incorrect:

Even though df->max_freq is now initialized to a value != 0 user space
can still set it to 0, in this case max_freq would be 0 instead of
df->scaling_max_freq as intended. In consequence the frequency adjustment
is not performed:

  if (max_freq && freq > max_freq) {
	freq = max_freq;

To fix this set df->min/max freq to the min/max OPP in max/max_freq_store,
when the user passes a value of 0. This also prevents df->max_freq from
being set below the min OPP when df->min_freq is 0, and similar for
min_freq. Since it is now guaranteed that df->min/max_freq can't be 0 the
checks for this case can be removed.

Fixes: f1d981eaecf8 ("PM / devfreq: Use the available min/max frequency")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- handle freq tables sorted in ascending and descending order in
  min/max_freq_store()
- use same order for conditional statements in min/max_freq_store()

 drivers/devfreq/devfreq.c | 42 ++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 0057ef5b0a98..6f604f8b2b81 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -283,11 +283,11 @@ int update_devfreq(struct devfreq *devfreq)
 	max_freq = MIN(devfreq->scaling_max_freq, devfreq->max_freq);
 	min_freq = MAX(devfreq->scaling_min_freq, devfreq->min_freq);
 
-	if (min_freq && freq < min_freq) {
+	if (freq < min_freq) {
 		freq = min_freq;
 		flags &= ~DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use GLB */
 	}
-	if (max_freq && freq > max_freq) {
+	if (freq > max_freq) {
 		freq = max_freq;
 		flags |= DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
 	}
@@ -1122,18 +1122,27 @@ static ssize_t min_freq_store(struct device *dev, struct device_attribute *attr,
 {
 	struct devfreq *df = to_devfreq(dev);
 	unsigned long value;
+	unsigned long *freq_table;
 	int ret;
-	unsigned long max;
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
 	mutex_lock(&df->lock);
-	max = df->max_freq;
-	if (value && max && value > max) {
-		ret = -EINVAL;
-		goto unlock;
+
+	if (value) {
+		if (value > df->max_freq) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+	} else {
+		freq_table = df->profile->freq_table;
+		/* typical order is ascending, some drivers use descending */
+		if (freq_table[0] < freq_table[df->profile->max_state - 1])
+			value = freq_table[0];
+		else
+			value = freq_table[df->profile->max_state - 1];
 	}
 
 	df->min_freq = value;
@@ -1157,18 +1166,27 @@ static ssize_t max_freq_store(struct device *dev, struct device_attribute *attr,
 {
 	struct devfreq *df = to_devfreq(dev);
 	unsigned long value;
+	unsigned long *freq_table;
 	int ret;
-	unsigned long min;
 
 	ret = sscanf(buf, "%lu", &value);
 	if (ret != 1)
 		return -EINVAL;
 
 	mutex_lock(&df->lock);
-	min = df->min_freq;
-	if (value && min && value < min) {
-		ret = -EINVAL;
-		goto unlock;
+
+	if (value) {
+		if (value < df->min_freq) {
+			ret = -EINVAL;
+			goto unlock;
+		}
+	} else {
+		freq_table = df->profile->freq_table;
+		/* typical order is ascending, some drivers use descending */
+		if (freq_table[0] < freq_table[df->profile->max_state - 1])
+			value = freq_table[df->profile->max_state - 1];
+		else
+			value = freq_table[0];
 	}
 
 	df->max_freq = value;
-- 
2.18.0.rc1.242.g61856ae69a-goog
