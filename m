Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C38C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B6E216E5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B6E216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeHHHn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:43:27 -0400
Received: from mx.socionext.com ([202.248.49.38]:4065 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726538AbeHHHn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:43:27 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Aug 2018 14:25:33 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 5C04B18015C;
        Wed,  8 Aug 2018 14:25:33 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 8 Aug 2018 14:25:33 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id E437540372;
        Wed,  8 Aug 2018 14:25:32 +0900 (JST)
Received: from aegis.e01.socionext.com (unknown [10.213.134.210])
        by yuzu.css.socionext.com (Postfix) with ESMTP id BC548120415;
        Wed,  8 Aug 2018 14:25:32 +0900 (JST)
From:   Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 0/7] add UniPhier DVB Frontend system support
Date:   Wed,  8 Aug 2018 14:25:12 +0900
Message-Id: <20180808052519.14528-1-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for DVB Frontend system named HSC support
for UniPhier LD11/LD20 SoCs. This driver supports MPEG2-TS serial
signal input from external demodulator and DMA MPEG2-TS stream data
onto memory.

UniPhier HSC driver provides many ports of TS input. Since the HSC
has mixed register map for those ports. It hard to split each register
areas.

---

Changes from v1:
  DT bindings
    - Fix mistakes of spelling
    - Rename uniphier,hsc.txt -> socionext,uniphier-hsc.txt
  Kconfig, Makefile
    - Add COMPILE_TEST, REGMAP_MMIO
    - Add $(srctree) to include path option
  Headers
    - Split large patch
    - Remove more unused definitions
    - Remove unneeded const
    - Replace enum that has special value into #define
    - Remove weird macro from register definitions
    - Remove field_get/prop inline functions
  Modules
    - Split register definitions, function prototypes
    - Fix include lines
    - Fix depended config
    - Remove redundant conditions
    - Drop adapter patches, and need no patches to build
    - Merge uniphier-adapter.o into each adapter drivers
    - Split 3 modules (core, ld11, ld20) to build adapter drivers as
      module
    - Fix compile error if build as module
    - Use hardware spec table to remove weird macro from register
      definitions
    - Use usleep_range instead of msleep
    - Use shift and mask instead of field_get/prop inline functions

Katsuhiro Suzuki (7):
  media: uniphier: add DT bindings documentation for UniPhier HSC
  media: uniphier: add DMA common file of HSC
  media: uniphier: add CSS common file of HSC
  media: uniphier: add TS common file of HSC
  media: uniphier: add ucode load common file of HSC
  media: uniphier: add platform driver module of HSC
  media: uniphier: add LD11/LD20 HSC support

 .../bindings/media/socionext,uniphier-hsc.txt |  38 ++
 drivers/media/platform/Kconfig                |   1 +
 drivers/media/platform/Makefile               |   2 +
 drivers/media/platform/uniphier/Kconfig       |  19 +
 drivers/media/platform/uniphier/Makefile      |   5 +
 drivers/media/platform/uniphier/hsc-core.c    | 515 ++++++++++++++++++
 drivers/media/platform/uniphier/hsc-css.c     | 250 +++++++++
 drivers/media/platform/uniphier/hsc-dma.c     | 212 +++++++
 drivers/media/platform/uniphier/hsc-ld11.c    | 273 ++++++++++
 drivers/media/platform/uniphier/hsc-reg.h     | 272 +++++++++
 drivers/media/platform/uniphier/hsc-ts.c      | 127 +++++
 drivers/media/platform/uniphier/hsc-ucode.c   | 416 ++++++++++++++
 drivers/media/platform/uniphier/hsc.h         | 389 +++++++++++++
 13 files changed, 2519 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/socionext,uniphier-hsc.txt
 create mode 100644 drivers/media/platform/uniphier/Kconfig
 create mode 100644 drivers/media/platform/uniphier/Makefile
 create mode 100644 drivers/media/platform/uniphier/hsc-core.c
 create mode 100644 drivers/media/platform/uniphier/hsc-css.c
 create mode 100644 drivers/media/platform/uniphier/hsc-dma.c
 create mode 100644 drivers/media/platform/uniphier/hsc-ld11.c
 create mode 100644 drivers/media/platform/uniphier/hsc-reg.h
 create mode 100644 drivers/media/platform/uniphier/hsc-ts.c
 create mode 100644 drivers/media/platform/uniphier/hsc-ucode.c
 create mode 100644 drivers/media/platform/uniphier/hsc.h

-- 
2.18.0

