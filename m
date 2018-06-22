Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F57C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6B3249C7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 23:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GmCwYfh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6B3249C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934045AbeFVXVp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 19:21:45 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36446 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbeFVXVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 19:21:17 -0400
Received: by mail-pl0-f68.google.com with SMTP id a7-v6so4140261plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 16:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=RmVnwqJu4yqdbEAPb8IWT5L/4G0BYyAhUPrkzFcI3ys=;
        b=GmCwYfh0eVRzgaNtdjZsY66NFfKR2UPs2IpxOB7qTnaWi35UJxh2+MIjsVq+WPjyAY
         KmXVgskby6PfeSBOBmBTrxMLTjOWguA9WlAlW0AjuPX/iR7k8WnMDVpnPTXABqVAz/9o
         H8eea+ydJ1Yxw5ppb6hpkc/OyqiyESr1l66RDv7q0HTEZixmXc6/cCBWIZFWFy8W/W+l
         7jVW/MCxJp74pOjER7ILcc82pSW5+en6kqfmI2SbblXloWVphEOz92fZIAxWd71cm92H
         NfgUcmxMtICB3diBU/JLoSwtSApE/fy+TN1w+fxyGNpWR87HTBrpNREvsQEaigWZKERA
         gtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=RmVnwqJu4yqdbEAPb8IWT5L/4G0BYyAhUPrkzFcI3ys=;
        b=cvX4ykk0Opq6BSLK/EGNU65WsUNnp3P2l+i1OIq3xFltk+BxyrnQeR188UFBJpnWIz
         tr1lilzvFbZCRlAw1BtQFAE1vI0diFkwj4N5uPIXoRdQ6V2e9K2oU/wTq7JT2qgj9diB
         XMndHk9RI4bxlxu8SPxZ4/mxK0r5AIYSdzcJNH2DwXdtjN+uBZnQW6gswEfuBtib9OxV
         QWxJfcNkFEcHgwfE404H+tckaGFoTX//4M7wTaqKAlvU0gu367P9qCqmQrOnsxZpIDsz
         cq2+J1HEDW45b0O8XjFpkhjwI8McioRXULhonSBCwsN3GNHvAs+OrJEinraGDh6Hwn0j
         Bs3Q==
X-Gm-Message-State: APt69E1HpqNBDIxz45nmGg2eFGXHrjvRBLdPKKkarqLmepNJWnS4B110
        iSd6mmrqVfaIzXZCIeJMJR5NkA==
X-Google-Smtp-Source: ADUXVKLKpbmMdKSI17oTGeZGy/uo1vvmZq3FNSDXO9XDVjhfGlnQHpqo6QCqEHUQBPW3KgsurU1jKg==
X-Received: by 2002:a17:902:b949:: with SMTP id h9-v6mr3448353pls.321.1529709676187;
        Fri, 22 Jun 2018 16:21:16 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id d23-v6sm22104635pfe.2.2018.06.22.16.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 16:21:15 -0700 (PDT)
Subject: [PATCH 2/3] dt-bindings: interrupt-controller: RISC-V local interrupt controller docs
Date:   Fri, 22 Jun 2018 16:20:05 -0700
Message-Id: <20180622232006.12158-3-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180622232006.12158-1-palmer@sifive.com>
References: <20180622232006.12158-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        shorne@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@dabbelt.com>

This patch adds documentation on the RISC-V local interrupt controller,
which is a per-hart interrupt controller that manages all interrupts
entering a RISC-V hart.  This interrupt controller is present on all
RISC-V systems.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 .../interrupt-controller/riscv,cpu-intc.txt        | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
new file mode 100644
index 000000000000..61900e2e3868
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
@@ -0,0 +1,41 @@
+RISC-V Hart-Level Interrupt Controller (HLIC)
+---------------------------------------------
+
+RISC-V cores include Control Status Registers (CSRs) which are local to each
+hart and can be read or written by software. Some of these CSRs are used to
+control local interrupts connected to the core.  Every interrupt is ultimately
+routed through a hart's HLIC before it interrupts that hart.
+
+The RISC-V supervisor ISA manual specifies three interrupt sources that are
+attached to every HLIC: software interrupts, the timer interrupt, and external
+interrupts.  Software interrupts are used to send IPIs between cores.  The
+timer interrupt comes from an architecturally mandated real-time timer that is
+controller via SBI calls and CSR reads.  External interrupts connect all other
+device interrupts to the HLIC, which are routed via the platform-level
+interrupt controller (PLIC).
+
+All RISC-V systems that conform to the supervisor ISA specification are
+required to have a HLIC with these three interrupt sources present.  Since the
+interrupt map is defined by the ISA it's not listed in the HLIC's device tree
+entry, though external interrupt controllers (like the PLIC, for example) will
+need to define how their interrupts map to the relevant HLICs.
+
+Required properties:
+- compatible : "riscv,cpu-intc"
+- #interrupt-cells : should be <1>
+- interrupt-controller : Identifies the node as an interrupt controller
+
+Furthermore, this interrupt-controller MUST be embedded inside the cpu
+definition of the hart whose CSRs control these local interrupts.
+
+An example device tree entry for a HLIC is show below.
+
+	cpu1: cpu@1 {
+		compatible = "riscv";
+		...
+		cpu1-intc: interrupt-controller {
+			#interrupt-cells = <1>;
+			compatible = "riscv,cpu-intc";
+			interrupt-controller;
+		};
+	};
-- 
2.16.4

