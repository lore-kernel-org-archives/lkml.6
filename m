Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AEEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BA821D25
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BA821D25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeGCXtR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:49:17 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41566 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753537AbeGCXrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:47:32 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so1744196ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 16:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BB5bFgMvczqwvFxpGImGlCQGaZfQstFGTxKw+wkkwn8=;
        b=ZUnXCGBDRneS53DzHqGINhJC+J4B8M+19V29R9gz6hXpANltWBSJWTlFLhb4gau57i
         KpUy+bKLlS/YpSjuFHp0mFzhzBvLA7uNetdRJMvZIgeb5HqcEe2a5fFFPIdxiwESEies
         Wi/Ua0mvOuexBKvogZ8w9kokjtKFM2o+vtgaNoRdzos8oRqt36ON12KgV/xU3nkWbqwU
         Awh5MoQ4bfA9SaOecTy5ahXGUqwn75VHq72gKMqn29Tpqg4Nq76JUumH/WeweK2DVFJ6
         W8jgiDnRcreJ7h91eit/GXmS0GjX1XXltwRruAqaMb2Tezi0PNC3t0g8rg8yR2oRcR8G
         jRbA==
X-Gm-Message-State: APt69E1jVsan2t2QdNtL+TthQV4wKAuJ/7mX8Bzqehqx9H+x+omBNCVx
        NYYhzQcLTjwnnRSJgsW3a4MBKw==
X-Google-Smtp-Source: ADUXVKKWkUX7yG7OmrnYn8Hkct+47CtSY1MAqvIlGc2tTxh83MZ0cISLf3rsfWOvPqGCp/mwFac9tw==
X-Received: by 2002:a17:902:7446:: with SMTP id e6-v6mr32494159plt.161.1530661651454;
        Tue, 03 Jul 2018 16:47:31 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm6608562pfk.79.2018.07.03.16.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 16:47:30 -0700 (PDT)
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
Subject: [PATCH v5 06/12] PM / devfreq: Make update_devfreq() public
Date:   Tue,  3 Jul 2018 16:46:59 -0700
Message-Id: <20180703234705.227473-7-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180703234705.227473-1-mka@chromium.org>
References: <20180703234705.227473-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently update_devfreq() is only visible to devfreq governors outside
of devfreq.c. Make it public to allow drivers that adjust devfreq policies
to cause a re-evaluation of the frequency after a policy change.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
--
Changes in v5:
- none

Changed in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- added 'Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>' tag
---
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
2.18.0.203.gfac676dfb9-goog

