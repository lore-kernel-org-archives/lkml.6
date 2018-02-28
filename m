Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbeB1AU6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 19:20:58 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36528 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751516AbeB1AU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 19:20:56 -0500
X-Google-Smtp-Source: AH8x225H96kUgEqnZNFDY8pW/NubTAwzoPjsf6L1j99agGAVGiMP5eLAFHSWSe3ou6CRuVRkXVSrNQ==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rpmsg: smd: Read remote state from channel info
Date: Tue, 27 Feb 2018 16:20:52 -0800
Message-Id: <20180228002052.11321-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases the remote processor does not trigger an interrupt when
transitioning a channel from OPENING to OPENED state and as such the
value of the cached "remote_state" will be stale.

Read the state directly from the "channel info" while waiting for the
remote to negotiate the channel state in order to remove false negatives
due to this.

Fixes: 268105fbc0f8 ("rpmsg: smd: Perform handshake during open")
Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_smd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 92d0c6a7a837..553a6c395f93 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -815,8 +815,8 @@ static int qcom_smd_channel_open(struct qcom_smd_channel *channel,
 
 	/* Wait for remote to enter opening or opened */
 	ret = wait_event_interruptible_timeout(channel->state_change_event,
-			channel->remote_state == SMD_CHANNEL_OPENING ||
-			channel->remote_state == SMD_CHANNEL_OPENED,
+			GET_RX_CHANNEL_INFO(channel, state) == SMD_CHANNEL_OPENING ||
+			GET_RX_CHANNEL_INFO(channel, state) == SMD_CHANNEL_OPENED,
 			HZ);
 	if (!ret) {
 		dev_err(&edge->dev, "remote side did not enter opening state\n");
@@ -827,7 +827,7 @@ static int qcom_smd_channel_open(struct qcom_smd_channel *channel,
 
 	/* Wait for remote to enter opened */
 	ret = wait_event_interruptible_timeout(channel->state_change_event,
-			channel->remote_state == SMD_CHANNEL_OPENED,
+			GET_RX_CHANNEL_INFO(channel, state) == SMD_CHANNEL_OPENED,
 			HZ);
 	if (!ret) {
 		dev_err(&edge->dev, "remote side did not enter open state\n");
-- 
2.16.2
