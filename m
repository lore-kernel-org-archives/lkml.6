Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CDFC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42E720672
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 15:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TBlhCU+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42E720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeLGP3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 10:29:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40781 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeLGP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 10:29:27 -0500
Received: by mail-wm1-f66.google.com with SMTP id q26so4895654wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 07:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RDj6MDHY8LfhaKzwZwR+xk+j8tl7N19Jf8vqoRp4O4Y=;
        b=TBlhCU+QpJs0e62CNtOmnH8EuDCbTs5nwf9+D/bWuRXOAo9kzw8a6XMrBcX3dGGkI1
         5bTG0DSuPBGdxzgapoNVR7u1wFv3JcMiVdao6XFt2l92C1P7zeZRKzbGbZv5WIoWmBy/
         EE/l87tIzCR1sK/TAmjJlY/lZCHjfAnc4RElo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RDj6MDHY8LfhaKzwZwR+xk+j8tl7N19Jf8vqoRp4O4Y=;
        b=RAzcbpMviJn4EMDzhkbrCIBnBv4qRHNwkb3oUccqgtG0Sk5jx15CUwlTzbo0oSheMM
         9slNYMMNLmgKTMx+bMuHGuI5G5wxMBs1gUHI5gOvE5bZC5iHdOjupt3E7O+L3+jQSpt5
         HdvaeV3aVWD4kdVdpnauT+qCdNYcBwWZ0vsU/UZavW+UxZlR1NjF0jUu1KwyNBB0QLw4
         qw4qvNSAWkyUOHWxufm32TIqEXHTGnG/A41OlTN7bgpDyyE4s7A6eJClknFhJZ05ufku
         OMCQYjlVhoQ80TG+e7lwn2M/GN8hIG6uil0dVyu0aE/VPwESbRC7zdkHvrMcLwbM4DYP
         T4QQ==
X-Gm-Message-State: AA+aEWYwdAuiP3KFffy9Q657gXGhV1ozTnW3/nTl0GoY/GBXo5vMP/v2
        v8WHyc76jwYVHZPz7p+IajK43A==
X-Google-Smtp-Source: AFSGD/Ug7EUJZLzyiClCy1tLMsG8DqVYJG/NjSUo2idfbtK0wz5sHnfXnQ893vEZzGfiOOpdxckpVQ==
X-Received: by 2002:a1c:d08b:: with SMTP id h133mr2656724wmg.8.1544196565420;
        Fri, 07 Dec 2018 07:29:25 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y145sm2728721wmd.30.2018.12.07.07.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Dec 2018 07:29:24 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     gregkh@linuxfoundation.org, linux-pm@vger.kernel.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        dianders@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        georgi.djakov@linaro.org
Subject: [PATCH v11 2/8] dt-bindings: Introduce interconnect binding
Date:   Fri,  7 Dec 2018 17:29:11 +0200
Message-Id: <20181207152917.4862-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181207152917.4862-1-georgi.djakov@linaro.org>
References: <20181207152917.4862-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is intended to represent the relations between the interconnect
controllers (providers) and consumer device nodes. It will allow creating links
between consumers and interconnect paths (exposed by interconnect providers).

Reviewed-by: Evan Green <evgreen@chromium.org>
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
