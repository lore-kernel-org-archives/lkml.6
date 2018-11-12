Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3BFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF16F2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DdXlVZ2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF16F2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeKLRyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:54:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46741 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbeKLRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:54:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so976456ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1etsSWfK+dYrvJcyqIxcEuivpRmFukZsShZNkNSmLLg=;
        b=DdXlVZ2BWgVHh5sAA1aKJSjdb1T9D6baEClN0xUcgjzHGFf1sSM/UhUBE37Yyy6Y5K
         jCAU/Z3AaNFnQRkXNE8CwixxHCOXKFJ62G5UldAMe9DLS3cnp1jPj+waSIwK+reNio6/
         GmPRs0F5oqwydbg4al76NylHpebSAiVJluj3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1etsSWfK+dYrvJcyqIxcEuivpRmFukZsShZNkNSmLLg=;
        b=VdHljubUl+sCjOUHVGmcEeZ1nO+czEsEfLQcOqDw0ho0U0HAXIdZGSq9U4oJepYjjf
         ZH3c7G+naDrgdA66LFSYb44noQZJykIXqUKijBpevYOkw2GlvHV7Mu+ErbeFXSL1utx9
         9+yduVcQLb8DLLpKNUj4jzHGomiuH99/8QgcyUjN5lX8ThOonEGNMVIi2PynwcJiyeHR
         J4UxCAn0GawxpXG8UI1VNqgpxRRbcA7e366jtl8dokCkgwLygfaWEd56n9r8H46E0vbr
         5wVkO3gyNwc1NoIzJb3hHGI9DYdULC7Dz2ed0UaYGgrw8E84oqhft6R9TOTcKrltmulb
         w5MQ==
X-Gm-Message-State: AGRZ1gJ4MPXTbGDyIBJQNA5IDZQvtqYqReJG+r0PI/f99IfZK/EdV4oK
        J5UYh/jT5AaAe5Hi479wfmWbmw==
X-Google-Smtp-Source: AJdET5dtvUvwp316D2ijXwMKHI8wwhgunDDiQq+UKHT6Rx9NiLTWJY0njGAgH02Jo2xB7kyBBq/+fg==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10-v6mr18600101plo.199.1542009727873;
        Mon, 12 Nov 2018 00:02:07 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 134sm13590085pgb.78.2018.11.12.00.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 00:02:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: soc: qcom: Add AOSS QMP binding
Date:   Mon, 12 Nov 2018 00:05:55 -0800
Message-Id: <20181112080557.22698-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181112080557.22698-1-bjorn.andersson@linaro.org>
References: <20181112080557.22698-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for the QMP based side-channel communication mechanism to
the AOSS, which is used to control resources not exposed through the
RPMh interface.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/soc/qcom/qcom,aoss-qmp.txt       | 63 +++++++++++++++++++
 include/dt-bindings/power/qcom-aoss-qmp.h     | 15 +++++
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
 create mode 100644 include/dt-bindings/power/qcom-aoss-qmp.h

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
new file mode 100644
index 000000000000..e3c8cb4372f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -0,0 +1,63 @@
+Qualcomm Always-On Subsystem side channel binding
+
+This binding describes the hardware component responsible for side channel
+requests to the always-on subsystem (AOSS), used for certain power management
+requests that is not handled by the standard RPMh interface. Each client in the
+SoC has it's own block of message RAM and IRQ for communication with the AOSS.
+The protocol used to communicate in the message RAM is known as QMP.
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
+= AOSS Power-domains
+The AOSS side channel exposes control over a set of resources, used to control
+a set of debug related clocks and to affect the low power state of resources
+related to the secondary subsystems. These resources are described as a set of
+power-domains in a subnode of hte AOSS side channel node.
+
+- compatible:
+	Usage: required
+	Value type: <string>
+	Definition: must be "qcom,sdm845-aoss-qmp-pd"
+
+- #power-domain-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: must be 1
+
+= EXAMPLE
+
+The following example represents the AOSS side-channel message RAM and the
+mechanism exposing the power-domains, as found in SDM845.
+
+  aoss_qmp: qmp@c300000 {
+          compatible = "qcom,sdm845-aoss-qmp";
+          reg = <0x0c300000 0x100000>;
+          interrupts = <GIC_SPI 389 IRQ_TYPE_EDGE_RISING>;
+
+          mboxes = <&apss_shared 0>;
+
+          aoss_qmp_pd: power-controller {
+                  compatible = "qcom,sdm845-aoss-qmp-pd";
+                  #power-domain-cells = <1>;
+          };
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

