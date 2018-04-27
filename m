Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934566AbeD0OIu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:08:50 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:44752 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934550AbeD0OIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:08:44 -0400
X-Google-Smtp-Source: AB8JxZpPB38Jr6db4vz+Fg9+OhKtRd8uLNdzunYF4OTvhHchg+G0IYc1oiKulK38kjVneEF3AMKKHg==
From: Alex Elder <elder@linaro.org>
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: qmi: fix a buffer sizing bug
Date: Fri, 27 Apr 2018 09:08:17 -0500
Message-Id: <20180427140817.10871-1-elder@linaro.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In qmi_handle_init(), a buffer is allocated for to hold messages
received through the handle's socket.  Any "normal" messages
(expected by the caller) will have a header prepended, so the
buffer size is adjusted to accomodate that.

The buffer must also be of sufficient size to receive control
messages, so the size is increased if necessary to ensure these
will fit.

Unfortunately the calculation is done wrong, making it possible
for the calculated buffer size to be too small to hold a "normal"
message.  Specifically, if:

  recv_buf_size > sizeof(struct qrtr_ctrl_pkt) - sizeof(struct qmi_header)
		AND
  recv_buf_size < sizeof(struct qrtr_ctrl_pkt)

the current logic will use sizeof(struct qrtr_ctrl_pkt) as the
receive buffer size, which is not enough to hold the maximum
"normal" message plus its header.  Currently this problem occurs
for (13 < recv_buf_size < 20).

This patch corrects this.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/qmi_interface.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index 321982277697..938ca41c56cd 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -639,10 +639,11 @@ int qmi_handle_init(struct qmi_handle *qmi, size_t recv_buf_size,
 	if (ops)
 		qmi->ops = *ops;
 
+	/* Make room for the header */
+	recv_buf_size += sizeof(struct qmi_header);
+	/* Must also be sufficient to hold a control packet */
 	if (recv_buf_size < sizeof(struct qrtr_ctrl_pkt))
 		recv_buf_size = sizeof(struct qrtr_ctrl_pkt);
-	else
-		recv_buf_size += sizeof(struct qmi_header);
 
 	qmi->recv_buf_size = recv_buf_size;
 	qmi->recv_buf = kzalloc(recv_buf_size, GFP_KERNEL);
-- 
2.14.1
