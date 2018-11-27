Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3C6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F206F2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RilZdxrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F206F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbeK1FCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:02:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39466 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeK1FCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:02:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so15707906wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 10:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOXubBChD/vsZf1Ak3ErpaX+5RE4VgjTS/XqQz0dBvI=;
        b=RilZdxrfjPOF+2i5mhmOpxBHmnuuuSWMk7GcoqQ/fFS/kpntXbl45YmNmM6Q15iw6l
         MTOVCfgMlT8dOsLZWqo3kgY0d2vai8oQCiOjiwqlW70jURO54W7FNnucRpa2TUtScNXF
         jU8oU8CA+4hZKaED4wdoWLtyY4y2d/5oWleTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOXubBChD/vsZf1Ak3ErpaX+5RE4VgjTS/XqQz0dBvI=;
        b=sp3HMu29+lQDiSxmMcBQQNqRJeTP3vpMsXY2jnG+LPuB2OylkQKK+PoQ7CgNh1pMa8
         T3cpDrnnEs9NeLhSjOzU0+r9UDsyDUtAUzfhgcEqejztvKN8we4QR8RnJJwZbUQyf0ae
         AfiaacQYsdQ3HF4/VyH4YbGo9NChDcmrpgsHvgBVP8YnYujOU9ZAHmvXWwtJ4dzen/F4
         WutOnVS10NN9A++sO2ZwZQnrQ0pq+t8ZFZ2dyhPGB0U59ZqhvS6WQWzRn5pSux3yU4MB
         sXO6Pi0+YfGa2OBGopI4SnmYkvOTG33xuIAugXWdf+RF1f3J8mNQJWM5XnNaVg12B6j0
         OUJg==
X-Gm-Message-State: AA+aEWZfS7o2dBvKdMs99keRSa+pfJTvqCjpOFZhqS7HFuwM1ck426iF
        H4NdJrXXEoRoyjXR8reFmg93yQ==
X-Google-Smtp-Source: AFSGD/Um4mllHvbUBTAR1SZ/3W/vVm2svreCSTqY7YP47bp2oK0eoMvcmCXTLY8yOOJZM6lDNRPdxg==
X-Received: by 2002:adf:f550:: with SMTP id j16mr27953023wrp.258.1543341835247;
        Tue, 27 Nov 2018 10:03:55 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a17sm6459921wrs.58.2018.11.27.10.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Nov 2018 10:03:54 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v10 2/7] dt-bindings: Introduce interconnect binding
Date:   Tue, 27 Nov 2018 20:03:44 +0200
Message-Id: <20181127180349.29997-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181127180349.29997-1-georgi.djakov@linaro.org>
References: <20181127180349.29997-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 000000000000..6775c07e1574
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
+		interconnect-names = "sdhc-ddr";
+	};
