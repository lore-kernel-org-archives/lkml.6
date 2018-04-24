Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbeDXWf6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 18:35:58 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33323 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbeDXWfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 18:35:31 -0400
X-Google-Smtp-Source: AIpwx48fGYWuGs2LG0PEWStWgzzH5wuUZo49bGpvfPrf4kv79LtsdgO+7Ia9jaUWwybrg3h+0TWbXw==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] PM / devfreq: Reject client provided freq_table
Date: Tue, 24 Apr 2018 15:35:21 -0700
Message-Id: <20180424223521.28193-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180424223521.28193-1-bjorn.andersson@linaro.org>
References: <20180424223521.28193-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq profile's freq_table is an internal resource used to keep
track of all levels described in the associated opp table, in order to
support levels being enabled and disabled in runtime by e.g.
devfreq_cooling.

As it is required by the implementation that the device has an
associated opp table and expected that the freq_table matches this, it
is not possible for clients to provide a freq_table through the devfreq
profile.

Check for this in devfreq_add_device() and remove the unnecessary
conditional generation of the internal freq_table.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/devfreq/devfreq.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index c804bd72a644..3d1f6a2edf68 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -557,7 +557,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	static atomic_t devfreq_no = ATOMIC_INIT(-1);
 	int err = 0;
 
-	if (!dev || !profile || !governor_name) {
+	if (!dev || !profile || !governor_name || profile->freq_table) {
 		dev_err(dev, "%s: Invalid parameters.\n", __func__);
 		return ERR_PTR(-EINVAL);
 	}
@@ -590,11 +590,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
 	devfreq->data = data;
 	devfreq->nb.notifier_call = devfreq_notifier_call;
 
-	if (!devfreq->profile->max_state && !devfreq->profile->freq_table) {
-		err = set_freq_table(devfreq);
-		if (err < 0)
-			goto err_dev;
-	}
+	err = set_freq_table(devfreq);
+	if (err < 0)
+		goto err_dev;
 
 	devfreq->min_freq = find_available_min_freq(devfreq);
 	if (!devfreq->min_freq) {
-- 
2.16.2
