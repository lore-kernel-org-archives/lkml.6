Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id RobDLot1GVu3CwAAmS7hNA
	; Thu, 07 Jun 2018 18:12:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4C3B26089E; Thu,  7 Jun 2018 18:12:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 89FA4605A2;
	Thu,  7 Jun 2018 18:12:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89FA4605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936037AbeFGSM5 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:12:57 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44460 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934057AbeFGSMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:12:53 -0400
Received: by mail-pf0-f196.google.com with SMTP id h12-v6so5294838pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NIEA+H3awriCfyFaPbK2sSX3NO1thRxMuqu1+D6vHF0=;
        b=NadmL4HJcRODVANm9wWoVlIiQqIOJSlYowaPMuhX2FLtlidE68RhsYo1GGZkBd7Ub2
         6R0z0RfnnOJ36X+ZQt2itBWQE7er4A2LRo7elxpBR37/+QK8mTewYgKBgzPinGGfMfI5
         z4JKIJKKvpertL0aaPhnRAuANsCMfIyqi1irUnAzRQwRZSX1JzpIAGyqb8hxRqjsOCvT
         T/VuUQnFH4DXwKEUP7/cnOzuoUrfhkH0GDLvUX+H6Z9do3UW4YZI25+hojYa7YSY+7Js
         AYs9NHlRFH2PycfyEOcwmIoxJqJy3QH5qhDsrygAElbfPhN//U0vtI//ySxwsfshqZuB
         5ESQ==
X-Gm-Message-State: APt69E3AZjz0Ic1LJ54ELmzXvPU1KZhNKCz/mJM/cXjwxpe8mv7UuD5o
        AqsSvzmdrXmd6bZNprwc3u7coA==
X-Google-Smtp-Source: ADUXVKKBVboFpzKDkK9XjrQ5oDpIfqpWFzrWcsscEFaofggSwJLymAoAzKFDec0EIGdQMZkFkCLXGQ==
X-Received: by 2002:a63:6647:: with SMTP id a68-v6mr676220pgc.82.1528395173044;
        Thu, 07 Jun 2018 11:12:53 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:12:52 -0700 (PDT)
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
Subject: [PATCH v2 01/11] PM / devfreq: Init user limits from OPP limits, not viceversa
Date: Thu,  7 Jun 2018 11:12:04 -0700
Message-Id: <20180607181214.30338-2-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
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
---
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
