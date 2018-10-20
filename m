Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579E7C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F69E2150F
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 10:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UQ/ifgKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F69E2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJTSWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 14:22:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45626 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbeJTSWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 14:22:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id f17-v6so8107126wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wASbXyBYFMcRIkQoK4CDFHurMQnCI3R8vyfKJiCMxpo=;
        b=UQ/ifgKTmwDizP/mPww3MG4vreiMpQ8AIMKtieTEAr/e5NNsOKHszM+NRRM5OWqRsR
         qd7ENY4cc1KqZyzybNUHmPRaqI6hA4icH9yhk/XO/ZBZfrz6kYQx9AeN67iH+tBwv+FU
         V0RC56nui14BWbtNn9eSkTrSwa54zWoy1tp6eRuJzqVI59aqjD/I6MaLS8bPm9LHklNb
         skVlnVaiuJ1Oprg0CLRSONC3L12mEW3lgYXtpwuxPX+grGwr2ieMHUVwhx2wbVa9g+Ao
         vDpf340Npqsz22uc4wCjnpaa2VXxa05BQcbbC5DP5C0sUQg5fjAOPqw/un60bBBRGGwc
         h83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wASbXyBYFMcRIkQoK4CDFHurMQnCI3R8vyfKJiCMxpo=;
        b=E7lI662cN+sxJlCuhpaVsT32frCsJ+C5BeFXd9qeWddUfgd2UFlZO9J82KJY6pyerU
         aJwasqOR/O3amCC2IWD9ZNpNb8REo+7QvXx33DwWkxL2fQ9TciicYBLPEdMVs8yH9c5L
         H+WqzGbKzRiuU0U6CdYEijOqFpuSn2JLWn0nCa5+gATChAlQ0NSlZeZmY7ZdIqjgjsXx
         ULSSriF2i+UBw7QUTG1vVmQ499m1/uLhdxXNR59dZNTfnRINNMLMH6K4Wxqp7U4DXUwS
         rftqBk/Z75g52D+tHFy6MOu8NbCX/Wh3dzDFdZZsbTZzEvSXu9zmtbWdspqLQf4UWoGo
         0tbA==
X-Gm-Message-State: ABuFfohuF+qP80VjiIr33kwL8QfHdC+O70M0HTQyxwP7KGR6ohz2vLYk
        HQmUUzUDmetj15/u3ELUY+AEwQ==
X-Google-Smtp-Source: ACcGV61ZRzN6qFa7EQQvAdvDjUdCAOdb5iqDYDLhqLEJ6Z8ehDOvwiwg5DMGbTi4qEM7MxgN/YkMEg==
X-Received: by 2002:a05:6000:1284:: with SMTP id f4mr16331584wrx.140.1540030337812;
        Sat, 20 Oct 2018 03:12:17 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id 2-v6sm23773438wro.96.2018.10.20.03.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 03:12:17 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: serial: add documentation for the SiFive UART driver
Date:   Sat, 20 Oct 2018 03:10:46 -0700
Message-Id: <20181020101045.15991-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181020101045.15991-1-paul.walmsley@sifive.com>
References: <20181020101045.15991-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for the Linux driver for the SiFive
asynchronous serial IP block.

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
v3: update description and example for compatible strings, per
    discussion with Rob Herring.

 .../bindings/serial/sifive-serial.txt         | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
new file mode 100644
index 000000000000..a426b18ba049
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
@@ -0,0 +1,33 @@
+SiFive asynchronous serial interface (UART)
+
+Required properties:
+
+- compatible: should be something similar to
+	      "sifive,<chip>-uart<version>" for the UART as integrated
+	      on a particular chip, and "sifive,uart<version>" for the
+	      general UART IP block programming model.	Supported
+	      compatible strings as of the date of this writing are:
+	      "sifive,fu540-c000-uart0" for the SiFive UART v0 as
+	      integrated onto the SiFive FU540 chip, or "sifive,uart0"
+	      for the SiFive UART v0 IP block with no chip integration
+	      tweaks (if any)
+- reg: address and length of the register space
+- interrupts: Should contain the UART interrupt identifier
+- clocks: Should contain a clock identifier for the UART's parent clock
+
+
+UART RTL that corresponds to the IP block version numbers can be found
+here:
+
+https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
+
+
+Example:
+
+uart0: serial@10010000 {
+	compatible = "sifive,fu540-c000-uart0", "sifive,uart0";
+	interrupt-parent = <&plic0>;
+	interrupts = <80>;
+	reg = <0x0 0x10010000 0x0 0x1000>;
+	clocks = <&prci PRCI_CLK_TLCLK>;
+};
-- 
2.19.1

