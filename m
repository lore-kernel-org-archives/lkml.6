Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7704BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2176C20858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AzYHWGhB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2176C20858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbeGWFRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:17:14 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42983 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbeGWFRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:17:14 -0400
Received: by mail-pl0-f66.google.com with SMTP id z7-v6so5896531plo.9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 21:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=o58N5bHQsq/+j9F99o0CqQR4WTmR1eeXgvHYhmsNOrQ=;
        b=AzYHWGhBihmWpCm4tMti3HinWoknKSd6NxBR+A+75CO7FWwGx3yZ281emJDWDIUH3U
         M3J6NaNgOu3Nvec/EYqbD3OHqCVg8pfz0k9mMG/CyklPvIW/dcLrchK/fJ/hfPP2QNO3
         9mA7xyU8sLSl2MVgk49w0hsTmjUL34FKuj3/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o58N5bHQsq/+j9F99o0CqQR4WTmR1eeXgvHYhmsNOrQ=;
        b=HC25eoKhYWSjaMn3AZqcPKJIuMxmaxGMM2J3yy1xg+QJBVmmtygJh0bAbAY0DUmMV8
         nt8rgk+E7z/Jy8A1F8brfjgUT7Ho2GJcFLnw8I4vrL1VW4FE2goAZVqTgItHsuuz2VEg
         eAh6FPth5uBepbrk4Ww5YgWXMCWdhsk5vT1+Tz/pO+gx/UAQlR+esbjFACp7eMJvMSeU
         yST1NOqT5zUlJui2JtUbtAgx5BkZWas8852xzglquuuCZGYoZk8hBFawSCOd7XjtUImC
         OxtvlKKMZ1kp5HNLXCo9p6Bcul5d0TCOiCMoTI7/v/y9ozHjzNWplMMJJzcocVnkYOCF
         k4Vw==
X-Gm-Message-State: AOUpUlEDsLKA57tU5+dXSX+nJaaL0NahFiu5lVvMbWQjM+xCSAghcudv
        kXO3fJCGYc8sfRGCvCHF+/+z
X-Google-Smtp-Source: AAOMgpeTvQsVZWC1Bp3pnN8T23MfThFhsVc4B26YE/rhVme5U5u+9vCqrf0qVHcWhHOE+s93nlBTvQ==
X-Received: by 2002:a17:902:209:: with SMTP id 9-v6mr11475965plc.270.1532319481344;
        Sun, 22 Jul 2018 21:18:01 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:802:a98c:b568:c01f:49a2:2aa5])
        by smtp.gmail.com with ESMTPSA id i20-v6sm13369282pfj.82.2018.07.22.21.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 21:18:00 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vkoul@kernel.org, dan.j.williams@intel.com, afaerber@suse.de,
        robh+dt@kernel.org
Cc:     dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/4] Add Actions Semi Owl family S900 DMA Controller support
Date:   Mon, 23 Jul 2018 09:47:39 +0530
Message-Id: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds DMA controller support for Actions Semi Owl family
S900 SoC. This driver has been structured in a way such that there will be only
one controller driver for the whole Owl family series (S500, S700 and
S900 SoCs).

There are 12 physical channels and 46 logical channels supported by the
DMA controller.

The DMA controller also supports 4 software configurable interrupt lines for
the priority based DMA usecase. But the DMA driver supports only 1 interrupt
for simplification. By default, the driver uses Linked list mode for all
transfers. Right now only MEMCPY support has been added and the rest
(SLAVE, CYCLIC) will be added in upcoming patches.

The driver has been tested using dmatest utility on the Bubblegum-96
board.

The DTS patches in this series depends on the pinctrl DTS patches
submitted [1], which is yet to be merged by the platform maintainer
Andreas. Since the DMA driver goes through DMA tree and the relevant
DTS patches goes through ARM-SoC tree, Andreas will pick it up once
it has been reviewed.

For the reference, I have queued up all reviewed dts patches so far
in my repo [2] from which Andreas is picking them for 4.19.

Thanks,
Mani

[1] https://patchwork.kernel.org/patch/10322937/
[2] https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=s900-for-next

Changes in v2:

* Fixed up the multi-line alignments according to `checkpatch --strict`

Manivannan Sadhasivam (4):
  dt-bindings: dma: Add binding for Actions Semi Owl SoCs
  arm64: dts: actions: Add Actions Semi S900 DMA Controller
  dma: Add Actions Semi Owl family S900 DMA driver
  MAINTAINERS: Add entry for Actions Semi Owl SoCs DMA driver

 .../devicetree/bindings/dma/owl-dma.txt       |   46 +
 MAINTAINERS                                   |    2 +
 arch/arm64/boot/dts/actions/s900.dtsi         |   13 +
 drivers/dma/Kconfig                           |    8 +
 drivers/dma/Makefile                          |    1 +
 drivers/dma/owl-dma.c                         | 1023 +++++++++++++++++
 6 files changed, 1093 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/owl-dma.txt
 create mode 100644 drivers/dma/owl-dma.c

-- 
2.17.1

