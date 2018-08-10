Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB96C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4FF223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5fe8omd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4FF223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeHJMV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:21:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41135 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbeHJMV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:21:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so4160766pgu.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=B/Wq136zb0MCV57dOEVEM5K37uB2RSDGwJBOts+o2MQ=;
        b=I5fe8omdpFORiG1cLPYLGvAEqGavPStje+HQ18xjtYhAqiFTKDPlOfir1f8viGBITx
         XCrupjOnzUCkAsaIbooyz7WmAX2R6wXS7K7K6o1XfGVOCdDrmMyF2Y8zSFtZ4l3n+0Vj
         Bfg+ReR5h5k52VU5aFABfJizX2xMS/B7/WuUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B/Wq136zb0MCV57dOEVEM5K37uB2RSDGwJBOts+o2MQ=;
        b=HEruEL1SUAneqoGqBCEYRceWmWZZ4V0tOGwHckWt35PA7z0U4Ufnk2kvWy6iaFK3hJ
         G8JaHIPBP85A2vX/mwlyh+32mALdAH+Wd+uGXq70carEkRMOt9RJo3QIdgbxJqMSfpFV
         E/ggeKHAA/L5mO7Q4z1ERGXkpMlJV6mKqzKgKwjJ6jBMRZSRHMwtQ9efYdb/ShsmHoj2
         W7Qa5/HIFWpozAfRrJg6A0as9yOB62WVYPMvaZ9AACdm7+bYY4ocBV8FEXJLOaCwhz3r
         9QUm2pGN8A4LcVPeoHr+yAgcEvulyijMGF72FAhFNiuRG2qdDvHcvg9RGV2vhkyvfRO7
         R9jw==
X-Gm-Message-State: AOUpUlEO5wadQx4n55eTEHBmZwzffz/29UvjO9XAfjxzW9iGxYEuE7LP
        wZS0cD6qMlt4KfWKpIsfP0Ax
X-Google-Smtp-Source: AA+uWPxsJO0211o8DKd6tGlsEN33gcaUzP8Y0o4y6BcjsHw4YIbdzxe51TDRlCS5e4lHnjz7crIOcQ==
X-Received: by 2002:a62:4bc6:: with SMTP id d67-v6mr6269459pfj.175.1533894738258;
        Fri, 10 Aug 2018 02:52:18 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.52.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:52:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/9] Add Reset Controller support for Actions Semi Owl SoCs
Date:   Fri, 10 Aug 2018 15:21:04 +0530
Message-Id: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Reset Controller (RMU) support for Actions Semi
Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
the clock subsystem in hardware. Hence, in software we integrate RMU
support into common clock driver inorder to maintain compatibility. The
syscon approach is not taken into account based on the review by Rob.

This patch series depends on the recently posted S700 clk series:
"[PATCH v7 0/5] Add clock driver for Actions S700 SoC". For the S700 clk
series, driver and bindings patches are applied through the clk tree.
But the DTS patches are not yet picked up by the platform maintainer,
Andreas.

Hence, Andreas is expected to pick the DTS patches in this series once
reviewed by the maintainers along with S700 clk DTS patches.

Because of the absence of the S500 SoC clk support, the reset controller
registration code is added to both S700 and S900 SoC clk drivers for now.
But once S500 clk support is added, the reset controller registration part
will be moved to Owl SoCs common clk code.

Thanks,
Mani

Changes in v3:

* Reverted back the syscon approach based on the review by Rob Herring
* Dropped the MAINTAINERS patch
* Converted reset_map struct definitions to const based on the review by
  Philipp
* Fixed S700 header in DT spotted by Parthiban
* Added Reviewed-by tags from Rob for 3 bindings patches

Changes in v2:

* Converted the CMU and RMU drivers to syscon for a more cleaner
  approach
* Declared the owl_reset_map structs to const
* Used regmap_update_bits instead of a combined regmap_read and write
* Removed unused headers in RMU drivers
* Added MAINTAINERS entry for the RMU driver and bindings

Manivannan Sadhasivam (9):
  clk: actions: Cache regmap info in private clock descriptor
  dt-bindings: clock: Add reset controller bindings for Actions Semi Owl
    SoCs
  dt-bindings: reset: Add binding constants for Actions Semi S700 RMU
  dt-bindings: reset: Add binding constants for Actions Semi S900 RMU
  arm64: dts: actions: Add Reset Controller support for S700 SoC
  arm64: dts: actions: Add Reset Controller support for S900 SoC
  clk: actions: Add Actions Semi Owl SoCs Reset Management Unit support
  clk: actions: Add Actions Semi S700 SoC Reset Management Unit support
  clk: actions: Add Actions Semi S900 SoC Reset Management Unit support

 .../bindings/clock/actions,owl-cmu.txt        |  2 +
 arch/arm64/boot/dts/actions/s700.dtsi         |  2 +
 arch/arm64/boot/dts/actions/s900.dtsi         |  2 +
 drivers/clk/actions/Kconfig                   |  1 +
 drivers/clk/actions/Makefile                  |  1 +
 drivers/clk/actions/owl-common.c              |  3 +-
 drivers/clk/actions/owl-common.h              |  5 +-
 drivers/clk/actions/owl-reset.c               | 66 ++++++++++++++
 drivers/clk/actions/owl-reset.h               | 31 +++++++
 drivers/clk/actions/owl-s700.c                | 55 +++++++++++-
 drivers/clk/actions/owl-s900.c                | 86 ++++++++++++++++++-
 .../dt-bindings/reset/actions,s700-reset.h    | 34 ++++++++
 .../dt-bindings/reset/actions,s900-reset.h    | 65 ++++++++++++++
 13 files changed, 347 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/actions/owl-reset.c
 create mode 100644 drivers/clk/actions/owl-reset.h
 create mode 100644 include/dt-bindings/reset/actions,s700-reset.h
 create mode 100644 include/dt-bindings/reset/actions,s900-reset.h

-- 
2.17.1

