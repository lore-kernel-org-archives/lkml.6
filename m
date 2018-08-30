Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6CAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43BC720838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw7eBAPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BC720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeH3VTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeH3VTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:19:24 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 512FC20658;
        Thu, 30 Aug 2018 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535649376;
        bh=cUijlKq92KWt/bqR6FTvDzcdVZPYk133bRNyqSTjx9k=;
        h=From:To:Subject:Date:From;
        b=Tw7eBAPG0KF/EfvnErGyspBLENt2tmuk5yNzbc4lsySVqoo6fG5ECy9T7swwQjFXW
         vsoBJwEdcaKLzmPy4iOzmdKy28fGmM3LU4Hrae0+Iiob7td8aXTuHnCgHhZEVRJHZM
         0cQ3fDeDdH2dvDy3N7F7763rvJ+0+qJzf0Cde264=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH 0/6] crypto: vf-crc - Add new driver (and required clk, DTS...)
Date:   Thu, 30 Aug 2018 19:15:33 +0200
Message-Id: <20180830171539.20008-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Add new driver for Freescale/NXP Vybrid CRC HW accelerator along with
prerequisities:
1. Clock,
2. Bindings,
3. CRC16 test tables for testing.

Patch 3/6 (ARM: dts: vfxxx: Add node for CRC hardware block) depends on patch
2/6 (clk) so it should go in following cycle (after clk change hits mainline).

Best regards,
Krzysztof


Krzysztof Kozlowski (6):
  dt-bindings: crypto: Add Freescale Vybrid CRC
  clk: imx: vf610: Add CRC clock
  ARM: dts: vfxxx: Add node for CRC hardware block
  crypto: testmgr - Add CRC16 test tables
  crypto - Group Freescale/NXP ARM architecture Kconfig entires together
  crypto: vf-crc - Add new driver for Freescale Vybrid CRC

 .../devicetree/bindings/crypto/fsl-vf610-crc.txt   |  16 +
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/vfxxx.dtsi                       |   7 +
 crypto/testmgr.c                                   |   6 +
 crypto/testmgr.h                                   | 386 ++++++++++++++++++++
 drivers/clk/imx/clk-vf610.c                        |   1 +
 drivers/crypto/Kconfig                             |  42 ++-
 drivers/crypto/Makefile                            |   1 +
 drivers/crypto/vf-crc.c                            | 387 +++++++++++++++++++++
 include/dt-bindings/clock/vf610-clock.h            |   3 +-
 include/linux/crc32poly.h                          |   7 +
 11 files changed, 846 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl-vf610-crc.txt
 create mode 100644 drivers/crypto/vf-crc.c

-- 
2.14.1

