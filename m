Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790FC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666F5223C6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="alG8SUHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666F5223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeHJRXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:23:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42585 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbeHJRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:23:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so8532998wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wpwh1J0n/D8S9rbxdqkayW0bLbU11ULq+GMS5dW7EjU=;
        b=alG8SUHlrGlrBguXp0OwUd+5ntlokkyoAptgeDfts5gxy1ZiFBgd3oVCKCcSMaChS+
         2kx8KgB6MDTKjmevMOINUJjHvklVYHSDPAE6Ky4jNsMLYET4eYH5Q8tFBRU+CTDLxSsc
         AeJb295UnxuH4Y0ipoepMDmkzHSCfQ2Nn8NE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wpwh1J0n/D8S9rbxdqkayW0bLbU11ULq+GMS5dW7EjU=;
        b=LvHslkOw2ZU+lXWbgwPJp2r/v/yRo/WaPOyhSRQXMisabXMhfJ5CnZXFJWxlii01D3
         C33dNmND/+PT27k+jvrZPQ+VxWdBibJGctPAzpeXBJ3FNGj+IdMdHGlbi3PUHMFuPEGO
         kgr5MW2bIRv8cbzQMhVPKuzAeLVurmdKwr4YwX2LmxZKWM2fx+DCpxTLoQAqJHFxxfwT
         NEb3aTtYMC0Pqt133SqrThFlLnxoj04iqJe0U55NsVFjKnRJgqTdhCw1lfyJPIfAw0Xq
         IPS1psvixWxQ3xmZfnRfQ7eGKyXlDs3KkVEMwDTdhsfyydVXxv82Od5g5AYtTLaRfLT4
         zGfA==
X-Gm-Message-State: AOUpUlGcaQLWrna5jzRBxc4QxuoPrj9RKsK7eevS4qr0WwKrspP/IkLx
        bzbmEhdShPYADIWKCsJtZF3B8Q==
X-Google-Smtp-Source: AA+uWPx1903AUYi6JtmezKEXa8XRio4UsXD7xO+QJ2IS6JJL/li8Qhw3nAwXOmWkxB1l/wpdPCSUcA==
X-Received: by 2002:adf:bf10:: with SMTP id p16-v6mr4324454wrh.235.1533912766599;
        Fri, 10 Aug 2018 07:52:46 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 9-v6sm19842700wrb.48.2018.08.10.07.52.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 07:52:45 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, arnd@arndb.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v8 2/8] dt-bindings: Introduce interconnect binding
Date:   Fri, 10 Aug 2018 17:52:27 +0300
Message-Id: <20180810145233.16466-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810145233.16466-1-georgi.djakov@linaro.org>
References: <20180810145233.16466-1-georgi.djakov@linaro.org>
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
