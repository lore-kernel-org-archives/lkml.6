Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB7CECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAEB2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l3HnpN0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AAEB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeGPSe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:34:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:53254 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbeGPSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:34:57 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6GI69oU103555;
        Mon, 16 Jul 2018 13:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531764369;
        bh=30TxWy5iBqkRrz70IwkKzPn6dEy0ZoXQPoVdoeUKsoU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=l3HnpN0LvCEjgwjZjBriIK3c1i4y3dJaUo0s8CPZa7u7MuDLPvyF0ivrxWj3cctKt
         fm3JMq71vRRGlN5At+okcu+LhMgyYaGudqQ3shW8cgWwdDizoaqDP9Vd3Ov8nLvA6/
         4IBDaRcedysLqGyQyZ1MszBPsyMsWwhLjruj/GdY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GI69mG018319;
        Mon, 16 Jul 2018 13:06:09 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 16
 Jul 2018 13:06:08 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 16 Jul 2018 13:06:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GI68iS025965;
        Mon, 16 Jul 2018 13:06:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 5/6] dt-bindings: mailbox: Add support for secure proxy threads
Date:   Mon, 16 Jul 2018 13:06:06 -0500
Message-ID: <20180716180607.16526-6-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180716180607.16526-1-nm@ti.com>
References: <20180716180607.16526-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Secure Proxy is another communication scheme in Texas Instrument's
devices intended to provide an unique communication path from various
processors in the System on Chip(SoC) to a central System Controller.

Secure proxy is, in effect, an evolution of current generation Message
Manager hardware block found in K2G devices. However the following
changes have taken place:

Secure Proxy instance exposes "threads" or "proxies" which is
primary representation of "a" communication channel. Each thread is
preconfigured by System controller configuration based on SoC usage
requirements. Secure proxy by itself represents a single "queue" of
communication but allows the proxies to be independently operated.

Each Secure proxy thread can uniquely have their own error and threshold
interrupts allowing for more fine control of IRQ handling.

Provide an hardware description of the same for device tree
representation.

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
* Example changed to indicate mailbox instead of secure_proxy
* Picked up Rob's Reviewed-by

V1: https://patchwork.kernel.org/patch/10475343/
RFC: https://patchwork.kernel.org/patch/10447695/

 .../bindings/mailbox/ti,secure-proxy.txt           | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt

diff --git a/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
new file mode 100644
index 000000000000..6c9c7daf0f5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/ti,secure-proxy.txt
@@ -0,0 +1,50 @@
+Texas Instruments' Secure Proxy
+========================================
+
+The Texas Instruments' secure proxy is a mailbox controller that has
+configurable queues selectable at SoC(System on Chip) integration. The
+Message manager is broken up into different address regions that are
+called "threads" or "proxies" - each instance is unidirectional and is
+instantiated at SoC integration level by system controller to indicate
+receive or transmit path.
+
+Message Manager Device Node:
+===========================
+Required properties:
+--------------------
+- compatible:		Shall be "ti,am654-secure-proxy"
+- reg-names 		target_data - Map the proxy data region
+			rt - Map the realtime status region
+			scfg - Map the configuration region
+- reg:			Contains the register map per reg-names.
+- #mbox-cells		Shall be 1 and shall refer to the transfer path
+			called thread.
+- interrupt-names:	Contains interrupt names matching the rx transfer path
+			for a given SoC. Receive interrupts shall be of the
+			format: "rx_<PID>".
+- interrupts:		Contains the interrupt information corresponding to
+			interrupt-names property.
+
+Example(AM654):
+------------
+
+	secure_proxy: mailbox@32c00000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg-names = "target_data", "rt", "scfg";
+		reg = <0x0 0x32c00000 0x0 0x100000>,
+		      <0x0 0x32400000 0x0 0x100000>,
+		      <0x0 0x32800000 0x0 0x100000>;
+		interrupt-names = "rx_011";
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	dmsc: dmsc {
+		[...]
+		mbox-names = "rx", "tx";
+		# RX Thread ID is 11
+		# TX Thread ID is 13
+		mboxes= <&secure_proxy 11>,
+			<&secure_proxy 13>;
+		[...]
+	};
-- 
2.15.1

