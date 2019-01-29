Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA28C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6612175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4RHOGL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbfA2XVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:21:17 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41206 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbfA2XUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:20:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so9442114pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 15:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ap/law2BDpJznVOQHUO8cmODdTJLWt4nh6MUrZcVJRQ=;
        b=Z4RHOGL6I8mu/s0j2ZRPdvRYI89VUM3yfZJV1cOubdW2FX+OO6PEZ0srd8UEN0bCEH
         jGZb4mVukSnUMlAHDk+F9MbRZ3V650pOgfLIL3MmzU3ko9pVQC7WkvjKHVGy2YFDMU+/
         rD4hY3/MBhjQDKliF7wqVJZM2bbZvvBEAsuZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ap/law2BDpJznVOQHUO8cmODdTJLWt4nh6MUrZcVJRQ=;
        b=tVu74VOC2INFiQ7BHqAiKnXoHe1crJsZvKodnn1X+wRCulvB+wZPCoe+75Ivs3ZsMO
         wKx/Sd+VCxUgrQ36J/L9yguvtZoWVTT/B0VjMD4SZH5R1MRfAbKCbFSm+rYCiuTg9PM3
         CF+IuagBEGKQXvPljUF/Djn5nPxhttGipkknRlKXuAMdCu2tsQIbUf94mNKB7s+LvSy3
         jfiNP1LrlIDMTgpgMnrZWsN9pgNycRZTAPPapHolgixyf1Bj+OHN3meKa51qYc1/qwsd
         /JGU5L4F3tQy795fo++/gbYlwIrr2yHF8l47xJYeSsSSFh56KRSWP6O+afcYWXezw4ZS
         4Jbw==
X-Gm-Message-State: AJcUukc0V8Qgtz7OFk4+C0u9HI/MoVS2wd5dMoSYsVG4XQqVEKnPiFJD
        a5eFty9/1v7jj/LeO/am/d500w==
X-Google-Smtp-Source: ALg8bN64yvyPKIJl3N9RNFHOkd+drJDqHcY7gZGVIIuFYUrcuqmlCpjLpu9YNoG+DVWAn2KS6littA==
X-Received: by 2002:a63:6486:: with SMTP id y128mr25425774pgb.18.1548804033994;
        Tue, 29 Jan 2019 15:20:33 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v70sm51182779pfa.152.2019.01.29.15.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 15:20:33 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 04/10] dt-bindings: soc: qcom: Add AOSS QMP binding
Date:   Tue, 29 Jan 2019 15:20:03 -0800
Message-Id: <20190129232009.5033-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190129232009.5033-1-bjorn.andersson@linaro.org>
References: <20190129232009.5033-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the QMP based side-channel communication mechanism to
the AOSS, which is used to control resources not exposed through the
RPMh interface.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Spelled out QMP

 .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 76 +++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     | 15 ++++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
new file mode 100644
index 000000000000..9ce6c42192ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -0,0 +1,76 @@
+Qualcomm Always-On Subsystem side channel binding
+
+This binding describes the hardware component responsible for side channel
+requests to the always-on subsystem (AOSS), used for certain power management
+requests that is not handled by the standard RPMh interface. Each client in the
+SoC has it's own block of message RAM and IRQ for communication with the AOSS.
+The protocol used to communicate in the message RAM is known as Qualcomm
+Messagin Protocol (QMP)
+
+The AOSS side channel exposes control over a set of resources, used to control
+a set of debug related clocks and to affect the low power state of resources
+related to the secondary subsystems. These resources are exposed as a set of
+power-domains.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,sdm845-aoss-qmp"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: the base address and size of the message RAM for this
+		    client's communication with the AOSS
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: should specify the AOSS message IRQ for this client
+
+- mboxes:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: reference to the mailbox representing the outgoing doorbell
+		    in APCS for this client, as described in mailbox/mailbox.txt
+
+- #power-domain-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: must be 1
+		    The provided power-domains are:
+		    QDSS clock-domain (0), CDSP state (1), LPASS state (2),
+		    modem state (3), SLPI state (4), SPSS state (5) and Venus
+		    state (6).
+
+= SUBNODES
+The AOSS side channel also provides the controls for three cooling devices,
+these are expressed as subnodes of the QMP node. The name of the node is used
+to identify the resource and must therefor be "cx", "mx" or "ebi".
+
+- #cooling-cells:
+	Usage: optional
+	Value type: <u32>
+	Definition: must be 2
+
+= EXAMPLE
+
+The following example represents the AOSS side-channel message RAM and the
+mechanism exposing the power-domains, as found in SDM845.
+
+  aoss_qmp: qmp@c300000 {
+	  compatible = "qcom,sdm845-aoss-qmp";
+	  reg = <0x0c300000 0x100000>;
+	  interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+	  mboxes = <&apss_shared 0>;
+
+	  #power-domain-cells = <1>;
+
+	  cx_cdev: cx {
+		#cooling-cells = <2>;
+	  };
+
+	  mx_cdev: mx {
+		#cooling-cells = <2>;
+	  };
+  };
diff --git a/include/dt-bindings/power/qcom-aoss-qmp.h b/include/dt-bindings/power/qcom-aoss-qmp.h
new file mode 100644
index 000000000000..7d8ac1a4f90c
--- /dev/null
+++ b/include/dt-bindings/power/qcom-aoss-qmp.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, Linaro Ltd. */
+
+#ifndef __DT_BINDINGS_POWER_QCOM_AOSS_QMP_H
+#define __DT_BINDINGS_POWER_QCOM_AOSS_QMP_H
+
+#define AOSS_QMP_QDSS_CLK	0
+#define AOSS_QMP_LS_CDSP		1
+#define AOSS_QMP_LS_LPASS	2
+#define AOSS_QMP_LS_MODEM	3
+#define AOSS_QMP_LS_SLPI		4
+#define AOSS_QMP_LS_SPSS		5
+#define AOSS_QMP_LS_VENUS	6
+
+#endif
-- 
2.18.0

