Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7865C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ABD21905
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfBSHhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:37:03 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25914 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbfBSHhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:37:02 -0500
X-UUID: 9bc7872c9eaa49fa83b488c8fce383d1-20190219
X-UUID: 9bc7872c9eaa49fa83b488c8fce383d1-20190219
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1334746906; Tue, 19 Feb 2019 15:36:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 15:36:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 15:36:52 +0800
From:   <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <tony@atomide.com>,
        <hdegoede@redhat.com>, Min Guo <min.guo@mediatek.com>
Subject: [PATCH v5 0/6] Add MediaTek MUSB Controller Driver
Date:   Tue, 19 Feb 2019 15:36:29 +0800
Message-ID: <1550561795-31132-1-git-send-email-min.guo@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min Guo <min.guo@mediatek.com>

These patches introduce the MediaTek MUSB controller driver.

The driver can be configured as Dual-Role Device (DRD),
Peripheral Only and Host Only modes. This has beed tested on
MT2701 with a variety of devices in host mode and with the 
f_mass gadget driver in peripheral mode, plugging otg cables
in/out a lot of times in all possible imaginable plug orders.

changes in v5:
changes of dt-bindings suggested by Rob:
1. Modify compatible as 
- compatible : should be one of:
               "mediatek,mt-2701"
               ...
               followed by "mediatek,mtk-musb"
2. Add usb connector child node
changes of DTS:
1. Add usb connector child node
changes of driver suggested by Bin:
1. Replace musb_readb() with musb_clearb() to clear dma pending interrupts
2. Replace musb_readb() with musb_clearb() to clear common/tx/rx pending interrupts
3. Make musb_clearb/w() return the value of musb_readb/w()

changes in v4:
changes of dt-bindings suggested by Sergei:
1. String alignment
changes of driver suggested by Tony and Bin:
1. Add a new patch for set/get_toggle()
2. Add a new patch for noirq type of dma
3. Add a new patch musb_clearb/w()
4. Abondon patch "usb: musb: Delete the const attribute of addr parameter in readb/w/l hooks"

changes in v3:
changes of driver suggested by Bin:
1. Add a new patch for musb_readb/w/l() to remove const attribute 
2. Use is_out as function parameter in set_toggle/get_toggle() hooks
3. Remove 'u8/u16 data' parameter in clearb/w() hooks
4. Remove musb_default_clearb/w()
5. Replace musb_readb/w() with musb_clearb/w() to clear pending interrupts 
6. Add comments to clearb/w() hooks
7. Replace musb_save_toggle() with musb->io.get_toggle()
8. Replace musb_set_toggle() with musb->io.set_toggle()

changes in v2:
changes of dt-bindings suggested by Rob and Bin:
1. Modify DRC to DRD
2. Drop the "<soc-model>-musb" in compatible
3. Remove phy-names
4. Add space after comma in clock-names
dtsi:
1. Remove phy-names
changes of driver suggested by Bin:
1. Add a new patch for musb_set_toggle
2. Add summarize of MediaTek musb controller differences in the commit log
3. Abondon patch "usb: musb: Move musbhsdma macro definition to musb_dma.h"
4. Add "|| COMPILE_TEST" in Kconfig
5. Add musb_clearb() and musb_clearw() hooks
6. Add get_toggle() and set_toggle() hooks
7. Replace musb_readl() with musb_readw() to read 16bit toggle register
8. Move MediaTek's private toggle registers from musb_regs.h to mediatek.c
9. Create musbhs_dma_controller_create_noirq()

Min Guo (6):
  dt-bindings: usb: musb: Add support for MediaTek musb controller
  arm: dts: mt2701: Add usb2 device nodes
  usb: musb: Add get/set toggle hooks
  usb: musb: Add noirq type of dma create interface
  usb: musb: Add musb_clearb/w() interface
  usb: musb: Add support for MediaTek musb controller

 .../devicetree/bindings/usb/mediatek,musb.txt      |  54 ++
 arch/arm/boot/dts/mt2701-evb.dts                   |  26 +
 arch/arm/boot/dts/mt2701.dtsi                      |  33 ++
 drivers/usb/musb/Kconfig                           |   8 +-
 drivers/usb/musb/Makefile                          |   1 +
 drivers/usb/musb/mediatek.c                        | 629 +++++++++++++++++++++
 drivers/usb/musb/musb_core.c                       |  74 ++-
 drivers/usb/musb/musb_core.h                       |  13 +-
 drivers/usb/musb/musb_dma.h                        |   9 +
 drivers/usb/musb/musb_host.c                       |  46 +-
 drivers/usb/musb/musb_io.h                         |  12 +-
 drivers/usb/musb/musbhsdma.c                       |  56 +-
 drivers/usb/musb/sunxi.c                           |   4 +-
 drivers/usb/musb/tusb6010.c                        |   2 +-
 14 files changed, 895 insertions(+), 72 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
 create mode 100644 drivers/usb/musb/mediatek.c

-- 
1.9.1

