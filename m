Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE28FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B3C208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VZH8v+Gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B3C208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeHWINe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:13:34 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47943 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbeHWINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:13:34 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w7N4ilM0021677;
        Thu, 23 Aug 2018 13:44:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w7N4ilM0021677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534999488;
        bh=/+fo0yOjS0VZxwHuwgyjBTZEbLP8nZAX67NGvuwXT9E=;
        h=From:To:Cc:Subject:Date:From;
        b=VZH8v+Gd84SQydllTCWwtPQHKducrd867iPDRU4LKzbLYAY+1Kky1Z6sDrgflUHHl
         OKqfrJmOhLOFl+u80/LOlnZ/Fw5fBoIQvp5FPxvd8eoFNglozaeQj/MIxbGp4Wv0oF
         Gh3kvQxQhXRqv7/18Je12AuMMTPaZsl7IPTJA/J6y717aBUWhgrMuTMcXfOKGj1yHZ
         Pfu0fAIU45w5Dq4z+LkQw466KNqgAkkBdkiGas53ErNnRNEitZCVejJQb9W0FNaY4N
         /4F1nGYM1xUQe8Jy2USx3bLYA4/OotYDNA/544gIkntBpk0J9c04qyTNo4BNByBHaZ
         KndccLt62nQ6Q==
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
Subject: [PATCH v3 0/6] mmc: tmio: refactor TMIO core a bit and add UniPhier SD/eMMC controller support
Date:   Thu, 23 Aug 2018 13:44:14 +0900
Message-Id: <1534999460-15111-1-git-send-email-yamada.masahiro@socionext.com>
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

V3 is rebase on top of Linus' tree.

I dropped 6/7 because Renesas added more quirks
in the current MW.


Masahiro Yamada (6):
  mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
  mmc: tmio: move tmio_mmc_set_clock() to platform hook
  dt-bindings: mmc: add DT binding for UniPhier SD/eMMC controller
  mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
  mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
  mmc: tmio: refactor CLK_CTL bit calculation

 .../devicetree/bindings/mmc/uniphier-sd.txt        |  55 ++
 MAINTAINERS                                        |   1 +
 drivers/mmc/host/Kconfig                           |  10 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/renesas_sdhi_core.c               |  48 +-
 drivers/mmc/host/tmio_mmc.c                        |  56 ++
 drivers/mmc/host/tmio_mmc.h                        |   4 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  92 +--
 drivers/mmc/host/uniphier-sd.c                     | 693 +++++++++++++++++++++
 9 files changed, 871 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
 create mode 100644 drivers/mmc/host/uniphier-sd.c

-- 
2.7.4

