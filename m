Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3AD20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3AD20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387737AbeHAURX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:17:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404223AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 16F31FCD;
        Wed,  1 Aug 2018 16:58:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 112/336] soc: qcom: qmi: fix a buffer sizing bug
Date:   Wed,  1 Aug 2018 18:47:27 +0200
Message-Id: <20180801165033.438294313@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Elder <elder@linaro.org>

[ Upstream commit 7df5ff258bd27900d516fea88da10d05602bf8c7 ]

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
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/qmi_interface.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -639,10 +639,11 @@ int qmi_handle_init(struct qmi_handle *q
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


