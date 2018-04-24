Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbeDXWgz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:36:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38397 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDXWf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:35:27 -0400
X-Google-Smtp-Source: AIpwx4/kEPaV9tfKhwbarWZbY3IHXr9Gc6F5GH8pg8wWp0x8xl43+KWtAQU5wJ76gZUgp9vFKkV9dQ==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] PM / devfreq: Use the device release function for cleanup
Date: Tue, 24 Apr 2018 15:35:17 -0700
Message-Id: <20180424223521.28193-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180424223521.28193-1-bjorn.andersson@linaro.org>
References: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the devfreq from the devfreq_list before calling unregister
causes the device's release function to not find the devfreq and as such
bails from the release function, resulting in the following log
entries if an invalid governor is specified.

 ufshcd-qcom 624000.ufshc: devfreq_add_device: Unable to find governor for the device
 devfreq devfreq0: releasing devfreq which doesn't exist

Drop the removal of devfreq from the list.

As the release function will end by freeing the devfreq context we have
to skip the freeing of this in our error handler, and hence need to pull
in the device_unregister() calls.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 30a672397ff0..d5b278b8f20e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -647,8 +647,10 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (IS_ERR(governor)) {
 		dev_err(dev, "%s: Unable to find governor for the device\n",
 			__func__);
+		mutex_unlock(&devfreq_list_lock);
+		device_unregister(&devfreq->dev);
 		err = PTR_ERR(governor);
-		goto err_init;
+		goto err_out;
 	}
 
 	devfreq->governor = governor;
@@ -657,17 +659,14 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	if (err) {
 		dev_err(dev, "%s: Unable to start governor for the device\n",
 			__func__);
-		goto err_init;
+		mutex_unlock(&devfreq_list_lock);
+		device_unregister(&devfreq->dev);
+		goto err_out;
 	}
 	mutex_unlock(&devfreq_list_lock);
 
 	return devfreq;
 
-err_init:
-	list_del(&devfreq->node);
-	mutex_unlock(&devfreq_list_lock);
-
-	device_unregister(&devfreq->dev);
 err_dev:
 	mutex_destroy(&devfreq->lock);
 	kfree(devfreq);
-- 
2.16.2
