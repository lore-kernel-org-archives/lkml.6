Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE7FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C99C20C0F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bUrqhTzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C99C20C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbeGJWFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:05:03 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42787 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732361AbeGJWFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:05:03 -0400
Received: by mail-pf0-f194.google.com with SMTP id l9-v6so5360937pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IushQ/ZLyaPZtkjLas+JFecM/MPWlXvMRXEQXvLDlAI=;
        b=bUrqhTzAvqZ7dVeroUjlYDwwqVlkPARw13Np9B85fcp2+GHFdkMbFAsU+rKZjhVdVF
         4WjfOtaYGqKu5i/KNO3BWENXBdRBbikDvHl7J3B0Pah4c1Gp9gVbtXo8TpOCYN1yek8Z
         9Kfh0QNlZ1UwRN95RyGKUdq5kKPmaFUAkUT0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IushQ/ZLyaPZtkjLas+JFecM/MPWlXvMRXEQXvLDlAI=;
        b=qi2iWtL/iyZqd2ueeafBpM4tMs80VnRQ1LwVx3N16DQU8VwTOLkSndSMOBRCoDp+t/
         eeu7sOYrVqaUMYdf5gJZeg63C53CjFhdhDXS5Mj5+HNn/Mw/oNXCZ674x6cJNHasMn2x
         AmOstRvuAIVaFBE787vyz61qmuJgMX1vOGyCmMZurs2juozIe1und5UoijayHMPhWssV
         av7v6fqB0eG9XLyqQpbPYI0zPXkAiF3gBqLIWCbcbKeRGP01EgrhYb6IHq/7Gt+/8YPt
         05CafQDxznxf6oasJZFOk1N+illXaN5dBBmdJZ3JGUC8laJzO8nKF6vo3AsKwoWBbIGg
         dKkQ==
X-Gm-Message-State: APt69E2P/Ja8g3mV6EbyMuMhxzki0WMPsSMGpCDQa32D7IvuYVGuelzV
        v4SxgROq/jvhtGkLZsdWQWFmHg==
X-Google-Smtp-Source: AAOMgpdD6f1Aw0an6FwAck9d+CVo/D4CCrtluE2h/rkQAe+eeHS/8kKfqkm74Z0BO9gdjmc/j/fttw==
X-Received: by 2002:a63:6d8b:: with SMTP id i133-v6mr24766612pgc.215.1531260238057;
        Tue, 10 Jul 2018 15:03:58 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:0:1000:1501:38e4:86fe:ec0c:4007])
        by smtp.gmail.com with ESMTPSA id y69-v6sm34939756pfd.36.2018.07.10.15.03.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 15:03:57 -0700 (PDT)
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
Date:   Tue, 10 Jul 2018 15:02:02 -0700
Message-Id: <20180710220202.116404-4-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180710220202.116404-1-dianders@chromium.org>
References: <20180710220202.116404-1-dianders@chromium.org>
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

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 1db4b9735e70..4e14f5f5c2f7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -481,6 +481,67 @@
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
2.18.0.203.gfac676dfb9-goog

