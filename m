Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8A2C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0297D208B1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0297D208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754456AbeFUBw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:52:59 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34147 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754184AbeFUBwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:52:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id a63-v6so692070pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4mX5x3QDwKptSH29ZhFnLZDq1CsEb+Mi+2luC4z2P9M=;
        b=dzVFa0NSzqOKuRMKaXqd64504YzEYua0zb0j4bBB3bLDqpRRVeyftfPjpxAFnYtwWU
         GpaaN8Ojc4GExJ2VSX1MO8nj6x0skn/NPfON6cTpTaqC/HBJbh1xE0UNmESmggiXxuZF
         Ey2YnbxMZgzRt/LrRONJ+a2FhYkpantmfx23sdTZR6pW4nGj3Ustnw0Qtj3EysYcGR1D
         zllcAaac24dGBEoS7uNrtRxMcXluZ/0NeYkBOdnxFuyxxkqo77OyFHpoDDZfw8Zvy4+n
         SiTrqLNPJnQd3m7dumWaKNA7GKc2WpQcI49z2C63ByONKcYK7D7trHAaeyVPCtXxtdA4
         z4Hg==
X-Gm-Message-State: APt69E14HhCJFq5dGg8y14dwDBZ4Rjj6DGzOxiusmMURxRaNF7Nah42K
        9b30LZn1gwa9n3NstIKt9IsHyA==
X-Google-Smtp-Source: ADUXVKLveQlNtWJIxxWGu3QB9nZEIW34L3iPUe9Rk0Dd9AEsrpGTh8EMGLIrPaabYcjw9KfYzgyRoA==
X-Received: by 2002:a65:65ca:: with SMTP id y10-v6mr20818381pgv.359.1529545975143;
        Wed, 20 Jun 2018 18:52:55 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p12-v6sm6585877pfi.175.2018.06.20.18.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:52:54 -0700 (PDT)
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
Subject: [PATCH v4 02/12] PM / devfreq: Fix handling of min/max_freq == 0
Date:   Wed, 20 Jun 2018 18:52:27 -0700
Message-Id: <20180621015237.100100-3-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621015237.100100-1-mka@chromium.org>
References: <20180621015237.100100-1-mka@chromium.org>
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
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- handle freq tables sorted in ascending and descending order in
  min/max_freq_store()
- use same order for conditional statements in min/max_freq_store()
---
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
2.18.0.rc2.346.g013aa6912e-goog

