Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDC2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E9D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfAQHQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:16:23 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:65333 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725933AbfAQHQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:16:23 -0500
X-UUID: 75ea166cd8b9438d965e0dbf06146572-20190117
X-UUID: 75ea166cd8b9438d965e0dbf06146572-20190117
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1103988965; Thu, 17 Jan 2019 15:16:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 15:16:11 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 17 Jan 2019 15:16:11 +0800
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
Subject: [PATCH v3 0/4] Add MediaTek MUSB Controller Driver
Date:   Thu, 17 Jan 2019 15:15:44 +0800
Message-ID: <1547709348-17506-1-git-send-email-min.guo@mediatek.com>
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
changes of dt-bindings suggested by Rob:
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

Min Guo (4):
  dt-bindings: usb: musb: Add support for MediaTek musb controller
  arm: dts: mt2701: Add usb2 device nodes
  usb: musb: Delete the const attribute of addr parameter in readb/w/l
    hooks
  usb: musb: Add support for MediaTek musb controller

 .../devicetree/bindings/usb/mediatek,musb.txt      |  43 ++
 arch/arm/boot/dts/mt2701-evb.dts                   |  21 +
 arch/arm/boot/dts/mt2701.dtsi                      |  33 ++
 drivers/usb/musb/Kconfig                           |   8 +-
 drivers/usb/musb/Makefile                          |   1 +
 drivers/usb/musb/mediatek.c                        | 624 +++++++++++++++++++++
 drivers/usb/musb/musb_core.c                       |  74 ++-
 drivers/usb/musb/musb_core.h                       |  13 +-
 drivers/usb/musb/musb_dma.h                        |   9 +
 drivers/usb/musb/musb_host.c                       |  46 +-
 drivers/usb/musb/musb_io.h                         |  12 +-
 drivers/usb/musb/musbhsdma.c                       |  57 +-
 drivers/usb/musb/sunxi.c                           |   4 +-
 drivers/usb/musb/tusb6010.c                        |   2 +-
 14 files changed, 876 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt
 create mode 100644 drivers/usb/musb/mediatek.c

-- 
1.9.1

