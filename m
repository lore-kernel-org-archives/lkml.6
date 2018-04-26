Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754166AbeDZCJ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:09:56 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44378 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeDZCIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:08:43 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FB5D60F78
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
From: Chris Lew <clew@codeaurora.org>
To: bjorn.andersson@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: aneela@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        clew@codeaurora.org
Subject: [PATCH v2 4/6] rpmsg: Guard against null endpoint ops in destroy
Date: Wed, 25 Apr 2018 19:07:50 -0700
Message-Id: <1524708472-18263-5-git-send-email-clew@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524708472-18263-1-git-send-email-clew@codeaurora.org>
References: <1524708472-18263-1-git-send-email-clew@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RPMSG GLINK the chrdev device will allocate an ept as part of the
rpdev creation. This device will not register endpoint ops even though
it has an allocated ept. Protect against the case where the device is
being destroyed.

Signed-off-by: Chris Lew <clew@codeaurora.org>
---

Changes since v1:
- New change

 drivers/rpmsg/rpmsg_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 920a02f0462c..7bfe36afccc5 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -88,7 +88,7 @@ struct rpmsg_endpoint *rpmsg_create_ept(struct rpmsg_device *rpdev,
  */
 void rpmsg_destroy_ept(struct rpmsg_endpoint *ept)
 {
-	if (ept)
+	if (ept && ept->ops)
 		ept->ops->destroy_ept(ept);
 }
 EXPORT_SYMBOL(rpmsg_destroy_ept);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
