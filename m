Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 38F68C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3D7208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3D7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935560AbeFNTrZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:47:25 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:44649 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755319AbeFNTrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:47:21 -0400
Received: by mail-pf0-f182.google.com with SMTP id h12-v6so3725652pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=02SeX4YfVOjCQ6yNg1z5x0uefnBEbh4S/qgy/FkI1x4=;
        b=iG03tfl1gsmxdNukPBwgaacZMSu0JvLi3S1lRUeLIRHZXl2QYFzajZ0mLvOb+yRcwx
         lfE/giUEo1GwVwvw8FUSv+XJUhGTJK/IKZJvkhvdmDjw/ZFmPavopugiKscXbMmLp9/M
         Rp9PxhbEyISJIxd2TU5VoQik9HJt8wJ0HF/8sqqau4jmIkUuzoP7JcTc7NiAC42SeOYd
         dA6I4lKk78uFqRLhdUwW9URTNJu2satzRR624iHBQU2MPgFbl9aejnbYO+ZcxI9npfmE
         fJQ2LIDlxtKAY0hTg7iSqeWD30A6RiUdpPbsvxExIpGszx0TKV2q7utd5VSUjly7deeU
         AZMQ==
X-Gm-Message-State: APt69E2uu8tcyakE9Rmn8dW5dLR7xkRaACDbKLnmqQJ+YPd4s1xutta7
        hMHAzw+7kaIF+kWlAVYFeZ8sKg==
X-Google-Smtp-Source: ADUXVKIpZxHRhOI557p+zKDY0AVnvZJheFrEJjjwsBnz+ZMRH+RipDYO3iOWy+VFmjKyLGq8q4PAxw==
X-Received: by 2002:a65:65d6:: with SMTP id y22-v6mr3481716pgv.270.1529005640214;
        Thu, 14 Jun 2018 12:47:20 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s28-v6sm9955506pfg.89.2018.06.14.12.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:47:19 -0700 (PDT)
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
Subject: [PATCH v3 01/12] PM / devfreq: Init user limits from OPP limits, not viceversa
Date:   Thu, 14 Jun 2018 12:47:01 -0700
Message-Id: <20180614194712.102134-2-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ab8f58ad72c4 ("PM / devfreq: Set min/max_freq when adding
the devfreq device") introduced the initialization of the user
limits min/max_freq from the lowest/highest available OPPs. Later
commit f1d981eaecf8 ("PM / devfreq: Use the available min/max
frequency") added scaling_min/max_freq, which actually represent
the frequencies of the lowest/highest available OPP. scaling_min/
max_freq are initialized with the values from min/max_freq, which
is totally correct in the context, but a bit awkward to read.

Swap the initialization and assign scaling_min/max_freq with the
OPP freqs and then the user limts min/max_freq with scaling_min/
max_freq.

Needless to say that this change is a NOP, intended to improve
readability.
---
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Changes in v3:
- none

Changes in v2:
- added 'Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>' tag

 drivers/devfreq/devfreq.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index fe2af6aa88fc..0057ef5b0a98 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -604,21 +604,21 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_lock(&devfreq->lock);
 	}
 
-	devfreq->min_freq = find_available_min_freq(devfreq);
-	if (!devfreq->min_freq) {
+	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
+	if (!devfreq->scaling_min_freq) {
 		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->scaling_min_freq = devfreq->min_freq;
+	devfreq->min_freq = devfreq->scaling_min_freq;
 
-	devfreq->max_freq = find_available_max_freq(devfreq);
-	if (!devfreq->max_freq) {
+	devfreq->scaling_max_freq = find_available_max_freq(devfreq);
+	if (!devfreq->scaling_max_freq) {
 		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
-	devfreq->scaling_max_freq = devfreq->max_freq;
+	devfreq->max_freq = devfreq->scaling_max_freq;
 
 	dev_set_name(&devfreq->dev, "devfreq%d",
 				atomic_inc_return(&devfreq_no));
-- 
2.18.0.rc1.242.g61856ae69a-goog

