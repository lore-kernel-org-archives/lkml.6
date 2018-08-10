Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F7CC46470
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2437223C7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fLMGH6tb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2437223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeHKAX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:23:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41836 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727173AbeHKAX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:23:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id z8-v6so4964501pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 14:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A59KG91HG7sB8r2YIt6FLFzdJGWUM4lD0M+IGFeOA04=;
        b=fLMGH6tbhkelo3cnhLFfFarS9blMlewrG6GhbverD/lG28tYnPMxprwjhZnZGYU6Co
         jdzfHl2yB8fhe2cekQbmTM5QLbg+IZOPNneRSFayw7LIBCgCF+G00k5JaOfo36pHXp/8
         yaZnrpagGV+eYOzrn7jamwStnSKidQD0Aj2uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A59KG91HG7sB8r2YIt6FLFzdJGWUM4lD0M+IGFeOA04=;
        b=iDgFSP3iSL1ukjfE/3b4K55p9kGp43aexltuxYL7ZBaX12uDnUal6e5IiK4pDsyHPU
         eMyMxu2bxejx9nuP9OFnFuikfsija4+6xirrC4yhaLbAHMlKiL5Rmt0tZRvC9wFSITZh
         Oz+c5wQidgKb1jSmMNEndkOpmw3Hwhe9AY1oJYmtSlrl38Vgd4ZigozDQC6rXW/IZBrq
         DlgMN8CGK7TBoFb+aHlgb62W8QLr7npxLiqJdeXDvnCDty7Bob6Ayppq4/LICsnUt+3x
         8dYebLHrT+DGNAmrQce4T9aDHdlZ3oHPEAZ0t+BMcAmLiEmqjyg5/1d5I2SxUzFjqRHr
         qtqg==
X-Gm-Message-State: AOUpUlHSkdJpU+sO5JcHFJvluJUJh2U7V0K72TrlEDfD5cDcQNaEa9xG
        6wrXrfRbqYFeA0HzYHalp9ZH6w==
X-Google-Smtp-Source: AA+uWPx+uNzvTBxI7vBRQGpyEH9S/KHKSz8JuNkAZix4bWVGUXaX6wBuqayp+BmrLQMKMHyuIYCpkA==
X-Received: by 2002:a63:fb07:: with SMTP id o7-v6mr8171281pgh.333.1533937936696;
        Fri, 10 Aug 2018 14:52:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id g11-v6sm25730102pgi.90.2018.08.10.14.52.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 14:52:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, swboyd@chromium.org,
        tfiga@chromium.org, Manu Gautam <mgautam@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: qcom: sdm845-mtp: Add nodes for USB
Date:   Fri, 10 Aug 2018 14:51:50 -0700
Message-Id: <20180810215150.82490-4-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810215150.82490-1-dianders@chromium.org>
References: <20180810215150.82490-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the various nodes to "okay" and hook up the regulators.

NOTE: For now the main USB port (the one that goes out the Type C
connector) is forced to host.  Eventually someone will need to get the
Type C detection hooked up and get this all integrated with the
PMI8998 PMIC.  The reason for forcing to "host" in the meantime is
that this will leave us with one "host" and one "peripheral" port.

In order for host mode this to work, we assume that the bootloader
left things configured enough for us.  Apparently the magic for that
is is to do these writes on pmi8998:
- pm_comm_write_byte(2, 0x1153, 0x2C, 0);
- pm_comm_write_byte(2, 0x1152, 0x07, 0);
- pm_comm_write_byte(2, 0x1140, 0x00, 0);
- pm_comm_write_byte(2, 0x1140, 0x01, 0);

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 839ef9125bf4..eb9400bf2cbf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -480,6 +480,67 @@
 	status = "okay";
 };
 
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	/* Until we have Type C hooked up we'll force this as host. */
+	dr_mode = "host";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vdda_usb1_ss_core>;
+	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
+	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
+
+	qcom,imp-res-offset-value = <8>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
+	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
+	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_usb1_ss_1p2>;
+	vdda-pll-supply = <&vdda_usb1_ss_core>;
+};
+
+&usb_2 {
+	status = "okay";
+};
+
+&usb_2_dwc3 {
+	/*
+	 * Though the USB block on SDM845 can support host, there's no vbus
+	 * signal for this port on MTP.  Thus (unless you have a non-compliant
+	 * hub that works without vbus) the only sensible thing is to force
+	 * peripheral mode.
+	 */
+	dr_mode = "peripheral";
+};
+
+&usb_2_hsphy {
+	status = "okay";
+
+	vdd-supply = <&vdda_usb2_ss_core>;
+	vdda-pll-supply = <&vdda_qusb_hs0_1p8>;
+	vdda-phy-dpdm-supply = <&vdda_qusb_hs0_3p1>;
+
+	qcom,imp-res-offset-value = <8>;
+	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_22_8_MA>;
+};
+
+&usb_2_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_usb2_ss_1p2>;
+	vdda-pll-supply = <&vdda_usb2_ss_core>;
+};
+
 /* PINCTRL - additions to nodes defined in sdm845.dtsi */
 
 &qup_i2c10_default {
-- 
2.18.0.597.ga71716f1ad-goog

