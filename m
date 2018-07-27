Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6593EC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B88F208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DgKn48ps";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="O2TPcbud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B88F208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbeG0Nk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:40:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbeG0Nk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:40:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 190AA605BD; Fri, 27 Jul 2018 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693926;
        bh=t7Cg7qiQtfy13b26flhqB4okLEiKCjABBkNCklA0/aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DgKn48psG5Kxmja89ReyxDoOocDE8iqTZjTY/38R8Ye8hNcCo760yOdBSVgDjyfeN
         4aVMquU4J9ik77HH/k8fOqPf4pyJYTaHiaiKDeFqiRmWBbuILNuflHo5uXFu2qaJVu
         AIGa0hdWLs22FnAJhcmfclzZJafRLCGHEU8k3D4s=
Received: from aneelaka-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aneela@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6611060BB2;
        Fri, 27 Jul 2018 12:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532693925;
        bh=t7Cg7qiQtfy13b26flhqB4okLEiKCjABBkNCklA0/aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2TPcbudKi3+L/DPBj3AiI4yBDsE6unGSheP7OS7GcdNjRNq+S91HKnRG0BZaxlUU
         c2zHTEjFDaw2OhpkbbpJsUoTxXd6o4HaVATnLYBet2y851GoSQhDT1Hck7K6AMi9xu
         TEjwCnkWI481Yp+BZTFCVaeOV4hUcB0/qpQ15pjE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6611060BB2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        robh+dt@kernel.org, arnaud.pouliquen@st.com, andy.gross@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [PATCH V4 6/9] rpmsg: glink: Expose rpmsg name attr for glink
Date:   Fri, 27 Jul 2018 17:47:26 +0530
Message-Id: <1532693849-7037-7-git-send-email-aneela@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
References: <1532693849-7037-1-git-send-email-aneela@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

Expose the name field as an attr so clients listening to uevents for
rpmsg can identify the edge the events correspond to.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/qcom_glink_native.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 9f3d026..7b4ffa0 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1544,6 +1544,26 @@ static void qcom_glink_work(struct work_struct *work)
 	}
 }
 
+static ssize_t rpmsg_name_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int ret = 0;
+	const char *name;
+
+	ret = of_property_read_string(dev->of_node, "label", &name);
+	if (ret < 0)
+		name = dev->of_node->name;
+
+	return snprintf(buf, RPMSG_NAME_SIZE, "%s\n", name);
+}
+static DEVICE_ATTR_RO(rpmsg_name);
+
+static struct attribute *qcom_glink_attrs[] = {
+	&dev_attr_rpmsg_name.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(qcom_glink);
+
 static void qcom_glink_device_release(struct device *dev)
 {
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
@@ -1593,6 +1613,12 @@ struct qcom_glink *qcom_glink_native_probe(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	glink->dev = dev;
+	glink->dev->groups = qcom_glink_groups;
+
+	ret = device_add_groups(dev, qcom_glink_groups);
+	if (ret)
+		dev_err(dev, "failed to add groups\n");
+
 	glink->tx_pipe = tx;
 	glink->rx_pipe = rx;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

