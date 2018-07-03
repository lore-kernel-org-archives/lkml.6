Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42362C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD9F21D25
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD9F21D25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753460AbeGCXr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:47:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45909 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeGCXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:24 -0400
Received: by mail-pf0-f194.google.com with SMTP id y24-v6so1720073pfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t//gmzpIVvV+WQDfrai/menR07GoTdBew0ehvnbR71Y=;
        b=l6TE2qIPzVPLq8FLbhd9UvHgUNQq/I5w7+czRNkYehxBB0rtwuQOKkBFYwX6P188TD
         5gwVq3dxtZxH1HXmna4i+nvlRwMo1qocjOj7N0NlF7VHiB91a6l+InDHru5sKJ153vMM
         QaU7idvdWxDV34hXKqSq6bGoKsylPZsh6keWhKNBRBkPhg42mAN9H+cQFH2HDUDzad3+
         ggKIwo2XnYu1F2McqRsuAVc/6mYe7Ne/esOkSkRVH4zeOCUoFAmrM6lW0X/z1EqDADmU
         XyvYcxANIL8qrBupxvJKXXQ2yr1bbZlUOph2e+dQC3kJHwpvOsNkJp4WXYKrDEL1W6cL
         Ctzg==
X-Gm-Message-State: APt69E3rieMnPPmb4gmXJ0vsIrkNsthkw7CA5PioPBGNKQm5wjgGpEgw
        yIvEJoNYI2Q1FH8B2opFri9eOQ==
X-Google-Smtp-Source: AAOMgpf6L4gCr+Ua9dg/5haEcBWNbzIbarE12TlOgnXHGGQKDnoxVO4UirfsEbv4MhYWzSZ127Pcdg==
X-Received: by 2002:a62:4a51:: with SMTP id x78-v6mr31824908pfa.45.1530661643730;
        Tue, 03 Jul 2018 16:47:23 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:22 -0700 (PDT)
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
Subject: [PATCH v5 01/12] PM / devfreq: Init user limits from OPP limits, not viceversa
Date:   Tue,  3 Jul 2018 16:46:54 -0700
Message-Id: <20180703234705.227473-2-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
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
Changes in v5:
- none

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
2.18.0.203.gfac676dfb9-goog

