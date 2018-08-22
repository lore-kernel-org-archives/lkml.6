Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329FEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF30C20C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 03:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF30C20C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbeHVHNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 03:13:35 -0400
Received: from mx.socionext.com ([202.248.49.38]:43973 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHVHNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 03:13:35 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 22 Aug 2018 12:50:35 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 10CAA600AA;
        Wed, 22 Aug 2018 12:50:35 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 22 Aug 2018 12:50:34 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 627761A04D8;
        Wed, 22 Aug 2018 12:50:34 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH v3 0/4] phy: socionext: add new UniPhier USB PHY driver support
Date:   Wed, 22 Aug 2018 12:50:30 +0900
Message-Id: <1534909834-16754-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for PHY interface built into USB controller
implemented in Socionext UniPhier SoCs.

The USB3 PHY driver supports High-Speed PHY and Super-Speed PHY included in
the USB3 glue layer, and the USB2 PHY driver supports High-Speed PHY
integrated into system controller.

Changes since v2:
- rewrite a header with style that other phy drivers use
- replace return value of probe functions with PTR_ERR_OR_ZERO()
- fix typo of register offset macros

Changes since v1:
- rewrite a header with C++ comment style
- dt-bindings: separate a document for ssphy and hsphy
- dt-bindings: sort clock-names and reset-names to begin with "phy"
- dt-bindings: use vbus-supply instead of phy-supply, because vbus isn't
  for phy, but vbus is tied to the port that corresponds to each phy [1]
- stop using phy_power and add own .power_on and .power_off functions
  to control clk/reset for phy and vbus regulator
- separate clk_get() and reset_control_get() for each clk/reset
  and remove arrays of clock_names and reset_names
- remove phy-parameters that are the same as power-on values
- remove functions to set phy-parameters for legacy SoCs
- express phy-parameters by using macros including the number of
  the register and its bitfield (msb and lsb)

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593279.html

Kunihiko Hayashi (4):
  dt-bindings: phy: add DT bindings for UniPhier USB3 PHY driver
  phy: socionext: add USB3 PHY driver for UniPhier SoC
  dt-bindings: phy: add DT bindings for UniPhier USB2 PHY driver
  phy: socionext: add USB2 PHY driver for UniPhier SoC

 .../devicetree/bindings/phy/uniphier-usb2-phy.txt  |  45 +++
 .../bindings/phy/uniphier-usb3-hsphy.txt           |  69 ++++
 .../bindings/phy/uniphier-usb3-ssphy.txt           |  57 +++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/socionext/Kconfig                      |  25 ++
 drivers/phy/socionext/Makefile                     |   7 +
 drivers/phy/socionext/phy-uniphier-usb2.c          | 244 ++++++++++++
 drivers/phy/socionext/phy-uniphier-usb3hs.c        | 422 +++++++++++++++++++++
 drivers/phy/socionext/phy-uniphier-usb3ss.c        | 349 +++++++++++++++++
 10 files changed, 1220 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-hsphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-usb3-ssphy.txt
 create mode 100644 drivers/phy/socionext/Kconfig
 create mode 100644 drivers/phy/socionext/Makefile
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb2.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3hs.c
 create mode 100644 drivers/phy/socionext/phy-uniphier-usb3ss.c

-- 
2.7.4

