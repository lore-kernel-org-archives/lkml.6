Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F0B20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqUU1JsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F0B20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbeHAFXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:23:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40615 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeHAFXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:23:09 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so8104299plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Y9HQDT6O0bUQrEKHBF5VUMmagpdhqNtYcCUMwS8a+wM=;
        b=fqUU1JsT8KHBgh548klaBujbxykYpidqtalc74Jw4feJDtgi9NB5ZXH9EdMi5QHAJp
         f5e30KcDODpiP9nhOrk9hoY34fv60V0k7NxnWvhmD5x7Nu78R7GCXZ3A8wBVfUfjTBYI
         vubS4s8go3qACvs4bUAxn6bly7u9lxtmXCOu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Y9HQDT6O0bUQrEKHBF5VUMmagpdhqNtYcCUMwS8a+wM=;
        b=NJIuuTifI4EM9Vi/14htQwAzo2AEt8ixAbjE0tIDZBETxLI17s0SnOdlKzBCcePaSY
         caUHITZGI1b2sZBoYLcUpInSNOyL6ygNgyjOoqAXF+ZNCdLK+ij5TGUj/tKgZK5eCK5X
         iwh8xYtSwfQvMm7k0BIikaliWYArfoFCnlHVwiHv7DprivKLOZnHwGpsBUulOSR7fXKT
         4CaZEhAdnThZeCISR3ALilOkjN7RupFXvFWJNAQMTR9YzYrmHVUt/qh4hPUe+XDFB0Me
         q3y2VLALGmkMWU/cdV+SyCpT1qDLuVs137qpPUSzPyuV/tVBEoO+uU7EspXrzKAWomYK
         Cu4g==
X-Gm-Message-State: AOUpUlGy2GQjxfCYiHhYsli0O7txma69iAoPH/9eZMMDb+NpTJpuPDQW
        l2ZPGCD1oj+O3Zcq3G6L2Hv+
X-Google-Smtp-Source: AAOMgpevBiq+Dtys991j+C6OcQTUcmFSjVf/N+jxrDoLFqh3HVF+FBUz/bINdkrRwPyoVEX4sknWKw==
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6-v6mr22360158plb.25.1533094782057;
        Tue, 31 Jul 2018 20:39:42 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34879545pgi.50.2018.07.31.20.39.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 20:39:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org, lee.jones@linaro.org,
        arnd@arndb.de
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/10] Add Reset Controller support for Actions Semi Owl SoCs
Date:   Wed,  1 Aug 2018 09:09:05 +0530
Message-Id: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Reset Controller (RMU) support for Actions Semi
Owl SoCs, S900 and S700. For the Owl SoCs, RMU's registers has been
integrated into the CMU memory map in hardware. Hence, in this patchset
the CMU driver has been converted to syscon so that the same memory map
can be resued by both CMU and RMU drivers. Finally, the support for RMU
in S700 and S900 SoCs are added.

This patch series depends on the recently posted S700 clk series:
"[PATCH v7 0/5] Add clock driver for Actions S700 SoC". For the S700 clk
series, driver and bindings patches are applied through the clk tree.
But the DTS patches are not yet picked up by the platform maintainer,
Andreas.

Hence, Andreas is expected to pick the DTS patches in this series once
reviewed by the maintainers along with S700 clk DTS patches.

Note: I have only tested the S900 part, S700 is only compile tested. But
there is no reason for it to fail.

Thanks,
Mani

Changes in v2:

* Converted the CMU and RMU drivers to syscon for a more cleaner
  approach
* Declared the owl_reset_map structs to const
* Used regmap_update_bits instead of a combined regmap_read and write
* Removed unused headers in RMU drivers
* Added MAINTAINERS entry for the RMU driver and bindings

Manivannan Sadhasivam (10):
  dt-bindings: clock: Add syscon support to Actions Semi Owl SoCs
  arm64: dts: actions: Convert Owl SoCs clock-controller nodes to syscon
  clk: actions: Add syscon support for Actions Semi Owl SoCs
  dt-bindings: reset: Add Actions Semi S900 SoC RMU support
  dt-bindings: reset: Add Actions Semi S700 SoC RMU support
  arm64: dts: actions: Add RMU node for Actions Semi S900 SoC
  arm64: dts: actions: Add RMU node for Actions Semi S700 SoC
  reset: Add Actions Semi S900 SoC Reset Management Unit support
  reset: Add Actions Semi S700 SoC Reset Management Unit support
  MAINTAINERS: Add entry for Actions Semi Owl SoCs Reset Management Unit

 .../bindings/clock/actions,owl-cmu.txt        |  21 +-
 .../bindings/reset/actions,owl-reset.txt      |  35 +++
 MAINTAINERS                                   |   4 +
 arch/arm64/boot/dts/actions/s700.dtsi         |  18 +-
 arch/arm64/boot/dts/actions/s900.dtsi         |  18 +-
 drivers/clk/actions/owl-common.c              |  20 +-
 drivers/reset/Kconfig                         |   6 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-owl.c                     | 225 ++++++++++++++++++
 include/dt-bindings/reset/actions,s700-rmu.h  |  34 +++
 include/dt-bindings/reset/actions,s900-rmu.h  |  65 +++++
 11 files changed, 416 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/actions,owl-reset.txt
 create mode 100644 drivers/reset/reset-owl.c
 create mode 100644 include/dt-bindings/reset/actions,s700-rmu.h
 create mode 100644 include/dt-bindings/reset/actions,s900-rmu.h

-- 
2.17.1

