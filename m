Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9B3C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2EA2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZL0jQZ0x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2EA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbeKGKBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:01:03 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:40142 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388662AbeKGKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:01:01 -0500
Received: by mail-it1-f180.google.com with SMTP id e11so17173506itl.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IWqht3lWvRgaSjU7kSguHrGrb0qMDwHxt+moiiah5KM=;
        b=ZL0jQZ0xy9R6opJpoe/wEfGb8ZRudO+IxHxd7U1ISG6XrvrQMj2vg0zUoEvGduml9U
         tSO1uBvK4IsragGs+1ghN9EYuNrN/xqcuE3ju86CN/qHt3xoMW4kqhC+y2hIRVdG9HEs
         V0T89ymdBWafur1XazI3iP0Lo9azskqt7ptu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IWqht3lWvRgaSjU7kSguHrGrb0qMDwHxt+moiiah5KM=;
        b=jAMgK0sVLwsDwL6R6gPe3qvd2febrn0REDjkKz4r0n63oJlJFm2XlO6iJjDZKcvksF
         g6f5DE9fcXH7r3GLu2JlkIxXdHTzID/XkzzLf8RiytVcuU+GAAioN6wPqwOgNzdKKmqy
         zHVjgUxY9LNxEmM62SqIKrNSwPvsk3ImThvCe+DCF0x/+ALNUcCClIUIIzViP0zuNVVB
         qTSsF2PsY9g/cxhP09CJoyNPgSx3ENZ4CiLEai2zSzP4FzMswWL1DOdcsH0mvJuvVcnc
         rawd2bywNE3G1JYF+Wsp8RZk7weL9ESUiEC37iPCOVRjbQb0ewYn+nWlqOeXtE8s3syy
         ZvpQ==
X-Gm-Message-State: AGRZ1gLUgNHdua85iZybpFObThYEf2YFD9wwU8C99EsdzdE7Im3EXddf
        LUWG/OxVAU0JW5HQwhP2ScazqA==
X-Google-Smtp-Source: AJdET5fFL4HNp5Gut9DMGOQrOGf69NMWtzXA/+P/rsQldhQpLI34aOg84581ENq6fHyn084lodzGCA==
X-Received: by 2002:a24:3c0a:: with SMTP id m10-v6mr116546ita.37.1541550786630;
        Tue, 06 Nov 2018 16:33:06 -0800 (PST)
Received: from shibby.gateway.innflux.com ([66.228.239.218])
        by smtp.gmail.com with ESMTPSA id e184-v6sm1061128ite.9.2018.11.06.16.33.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:33:05 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, davem@davemloft.net,
        arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        syadagir@codeaurora.org, mjavid@codeaurora.org
Subject: [RFC PATCH 01/12] dt-bindings: soc: qcom: add IPA bindings
Date:   Tue,  6 Nov 2018 18:32:39 -0600
Message-Id: <20181107003250.5832-2-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181107003250.5832-1-elder@linaro.org>
References: <20181107003250.5832-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding definitions for the "qcom,ipa" and "qcom,rmnet-ipa"
device tree nodes.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,ipa.txt | 136 ++++++++++++++++++
 .../bindings/soc/qcom/qcom,rmnet-ipa.txt      |  15 ++
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
new file mode 100644
index 000000000000..d4d3d37df029
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ipa.txt
@@ -0,0 +1,136 @@
+Qualcomm IPA (IP Accelerator) Driver
+
+This binding describes the Qualcomm IPA.  The IPA is capable of offloading
+certain network processing tasks (e.g. filtering, routing, and NAT) from
+the main processor.  The IPA currently serves only as a network interface,
+providing access to an LTE network available via a modem.
+
+The IPA sits between multiple independent "execution environments,"
+including the AP subsystem (APSS) and the modem.  The IPA presents
+a Generic Software Interface (GSI) to each execution environment.
+The GSI is an integral part of the IPA, but it is logically isolated
+and has a distinct interrupt and a separately-defined address space.
+
+    ----------   -------------   ---------
+    |        |   |G|       |G|   |       |
+    |  APSS  |===|S|  IPA  |S|===| Modem |
+    |        |   |I|       |I|   |       |
+    ----------   -------------   ---------
+
+See also:
+  bindings/interrupt-controller/interrupts.txt
+  bindings/interconnect/interconnect.txt
+  bindings/soc/qcom/qcom,smp2p.txt
+  bindings/reserved-memory/reserved-memory.txt
+  bindings/clock/clock-bindings.txt
+
+All properties defined below are required.
+
+- compatible:
+	Must be one of the following compatible strings:
+		"qcom,ipa-sdm845-modem_init"
+		"qcom,ipa-sdm845-tz_init"
+
+-reg:
+	Resources specyfing the physical address spaces of the IPA and GSI.
+
+-reg-names:
+	The names of the address space ranges defined by the "reg" property.
+	Must be "ipa" and "gsi".
+
+- interrupts-extended:
+	Specifies the IRQs used by the IPA.  Four cells are required,
+	specifying: the IPA IRQ; the GSI IRQ; the clock query interrupt
+	from the modem; and the "ready for stage 2 initialization"
+	interrupt from the modem.  The first two are hardware IRQs; the
+	third and fourth are SMP2P input interrupts.
+
+- interrupt-names:
+	The names of the interrupts defined by the "interrupts-extended"
+	property.  Must be "ipa", "gsi", "ipa-clock-query", and
+	"ipa-post-init".
+
+- clocks:
+	Resource that defines the IPA core clock.
+
+- clock-names:
+	The name used for the IPA core clock.  Must be "core".
+
+- interconnects:
+	Specifies the interconnects used by the IPA.  Three cells are
+	required, specifying:  the path from the IPA to memory; from
+	IPA to internal (SoC resident) memory; and between the AP
+	subsystem and IPA for register access.
+
+- interconnect-names:
+	The names of the interconnects defined by the "interconnects"
+	property.  Must be "memory", "imem", and "config".
+
+- qcom,smem-states
+	The state bits used for SMP2P output.  Two cells must be specified.
+	The first indicates whether the value in the second bit is valid
+	(1 means valid).  The second, if valid, defines whether the IPA
+	clock is enabled (1 means enabled).
+
+- qcom,smem-state-names
+	The names of the state bits used for SMP2P output.  These must be
+	"ipa-clock-enabled-valid" and "ipa-clock-enabled".
+
+- memory-region
+	A phandle for a reserved memory area that holds the firmware passed
+	to Trust Zone for authentication.  (Note, this is required
+	only for "qcom,ipa-sdm845-tz_init".)
+
+= EXAMPLE
+
+The following example represents the IPA present in the SDM845 SoC.  It
+shows portions of the "modem-smp2p" node to indicate its relationship
+with the interrupts and SMEM states used by the IPA.
+
+	modem-smp2p {
+		compatible = "qcom,smp2p";
+		. . .
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	ipa@1e00000 {
+		compatible = "qcom,ipa-sdm845-modem_init";
+
+		reg = <0x1e40000 0x34000>,
+		      <0x1e04000 0x2c000>;
+		reg-names = "ipa",
+			    "gsi";
+
+		interrupts-extended = <&intc 0 311 IRQ_TYPE_LEVEL_HIGH>,
+				      <&intc 0 432 IRQ_TYPE_LEVEL_HIGH>,
+				      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+				      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "ipa",
+				  "gsi",
+				  "ipa-clock-query",
+				  "ipa-post-init";
+
+		clocks = <&rpmhcc RPMH_IPA_CLK>;
+		clock-names = "core";
+
+		interconnects = <&qnoc MASTER_IPA &qnoc SLAVE_EBI1>,
+			        <&qnoc MASTER_IPA &qnoc SLAVE_IMEM>,
+			        <&qnoc MASTER_APPSS_PROC &qnoc SLAVE_IPA_CFG>;
+		interconnect-names = "memory",
+				     "imem",
+				     "config";
+
+		qcom,smem-states = <&ipa_smp2p_out 0>,
+				   <&ipa_smp2p_out 1>;
+		qcom,smem-state-names = "ipa-clock-enabled-valid",
+					"ipa-clock-enabled";
+	};
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
new file mode 100644
index 000000000000..3d0b2aabefc7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rmnet-ipa.txt
@@ -0,0 +1,15 @@
+Qualcomm IPA RMNet Driver
+
+This binding describes the IPA RMNet driver, which is used to
+represent virtual interfaces available on the modem accessed via
+the IPA.  Other than the compatible string there are no properties
+associated with this device.
+
+- compatible:
+	Must be "qcom,rmnet-ipa".
+
+= EXAMPLE
+
+	qcom,rmnet-ipa {
+		compatible = "qcom,rmnet-ipa";
+	};
-- 
2.17.1

