Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A93C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF7B20652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 13:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=obeliks.de header.i=@obeliks.de header.b="Ek1iwRyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF7B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nospam.obeliks.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeIHR7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 13:59:53 -0400
Received: from scopuli.esotechnik.de ([79.143.188.15]:39048 "EHLO
        mail.esotechnik.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHR7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 13:59:52 -0400
Received: by mail.esotechnik.net (Postfix) with ESMTPSA id 0A1EDAE0B82;
        Sat,  8 Sep 2018 15:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=obeliks.de; s=jul2017;
        t=1536412445; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qWG7AqkXahklo3swWdltiDpxSLZ0ILQ8gXrfFQJlO9Q=;
        b=Ek1iwRyulz07b2/C8pbm93gIdsqxKWeIihqQj5t6D/5w6rihsbYxw94p+GKk0/u+kctupR
        a93yg0H7gZVVd9jhntgAXAp1/Gli0MkIn85V66B79NdFHTPm9v69Q+vsdyvc+ZNDkbX325
        ak/DXMhdRikjeo+Arv7XGW9D409iqcWa3yyZAykO10gz22P7fq9AbfAk5/QU4qZddS6FcZ
        l8IfaLNtTweHCygiFXtlTRFkC/Nrpw/94z1rxd00gtEkJxAeVcZVkRAwFIZzQt19q5+glb
        t12ayBSATstp9JR4rbsYVeLJ48JKHAGSEyjT6mUtDt+CGJNBbDtzrlHT0fPKEg==
From:   Bernhard Frauendienst <kernel@nospam.obeliks.de>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Bernhard Frauendienst <kernel@nospam.obeliks.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: add bindings for mtd-concat devices
Date:   Sat,  8 Sep 2018 15:13:44 +0200
Message-Id: <20180908131345.8145-3-kernel@nospam.obeliks.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908131345.8145-1-kernel@nospam.obeliks.de>
References: <20180908131345.8145-1-kernel@nospam.obeliks.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document virtual mtd-concat device bindings.

Signed-off-by: Bernhard Frauendienst <kernel@nospam.obeliks.de>
---
 .../devicetree/bindings/mtd/mtd-concat.txt    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/mtd-concat.txt

diff --git a/Documentation/devicetree/bindings/mtd/mtd-concat.txt b/Documentation/devicetree/bindings/mtd/mtd-concat.txt
new file mode 100644
index 000000000000..2daf3157b163
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/mtd-concat.txt
@@ -0,0 +1,36 @@
+Virtual MTD concat device
+
+Requires properties:
+- devices: list of phandles to mtd nodes that should be concatenated
+
+Example:
+
+&spi {
+	flash0: flash@0 {
+		...
+	};
+	flash1: flash@1 {
+		...
+	};
+};
+
+flash {
+	compatible = "mtd-concat";
+
+	devices = <&flash0 &flash1>;
+
+	partitions {
+		compatible = "fixed-partitions";
+
+		partition@0 {
+			label = "boot";
+			reg = <0x0000000 0x0040000>;
+			read-only;
+		};
+
+		partition@40000 {
+			label = "firmware";
+			reg = <0x0040000 0x1fc0000>;
+		};
+	}
+}
-- 
2.18.0

