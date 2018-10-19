Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD23ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F31A214EE
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 18:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QyIDZkhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F31A214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJTC4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:56:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:47049 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeJTC4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 22:56:07 -0400
Received: by mail-io1-f68.google.com with SMTP id t7-v6so23596560ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHJXfG7Y0xQkyTOnP5dwDTuUGV80eAqpfuxXYLtQfk0=;
        b=QyIDZkhDfja4pVEr4POteuKtXIQdBuc2PcMz11Jy4g2ytDD/FBIhv1rxvo9lbflKzS
         3/SOPpGsAliCyDMiwG/+OOUark9AbexNsTM0N8o3tP88D4ZzefJ+OMe9lW4PUU/j5zxn
         wi65cBJhrmD+a5MTTTe1PZX9t97jYN++BZumU25OnUrCrjl5pvujqJ113QqgeYvHzPW4
         RUSMOVbC5MFbXFIPla0jcFmseP5X6x96TXiCdfYRrhtsEqCIGdhKlGlIfE/BUoNLm/3g
         NcXKjrD5gJvXIgPdx7Gi54GHx9iWOu7j8eu8LMEwHqXj5HkC+KPE+/Iaf1/TbxWbK15F
         NFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHJXfG7Y0xQkyTOnP5dwDTuUGV80eAqpfuxXYLtQfk0=;
        b=LQZwsYWHQAxNfpgg2/Yooa4LXSxy7D+9jBJKzM9Cj4xBFrhq7d1iDn+GT6TyDqTtwT
         3YOsiEfjgQgpJE819ZMZul9iWJ4yE/381sbrBUq+k/CRq67eLqa1pXyeEcJyw4SbhSMd
         q2xtyIh62Jtck5I+u3pvyZE4SDJ9DOJ/GSEp0xVYbTZt9ykM6/MDWUWBpXh2iQvtfnEa
         htYXMreWmmuTcYoQfLybi94cCsKcI+SW3MBrop88BnuWE8F0XOGTZ9V/1h2aUU+5TiLy
         u5N7giYdfccRrm0pRqDx76Zm7LqLPEt07XYt94YFirHE5hO8i0ex0mrKW9+5wJvyjcyO
         VEAA==
X-Gm-Message-State: AGRZ1gKZHaAC+G2bHx4GjI9Cw61ddMae9l6g2i+OrLTHsLvQ7XJ9Z6zx
        sIWB/TKMsMTZnl/K9t9TARDBSA==
X-Google-Smtp-Source: AJdET5dI4UtJSsCWSc4FcShxm38Lobwpp0/+NPC/PgybWYKO5lGtbvrgSs3mQLG160JmlaCn0XDCuA==
X-Received: by 2002:a6b:3b54:: with SMTP id i81-v6mr3642373ioa.133.1539974929039;
        Fri, 19 Oct 2018 11:48:49 -0700 (PDT)
Received: from viisi.dia.dnvr ([67.133.97.101])
        by smtp.gmail.com with ESMTPSA id f9-v6sm7528873iok.25.2018.10.19.11.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:48:48 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-serial@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: add documentation for the SiFive UART driver
Date:   Fri, 19 Oct 2018 11:48:27 -0700
Message-Id: <20181019184827.12351-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181019184827.12351-1-paul.walmsley@sifive.com>
References: <20181019184827.12351-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the Linux driver for the SiFive
asynchronous serial IP block.  Nothing too exotic.

Cc: linux-serial@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
new file mode 100644
index 000000000000..8982338512f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
@@ -0,0 +1,21 @@
+SiFive asynchronous serial interface (UART)
+
+Required properties:
+
+- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
+- reg: address and length of the register space
+- interrupt-parent: should contain a phandle pointing to the SoC interrupt
+    controller device node that the UART interrupts are connected to
+- interrupts: Should contain the UART interrupt identifier
+- clocks: Should contain a clock identifier for the UART's parent clock
+
+
+Example:
+
+uart0: serial@10010000 {
+	compatible = "sifive,uart0";
+	interrupt-parent = <&plic0>;
+	interrupts = <80>;
+	reg = <0x0 0x10010000 0x0 0x1000>;
+	clocks = <&prci PRCI_CLK_TLCLK>;
+};
-- 
2.19.1

