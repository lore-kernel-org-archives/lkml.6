Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9BDC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 22:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8872083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 22:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="enVR9tSw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8872083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIBCjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 22:39:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35431 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbeIBCjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 22:39:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id d9-v6so6996339plr.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lURYql7MA2gfxmOpm8kifVlXh1WBUhVi7oHkI8NABxg=;
        b=enVR9tSwdcpVuZUuR7biz0Z7cFZIfA1ZN7B1N+8X27epayvUhl04ZGY5nKvKr5+BJe
         w2zYj6Gps+WAuZkpLEVMLm+IU4RQqalQ1diem+C+HNWWRLYIn154A4CaBnmnzEXCP4Pg
         pVBx6sQJjy4EmcEQ9XHTZmtXYE+3uafs5Kff4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lURYql7MA2gfxmOpm8kifVlXh1WBUhVi7oHkI8NABxg=;
        b=Gq6WhlH3niy7UOMFbeRUCYN+YPFYQiaclHUAbxw/4V3aAZH2nQaXtq8iKd49/uKSwj
         LmiP9UBjJOgyQTlhuG13xLbxxCyzeJ2hqNagFSteQG0IxfvJmwB+csvmdq3lrqdSgJLF
         QpdvE+CVZ1vp8idRTyezZGFVAFk1jSYUgDrsU+TLxOe1qJO4hhy8m3XZJlgVbZP+ZqEc
         Af8kg58NyN+i5tjpj+VKMtKAePFGtUZraWMUeENMVIyiSZ7jRQG9VnP4LedMuwKkALLY
         IYAe48VtRFZzHRwwQZdckOn6P2N/fQoLkFEfiWKdVQ+DN30xWrN1FtitAZDrU8j5JbFz
         kXYQ==
X-Gm-Message-State: APzg51B9CkK0iAm5YML9eUNh6Bu1+W5qBuoHs7fDS7YZFWgQEFSAp/RB
        cv35D3/ns+BSuKMytJFYEvIQrQ==
X-Google-Smtp-Source: ANB0VdYiRDpi3Y1zY5/QU0iHPk2oARg3CPQOcaGpnFC7eycYUdIFSgPFmSizt0dLNYUDIwlkEiBekQ==
X-Received: by 2002:a17:902:6907:: with SMTP id j7-v6mr21707662plk.323.1535840735864;
        Sat, 01 Sep 2018 15:25:35 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a16-v6sm15431025pgv.29.2018.09.01.15.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 15:25:35 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845: Add adsp, cdsp and slpi smp2p
Date:   Sat,  1 Sep 2018 15:27:21 -0700
Message-Id: <20180901222721.21929-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SMP2P nodes for the remoteproc states for adsp, cdsp and slpi.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 88 ++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0c9a2aa6a1b5..d977117acac4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -230,6 +230,94 @@
 		hwlocks = <&tcsr_mutex 3>;
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+
+		interrupts = <GIC_SPI 576 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apss_shared 6>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-lpass {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+
+		interrupts = <GIC_SPI 158 IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&apss_shared 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		adsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		adsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+		interrupts = <GIC_SPI 451 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apss_shared 14>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-slpi {
+		compatible = "qcom,smp2p";
+		qcom,smem = <481>, <430>;
+		interrupts = <GIC_SPI 172 IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&apss_shared 26>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <3>;
+
+		slpi_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		slpi_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.18.0

