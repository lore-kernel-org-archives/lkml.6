Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A91C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096DD214DC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="URnqjOZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 096DD214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391493AbeHPPx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:53:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38091 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391479AbeHPPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:53:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so1996865pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 05:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Q+AUOMeB2Ab47XkW5MPLyXFqW7/NNAsWImFo6vB5OtQ=;
        b=URnqjOZuTORwigtzkX6s24VzknHrs8yQxQ5TfLTc+uITW4cEWB3jI1TkqWlOLbBq4U
         Sx91giRa9ZEudT8BVAWDBLI04S4rgZZFVvp+nQjcOz8I+NUMnjlPpfrwq2DhShDQoA8C
         6byd+8Chnpm1tPZ6E734EzvTPdwR1XpSnugMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Q+AUOMeB2Ab47XkW5MPLyXFqW7/NNAsWImFo6vB5OtQ=;
        b=spyyPZuizDuRNQGXONIp1eiVShXMpcdPD2UsbGJa4Ae64/7MrIkEbw7GK71NQ9tTiZ
         WoksDW+NsmnFg+F/8LcM/+8b8akjZAgY6kh6vSYrsCKltXmlEvgDncQ2TFc9sVn0bqze
         Hvbi/qorwMceTX8bsElNWm3hdgT7DmMFVQwZ+070PZjSBDrHn2wU5zRaLtqxvDLp6UH1
         egRCYEx0/8agtOCeiIn0KN0GV6y1vV1fVpI6FhlMHW8N5Xa6g5JLiqqVr7MjNkVPaiVe
         6VRD1YtlaTC1GbNuKlJ1JU+pz/dNOsgp0g9hijiQxDrkvKZugdYfB9bq8HvFGkhO3qQT
         xNZw==
X-Gm-Message-State: AOUpUlELBQajDuDbZPxVxG+qBWVLHKQ/PSktV5sTKf8Rtpdws12b9m6J
        XmM/g99LxvlIYXbVr+YGpdND6w==
X-Google-Smtp-Source: AA+uWPwDyjd0IfHzC/9VyYs/GWbJ+yLFmhz60JST8M5HTzKboZ8wnTw+vFWElRt7Qz5BC+H6zoXPvw==
X-Received: by 2002:a62:ca0d:: with SMTP id n13-v6mr31983354pfg.69.1534424132161;
        Thu, 16 Aug 2018 05:55:32 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 203-v6sm34944589pgb.14.2018.08.16.05.55.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 05:55:31 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        lanqing.liu@spreadtrum.com, baolin.wang@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: spi: Add Spreadtrum SPI controller documentation
Date:   Thu, 16 Aug 2018 20:54:50 +0800
Message-Id: <53e9467b4b16911576bcfb71c50c108ea83a803c.1534423916.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
In-Reply-To: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lanqing Liu <lanqing.liu@spreadtrum.com>

This patch adds the binding documentation for Spreadtrum SPI
controller device.

Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - Remove the sprd,spi-interval property.
---
 Documentation/devicetree/bindings/spi/spi-sprd.txt |   26 ++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
new file mode 100644
index 0000000..bad211a
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
@@ -0,0 +1,26 @@
+Spreadtrum SPI Controller
+
+Required properties:
+- compatible: Should be "sprd,sc9860-spi".
+- reg: Offset and length of SPI controller register space.
+- interrupts: Should contain SPI interrupt.
+- clock-names: Should contain following entries:
+	"spi" for SPI clock,
+	"source" for SPI source (parent) clock,
+	"enable" for SPI module enable clock.
+- clocks: List of clock input name strings sorted in the same order
+	as the clock-names property.
+- #address-cells: The number of cells required to define a chip select
+	address on the SPI bus. Should be set to 1.
+- #size-cells: Should be set to 0.
+
+Example:
+spi0: spi@70a00000{
+	compatible = "sprd,sc9860-spi";
+	reg = <0 0x70a00000 0 0x1000>;
+	interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	clock-names = "spi", "source","enable";
+	clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
-- 
1.7.9.5

