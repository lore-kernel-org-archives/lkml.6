Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A894C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA0AF2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 09:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pmDkVcUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0AF2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeGYKsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 06:48:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbeGYKsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 06:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zw790fIsPJb4zF8WntNv/1o2cuZq1bliXkE2Dn8ZPGs=; b=pmDkVcUHyN/cvT8kZYE8+oel9
        ZZuoKobFEvq6MfMO9999RxoR+gbhrlnIkOQRsNjVTxm/No9b1QclLLOlAo9kfP70HEhM0LftM1PvX
        qwhlUwAY4icW9avGjVqSdIeuRk8rnoyN/Hr6SQhrvfQrtwwOyZ+hHpgMlbksYxXNRK6At8WiimJ2X
        oP29p2kjDyX398Ih+vs969C+Afj3ED2u0YIEOoQNmHpP5CeKvoVCilaBYm2QSg8USeeg+pv39Qzpx
        RviaNO1GBpdljEdavLKib8i9ohKn3r0FXZnAfe6hNSkHGsBRVe1TpgGv3qsuubXpRZIi0NPEiGHHT
        6fMXj+kQw==;
Received: from [91.112.108.175] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fiGEK-0005MZ-2f; Wed, 25 Jul 2018 09:37:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 6/6] dt-bindings: interrupt-controller: RISC-V PLIC documentation
Date:   Wed, 25 Jul 2018 11:36:49 +0200
Message-Id: <20180725093649.32332-7-hch@lst.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725093649.32332-1-hch@lst.de>
References: <20180725093649.32332-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

This patch adds documentation for the platform-level interrupt
controller (PLIC) found in all RISC-V systems.  This interrupt
controller routes interrupts from all the devices in the system to each
hart-local interrupt controller.

Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
want to change how we're specifying holes in the hart list.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 .../interrupt-controller/riscv,plic0.txt      | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
new file mode 100644
index 000000000000..99cd359dbd43
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
@@ -0,0 +1,55 @@
+RISC-V Platform-Level Interrupt Controller (PLIC)
+-------------------------------------------------
+
+The RISC-V supervisor ISA specification allows for the presence of a
+platform-level interrupt controller (PLIC).   The PLIC connects all external
+interrupts in the system to all hart contexts in the system, via the external
+interrupt source in each hart's hart-local interrupt controller (HLIC).  A hart
+context is a privilege mode in a hardware execution thread.  For example, in
+an 4 core system with 2-way SMT, you have 8 harts and probably at least two
+privilege modes per hart; machine mode and supervisor mode.
+
+Each interrupt can be enabled on per-context basis. Any context can claim
+a pending enabled interrupt and then release it once it has been handled.
+
+Each interrupt has a configurable priority. Higher priority interrupts are
+serviced firs. Each context can specify a priority threshold. Interrupts
+with priority below this threshold will not cause the PLIC to raise its
+interrupt line leading to the context.
+
+While the PLIC supports both edge-triggered and level-triggered interrupts,
+interrupt handlers are oblivious to this distinction and therefor it is not
+specific in the PLIC device-tree binding.
+
+While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
+"riscv,plic0" device is a concrete implementation of the PLIC that contains a
+specific memory layout.  More details about the memory layout of the
+"riscv,plic0" device can be found as a comment in the device driver, or as part
+of the SiFive U5 Coreplex Series Manual (page 22 of the PDF of version 1.0)
+<https://www.sifive.com/documentation/coreplex/u5-coreplex-series-manual/>
+
+Required properties:
+- compatible : "riscv,plic0"
+- #address-cells : should be <0>
+- #interrupt-cells : should be <1>
+- interrupt-controller : Identifies the node as an interrupt controller
+- reg : Should contain 1 register range (address and length)
+- interrupts-extended : Specifies which contexts are connected to the PLIC,
+  with "-1" specifying that a context is not present.
+
+Example:
+
+	plic: interrupt-controller@c000000 {
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		compatible = "riscv,plic0";
+		interrupt-controller;
+		interrupts-extended = <
+			&cpu0-intc 11
+			&cpu1-intc 11 &cpu1-intc 9
+			&cpu2-intc 11 &cpu2-intc 9
+			&cpu3-intc 11 &cpu3-intc 9
+			&cpu4-intc 11 &cpu4-intc 9>;
+		reg = <0xc000000 0x4000000>;
+		riscv,ndev = <10>;
+	};
-- 
2.18.0

