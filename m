Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BEFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E93B2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E93B2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeKZU6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 15:58:04 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:45786 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZU6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 15:58:04 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 433Mvp63zgz1r0gc;
        Mon, 26 Nov 2018 11:04:22 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 433Mvn70mxz1qrnD;
        Mon, 26 Nov 2018 11:04:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id o4M988OONLLE; Mon, 26 Nov 2018 11:04:19 +0100 (CET)
X-Auth-Info: GFw8rKSdpbRcbWIH92I8BHAB1iLGsqN4VfwyPHTvRxA=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 26 Nov 2018 11:04:19 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        manivannan.sadhasivam@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, thomas.liau@actions-semi.com,
        mp-cs@actions-semi.com, linux@cubietech.com,
        edgar.righi@lsitec.org.br, laisa.costa@lsitec.org.br,
        guilherme.simoes@lsitec.org.br, mkzuffo@lsi.usp.br,
        Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v3 0/4] Add Actions Semi Owl family sirq support
Date:   Mon, 26 Nov 2018 11:03:52 +0100
Message-Id: <20181126100356.2840578-1-pn@denx.de>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support for external interrupt controller
in Actions Semi Owl famil of SoC's (S500, S700 and S900). Actions
provides support for external interrupt controller to be connected
with it's SoC's using 3 SIRQ pins.

Each line can be configures independently, i.e 3 independent external
interrupt controller can be connected and managed parallely.

Device tree node is created only for S700 after testing it in Cubieboard7.

Changelog in v3:
- Set default operating frequency to 24MHz
- Falling edge and Low Level interrupts translated to rising edge and high level
- Introduced common function with lock handling for register read and write
- Used direct GIC interrupt number for interrupt local hwirq and finding offset
using DT entry (range) when registers are shared 
- Changed irq_ack to irq_eoi
- Added translation method for irq_domain_ops
- Clearing interrupt pending based on bitmask for edge triggered
- Added pinctrl definition for sirq for cubieboard7. This depends on,
https://lore.kernel.org/patchwork/patch/1012859/

Changelog in v2:
- Added SIRQ as hierarchical chip
        GIC <----> SIRQ <----> External interrupt controller/Child devices
- Device binding updates with vendor prefix
- Register sharing handled globally and common init sequence/data for all
actions SoC family

Thanks,
Parthiban
Saravanan

Parthiban Nallathambi (4):
  dt-bindings: interrupt-controller: Actions external interrupt
    controller
  drivers/irqchip: Add Actions external interrupts support
  arm64: dts: actions: Add sirq node for Actions Semi S700
  arm64: dts: actions: s700-cubieboard7: Enable SIRQ

 .../interrupt-controller/actions,owl-sirq.txt |  57 ++++
 .../boot/dts/actions/s700-cubieboard7.dts     |  19 ++
 arch/arm64/boot/dts/actions/s700.dtsi         |  10 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-owl-sirq.c                | 301 ++++++++++++++++++
 5 files changed, 388 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
 create mode 100644 drivers/irqchip/irq-owl-sirq.c

-- 
2.17.2

