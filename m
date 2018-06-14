Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 216AAC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DC7208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DC7208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755553AbeFNTtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:49:19 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39019 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755466AbeFNTra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:47:30 -0400
Received: by mail-pf0-f194.google.com with SMTP id r11-v6so3729745pfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3GU5jBNuwcofU2Pz3yweZqPOf7o7b8ZFESSj4vZKetU=;
        b=lM9byEm8+FbBEAVK6ZfQoYvEN5pajMcLr0ZFeE4neYInye7ESDrLuSfcNpoX9NoWpX
         Ga/Zs15KtZYisRzBMZ+x9AHWZmAJQU197xFaAcAGmGfP1G9Zu8Ci4eXZz+FI8RLAmAe/
         /L+1rlijWcmcY+9VZFNVsngtJujBjRGLmn9oSKnSmpJ/S9CzLsZgU055uU3Mu9uzI/sQ
         WU1wTNbs5+n5CHFAit59+x+OrjvLQ0QNEaAbCrQSVerma48Je4LZD8EeY9XYZlhHTNQq
         Hl7X6KE71gWmo83Ivzms9L7JQ2wwbOHlQ06wJvQtvUr4gkwwArl29n6OIpMAsR84+0NT
         5XgA==
X-Gm-Message-State: APt69E3zAQUe2pk+2nwtgsBZ+XcDxPtOaKn808gv+iLS6iP+nOMA+m8N
        L/Fs+PrvAXo61pJs7oS+2QgM6w==
X-Google-Smtp-Source: ADUXVKJBbEpt6ipQKPj2/vflFriuut/FF02AfKhUZ/ijdAqIuRwQUKiLxAH2hBubzdU/VKQxeN2ELA==
X-Received: by 2002:a62:5788:: with SMTP id i8-v6mr10695132pfj.175.1529005649959;
        Thu, 14 Jun 2018 12:47:29 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s28-v6sm9955506pfg.89.2018.06.14.12.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:47:28 -0700 (PDT)
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
Subject: [PATCH v3 06/12] PM / devfreq: Make update_devfreq() public
Date:   Thu, 14 Jun 2018 12:47:06 -0700
Message-Id: <20180614194712.102134-7-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently update_devfreq() is only visible to devfreq governors outside
of devfreq.c. Make it public to allow drivers that adjust devfreq policies
to cause a re-evaluation of the frequency after a policy change.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
Changes in v3:
- none

Changes in v2:
- added 'Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>' tag

 drivers/devfreq/governor.h | 3 ---
 include/linux/devfreq.h    | 8 ++++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index b81700244ce3..f53339ca610f 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -57,9 +57,6 @@ struct devfreq_governor {
 				unsigned int event, void *data);
 };
 
-/* Caution: devfreq->lock must be locked before calling update_devfreq */
-extern int update_devfreq(struct devfreq *devfreq);
-
 extern void devfreq_monitor_start(struct devfreq *devfreq);
 extern void devfreq_monitor_stop(struct devfreq *devfreq);
 extern void devfreq_monitor_suspend(struct devfreq *devfreq);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 7c8dce96db73..c4f84a769cb5 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -222,6 +222,14 @@ extern void devm_devfreq_remove_device(struct device *dev,
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
+/**
+ * update_devfreq() - Reevaluate the device and configure frequency
+ * @devfreq:	the devfreq device
+ *
+ * Note: devfreq->lock must be held
+ */
+extern int update_devfreq(struct devfreq *devfreq);
+
 /* Helper functions for devfreq user device driver with OPP. */
 extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags);
-- 
2.18.0.rc1.242.g61856ae69a-goog

