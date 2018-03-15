Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeCOSMu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:12:50 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43835 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752567AbeCOSMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:12:48 -0400
X-Google-Smtp-Source: AG47ELssJwdQlcv+U4r2ccWYFiUwvFBVR4l1ucpfcMgOjGNJZwBpYC1ja2BjqxZ6xz3JwRenRCXAfw==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] Revert "rpmsg: smd: Create device for all channels"
Date: Thu, 15 Mar 2018 11:12:44 -0700
Message-Id: <20180315181244.8859-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to pick up channels that are in a funky state we
optimistically tried to open all channels that we found, with the
addition that we failed if the other side did not handshake the opening.

But as we're starting the modem a second time all channels are found -
in a "funky" state - and we try to open them. But the modem firmware
requires the IPCRTR to be up in order to initialize. So any channels we
try to open before that will fail and will not be opened again.

This takes care of the regression, at the cost of reintroducing the
previous behavior of handling of channels with "funky" states.

Reverts commit c12fc4519f60 ("rpmsg: smd: Create device for all channels")

Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/rpmsg/qcom_smd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 92d0c6a7a837..1bca889bbea5 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1234,6 +1234,11 @@ static void qcom_channel_state_worker(struct work_struct *work)
 		if (channel->state != SMD_CHANNEL_CLOSED)
 			continue;
 
+		remote_state = GET_RX_CHANNEL_INFO(channel, state);
+		if (remote_state != SMD_CHANNEL_OPENING &&
+		    remote_state != SMD_CHANNEL_OPENED)
+			continue;
+
 		if (channel->registered)
 			continue;
 
-- 
2.16.2
