Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C0C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8D5C20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HS9y9EVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8D5C20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbeLHRDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:03:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39687 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeLHRCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:02:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so6555081wra.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 09:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYVwTFHfIdIF1mZV76OOxHqL8mAPwlcr24Pr/3Xy1IA=;
        b=HS9y9EVfzKeMOVbRIxLLfBnvq0rZL3W67pLPJ8NUfhzMZB3GBei6SgiXy3nuNR8Qdi
         9zpbM8Tg8A+Uh7RvBSv7GsomS42qtpcc9TGa1re2lSgz82OCPWf2EHIoqctxkDUqGZlM
         ytUJ7QrgJqbyCGDBfiSuYqZieQzCsXl4uxH3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYVwTFHfIdIF1mZV76OOxHqL8mAPwlcr24Pr/3Xy1IA=;
        b=DeCvmYTvfvIeNV5iRniws+3Fu2gr9Lj/h6/Cw1j0mmW/2U2YAyzaVmSVgBR7Lh2u8N
         tAoC4CxbmoHjRgfnKgaRtIiL3h29/AT9ktiwZAhLiSG+3I29gs8/4fDjLCGUQR8h7eEO
         ezFVbqKtNMwMa33jrw/i02likGKMZmAqWQlTx7DpgjjrCfnMO53sRDrI6GNoNNcDT6CM
         WkWQCXH2LN7wqCUDnuLPB+wdkWR3FKX6x4X4tJX6U+kaF9lSE7aui027I4Kd6F/6gvhm
         +fNxiFjGWqIazDr6YStmZM/W3BS5u/8sTl0kRFPrXVt3WwNJ44LqUClV6VRUcPnn8fT4
         X6JQ==
X-Gm-Message-State: AA+aEWbG7u9PKogJgkL6F7WACgBGB8LOPI+b2Jfi6BYJ1z7RBKMKNaNS
        ivMUVOjxr55ARNClO7FC6txCTA==
X-Google-Smtp-Source: AFSGD/V4FMoCY4qPEk1+ugBTTCKc3TSjhL8vXLabfRIMUbTMklVDXHZz9AYWIkK/R+qo1ZBvgkEKmA==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr5041589wrp.198.1544288543299;
        Sat, 08 Dec 2018 09:02:23 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l20sm17411344wrb.93.2018.12.08.09.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Dec 2018 09:02:22 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org, andy.gross@linaro.org, olof@lixom.net,
        arnd@arndb.de, linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v12 2/7] dt-bindings: Introduce interconnect binding
Date:   Sat,  8 Dec 2018 19:02:11 +0200
Message-Id: <20181208170216.32555-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208170216.32555-1-georgi.djakov@linaro.org>
References: <20181208170216.32555-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is intended to represent the relations between interconnect
controllers (providers) and consumer device nodes. It will allow creating
links between consumers and interconnect paths (exposed by interconnect
providers).

Reviewed-by: Evan Green <evgreen@chromium.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
new file mode 100644
index 000000000000..5a3c575b387a
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
+directly.
+
+Required properties:
+- compatible : contains the interconnect provider compatible string
+- #interconnect-cells : number of cells in a interconnect specifier needed to
+			encode the interconnect node id
+
+Example:
+
+		snoc: interconnect@580000 {
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
+		     specifier pairs.
+
+Example:
+
+	sdhci@7864000 {
+		...
+		interconnects = <&pnoc MASTER_SDCC_1 &bimc SLAVE_EBI_CH0>;
+		interconnect-names = "sdhc-mem";
+	};
