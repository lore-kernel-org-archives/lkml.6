Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeDXWhJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:37:09 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45901 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeDXWf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:35:26 -0400
X-Google-Smtp-Source: AIpwx4+ol/d3CV9MyLBpSxk3Ib/kIgfU+U4Zsm5KODyxZqI/bJv/7k74GBi1unkYjIS3RSy0wm37xg==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] PM / devfreq: Free devfreq upon set_freq_table error
Date: Tue, 24 Apr 2018 15:35:16 -0700
Message-Id: <20180424223521.28193-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180424223521.28193-1-bjorn.andersson@linaro.org>
References: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When set_freq_table() fails we must still free the previously allocated
devfreq context, so jump to the correct label for this. Also when this
happens devfreq will always be non-NULL, so drop the unnecessary
conditional.

Also destroy the devfreq mutex as we're cleaning up the devfreq object.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 2067cd229ce3..30a672397ff0 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -597,7 +597,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 		mutex_unlock(&devfreq->lock);
 		err = set_freq_table(devfreq);
 		if (err < 0)
-			goto err_out;
+			goto err_dev;
 		mutex_lock(&devfreq->lock);
 	}
 
@@ -669,8 +669,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
 
 	device_unregister(&devfreq->dev);
 err_dev:
-	if (devfreq)
-		kfree(devfreq);
+	mutex_destroy(&devfreq->lock);
+	kfree(devfreq);
 err_out:
 	return ERR_PTR(err);
 }
-- 
2.16.2
