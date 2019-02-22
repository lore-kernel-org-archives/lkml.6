Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19E1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D26207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 02:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="N+0PJt3T";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iPJP9ncz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfBVCe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 21:34:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:35132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfBVCe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 21:34:27 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B7D060910; Fri, 22 Feb 2019 02:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550802866;
        bh=r8UIRezX+WeLrO0TT5YggxxvbSUCelgK2h8XTj2j6lw=;
        h=From:To:Cc:Subject:Date:From;
        b=N+0PJt3TKplHBx/pknpd/JWLbQF5IVVe8PY+X9t0BUL5RYztOcJNRC8MnDaJTpSju
         055zlqFehKz8HRAHvNooIpDzeIhfdrtevss3vdHUA8wqa4HoCtpJCBZYzyq41EPJkG
         Hq2d0axlf8IXmhw0+kFk0gtu/ezJQWyThgQlQ2/s=
Received: from clew-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clew@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 498FE6075A;
        Fri, 22 Feb 2019 02:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1550802858;
        bh=r8UIRezX+WeLrO0TT5YggxxvbSUCelgK2h8XTj2j6lw=;
        h=From:To:Cc:Subject:Date:From;
        b=iPJP9nczrm8mJkXY3WJ5DhB0re0H5AqEzrBXReKpTb3wPCQQ2D518G7ymkTzRDFJZ
         X33imvlqek8MDWl2ogHBiIHWU2lYRuRuQBy71EtW2OanBbOGNtqYsGig7y5HRKo6Rs
         eLapIFEEJr4Ve1YpHFrjHipvokv/8jIF6IU3bszU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 498FE6075A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
From:   Chris Lew <clew@codeaurora.org>
To:     bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org
Cc:     aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, clew@codeaurora.org
Subject: [PATCH] soc: qcom: qmi: Change txn wait to non-interruptible
Date:   Thu, 21 Feb 2019 18:33:39 -0800
Message-Id: <20190222023339.30454-1-clew@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current QMI clients are not userspace facing, if their threads are
signaled, they do not do any signal checking or propagate the
ERESTARTSYS return code up. Remove the interruptible option so clients
can finish their QMI transactions even if the thread is signaled.

Signed-off-by: Chris Lew <clew@codeaurora.org>
---
 drivers/soc/qcom/qmi_interface.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index c239a28e503f..f9e309f0acd3 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -345,8 +345,7 @@ int qmi_txn_wait(struct qmi_txn *txn, unsigned long timeout)
 	struct qmi_handle *qmi = txn->qmi;
 	int ret;
 
-	ret = wait_for_completion_interruptible_timeout(&txn->completion,
-							timeout);
+	ret = wait_for_completion_timeout(&txn->completion, timeout);
 
 	mutex_lock(&qmi->txn_lock);
 	mutex_lock(&txn->lock);
@@ -354,9 +353,7 @@ int qmi_txn_wait(struct qmi_txn *txn, unsigned long timeout)
 	mutex_unlock(&txn->lock);
 	mutex_unlock(&qmi->txn_lock);
 
-	if (ret < 0)
-		return ret;
-	else if (ret == 0)
+	if (ret == 0)
 		return -ETIMEDOUT;
 	else
 		return txn->result;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

