Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834D6C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F4B20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnKMpsPo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F4B20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbeHaSJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:09:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39770 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbeHaSJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:09:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id o37-v6so11325864wrf.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 07:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wpwh1J0n/D8S9rbxdqkayW0bLbU11ULq+GMS5dW7EjU=;
        b=WnKMpsPo7YRkUxgETFZi0F4/wLp546KODvbWtN2BHc9uDkMXKakn+Cq0aW7erowIw7
         DZrIqcF8k1dLKnTZOLReOQQ5aOGIqsYbJUibaP/mz3fkqODYlXrye8b/ePQY7CVA9UPb
         JnG6JSLbZB5aIEs62YcMeY7RhmUArMwZnpZa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wpwh1J0n/D8S9rbxdqkayW0bLbU11ULq+GMS5dW7EjU=;
        b=H8SRZND61LGH2ye5093busjlEIkLO+jZcMNNTqERBt+nmnzjp5qnOifrsVnvQRhU+C
         F8D5JcheCYRszKEy+0IkDucgpfQjmhx042HXhNCtyzpB5CWh1nha1bLSklKuvFUKVI/6
         3ftgg7CBXtjdCs3eJ57LJTh04fAozoQig3qpF8n2bM8cyM7oxZ0DDDq59lYnmpRuC1Ck
         D8avr38byiuu3TzoKNmdWKv0JOGNxMwo/JDMK++CZEAP5IamOv4LpyTtJM7Zv3S9yST4
         lIodq4AFIfBK++U/1ygLv7CEhd//EOGTIWc1s3g9k0mkXbld0usNv84bI9Yf/lmlKJqZ
         yucg==
X-Gm-Message-State: APzg51Ck8cmjHJKguzE+LXDbDkm7H3JeJDKGLhfdkB3PNYFa5IrbbQme
        3O3z2O13+vEBK4MlmLH5Q4/zfg==
X-Google-Smtp-Source: ANB0Vda6Eb6mg/gjdyI40hCoEyj7g9ZHIERtkKsBaJkfHVdRNOUj1IYFrTgETUkiqi2U8GCawuWaVg==
X-Received: by 2002:adf:ce06:: with SMTP id p6-v6mr11550258wrn.118.1535724117788;
        Fri, 31 Aug 2018 07:01:57 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id m68-v6sm8624513wmb.10.2018.08.31.07.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 31 Aug 2018 07:01:57 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v9 2/8] dt-bindings: Introduce interconnect binding
Date:   Fri, 31 Aug 2018 17:01:45 +0300
Message-Id: <20180831140151.13972-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831140151.13972-1-georgi.djakov@linaro.org>
References: <20180831140151.13972-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is intended to represent the relations between the interconnect
controllers (providers) and consumer device nodes. It will allow creating links
between consumers and interconnect paths (exposed by interconnect providers).

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
new file mode 100644
index 000000000000..5cb7d3c8d44d
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -0,0 +1,60 @@
+Interconnect Provider Device Tree Bindings
+=========================================
+
+The purpose of this document is to define a common set of generic interconnect
+providers/consumers properties.
+
+
+= interconnect providers =
+
+The interconnect provider binding is intended to represent the interconnect
+controllers in the system. Each provider registers a set of interconnect
+nodes, which expose the interconnect related capabilities of the interconnect
+to consumer drivers. These capabilities can be throughput, latency, priority
+etc. The consumer drivers set constraints on interconnect path (or endpoints)
+depending on the use case. Interconnect providers can also be interconnect
+consumers, such as in the case where two network-on-chip fabrics interface
+directly
+
+Required properties:
+- compatible : contains the interconnect provider compatible string
+- #interconnect-cells : number of cells in a interconnect specifier needed to
+			encode the interconnect node id
+
+Example:
+
+		snoc: snoc@580000 {
+			compatible = "qcom,msm8916-snoc";
+			#interconnect-cells = <1>;
+			reg = <0x580000 0x14000>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				 <&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+
+
+= interconnect consumers =
+
+The interconnect consumers are device nodes which dynamically express their
+bandwidth requirements along interconnect paths they are connected to. There
+can be multiple interconnect providers on a SoC and the consumer may consume
+multiple paths from different providers depending on use case and the
+components it has to interact with.
+
+Required properties:
+interconnects : Pairs of phandles and interconnect provider specifier to denote
+	        the edge source and destination ports of the interconnect path.
+
+Optional properties:
+interconnect-names : List of interconnect path name strings sorted in the same
+		     order as the interconnects property. Consumers drivers will use
+		     interconnect-names to match interconnect paths with interconnect
+		     specifiers.
+
+Example:
+
+	sdhci@7864000 {
+		...
+		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
+		interconnect-names = "ddr";
+	};
