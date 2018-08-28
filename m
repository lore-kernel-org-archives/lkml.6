Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61407C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C5020645
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C5020645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbeH1Fo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:44283 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbeH1Fo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:26 -0400
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so1713769oih.11;
        Mon, 27 Aug 2018 18:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q+zF8tFFk/j0HNBZCXJzNNM8VFhzda8Cqqndx/hlaDs=;
        b=WkqGwoCNeExxTYwCuhQwfXo4mOsfJgUTl3JxpTSCOp/qBmKncdBlWG1/he07KUj3g5
         C8AZ6kgLD6FPs7t0Sk+Kmjf8XQ9jxo9y0PfA4X2vg0v4sVjs1vxD/nYZ48HT0IRvOtBl
         dAthjcVwlm3IrKj3Kht1VwjAYynHrolJp+RYG/0rrf4CnS2WCvcjieb/UjictIBB8hTG
         /y1sofaC+78Z5XgfLMeUlLDJ3p4Gy+VPtYmbACZgBuCXrynGW/GIvXyQCWsukAd3ZPGY
         71+pAhgkhgxPMCsfHypZ2cXv24cUvDqEB7KrmxWPLk+ez/+lFGdWY4kx1oItmzPLcq9A
         swxA==
X-Gm-Message-State: APzg51AOic6ZIvXwcp6hTm8v30QLyksXHxaQTDxADCQDFvCemjc3BeEI
        ED9QCZMtYLIHCh9CJkElrBtfbfA=
X-Google-Smtp-Source: ANB0VdbOnFOtThhxonPHVDxFuyHl1ZUsqDBNt25EbW3/SVBdFlU02ml9V0l0qJqJL7MJFvdTmzo4Kg==
X-Received: by 2002:aca:da56:: with SMTP id r83-v6mr1113051oig.265.1535421310641;
        Mon, 27 Aug 2018 18:55:10 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:10 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH] rpmsg: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:43 -0500
Message-Id: <20180828015252.28511-42-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/rpmsg/qcom_glink_smem.c | 2 +-
 drivers/rpmsg/qcom_smd.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 2b5cf2790954..ab23da3d7131 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -205,7 +205,7 @@ struct qcom_glink *qcom_glink_smem_register(struct device *parent,
 	dev->parent = parent;
 	dev->of_node = node;
 	dev->release = qcom_glink_smem_release;
-	dev_set_name(dev, "%s:%s", node->parent->name, node->name);
+	dev_set_name(dev, "%pOFn:%pOFn", node->parent, node);
 	ret = device_register(dev);
 	if (ret) {
 		pr_err("failed to register glink edge\n");
diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 8da83a4ebadc..0dae7c9f4a8f 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1454,7 +1454,7 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
 	edge->dev.release = qcom_smd_edge_release;
 	edge->dev.of_node = node;
 	edge->dev.groups = qcom_smd_edge_groups;
-	dev_set_name(&edge->dev, "%s:%s", dev_name(parent), node->name);
+	dev_set_name(&edge->dev, "%s:%pOFn", dev_name(parent), node);
 	ret = device_register(&edge->dev);
 	if (ret) {
 		pr_err("failed to register smd edge\n");
-- 
2.17.1

