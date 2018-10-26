Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDC8ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956BE20868
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 17:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QrwWNaG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956BE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeJ0COF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 22:14:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42254 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbeJ0COF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 22:14:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so881695pfn.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PteDfKg2sjPU8GQpzvIO14bIYL+O+BA756dZUBXv6tU=;
        b=QrwWNaG1lXd02WO21bjNs3fmRSj7JiJ7RfUNvb99Rzh3bD5klyrxRxvr1/171MxImF
         9kVfK0Eecr7Y9C6663eDEwu68UQxeDbIIs9/Jz2mmwHod3Qs+dTr/wuFaLx2HW2L6Mh4
         Ml1WdBmJPLesYaTs6O2OzafknRUxrF+WorSmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PteDfKg2sjPU8GQpzvIO14bIYL+O+BA756dZUBXv6tU=;
        b=ZBpsCZN7lidl2P0gcaMxSVT1zm/H9dMgAEuJvWXuErJJANgZgAk/DUrvzuVPv0PFVP
         8n7skYVWSdmsSmATmAPdtfHh1tNKYZJ3gLXRk0s5999/kX0e0Ze7EYsMBvdwP3noepZ+
         hYBFWL1LIE7zNrlk3+Au2SrYmnR+dizrMwngSOzHh+pTIsrBKWqJxBMBIvTAZ6LYFxpp
         /0WWS24ZIjreQIXcjKMem4RP4rncChqwHMcL0hsohle8u5UQXtZgcmjjs9vsrBLKspyr
         xpD35ADxNUk6Yr98KAy7KKAt2/EohLXJ/RjzZIPOqo/c9SZEpX//rMPNSz6HFeJd3chB
         jD2w==
X-Gm-Message-State: AGRZ1gJE7lGT7glsi91BfMlY1pA1Lfb/AgywoC8ALcxOtcFvM2b8no36
        JA32yHoh680p19OALNEokbf7xw==
X-Google-Smtp-Source: AJdET5d0cgF5A2cjMuQza8KRpAWakLVECFTDBi85IVSJwrkQn7g4ukHilmgjt6EbG7wJxTg0qxqHZw==
X-Received: by 2002:a62:8012:: with SMTP id j18-v6mr4635258pfd.202.1540575371842;
        Fri, 26 Oct 2018 10:36:11 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id b29-v6sm20164448pfj.183.2018.10.26.10.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 10:36:10 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Can Guo <cang@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v5 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
Date:   Fri, 26 Oct 2018 10:35:43 -0700
Message-Id: <20181026173544.136037-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181026173544.136037-1-evgreen@chromium.org>
References: <20181026173544.136037-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

Enable the UFS host controller and PHY on sdm845-mtp.

Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

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

