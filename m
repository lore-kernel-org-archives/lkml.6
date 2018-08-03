Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7DEC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6DF216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 07:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=iluvatar.ai header.i=@iluvatar.ai header.b="gb46SPN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6DF216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iluvatar.ai
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeHCJQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 05:16:16 -0400
Received: from mail.iluvatar.ai ([58.213.90.100]:56390 "EHLO mail.iluvatar.ai"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbeHCJQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 05:16:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 160A013C8D162;
        Fri,  3 Aug 2018 15:24:46 +0800 (CST)
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6ctxhGaTBqGd; Fri,  3 Aug 2018 15:24:45 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by mail.iluvatar.ai (Postfix) with ESMTP id 7D0B613ED1C86;
        Fri,  3 Aug 2018 15:24:45 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.iluvatar.ai 7D0B613ED1C86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iluvatar.ai;
        s=809B2F8E-810B-11E8-86FD-A0A654EEFFEB; t=1533281085;
        bh=U4m86qea4iJOaO5k/BmZRVgFVoLy61hQ9icocjhhoLo=;
        h=From:To:Subject:Date:Message-Id;
        b=gb46SPN2uNOEGZH+NZmpnzpR7Bbg07HWaUSiLrmH+KkslvvRACyT20a9DdVPX2ED6
         JVH0m5S8Zre5aB/O9V9u6MZ4X2h1gsxAVbZkRsWynwkhxTY/5KNv7ZZN7QTmDhYz84
         +ULrzOUH2fC0R7sdvnaBOUYvRGKK9Pa14lpVGo28=
X-Virus-Scanned: amavisd-new at iluvatar.ai
Received: from mail.iluvatar.ai ([127.0.0.1])
        by localhost (mail.iluvatar.ai [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9YAcz0Gzr2A9; Fri,  3 Aug 2018 15:24:45 +0800 (CST)
Received: from localhost.localdomain (unknown [180.166.124.10])
        by mail.iluvatar.ai (Postfix) with ESMTPSA id 944A213C8D162;
        Fri,  3 Aug 2018 15:24:44 +0800 (CST)
From:   Huang Shijie <sjhuang@iluvatar.ai>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.jiang@intel.com, radhey.shyam.pandey@xilinx.com,
        appana.durga.rao@xilinx.com, jmkrzyszt@gmail.com,
        gomonovych@gmail.com, peter.ujfalusi@ti.com, keescook@chromium.org,
        horms+renesas@verge.net.au, geert+renesas@glider.be,
        shawnguo@kernel.org, baoyou.xie@linaro.org,
        michal.simek@xilinx.com, baohua@kernel.org,
        ludovic.desroches@microchip.com, linus.walleij@linaro.org,
        david.brown@linaro.org, Huang Shijie <sjhuang@iluvatar.ai>
Subject: [PATCH 00/46] Use dmaenginem_async_device_register to simplify code
Date:   Fri,  3 Aug 2018 15:19:30 +0800
Message-Id: <20180803072016.21544-1-sjhuang@iluvatar.ai>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the patches are using dmaenginem_async_device_register to simplify code
except the last one:
  dmaengine: add COMPILE_TEST for the drivers

I use the last one to do the compiler test.  
There are still 20 drivers which do not use the dmaenginem_async_device_register.
Let me take a rest, if this patch set is accepted, I will do the rest.

Huang Shijie (46):
  dmaengine: zx_dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: zynqmp_dma: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: xilinx_dma: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: xgene-dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: txx9dmac: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: timb_dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: omap-dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: edma: use dmaenginem_async_device_register to simplify the
    code
  dmaengine: cppi41: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: tegra210-adma: use helper dmaenginem_async_device_register
  dmaengine: tegra20-apb-dma: use helper
    dmaenginem_async_device_register
  dmaengine: sun6i-dma: use helper dmaenginem_async_device_register
  dmaengine: sun4i-dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: coh901318: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: s3c24xx-dma: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: ste_dma40: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: stm32-mdma: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: stm32-dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: sprd-dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: sirf-dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: bam_dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: sudmac: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: sa11x0-dma: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: nbpfaxi: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: mmp_tdma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: shdmac: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: usb-dmac: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: rcar-dmac: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: hidma: use dmaenginem_async_device_register to simplify the
    code
  dmaengine: pxa_dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: moxart-dma: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: pl330: use dmaenginem_async_device_register to simplify the
    code
  dmaengine: pch_dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: mxs-dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: mtk-hsdma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: k3dma: use dmaenginem_async_device_register to simplify the
    code
  dmaengine: imx-sdma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: imx-dma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: img-mdc-dma: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: fsl-edma: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: at_hdmac: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: at_xdmac: use dmaenginem_async_device_register to simplify
    the code
  dmaengine: dma-jz4780: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: dma-jz4740: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: dma-axi-dmac: use dmaenginem_async_device_register to
    simplify the code
  dmaengine: add COMPILE_TEST for the drivers

 drivers/dma/Kconfig              | 24 ++++++++++++------------
 drivers/dma/at_hdmac.c           |  4 +---
 drivers/dma/at_xdmac.c           |  7 ++-----
 drivers/dma/coh901318.c          | 14 ++++----------
 drivers/dma/dma-axi-dmac.c       |  7 ++-----
 drivers/dma/dma-jz4740.c         |  7 ++-----
 drivers/dma/dma-jz4780.c         |  8 ++------
 drivers/dma/fsl-edma.c           |  4 +---
 drivers/dma/img-mdc-dma.c        |  7 ++-----
 drivers/dma/imx-dma.c            |  8 ++------
 drivers/dma/imx-sdma.c           |  7 ++-----
 drivers/dma/k3dma.c              |  7 ++-----
 drivers/dma/mediatek/mtk-hsdma.c |  4 +---
 drivers/dma/mmp_tdma.c           |  7 ++-----
 drivers/dma/moxart-dma.c         |  5 +----
 drivers/dma/mxs-dma.c            |  3 +--
 drivers/dma/nbpfaxi.c            |  7 ++-----
 drivers/dma/pch_dma.c            |  4 +---
 drivers/dma/pl330.c              |  4 +---
 drivers/dma/pxa_dma.c            |  3 +--
 drivers/dma/qcom/bam_dma.c       |  7 ++-----
 drivers/dma/qcom/hidma.c         |  3 +--
 drivers/dma/s3c24xx-dma.c        | 11 +++--------
 drivers/dma/sa11x0-dma.c         |  4 +---
 drivers/dma/sh/rcar-dmac.c       |  5 +----
 drivers/dma/sh/shdmac.c          |  5 +----
 drivers/dma/sh/sudmac.c          |  4 +---
 drivers/dma/sh/usb-dmac.c        |  3 +--
 drivers/dma/sirf-dma.c           |  7 ++-----
 drivers/dma/sprd-dma.c           |  7 ++-----
 drivers/dma/ste_dma40.c          | 14 +++++---------
 drivers/dma/stm32-dma.c          |  3 +--
 drivers/dma/stm32-mdma.c         |  4 +---
 drivers/dma/sun4i-dma.c          |  7 ++-----
 drivers/dma/sun6i-dma.c          |  7 ++-----
 drivers/dma/tegra20-apb-dma.c    |  8 ++------
 drivers/dma/tegra210-adma.c      |  8 ++------
 drivers/dma/ti/Kconfig           |  2 +-
 drivers/dma/ti/cppi41.c          |  7 ++-----
 drivers/dma/ti/edma.c            |  8 ++------
 drivers/dma/ti/omap-dma.c        |  5 +----
 drivers/dma/timb_dma.c           |  3 +--
 drivers/dma/txx9dmac.c           |  4 +---
 drivers/dma/xgene-dma.c          | 16 ++--------------
 drivers/dma/xilinx/xilinx_dma.c  |  5 +----
 drivers/dma/xilinx/zynqmp_dma.c  |  4 +---
 drivers/dma/zx_dma.c             |  7 ++-----
 47 files changed, 88 insertions(+), 221 deletions(-)

-- 
2.17.1

