Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8051C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6534621521
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 01:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IH1GCFTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6534621521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbeITHYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 03:24:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44735 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbeITHYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 03:24:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id ba4-v6so3494586plb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 18:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MDe98nJtaP52iCM20cLVH1FctWbKDc5NhiV3mOdh0j4=;
        b=IH1GCFTrq1SyGO046HTsW6poTclRD7/b8+k0+xK45s4jpnB2w9rQTD10KhaA6b66XI
         RZ43JaqT6ULYXs2vgHGSAphIV7qkki2LI+rhwE/g6FKo9ASoDapX/GAeP/HIZtuufyqH
         wooj3iRXhGfMMkIMAUi0n/YA8Nj3CgJTZrbLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MDe98nJtaP52iCM20cLVH1FctWbKDc5NhiV3mOdh0j4=;
        b=lsTlpt0djRTQcEYsf8IR+9fiI9W0unVt4VHU78wKrb0p89IUeDucWsrWBbEeoQZvSa
         q/SCXOzyatqfwH4fsnAEWgf3zSDVSgvGeMWmO3Ui6IbSMd7n3zB0Df8sC821qoJvNOxU
         XfeJBPZkBYLoDTAU+GMcAtzkawGUrxeHY+EKnS9IdyRbjGfaJMn+DOrIcQzFd08divoS
         WBbFpfY9Txoje+Tz7KaHoMdMxsJ3rXW1QydEsndIRupWKIRfIbrzz9ZKwSiL+qg5PCbf
         0RDqic6UdIhtw6W2VgKO/crPamYoTLWzS1Je7onKVdg4yBCkrJiZusrcHblkihoM8Rs1
         NiDg==
X-Gm-Message-State: APzg51AbYqr88JIhCJ2I+MXe1TAe3j65yxLIFOt4Ve/W4u4tQb711pIw
        RT5i5x5BnVu11HlafN3ER7cbbQ==
X-Google-Smtp-Source: ANB0VdYHWHhqql6yK1NUQXy31cVc4Hd+p/FeopCkIwIYkAkhng/caswgHzLvOBt8HQjYJRXDyxFFgw==
X-Received: by 2002:a17:902:7287:: with SMTP id d7-v6mr37470427pll.54.1537407803916;
        Wed, 19 Sep 2018 18:43:23 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s3-v6sm37746285pgj.84.2018.09.19.18.43.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 18:43:23 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: smd-rpm: Add QCS404 compatible
Date:   Wed, 19 Sep 2018 18:45:40 -0700
Message-Id: <20180920014540.14894-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt | 1 +
 drivers/soc/qcom/smd-rpm.c                                  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
index 89e1cb9212f6..ec95705ba692 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.txt
@@ -23,6 +23,7 @@ resources.
 		    "qcom,rpm-msm8916"
 		    "qcom,rpm-msm8974"
 		    "qcom,rpm-msm8998"
+		    "qcom,rpm-qcs404"
 
 - qcom,smd-channels:
 	Usage: required
diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 93517ed83355..b8e63724a49d 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -227,6 +227,7 @@ static const struct of_device_id qcom_smd_rpm_of_match[] = {
 	{ .compatible = "qcom,rpm-msm8974" },
 	{ .compatible = "qcom,rpm-msm8996" },
 	{ .compatible = "qcom,rpm-msm8998" },
+	{ .compatible = "qcom,rpm-qcs404" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qcom_smd_rpm_of_match);
-- 
2.18.0

