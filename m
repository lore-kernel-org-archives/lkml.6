Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E317AC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB24920837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB24920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754786AbeFUBz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:55:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38306 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754172AbeFUBwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:52:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id b74-v6so686778pfl.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iP0aNpMNP5NFNiX8O+ENtHFFZp1nhrIXS/ECXHZDgak=;
        b=mJ4Ys2w52y9B1cFLN/JUfWvi3NeantNWsRUTKjD7ROCfyVxrTcXOb/iDhMTSu3Jw2+
         3FDAa15jY7v9h5cLcJNSE2RsYqoWDWgvv+IVRa5iugsfhg8MSNPxPj3taLj3SGsgbHrH
         vMZop1yV5z+U2XyP94lFTza6oRAifE0MIddp1PqxYs+5N8OlHjyosuCtEJ7GL4TIadX4
         rXEMqGTsWnXNWWX2O6rt0DclCGRkpWDJ5TS2M3owZnrOZ+bsoAqjjushr1rKdPvU1CHS
         UUK2ZxI0aYzJEAe44XuZcup7kly6mrqjDaDY9ahLpFJGqIVWaZMFTzkL8i85wJPLurAy
         SmLQ==
X-Gm-Message-State: APt69E2Aoft9MyO7KrKtpKPAmbp6aMWuI+0aGJgd0UnJ+4TqeOrOuIdY
        tNEaTmpEnDzoWi8GRZ8ieboLyg==
X-Google-Smtp-Source: ADUXVKLBq38NT4ZRCc1aRgRYsNJKMnM2JlMqf3VBfqmYseNEPxL7z1gLoKIkHEUTMrb7CgmkgCn9eg==
X-Received: by 2002:a63:3759:: with SMTP id g25-v6mr21087268pgn.59.1529545973425;
        Wed, 20 Jun 2018 18:52:53 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p12-v6sm6585877pfi.175.2018.06.20.18.52.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:52:52 -0700 (PDT)
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
Subject: [PATCH v4 01/12] PM / devfreq: Init user limits from OPP limits, not viceversa
Date:   Wed, 20 Jun 2018 18:52:26 -0700
Message-Id: <20180621015237.100100-2-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621015237.100100-1-mka@chromium.org>
References: <20180621015237.100100-1-mka@chromium.org>
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

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- added 'Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>' tag
---
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
2.18.0.rc2.346.g013aa6912e-goog

