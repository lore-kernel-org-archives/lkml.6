Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC819C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2FF20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 03:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF2FF20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbeLCDpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 22:45:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725811AbeLCDpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 22:45:42 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 11C91C004C5E6;
        Mon,  3 Dec 2018 11:45:37 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 11:45:28 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>
Subject: [PATCH v1 00/12] Add support for usb on Hikey960
Date:   Mon, 3 Dec 2018 11:45:03 +0800
Message-ID: <20181203034515.91412-1-chenyu56@huawei.com>
X-Mailer: git-send-email 2.15.0-rc2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.113.134]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds support for usb functionality of Hikey960, includes:
- dwc3 driver for Hisilicon Kirin Soc hi3660
- usb driver for HiKey960 board
- some adjustment in dwc3, usb gadget and typec driver
- dts for support usb of HiKey960

Yu Chen (12):
  dt-bindings: usb: add support for dwc3 controller on HiSilicon SoCs
  dt-bindings: phy: Add support for HiSilicon's hi3660 USB PHY
  dt-bindings: misc: Add bindings for HiSilicon usb hub and data role
    switch functionality on HiKey960
  usb: dwc3: dwc3-hisi: Add code for dwc3 of Hisilicon Soc Platform
  usb: dwc3: Add two quirks for Hisilicon Kirin Soc Platform
  phy: Add usb phy support for hi3660 Soc of Hisilicon
  usb: roles: Find the usb role switch by also matching against the
    device node
  usb: roles: Add usb role switch notifier.
  usb: dwc3: Registering a role switch in the DRD code.
  hikey960: Support usb functionality of Hikey960
  usb: gadget: Add configfs attribuite for controling
    match_existing_only
  dts: hi3660: Add support for usb on Hikey960

 .../bindings/misc/hisilicon-hikey-usb.txt          |  36 +++
 .../devicetree/bindings/phy/phy-hi3660-usb3.txt    |  21 ++
 .../devicetree/bindings/usb/dwc3-hisi.txt          |  67 +++++
 MAINTAINERS                                        |  10 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |  56 ++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  72 +++++
 drivers/misc/Kconfig                               |   7 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/hisi_hikey_usb.c                      | 198 ++++++++++++
 drivers/phy/hisilicon/Kconfig                      |  10 +
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-hi3660-usb3.c            | 237 +++++++++++++++
 drivers/usb/common/roles.c                         |  60 +++-
 drivers/usb/dwc3/Kconfig                           |   8 +
 drivers/usb/dwc3/Makefile                          |   1 +
 drivers/usb/dwc3/core.c                            |  43 +++
 drivers/usb/dwc3/core.h                            |   9 +
 drivers/usb/dwc3/drd.c                             |  49 +++
 drivers/usb/dwc3/dwc3-hisi.c                       | 335 +++++++++++++++++++++
 drivers/usb/dwc3/gadget.c                          |   2 +-
 drivers/usb/gadget/configfs.c                      |  32 ++
 include/linux/usb/role.h                           |  46 +++
 22 files changed, 1299 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
 create mode 100644 Documentation/devicetree/bindings/usb/dwc3-hisi.txt
 create mode 100644 drivers/misc/hisi_hikey_usb.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c
 create mode 100644 drivers/usb/dwc3/dwc3-hisi.c

-- 
2.15.0-rc2

