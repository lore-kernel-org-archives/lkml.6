Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D206C43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EA120C03
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 17:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAy5VYwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EA120C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeHVVCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:02:47 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35228 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeHVVCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:02:46 -0400
Received: by mail-pl0-f68.google.com with SMTP id d9-v6so984954plr.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f5+NWx549tJ2rapOX/0dvESfYlFrxtpaywKRZDnXrDk=;
        b=CAy5VYwnkblxuRfDtKvMVDZROdEtDEE0MkCFGpFX2K9D67EOL7jxLG+IvCRJZC3ZX+
         Wxwpyr4OPcS5wwueY3yHME7f3AYRiK0YXqPYRXcaff0AJ4qn6EnjMul10zZ+fA1+Pfw4
         0+mU4w1zijLLKtu+9+iQSGTk1o58L5bDhXibI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f5+NWx549tJ2rapOX/0dvESfYlFrxtpaywKRZDnXrDk=;
        b=IutHX6V98oeT+3mvh9eD5+YFcUNnEskHv2k5nfmC4DxjKH+n6Os0QH88j4/b9fVKjP
         ZVOLLBvmldpgRDE/wf4wOmwWv+21GgLqRKD3bw2+jBU2fuEwWFn2qgVVdCwhIotO5qZ+
         15uMIRjQiq5+E1aOr2K5nN8e66JGcJhnLaooH24kCsy14DWJ1SP+ALqj+xNZTyt709Kh
         jDn0eDZ2Cc2vRASSwsKIl+eiPgKrH7a0YtWOK+2FFp+voty17/o56ouuCRib2KRIOM1H
         QLYR9lhRwvJWviJnb4xBffr0CTI7Y8hbwnH0S7NuwflxqjJaAx5kUIOxtizAu+zsDFFW
         EjeQ==
X-Gm-Message-State: APzg51CHBi+/jDsUnPXcB9bfSWCliyZo/MoagUbpfUli7jyZ3nqetZDh
        O87I0pDBZl/HB6RYCqk/nbVTdA==
X-Google-Smtp-Source: ANB0Vdba++o58JxGSMZQdWGTQTDlVlKpbqCacVE7cLg08QM6oCQxqraj/sLTIHHQh/J93dTtIp3kOQ==
X-Received: by 2002:a17:902:a5c2:: with SMTP id t2-v6mr7039896plq.85.1534959417607;
        Wed, 22 Aug 2018 10:36:57 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id s73-v6sm3378439pfi.154.2018.08.22.10.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 10:36:56 -0700 (PDT)
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
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: qcom: sdm845-mtp: Add nodes for USB
Date:   Wed, 22 Aug 2018 10:36:29 -0700
Message-Id: <20180822173629.202885-4-dianders@chromium.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
In-Reply-To: <20180822173629.202885-1-dianders@chromium.org>
References: <20180822173629.202885-1-dianders@chromium.org>
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

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index ef53c4ae60b0..eedfaf8922e2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -356,6 +356,67 @@
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
2.18.0.1017.ga543ac7ca45-goog

