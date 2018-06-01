Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbeFAXej (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 19:34:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34853 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbeFAXeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 19:34:37 -0400
X-Google-Smtp-Source: ADUXVKIWO/FKYLbsnK4mzFx9fjRAdyin6Ml1Djbg1Z0z4IQOtzooIKgg9glWrbt341nq8L42exgTHw==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: ohad@wizery.com, bjorn.andersson@linaro.org
Cc: linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] rpmsg: smd: do not use mananged resources for endpoints and channels
Date: Sat,  2 Jun 2018 00:32:31 +0100
Message-Id: <20180601233231.11230-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the managed resources would be freed by the time release function
is invoked. Handling such memory in qcom_smd_edge_release() would do
bad things.

Found this issue while testing Audio usecase where the dsp is started up
and shutdown in a loop.

This patch fixes this issue by using simple kzalloc for allocating
channel->name and channel which is then freed in qcom_smd_edge_release().

Without this patch restarting a remoteproc would crash the system.
Fixes: 53e2822e56c7 ("rpmsg: Introduce Qualcomm SMD backend")
Cc: <stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/rpmsg/qcom_smd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 5ce9bf7b897d..49d3838dfc3d 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1100,12 +1100,12 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
 	void *info;
 	int ret;
 
-	channel = devm_kzalloc(&edge->dev, sizeof(*channel), GFP_KERNEL);
+	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
 	if (!channel)
 		return ERR_PTR(-ENOMEM);
 
 	channel->edge = edge;
-	channel->name = devm_kstrdup(&edge->dev, name, GFP_KERNEL);
+	channel->name = kstrdup(name, GFP_KERNEL);
 	if (!channel->name)
 		return ERR_PTR(-ENOMEM);
 
@@ -1156,8 +1156,8 @@ static struct qcom_smd_channel *qcom_smd_create_channel(struct qcom_smd_edge *ed
 	return channel;
 
 free_name_and_channel:
-	devm_kfree(&edge->dev, channel->name);
-	devm_kfree(&edge->dev, channel);
+	kfree(channel->name);
+	kfree(channel);
 
 	return ERR_PTR(ret);
 }
@@ -1380,11 +1380,13 @@ static void qcom_smd_edge_release(struct device *dev)
 {
 	struct qcom_smd_channel *channel;
 	struct qcom_smd_edge *edge = to_smd_edge(dev);
+	struct list_head *this, *tmp;
 
-	list_for_each_entry(channel, &edge->channels, list) {
-		SET_RX_CHANNEL_INFO(channel, state, SMD_CHANNEL_CLOSED);
-		SET_RX_CHANNEL_INFO(channel, head, 0);
-		SET_RX_CHANNEL_INFO(channel, tail, 0);
+	list_for_each_safe(this, tmp, &edge->channels) {
+		channel = list_entry(this, struct qcom_smd_channel, list);
+		list_del(&channel->list);
+		kfree(channel->name);
+		kfree(channel);
 	}
 
 	kfree(edge);
-- 
2.16.2
