Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A64C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0528C2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T5fZuKD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0528C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbeLJT3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:29:00 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45700 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbeLJT27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:28:59 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so5861258pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gs0TgIJlRi1fcRzieQN8vIKDbS1pjM9AVMbx4uE7Nus=;
        b=T5fZuKD5TKY7zC4yAOel4JOzkomIqRAGvV98YfPcUIVZWtTN1OOf1XKnnCsNJQ5XVv
         YBqlm3BwSTwALoPsQZ/Op6+h5KtlxfvFaqst+mJBq+X4VHErfUtu/Rfaa8y4aeb/iDCh
         hY7FScGbSq/zd/8hw58HLAafyO8fZWm/a/GNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gs0TgIJlRi1fcRzieQN8vIKDbS1pjM9AVMbx4uE7Nus=;
        b=maaGUpFUD6B7ynuNd0nPJ/JVr5warpgvDTYh0AoacwTqbuP+2yRk1ZQbxFBLU41qSY
         JvEJXBfSJT3EQUXYw8QFfiuwPRevxSXkUYdm7sU9FSFZudmOqaZZZ0cqeOqtoEAef1t9
         XU6Jc8tcR8a7CuUcb/x032K7MswFrag0WaKj2mNT9e1To0ZRAyp1mZQI+XdmWjVyHEWw
         Y1ioIRKIg9cruW2vjm4aOu63KHwTAiHBUn+uilIcfErvX0XKAxQSOk92Un5F5sXec++i
         mEZuHZK+hO8CWNy/rr+StDnwOBv162VzEv1bEbiMEjzGRt13xJI7bPZAm8BsfUX4rWQd
         P5Rg==
X-Gm-Message-State: AA+aEWabOtD8FzRmlRWYSjCE8+Mzb47caEvth6891hY4mpFys7KAnnh4
        Th6imeTpaw8npL0nXSaa7/mA6g==
X-Google-Smtp-Source: AFSGD/XBv2353VDPfQ9LKdSIRrTD6S47ocs4GcvBx3+5x+F71BK68FvPSPRWDGF0lwcKrPIBQ6zGRg==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr13396676pfi.44.1544470138454;
        Mon, 10 Dec 2018 11:28:58 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v12sm18318674pgg.41.2018.12.10.11.28.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:28:57 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Can Guo <cang@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v7 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
Date:   Mon, 10 Dec 2018 11:28:25 -0800
Message-Id: <20181210192826.241350-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181210192826.241350-1-evgreen@chromium.org>
References: <20181210192826.241350-1-evgreen@chromium.org>
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

Changes in v7: None
Changes in v6:
- Fix renamed nodes in MTP (Bjorn)

Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index eedfaf8922e2a..707134f84fe1b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -356,6 +356,20 @@
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

