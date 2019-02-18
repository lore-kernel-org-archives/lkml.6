Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DEFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB106217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 11:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfBRLXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 06:23:24 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729204AbfBRLXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 06:23:24 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A8477506E0C8F3DAD926;
        Mon, 18 Feb 2019 19:23:21 +0800 (CST)
Received: from vm100-107-113-134.huawei.com (100.107.113.134) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Feb 2019 19:23:15 +0800
From:   Yu Chen <chenyu56@huawei.com>
To:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.stultz@linaro.org>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>, <liuyu712@hisilicon.com>,
        <wanghu17@hisilicon.com>, <butao@hisilicon.com>,
        <chenyao11@huawei.com>, <fangshengzhou@hisilicon.com>,
        <lipengcheng8@huawei.com>, <songxiaowei@hisilicon.com>,
        <xuyiping@hisilicon.com>, <xuyoujun4@huawei.com>,
        <yudongbin@hisilicon.com>, <zangleigang@hisilicon.com>,
        Yu Chen <chenyu56@huawei.com>
Subject: [PATCH v2 00/10] Add support for usb on Hikey960
Date:   Mon, 18 Feb 2019 19:23:00 +0800
Message-ID: <20190218112310.17860-1-chenyu56@huawei.com>
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

---
v2:
* This patchset based on patchset https://lkml.org/lkml/2019/1/25/344
of Heikki Krogerus
---

Yu Chen (10):
  dt-bindings: phy: Add support for HiSilicon's hi3660 USB PHY
  dt-bindings: misc: Add bindings for HiSilicon usb hub and data role
    switch functionality on HiKey960
  usb: dwc3: dwc3-of-simple: Add support for dwc3 of Hisilicon Soc
    Platform
  usb: dwc3: Add two quirks for Hisilicon Kirin Soc Platform
  phy: Add usb phy support for hi3660 Soc of Hisilicon
  usb: roles: Add usb role switch notifier.
  usb: dwc3: Registering a role switch in the DRD code.
  hikey960: Support usb functionality of Hikey960
  usb: gadget: Add configfs attribuite for controling
    match_existing_only
  dts: hi3660: Add support for usb on Hikey960

 .../bindings/misc/hisilicon-hikey-usb.txt          |  35 ++++
 .../devicetree/bindings/phy/phy-hi3660-usb3.txt    |  21 ++
 MAINTAINERS                                        |   8 +
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |  54 +++++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  73 +++++++
 drivers/misc/Kconfig                               |   6 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/hisi_hikey_usb.c                      | 181 ++++++++++++++++
 drivers/phy/hisilicon/Kconfig                      |  10 +
 drivers/phy/hisilicon/Makefile                     |   1 +
 drivers/phy/hisilicon/phy-hi3660-usb3.c            | 232 +++++++++++++++++++++
 drivers/usb/dwc3/core.c                            |  43 ++++
 drivers/usb/dwc3/core.h                            |   9 +
 drivers/usb/dwc3/drd.c                             |  45 ++++
 drivers/usb/dwc3/dwc3-of-simple.c                  |   4 +-
 drivers/usb/dwc3/gadget.c                          |   2 +-
 drivers/usb/gadget/configfs.c                      |  32 +++
 drivers/usb/roles/class.c                          |  20 +-
 include/linux/usb/role.h                           |  46 ++++
 19 files changed, 820 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
 create mode 100644 drivers/misc/hisi_hikey_usb.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c

-- 
2.15.0-rc2

