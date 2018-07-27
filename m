Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7634FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2487C20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bzOvJIGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2487C20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389100AbeG0UJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:09:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41907 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388967AbeG0UJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:09:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so2020550pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5FC7TeMTQ3IsSPp6n95qC1z3uRHEWTZfinsf63P4O1M=;
        b=bzOvJIGAnprqFhC1zXSb1t7zBx7rAhg7wet88rwu5nppb6ySgUxxxdLg8Juuxf4CSV
         p0ny5CeY2+4BJWhVEmDYeLaCUzR4s7RGVd4amNtnXa+GZ7dREpDKN92w7sNrwb+/gHx2
         M1a2ilw4j7TCzF3qk//5uYjLWmxj3xqaW41GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5FC7TeMTQ3IsSPp6n95qC1z3uRHEWTZfinsf63P4O1M=;
        b=FiUQfo9u4qlSHbjHntjpap8kWwFc1EIKMooD4hdjPuHXxkOIhCCnDX7nO6EcFBHrHl
         27fQ87bsfM4lkSih8louqBPUnWV5EYP3+0U+h2U0JlLEzqOcCR1rAaUGRPJFr53vud8Z
         lMKhRNO2PcOx0g+6BjANv6kcnkNqUOlcr7QVf69Zy1SyMDdkLBZCkdoBaOnmBYO98cwh
         tYVKGs+NdiPlagwW7pLh8xN0zg39aSCejpv2/knm2r5DecUenE1XtT29kQOawFq5TGHZ
         LVMgc1o3kbrGi+TVEB02wZXghyxVaTSy31psphA/L5oyFv0Y3CtdsDF6aWcRV9Fa6Vrh
         Rskg==
X-Gm-Message-State: AOUpUlE/SGMGlqg8Kgb8hicCjs6a0OkjxBa+YXP9XDEJnHcGcNi9n0YX
        JkGxrzg3TtPY6XzkaAVeExOT
X-Google-Smtp-Source: AAOMgpfvwDg6RGgFZne5kYBMt54Ht0yu4tdt3POStbkKNLGhGwXGMhbrN7cbZuPp8XkyELtK3KTQZg==
X-Received: by 2002:a63:a347:: with SMTP id v7-v6mr6999456pgn.182.1532717200874;
        Fri, 27 Jul 2018 11:46:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:46:40 -0700 (PDT)
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
Subject: [PATCH 0/9] Add Reset Controller support for Actions Semi Owl SoCs
Date:   Sat, 28 Jul 2018 00:15:18 +0530
Message-Id: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds Reset Controller (RMU) support for Actions Semi
Owl SoCs, S900 and S700. For the Owl SoCs, RMU has been integrated into
the clock subsystem in hardware. Hence, in software we integrate RMU
support into common clock driver inorder to maintain compatibility.

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
 drivers/clk/actions/owl-reset.c               | 72 ++++++++++++++++
 drivers/clk/actions/owl-reset.h               | 32 +++++++
 drivers/clk/actions/owl-s700.c                | 55 +++++++++++-
 drivers/clk/actions/owl-s900.c                | 86 ++++++++++++++++++-
 .../dt-bindings/reset/actions,s700-reset.h    | 34 ++++++++
 .../dt-bindings/reset/actions,s900-reset.h    | 65 ++++++++++++++
 13 files changed, 354 insertions(+), 6 deletions(-)
 create mode 100644 drivers/clk/actions/owl-reset.c
 create mode 100644 drivers/clk/actions/owl-reset.h
 create mode 100644 include/dt-bindings/reset/actions,s700-reset.h
 create mode 100644 include/dt-bindings/reset/actions,s900-reset.h

-- 
2.17.1

