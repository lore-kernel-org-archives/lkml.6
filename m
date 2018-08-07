Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F336BC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A242F208AD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uNPeQzPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A242F208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388642AbeHGIbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:31:20 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:39876 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbeHGIbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:31:19 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id w776HYgc009463;
        Tue, 7 Aug 2018 15:17:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com w776HYgc009463
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1533622655;
        bh=xMl5MUMrp+no3yWUAYGzVuosZcDXuRzwnhkraSZOqDc=;
        h=From:To:Cc:Subject:Date:From;
        b=uNPeQzPzsEG1hVJ9pSzI8lKGbJd5/EPZx+oI5MacGEoLmV/rbbPTK4HLcTPBxe0an
         03hh3aUC43RKkDbV5A1nWw6nYgP5Wom3jsnoqK9RWzgpdUrWSRz3BU8ELUHK3WaC1B
         aUcPzEE/6T8oyWQ8xPBpP75XR2zea08xHpy/FOnpOwO0XdXwfHicRziVxLhOLn0Ux4
         Ul9siArlV3iwFlUzdwHU02KrRWHG0gYJJmfrTWbkkntC8BaXKLRHnO7mPDbHdOu5ov
         +RdhVvIgmc/vWzgqRfMFbRB2FiD27+JzDFp1T5k7/QN8rRRI5mkz8/BY4YxQ6O5FUd
         OfJl8QGdf/sYA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [v0.1 PATCH 0/7] mmc: tmio: refactor TMIO core a bit and add UniPhier SD/eMMC controller support
Date:   Tue,  7 Aug 2018 15:17:15 +0900
Message-Id: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Add UniPhier SD/eMMC controller support.

As a preparation, I changed tmio_mmc_set_clock() to a platform hook.
The clock rate setting is platform-specific, and UniPhier variants
will add another way.  I thought it would be better to split this
to a hook to avoid a mess.



Masahiro Yamada (7):
  mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
  mmc: tmio: move tmio_mmc_set_clock() to platform hook
  dt-bindings: mmc: add DT binding for UniPhier SD/eMMC controller
  mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
  mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
  mmc: renesas_sdhi: refactor CLK_CTL bit calculation
  mmc: tmio: refactor CLK_CTL bit calculation

 .../devicetree/bindings/mmc/uniphier-sd.txt        |  60 ++
 MAINTAINERS                                        |   1 +
 drivers/mmc/host/Kconfig                           |  10 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/renesas_sdhi_core.c               |  40 +-
 drivers/mmc/host/tmio_mmc.c                        |  56 ++
 drivers/mmc/host/tmio_mmc.h                        |   4 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  79 +--
 drivers/mmc/host/uniphier-sd.c                     | 694 +++++++++++++++++++++
 9 files changed, 869 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
 create mode 100644 drivers/mmc/host/uniphier-sd.c

-- 
2.7.4

