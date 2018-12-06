Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04251C65BAF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD47820878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZEiovGZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD47820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbeLFXc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:32:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44617 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbeLFXc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:32:27 -0500
Received: by mail-pl1-f193.google.com with SMTP id k8so886240pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 15:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=79Mc2sTRXTy/reDsA09tWOgsmHMjQBqHWoIDf/G9rW8=;
        b=ZEiovGZ/Uo/x32fPA/RbAIqdh277Us+woHgTrU874fb6A35sau793e9pX36nbXjjVJ
         7qcQcnRUXi7QqfEHhCuQaJ6yeWy8C4OI+n7HF9FrPCGCZuXz/HRVx2Cq0VJbjCK0fQyR
         S7+6JxZK7aIYFeoDWCo8DL3gND3N79E5gKctw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=79Mc2sTRXTy/reDsA09tWOgsmHMjQBqHWoIDf/G9rW8=;
        b=PtEVZK6MuLPOtVLfswNCox8qd9DvsFb76t1K9pM4Slo6vaDz1d/LPzrn2KluS2wSeM
         1snZy64MYlu0O6P8HJgUeb0/pbtZOGscoXYjWOVpLYDofxHeCCZGP6d6DPgZ3wfYJlGe
         IUZnA+HuMKp09ttK3X1UiqD41wKOza/OuC/q17yy0qdA/pXPQsGBxgY/7W9+HzRoTk9Z
         Hmc9OfilTVtPMrX2feNHRH3gCtkuMf68nGBrEOb7Bf9z33wlLvZyoE40LFkq2EU3+vMD
         iRzJ0bESP1zp/APUZgzoZlQ+jxrBMos8EkaxLuGtMdYyVrIVSWw+Ni3MZYPAOmgHSWdq
         CSzQ==
X-Gm-Message-State: AA+aEWYdEhGmxv2s9w0ZbXzyiUVlWybLBuaPpnwoIkbQ2cbE/X88iO58
        2bxHwmeckRdytC9S9eR0TDHVGw==
X-Google-Smtp-Source: AFSGD/Vz8vYTJyortHTXMiUteIy+cEq7BycTXYO3vf28RieQGOdpMb4nlJGoC1HcKFSQLGcZVjq/lQ==
X-Received: by 2002:a17:902:9a02:: with SMTP id v2mr30856864plp.180.1544139146964;
        Thu, 06 Dec 2018 15:32:26 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id s190sm2100875pfb.103.2018.12.06.15.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 15:32:26 -0800 (PST)
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
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v6 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
Date:   Thu,  6 Dec 2018 15:32:03 -0800
Message-Id: <20181206233205.193244-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181206233205.193244-1-evgreen@chromium.org>
References: <20181206233205.193244-1-evgreen@chromium.org>
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

Changes in v6:
- Fix renamed nodes in MTP (Bjorn)

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index b3def03581775..99b1eefef0ff2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -366,6 +366,20 @@
 	status = "okay";
 };
 
+&ufs_mem_hc {
+	status = "okay";
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vcc-max-microamp = <600000>;
+};
+
+&ufs_mem_phy {
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
2.18.1

