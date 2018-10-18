Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634B0ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167672098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U7Y4ZkuA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167672098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJSFMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:12:53 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35092 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727577AbeJSFMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:12:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id 32-v6so3582090pgu.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zoJZ7MyvvT4eCQ4mcWZ7Dmh+jlnSroj2F6OCjyhHlSU=;
        b=U7Y4ZkuAAlV5rvKjh3EQqspBA3uPAdXQrVGRmsz7HJyLTpLN/JS/L0bxDuCUGTJUAN
         yC1OFGrDd3bg4MA4PE8HsGaXwyzEzNb+XCoOxfSaIFgquamsIvA11ZtnEo8cJpXqXpXW
         Fh3eWmdUzqsnKTee7TZpzrvG/a3BAL0bHjkBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zoJZ7MyvvT4eCQ4mcWZ7Dmh+jlnSroj2F6OCjyhHlSU=;
        b=nxKcsEz3rJC2dGHigP1kUZHsQQV36Crz+542t6w9vN3LdDisdrXXsFzKokaSsbZhMI
         ivLMh7YkWAEdGqTPt80tYaN36YDbK3/t54FVmUQ+i44p0G0W4gqIWj3mfPkXKPYvb6vv
         TAJWQ92pk2oKpVXLFWgzNPkwgezeYr//h9V/c35FpQ/6pCjf3iCQbe9GQ89eEAk5iPVS
         XQJCpa8tNBIuIb7RozQLTJMeN/3j83c76JQnzk2HpcBb0235cmZwEw8YhgPxrLmikcS6
         cTzpaPPtjnlK1fImFh/crxJlomEjdCoTXlGNQLqCiboE1+oakjgZdXbB9X5fNnUqIrgo
         uoNQ==
X-Gm-Message-State: ABuFfogDIO+lz+XPMlgFQsScp6XK0q4UPm7JJgRmDnd2dv1EkKVtQ1fA
        cM+2EsSlsNoBBTp7qZdGHt8h2w==
X-Google-Smtp-Source: ACcGV61TWVYLEzpRm/Uhj4/A9T/9Rtn1TxKX0Zvlk1ymeOZR3NFYvCCj2S/aWziSTHS0XVb8/YohfQ==
X-Received: by 2002:a63:7a50:: with SMTP id j16-v6mr30319733pgn.112.1539897000846;
        Thu, 18 Oct 2018 14:10:00 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id i29-v6sm35133678pfj.82.2018.10.18.14.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 14:09:59 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        swboyd@chromium.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
Date:   Thu, 18 Oct 2018 14:09:32 -0700
Message-Id: <20181018210933.113592-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181018210933.113592-1-evgreen@chromium.org>
References: <20181018210933.113592-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

This change enables the UFS host controller and PHY on sdm845-mtp.

Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index eedfaf8922e2..d5fddea71a85 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -356,6 +356,20 @@
 	status = "okay";
 };
 
+&ufshc1 {
+	status = "okay";
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vcc-max-microamp = <600000>;
+};
+
+&ufsphy1 {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_ufs1_core>;
+	vdda-pll-supply = <&vdda_ufs1_1p2>;
+};
+
 &usb_1 {
 	status = "okay";
 };
-- 
2.16.4

