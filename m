Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6194C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75879256CC
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75879256CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030923AbeGAQeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:34:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35522 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030505AbeGAQeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:34:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B7FE049B;
        Sun,  1 Jul 2018 16:34:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.14 108/157] rpmsg: smd: do not use mananged resources for endpoints and channels
Date:   Sun,  1 Jul 2018 18:23:00 +0200
Message-Id: <20180701160857.938337328@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

commit 4a2e84c6ed85434ce7843e4844b4d3263f7e233b upstream.

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
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rpmsg/qcom_smd.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1043,12 +1043,12 @@ static struct qcom_smd_channel *qcom_smd
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
 
@@ -1098,8 +1098,8 @@ static struct qcom_smd_channel *qcom_smd
 	return channel;
 
 free_name_and_channel:
-	devm_kfree(&edge->dev, channel->name);
-	devm_kfree(&edge->dev, channel);
+	kfree(channel->name);
+	kfree(channel);
 
 	return ERR_PTR(ret);
 }
@@ -1320,13 +1320,13 @@ static int qcom_smd_parse_edge(struct de
  */
 static void qcom_smd_edge_release(struct device *dev)
 {
-	struct qcom_smd_channel *channel;
+	struct qcom_smd_channel *channel, *tmp;
 	struct qcom_smd_edge *edge = to_smd_edge(dev);
 
-	list_for_each_entry(channel, &edge->channels, list) {
-		SET_RX_CHANNEL_INFO(channel, state, SMD_CHANNEL_CLOSED);
-		SET_RX_CHANNEL_INFO(channel, head, 0);
-		SET_RX_CHANNEL_INFO(channel, tail, 0);
+	list_for_each_entry_safe(channel, tmp, &edge->channels, list) {
+		list_del(&channel->list);
+		kfree(channel->name);
+		kfree(channel);
 	}
 
 	kfree(edge);


