Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DCCC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451BC205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PTvGohUI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LzlH4UXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451BC205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJCM1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:27:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45168 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeJCM1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:27:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5A4AF60C61; Wed,  3 Oct 2018 05:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538545224;
        bh=jsjxrL3tweSVlWRKUmeXfJxlcUzqbT5q82fzNyNYPe8=;
        h=From:To:Cc:Subject:Date:From;
        b=PTvGohUIr+G+oXQmJ8pj6nnuDQWrph5e9id/HyBGWZoeMluNb/o5VRpZeUwVR4eIM
         cEbUmIhjTnPgdUQ5kEW5/yVe0zcL4SX5vrUSMO+dGWadj7Yxdn6mq3hzYk8hP625uZ
         eofruHi/LQ1ss68DKjcFmtb/Wu02syQkw7s6mPnw=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D30DC60C61;
        Wed,  3 Oct 2018 05:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538545223;
        bh=jsjxrL3tweSVlWRKUmeXfJxlcUzqbT5q82fzNyNYPe8=;
        h=From:To:Cc:Subject:Date:From;
        b=LzlH4UXOIKY1ELzFQfb3Ta89Aj+AHi2VVzHs50BZDt+rEXKz+6R/P70tjSb5A4pzC
         fj9ZNsUQUIZPcjYVT5/panNAIPYqmKD8OMBoAHd3WhT/5Y+dPNHGSXk6/BMkI/CPHK
         aUyLmRGJpunvZsqwVLloQnX/Szn1u2UIXV/HgrR8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D30DC60C61
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     davem@davemloft.net, bjorn.andersson@linaro.org,
        clew@codeaurora.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, fw@strlen.de,
        hannes@stressinduktion.org, dvlasenk@redhat.com,
        nicolas.dechesne@linaro.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-soc@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
Subject: [PATCH] soc: qcom: qmi_interface: Limit txn ids to U16_MAX
Date:   Wed,  3 Oct 2018 11:10:02 +0530
Message-Id: <1538545205-17939-1-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Txn IDs created up to INT_MAX cause overflow while storing
the IDs in u16 type supported by QMI header.

Limit the txn IDs max value to U16_MAX to avoid overflow.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/soc/qcom/qmi_interface.c | 2 +-
 include/linux/soc/qcom/qmi.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qmi_interface.c b/drivers/soc/qcom/qmi_interface.c
index 938ca41c..c239a28 100644
--- a/drivers/soc/qcom/qmi_interface.c
+++ b/drivers/soc/qcom/qmi_interface.c
@@ -318,7 +318,7 @@ int qmi_txn_init(struct qmi_handle *qmi, struct qmi_txn *txn,
 	txn->dest = c_struct;
 
 	mutex_lock(&qmi->txn_lock);
-	ret = idr_alloc_cyclic(&qmi->txns, txn, 0, INT_MAX, GFP_KERNEL);
+	ret = idr_alloc_cyclic(&qmi->txns, txn, 0, U16_MAX, GFP_KERNEL);
 	if (ret < 0)
 		pr_err("failed to allocate transaction id\n");
 
diff --git a/include/linux/soc/qcom/qmi.h b/include/linux/soc/qcom/qmi.h
index f4de336..5efa2b6 100644
--- a/include/linux/soc/qcom/qmi.h
+++ b/include/linux/soc/qcom/qmi.h
@@ -166,7 +166,7 @@ struct qmi_ops {
 struct qmi_txn {
 	struct qmi_handle *qmi;
 
-	int id;
+	u16 id;
 
 	struct mutex lock;
 	struct completion completion;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

