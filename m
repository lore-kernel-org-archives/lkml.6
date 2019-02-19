Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2316CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02E421738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfBSPzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:55:22 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:56594 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbfBSPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:55:22 -0500
X-IronPort-AV: E=Sophos;i="5.58,388,1544454000"; 
   d="scan'208";a="8079557"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Feb 2019 00:55:20 +0900
Received: from vbox.ree.adwin.renesas.com (unknown [10.226.37.67])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A92D2409EDE3;
        Wed, 20 Feb 2019 00:55:17 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] irqchip: Add support for Renesas RZ/N1 GPIO interrupt multiplexer
Date:   Tue, 19 Feb 2019 15:55:09 +0000
Message-Id: <20190219155511.28507-1-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RZ/N1 devices, there are lots of GPIO interrupts that are multiplexed before
getting to the GIC interrupt controller. Other than the multiplexing, there is
no other logic applied to the signals.

The multiplexing cannot be handled dynamically because there is another CPU that
runs firmware. It's likely that the firmware will use some of these GPIO
interrupts and so we don't want them to move around.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v4:
 - Fix DT binding nits
v3:
 - Use 'interrupt-map' DT property to map the interrupts, this is very similar
   to PCIe MSI. The only difference is that we need to get hold of the interrupt
   specifier for the interupts coming into the irqmux.
   I had completely messed up the use of 'interrupt-map' in v2... oops.
 - Do not use a chained interrupt controller.
v2:
 - Split DT bindings into separate patch.
 - Use interrupt-map to allow the GPIO controller info to be specified
   as part of the irq.
 - Don't show status in binding examples.
 - Don't show the soc/board split in binding doc.
 - Renamed struct and funcs from 'girq' to a more comprehenisble 'irqmux'.

Phil Edworthy (2):
  dt-bindings/interrupt-controller: rzn1: Add RZ/N1 gpio irq mux binding
  irqchip: Add support for Renesas RZ/N1 GPIO interrupt multiplexer

 .../interrupt-controller/renesas,rzn1-mux.txt |  73 +++++++
 drivers/irqchip/Kconfig                       |   9 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/rzn1-irq-mux.c                | 205 ++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/renesas,rzn1-mux.txt
 create mode 100644 drivers/irqchip/rzn1-irq-mux.c

-- 
2.17.1

