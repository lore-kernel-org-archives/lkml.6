Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13C6C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4D5208E5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RpZIPx/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4D5208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933701AbeGIPzk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:55:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41187 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933328AbeGIPvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:51:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so4991932wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ciWHyLMikqH3wKENiDm/GxmXb1N461xZPfHB5KvcB1o=;
        b=RpZIPx/beUHRYti0cQ744TwtbMvSNQQPb29N9xR6xlvLjFNzkXijkASH1thcPbhx4X
         AteMQP0KOH3YQWSq/pwtEVJ6xxySNUrwSrwZkw3wWycGiuUScWXVfFuiieHZ4hY/jp1G
         9fkUbuFQMqehVLNUclSBcO1q9gk7u+r+vRt6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ciWHyLMikqH3wKENiDm/GxmXb1N461xZPfHB5KvcB1o=;
        b=FizC7UGzO+6aIHFYiI1wgeSXIFXNrwZH6VYZmUAzRUXr8W44VuopQleG2joRvJGuvJ
         cbRu08Ras4dYPCkUjW/RPJi9/zJSeoQE9AZIPOD9vr6d8uf3plqBzhb8Xo0wI3U4VPb3
         jpoBZyjeJmlPDCUmHYUzv7Na1v0jm6rB/Hj8gFg4vGHVBEMP7P4nG5aHtJIIz3NsHo04
         Uy4vC5WSGoZIwJJ1ySOEl1AnsoL0V7pXRkzkqUnynrFpZVTEV1IY8xTaxTpru3mmBmpp
         8s7i+xkZ0ejjOqvYlCrH4th5qT1Qw+hwD8XB/Z8/IIFOgr5XHnGyN4im5/ofw59Vk4pj
         SYRw==
X-Gm-Message-State: APt69E3tmS/diMPA0/6N+84ob4V/wxmVe5z4f0pnY9ua/wBkKUrmCmUo
        kyGKJGwFFHLsJnZLdLMQEFZ47w==
X-Google-Smtp-Source: AAOMgpfT1RGT+MYVWSClFtIOg+Vs4q3uzoZ01QO44jNsP6+UN4OchIdgkC/HoYXXAB2xvNwHu9khzA==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12-v6mr14513762wrt.71.1531151470880;
        Mon, 09 Jul 2018 08:51:10 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id o21-v6sm16229202wmg.28.2018.07.09.08.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 08:51:10 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, abailon@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mka@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v6 2/8] dt-bindings: Introduce interconnect provider bindings
Date:   Mon,  9 Jul 2018 18:50:58 +0300
Message-Id: <20180709155104.25528-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180709155104.25528-1-georgi.djakov@linaro.org>
References: <20180709155104.25528-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This binding is intended to represent the interconnect hardware present
in some of the modern SoCs. Currently it consists only of a binding for
the interconnect hardware devices (provider).

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/interconnect.txt    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/interconnect.txt

diff --git a/Documentation/devicetree/bindings/interconnect/interconnect.txt b/Documentation/devicetree/bindings/interconnect/interconnect.txt
new file mode 100644
index 000000000000..6e2b2971b094
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/interconnect.txt
@@ -0,0 +1,33 @@
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
