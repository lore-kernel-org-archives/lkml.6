Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E31AC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086CB2081B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 05:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olCPqWZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfBFFNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 00:13:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36819 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfBFFNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 00:13:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so2588657plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 21:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7GluNEYIYq7F+AEH/HbazVyyzUsPwLBNFtLOwueywr4=;
        b=olCPqWZkszTummcLF45fgSS6Be0r4s970GM4lIGJG9B/+d9N8Fxy70sK+n3s50kPK+
         5tu4ImXkCoDV28G+iAye35ofFuuDYUdvgipmEcrRo9wQLLVVHo8WFraxm/SYiIcDQTaw
         mR0hrE7KK2kVXPMMl5WczmHP39d59X6uKFSAC32YbfIX3Zbn5nS3/epiiDTUEQ/N5nda
         WOZ7ZoOeZ8uAh5o5eT/W8YPG3rODa4reiyPhaJarlcmlOSzt+UWhgsAgISojGlcBfuxC
         UFXmCfAH/HtzAZbGU8KXf2FGGR4cL2duTCktq4coq2bJixpPayAqSDy3G0KE9cKaQyt1
         5Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7GluNEYIYq7F+AEH/HbazVyyzUsPwLBNFtLOwueywr4=;
        b=P/r6jnAxuTvL1KOJdR65jcJYUNuKa+qEYJ2ffow6FlZxl702xqvOMJ5xns2E782YAA
         v0vQl44fFllEG1Zf/m8Srzg1jB+wnUZAsGjNoOL2D63M+jSPXuDk5NPkkzYPP6jC6Mwy
         9ag6I3j+gXqQ+vihQDShakygRiOaxn91iMu6xcQ7zKQRaX0FftgjjepgMy/0kAf0a2lV
         zxhgO31XNjPM0WMheX98vrRe/+1M9awFQdX7OK9fGJoSIwklySzTV2Z4MyXbkcs3CyPR
         RowDxqNh2drcs5nY3uo85pkRCb71A3XSKhXVTDq/wgEhHOVXAqKaXvkGn7UxR89whehK
         voQA==
X-Gm-Message-State: AHQUAuZ2fdQNCSJiZZ6TwJ/Fcc7AqTbf0+fQmgoNO37U49zhoEkMqSWX
        W7KIGs+RplPonNY2bi+4y8YcAQ==
X-Google-Smtp-Source: AHgI3IZK49kdzp565XwPjiogxRJu4Wk2gPAo7z6qcWVY99mk5isv/aEpBy89/pEQrE/OFgP7IS/2hw==
X-Received: by 2002:a17:902:9b87:: with SMTP id y7mr8931954plp.336.1549430027126;
        Tue, 05 Feb 2019 21:13:47 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y71sm10735012pfi.123.2019.02.05.21.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 21:13:46 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/8] dt-bindings: soc: qcom: Add AOSS QMP binding
Date:   Tue,  5 Feb 2019 21:13:31 -0800
Message-Id: <20190206051335.23799-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190206051335.23799-1-bjorn.andersson@linaro.org>
References: <20190206051335.23799-1-bjorn.andersson@linaro.org>
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

Changes since v5:
- None

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

