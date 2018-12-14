Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269EAC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C082133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C082133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbeLNKWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:22:50 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33611 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbeLNKWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:22:50 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gXkcH-000837-CX; Fri, 14 Dec 2018 11:22:45 +0100
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH v2 0/2] imx-irqsteer for real
Date:   Fri, 14 Dec 2018 11:22:42 +0100
Message-Id: <20181214102244.21509-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is a completely reworked submission of the imx-irqsteer driver. The
first version was bugged due to wrong/misleading documentation and buggy
implementation of the downstream driver that only worked correctly with
a very specific DT configuration.

The key information here is that a given SoC can have multiple instances
of the irqsteer controller, which can be connected to mutiple output IRQ
lines, but all the input IRQs to one instance are exclusively steered to
one of the output IRQs (which is called a channel). So it's a flexible
hardware design, were each irqsteer instance needs to be told which
upstream IRQ it should use, instead of this being fixed at SoC design
time.

Also the controller is configurable in the number of input IRQs supported,
but only in groups of 64 IRQs, which has an influence on the register
layout, as status, mask and force registers are packed together. Currently
existing implementations of the irqsteer block have between 1 and 8 IRQ
groups, which the documentation confusingly also calls a channel.

Also there is no per-groups status indication, but only a global status
bit, so the IRQ handling can not be optimized, but all status registers
must be checked.

After figuring out all those bits, the driver turned out to be pretty
simple.

Regards,
Lucas

Lucas Stach (2):
  dt-bindings: irq: add binding for Freescale IRQSTEER multiplexer
  irqchip: add driver for imx-irqsteer controller

 .../interrupt-controller/fsl,irqsteer.txt     |  34 +++
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-imx-irqsteer.c            | 269 ++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,irqsteer.txt
 create mode 100644 drivers/irqchip/irq-imx-irqsteer.c

-- 
2.19.1

