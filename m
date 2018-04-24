Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeDXWg2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:36:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34868 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbeDXWf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:35:29 -0400
X-Google-Smtp-Source: AIpwx4/vWbic9Mv4Lp4ZdJG8esoofx2zUWtRad2gNKq233seQQuQXcYreASl4r5tcjwSQQJIwuxi3Q==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] PM / devfreq: Remove unnecessary locking
Date: Tue, 24 Apr 2018 15:35:19 -0700
Message-Id: <20180424223521.28193-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180424223521.28193-1-bjorn.andersson@linaro.org>
References: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq lock is used to prevent concurrent access to the devfreq
object, but as all operations leading up to the registration of the
devfreq device are local to devfreq_add_device() there's no reason to
hold the lock.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2e50f5d9d92a..70588dc2032c 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -584,7 +584,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	}
 
 	mutex_init(&devfreq->lock);
-	mutex_lock(&devfreq->lock);
 	devfreq->dev.parent = dev;
 	devfreq->dev.class = devfreq_class;
 	devfreq->dev.release = devfreq_dev_release;
@@ -596,16 +595,13 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
 	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
-		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
 			goto err_dev;
-		mutex_lock(&devfreq->lock);
 	}
 
 	devfreq->min_freq = find_available_min_freq(devfreq);
 	if (!devfreq->min_freq) {
-		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
@@ -613,7 +609,6 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	devfreq->max_freq = find_available_max_freq(devfreq);
 	if (!devfreq->max_freq) {
-		mutex_unlock(&devfreq->lock);
 		err = -EINVAL;
 		goto err_dev;
 	}
@@ -635,12 +630,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 				atomic_inc_return(&devfreq_no));
 	err = device_register(&devfreq->dev);
 	if (err) {
-		mutex_unlock(&devfreq->lock);
 		goto err_dev;
 	}
 
-	mutex_unlock(&devfreq->lock);
-
 	mutex_lock(&devfreq_list_lock);
 	list_add(&devfreq->node, &devfreq_list);
 
-- 
2.16.2
