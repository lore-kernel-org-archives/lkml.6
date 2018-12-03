Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06884C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09B2208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 19:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KUDtwD77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09B2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbeLCThm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 14:37:42 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36226 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeLCThm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 14:37:42 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so6903597pfc.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 11:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpMyzjGkH0BtMJuD/epBPGdByPRB26CjbrPIHVKA3no=;
        b=KUDtwD77gOhDkTcQ4iHv/XEYUPTwhPtkqZD+4pqJ3ocMck+9Suogbz8nKndXUQOk26
         t6VgVVeI6vUdSWMeguvX0I880lLuGaXHfMZ1AtRLBAz3wD5GqZ5a2P0woZaWPQ1S/CRd
         zycyyD5j4/GX/UEpuztpS9JV5ryC0Cfmynwlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpMyzjGkH0BtMJuD/epBPGdByPRB26CjbrPIHVKA3no=;
        b=NpSEFToF6/ehDkvAwD95y/uPlxKV2hT73MoawvpqW+4ZPpksOyqr5dcAHyQnEOCjmo
         i6XQnRP2qXSimx39cCknZM2ktaur2jqaG0FTraxuMi3W98oYlPuMMowcrs1MGhHEf3SI
         JeHQFFcEd7noGCwby/KSlO/tkaTzkwEIo6/zl6YnH/zM2eDY10YBCqAW08SGlRGRnjuG
         9td85ShBbyZZjY0pPNfUhrZa7Y+XvIjD24XV+iTRggbVi6bU0Cw+aI9KFfTfSXhwMPBK
         1AEKEVJ4Y619oMnNoFTFivvOKI08vVTIIpmtcrTP3oE3vPqwWnVeyFB69peUThOvfrOm
         cL5Q==
X-Gm-Message-State: AA+aEWYqGbE3n89utrv5prejxUpEbTk4V5I6YDlMdWLr2xCL0Y6RDDIR
        dOrjc4j53KH3e8KWLsVZhPuOeA==
X-Google-Smtp-Source: AFSGD/VFBtm8Ha0A/zUxUAnxgoxre6fRn6tdxgbjN4zgGrDfkXFdl1ABQOnnuYHMG9XUPOKtgALC6A==
X-Received: by 2002:a63:d208:: with SMTP id a8mr14089311pgg.77.1543865860957;
        Mon, 03 Dec 2018 11:37:40 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id h64sm2792202pfc.142.2018.12.03.11.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 11:37:40 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v2] arm64: dts: sdm845: Add videocc node
Date:   Mon,  3 Dec 2018 11:36:29 -0800
Message-Id: <20181203193629.58505-1-dianders@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taniya Das <tdas@codeaurora.org>

This adds the video clock controller node to sdm845 based on the examples
in the bindings.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Add #reset-cells = <1>.
- Sort properly.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 1419b0098cb3..3f6bf5750918 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
 #include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/clock/qcom,videocc-sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/phy/phy-qcom-qusb2.h>
 #include <dt-bindings/reset/qcom,sdm845-aoss.h>
@@ -1256,6 +1257,14 @@
 			};
 		};
 
+		videocc: clock-controller@ab00000 {
+			compatible = "qcom,sdm845-videocc";
+			reg = <0xab00000 0x10000>;
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		dispcc: clock-controller@af00000 {
 			compatible = "qcom,sdm845-dispcc";
 			reg = <0xaf00000 0x10000>;
-- 
2.20.0.rc1.387.gf8505762e3-goog

